" vi:set ts=8 sts=2 sw=2 tw=0 nowrap:
"
" vime.vim - 簡易SKK-IME
"
" Last Change: 02-May-2003.
" Written By:  Muraoka Taro <koron@tka.att.ne.jp>
"

let s:verbose = 0
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
"echo "candidate_file: ".s:candidate_file

"==============================================================================
"				    辞書検索
"

"
" WinEnter/WinLeave hooks
"
"   WinEnter
function! s:Candidate_WinEnter()
  set ft=
  if winbufnr(2) > 0
  else
    exe "quit!"
  endif
endfunction
"   WinLeave
function! s:Candidate_WinLeave()
  setlocal nowrap
  hide
  "exe "normal! 1\<C-W>_"
endfunction

" 辞書データファイルをオープン
function! s:Candidate_FileOpen()
  if filereadable(s:candidate_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:candidate_file) < 0
    execute "augroup VIme"
    execute "autocmd!"
    execute "autocmd WinEnter ".s:candidate_file." call <SID>Candidate_WinEnter()"
    execute "autocmd WinLeave ".s:candidate_file." call <SID>Candidate_WinLeave()"
    execute "augroup END"
    execute 'silent normal! :sv '.s:candidate_file."\<CR>"
  endif
  return 1
endfunction

" 検索に使用する状態変数
let s:last_keyword = ''
let s:last_found = 0
let s:last_candidate = ''
let s:last_candidate_str = ''
let s:last_candidate_num = 0
let s:is_katuyo = 0

" 辞書から未確定文字列を検索
function! s:CandidateSearch(keyword)
  let found_num = s:last_found

  " 検索文字列が前回と同じ時は省略
  if s:last_keyword !=# a:keyword
    let s:last_keyword = a:keyword
    if !s:Candidate_FileOpen()
      return 0
    endif
    let save_undolevels = &undolevels
    let &undolevels = 0
    " 見つからなくてエラーメッセージが表示されないようにダミーを入れておく
    execute "silent normal! ggO" . a:keyword . " \<ESC>"
    " 実際の検索
    execute "silent normal! 2G/^" . a:keyword . " \<CR>"
    let s:last_candidate = ''
    let s:last_candidate_str = substitute(getline('.'), '^' . a:keyword . ' ', '', '')
    let s:last_candidate_num = 1
    let found_num = line('.')
    execute "normal! u\<C-w>p"
    let &undolevels = save_undolevels
  else
    " 次の変換候補を探し出すため
    if s:last_candidate_num > 0 && s:last_candidate != ''
      let s:last_candidate_num = s:last_candidate_num + strlen(s:last_candidate) + 1
    endif
  endif

  if found_num > 1
    " 候補がみつかっているならば、順番に表示する
    let str = ''
    while strlen(str) < 1
      let str = matchstr(s:last_candidate_str, '[^/]\+', s:last_candidate_num)
      if strlen(str) < 1
	let s:last_candidate_num = 1
      endif
    endwhile
    let s:last_candidate = str
    echo "CANDIDATE: ".str
    "echo "CANDIDATE: ".str." (".s:last_candidate_str.")"
  else
    " 候補がみつからなかった時、リセット
    let s:last_candidate = ''
    let s:last_candidate_str = ''
    let s:last_candidate_num = 0
  endif
  let s:last_found = found_num
endfunction

" 候補をバッファに挿入
function! s:CandidateSelect(len)
  if strlen(s:last_candidate) > 0
    let str = getline(s:status_line)
    let str = strpart(str, 0, s:status_column - 1).s:last_candidate.strpart(str, s:status_column - 1 + a:len)
    call setline(s:status_line, str)
    let s:status_column = s:status_column + strlen(s:last_candidate)
    let s:last_candidate = ''
    let s:last_candidate_num = 1
    let &cmdheight = s:save_cmdheight
    unlet s:save_cmdheight
  endif
endfunction

"
" SelectWindowByName(name) [global function]
"   Acitvate selected window by a:name.
"
function! s:SelectWindowByName(name)
  let num = bufwinnr(a:name)
  if num >= 0 && num != winnr()
    execute 'normal! ' . num . "\<C-W>\<C-W>"
  endif
  return num
endfunction

" 部首合成辞書データファイルをオープン
function! s:Bushu_FileOpen()
  if filereadable(s:bushu_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushu_file) < 0
    execute "augroup VIme"
    execute "autocmd!"
    execute "autocmd WinEnter ".s:bushu_file." call <SID>Candidate_WinEnter()"
    execute "autocmd WinLeave ".s:bushu_file." call <SID>Candidate_WinLeave()"
    execute "augroup END"
    execute 'silent normal! :sv '.s:bushu_file."\<CR>"
  endif
  return 1
endfunction

" 等価文字を検索して返す。等価文字がない場合はもとの文字そのものを返す
function! s:BushuAlternative(ch)
  if !s:Bushu_FileOpen()
    return a:ch
  endif
  let save_undolevels = &undolevels
  let &undolevels = 0
  execute "silent normal! ggO." . a:ch . "\<ESC>"
  execute "silent normal! 2G/^." . a:ch . "$\<CR>"
  let found_num = line('.')
  if found_num > 1
    execute "normal! l"
    let retchar = strpart(getline('.'), 0, col('.') - 1)
  else
    let retchar = a:ch
  endif
  execute "normal! u\<C-w>p"
  let &undolevels = save_undolevels
  return retchar
endfunction

" char1とchar2をこの順番で合成してできる文字を検索して返す。
" 見つからない場合は''を返す
function! s:BushuSearchCompose(char1, char2)
  if !s:Bushu_FileOpen()
    return ''
  endif
  let save_undolevels = &undolevels
  let &undolevels = 0
  execute "silent normal! ggO." . a:char1 . a:char2 . "\<ESC>"
  execute "silent normal! 2G/^." . a:char1 . a:char2 . "\<CR>"
  let found_num = line('.')
  if found_num > 1
    execute "normal! l"
    let retchar = strpart(getline('.'), 0, col('.') - 1)
  else
    let retchar = ''
  endif
  execute "normal! u\<C-w>p"
  let &undolevels = save_undolevels
  return retchar
endfunction

" 指定された文字を2つの部首に分解する。
" 分解した部首をs:decomp1, s:decomp2にセットする。
" @return 1: 分解に成功した場合、0: 分解できなかった場合
function! s:BushuDecompose(ch)
  if !s:Bushu_FileOpen()
    return 0
  endif
  let save_undolevels = &undolevels
  let &undolevels = 0
  execute "silent normal! ggO" . a:ch . "..\<ESC>"
  execute "silent normal! 2G/^" . a:ch . "..\<CR>"
  let found_num = line('.')
  if found_num > 1
    let save_ve = &ve
    let &ve = 'all'
    execute "normal! l"
    let pos1 = col('.') - 1
    execute "normal! l"
    let pos2 = col('.') - 1
    execute "normal! l"
    let pos3 = col('.') - 1
    let &ve = save_ve
    let str = getline('.')
    let s:decomp1 = strpart(str, pos1, pos2 - pos1)
    let s:decomp2 = strpart(str, pos2, pos3 - pos2)
    let ret = 1
  else
    let ret = 0
  endif
  execute "normal! u\<C-w>p"
  let &undolevels = save_undolevels
  return ret
endfunction

" 合成後の文字が空でなく、元の文字でもないことを確認
" @param ch 合成後の文字
" @param char1 元の文字
" @param char2 元の文字
" @return 1: chが空でもchar1でもchar2でもない場合。0: それ以外の場合
function! s:BushuCharOK(ch, char1, char2)
  if a:ch !=# '' && a:ch !=# a:char1 && a:ch !=# a:char2
    return 1
  else
    return 0
  endif
endfunction

" 部首合成変換辞書を検索
function! s:BushuSearch(char1, char2)
  let char1 = a:char1
  let char2 = a:char2
  let i = 0
  while i < 2
    " そのまま合成できる?
    let retchar = s:BushuSearchCompose(char1, char2)
    if s:BushuCharOK(retchar, char1, char2)
      return retchar
    endif

    " 等価文字どうしで合成できる?
    if !exists("ch1alt")
      let ch1alt = s:BushuAlternative(char1)
    endif
    if !exists("ch2alt")
      let ch2alt = s:BushuAlternative(char2)
    endif
    let retchar = s:BushuSearchCompose(ch1alt, ch2alt)
    if s:BushuCharOK(retchar, char1, char2)
      return retchar
    endif

    " 等価文字を部首に分解
    if !exists("ch1a1")
      if s:BushuDecompose(ch1alt) == 1
	let ch1a1 = s:decomp1
	let ch1a2 = s:decomp2
	unlet s:decomp1
	unlet s:decomp2
      else
	let ch1a1 = ''
	let ch1a2 = ''
      endif
    endif
    if !exists("ch2a1")
      if s:BushuDecompose(ch2alt) == 1
	let ch2a1 = s:decomp1
	let ch2a2 = s:decomp2
	unlet s:decomp1
	unlet s:decomp2
      else
	let ch2a1 = ''
	let ch2a2 = ''
      endif
    endif

    " 引き算
    if ch1a1 !=# '' && ch1a2 !=# '' && ch1a2 ==# ch2alt
      let retchar = ch1a1
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if ch1a1 !=# '' && ch1a2 !=# '' && ch1a1 ==# ch2alt
      let retchar = ch1a2
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " 一方が部品による足し算
    if ch1alt !=# '' && ch2a1 !=# ''
      let retchar = s:BushuSearchCompose(ch1alt, ch2a1)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if ch1alt !=# '' && ch2a2 !=# ''
      let retchar = s:BushuSearchCompose(ch1alt, ch2a2)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if ch1a1 !=# '' && ch2alt !=# ''
      let retchar = s:BushuSearchCompose(ch1a1, ch2alt)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if ch1a2 !=# '' && ch2alt !=# ''
      let retchar = s:BushuSearchCompose(ch1a2, ch2alt)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " 両方が部品による足し算
    if ch1a1 !=# '' && ch2a1 !=# ''
      let retchar = s:BushuSearchCompose(ch1a1, ch2a1)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if ch1a1 !=# '' && ch2a2 !=# ''
      let retchar = s:BushuSearchCompose(ch1a1, ch2a2)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if ch1a2 !=# '' && ch2a1 !=# ''
      let retchar = s:BushuSearchCompose(ch1a2, ch2a1)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if ch1a2 !=# '' && ch2a2 !=# ''
      let retchar = s:BushuSearchCompose(ch1a2, ch2a2)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " 部品による引き算
    if ch1a2 !=# '' && ch2a1 !=# '' && ch1a2 ==# ch2a1
      let retchar = ch1a1
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if ch1a2 !=# '' && ch2a2 !=# '' && ch1a2 ==# ch2a2
      let retchar = ch1a1
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if ch1a1 !=# '' && ch2a1 !=# '' && ch1a1 ==# ch2a1
      let retchar = ch1a2
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if ch1a1 !=# '' && ch2a2 !=# '' && ch1a1 ==# ch2a2
      let retchar = ch1a2
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " 文字の順を逆にしてやってみる
    let t = char1  | let char1  = char2  | let char2 = t
    let t = ch1alt | let ch1alt = ch2alt | let ch2alt = t
    let t = ch1a1  | let ch1a1  = ch2a1  | let ch2a1 = t
    let t = ch1a2  | let ch1a2  = ch2a2  | let ch2a2 = t
    let i = i + 1
  endwhile

  " 合成できなかった
  return ''
endfunction

" 部首合成した文字をバッファに挿入
function! s:BushuReplace(linenum, stcol, endcol, ch)
  let str = getline(a:linenum)
  let str = strpart(str, 0, a:stcol - 1) . a:ch . strpart(str, a:endcol - 1)
  call setline(a:linenum, str)
endfunction

"==============================================================================
"				    入力制御
"

function! s:InputConvert()
  let col = col("'^")
  let s:is_katuyo = 0
  let status = s:StatusGet()
  let len = strlen(status)
  if len > 0
    call s:CandidateSearch(status)
  else
    let s:last_keyword = ''
    call s:StatusReset()
  endif
  execute "normal! " . col . "|"
endfunction

" 活用のある単語の変換を行う。
" 変換対象文字列の末尾に「―」を追加して交ぜ書き辞書を検索する。
function! s:InputConvertKatuyo()
  let col = col("'^")
  let status = s:StatusGet()
  let len = strlen(status)
  if len > 0
    let s:is_katuyo = 1
    call s:CandidateSearch(status . "―")
  else
    let s:last_keyword = ''
    call s:StatusReset()
  endif
  execute "normal! " . col . "|"
endfunction

" 確定しようとしている候補が問題ないかどうかチェック
function! s:IsCandidateOK(str)
  if strlen(a:str) > 0 && strlen(s:last_candidate) > 0
    if s:is_katuyo && s:last_keyword ==# a:str . "―" || s:last_keyword ==# a:str
      return 1
    endif
  endif
  return 0
endfunction

function! s:InputCR()
  let str = s:StatusGet()
  if s:IsCandidateOK(str)
    let len = strlen(str)
    call s:CandidateSelect(len)
    execute "normal! " . s:status_column . "|"
  else
    execute "normal! gi\<CR>\<ESC>"
  endif
  call s:StatusReset()
endfunction

function! s:InputStart()
  let s:save_cmdheight = &cmdheight
  if &cmdheight < 2
    let &cmdheight = 2
  endif
  call s:StatusSet()
endfunction

" 直前の2文字の部首合成変換を行う
function! s:InputConvertBushu(is_insert_mode)
  let col3 = col("'^")
  if col3 > 3
    let save_ve = &ve
    let &ve = 'all'
    execute "normal! " . col3 . "|h"
    let col2 = col(".")
    execute "normal! h"
    let col1 = col(".")
    let str = getline('.')
    let char1 = strpart(str, col1 - 1, col2 - col1)
    let char2 = strpart(str, col2 - 1, col3 - col2)
    let retchar = s:BushuSearch(char1, char2)
    let len = strlen(retchar)
    if len > 0
      call s:BushuReplace(line("."), col1, col3, retchar)
      if a:is_insert_mode
	execute "normal! " . col2 . "|"
      else
	execute "normal! " . col1 . "|"
      endif
    else
      if a:is_insert_mode
	execute "normal! " . col3 . "|"
      else
	execute "normal! " . col2 . "|"
      endif
    endif
    let &ve = save_ve
  endif
endfunction

" 今の位置以前の2文字を部首合成変換する
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  call s:InputConvertBushu(0)
endfunction

" 今の位置以前のcount文字を変換する
function! s:ConvertCount(count)
  if a:count < 1
    call s:StatusReset()
  else
    let s:is_katuyo = 0
    let s:status_line = line(".")
    let save_col = col(".")
    execute "normal! a\<ESC>"
    let cnt = a:count - 1
    if cnt > 0
      execute "normal! " . cnt . "h"
    endif
    let s:status_column = col(".")
    execute "normal! " . save_col . "|"
    if !s:StatusIsEnable()
      call s:StatusReset()
    else
      let status = s:StatusGet()
      let len = strlen(status)
      if len > 0
	let s:save_cmdheight = &cmdheight
	if &cmdheight < 2
	  let &cmdheight = 2
	endif
	call s:CandidateSearch(status)
      else
	let s:last_keyword = ''
	call s:StatusReset()
      endif
    endif
  endif
endfunction

" 今の位置以前のcount文字を活用のある語として変換する
function! s:ConvertKatuyo(count)
  if a:count < 1
    call s:StatusReset()
  else
    let s:status_line = line(".")
    let save_col = col(".")
    execute "normal! a\<ESC>"
    let cnt = a:count - 1
    if cnt > 0
      execute "normal! " . cnt . "h"
    endif
    let s:status_column = col(".")
    execute "normal! " . save_col . "|"
    if !s:StatusIsEnable()
      call s:StatusReset()
    else
      let status = s:StatusGet()
      let len = strlen(status)
      if len > 0
	let s:save_cmdheight = &cmdheight
	if &cmdheight < 2
	  let &cmdheight = 2
	endif
	let s:is_katuyo = 1
	call s:CandidateSearch(status . "―")
      else
	let s:last_keyword = ''
	call s:StatusReset()
      endif
    endif
  endif
endfunction

" ConvertCount()で変換を開始した候補を確定する
function! s:FixCandidate()
  execute "normal! a\<ESC>"
  let str = s:StatusGet()
  if s:IsCandidateOK(str)
    let len = strlen(str)
    call s:CandidateSelect(len)
    execute "normal! " . s:status_column . "|"
  else
    execute "normal! \<CR>"
  endif
  call s:StatusReset()
endfunction

"==============================================================================
"				  キートラップ
"

"   マッピングを有効化
function! s:MappingOn()
  inoremap <buffer> <CR> <C-O>:call <SID>InputCR()<CR>
  inoremap <buffer> <C-L> <C-O>:call <SID>InputStart()<CR>
  inoremap <buffer> <Nul> <C-O>:call <SID>InputConvert()<CR>
  inoremap <buffer> <C-Q> <C-O>:call <SID>InputConvertKatuyo()<CR>
  inoremap <buffer> <C-S> <C-O>:call <SID>InputConvertBushu(1)<CR>
  nnoremap <buffer> <CR> :<C-U>call <SID>FixCandidate()<CR>
  nnoremap <buffer> <Nul> :<C-U>call <SID>ConvertCount(v:count)<CR>
  nnoremap <buffer> <C-Q> :<C-U>call <SID>ConvertKatuyo(v:count)<CR>
  nnoremap <buffer> <C-S> :<C-U>call <SID>ConvertBushu()<CR>
endfunction

"   マッピングを無効化
function! s:MappingOff()
  imapclear <buffer>
  nmapclear <buffer>
endfunction

" iminsertが1の場合はMappingOnして、0の場合はMappingOffする
function! s:MappingToggle()
  if &iminsert == 1
    call s:MappingOn()
  else
    call s:MappingOff()
  endif
endfunction

"==============================================================================
"			     未確定文字管理用関数群
"

"   未確定文字列が存在するかチェックする
function! s:StatusIsEnable()
  if s:status_line != line('.') || s:status_column <= 0 || s:status_column > col('.')
    return 0
  endif
  return 1
endfunction

"   未確定文字列を開始する
function! s:StatusSet()
  let s:status_line = line("'^")
  let s:status_column = col("'^")
  call s:StatusEcho()
  if s:verbose
    echo "StatusSet: SLINE=".s:status_line." SCOLUMN=".s:status_column
  endif
endfunction

"   未確定文字列をリセットする
function! s:StatusReset()
  let s:status_line = 0
  let s:status_column = 0
endfunction

"   未確定文字列を「状態」として取得する
function! s:StatusGet()
  if !s:StatusIsEnable()
    return ''
  endif

  " 必要なパラメータを収集
  let stpos = s:status_column - 1
  let ccl = col("'^")
  let len = ccl - s:status_column
  let str = getline('.')

  if s:verbose
    echo "SLINE=".s:status_line." SCOLUMN=".s:status_column." CCOLUMN=".ccl." LEN=".len
  endif
  return strpart(str, stpos, len)
endfunction

"   未確定文字列の開始位置と終了位置を表示(デバッグ用)
function! s:StatusEcho(...)
  echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

"==============================================================================
"				   初期設定
"

call s:StatusReset()
command! VImeOn :call <SID>MappingOn()
command! VImeOff :call <SID>MappingOff()
command! VImeToggle :call <SID>MappingToggle()
