" vi:set ts=8 sts=2 sw=2 tw=0 nowrap:
"
" vime.vim - 簡易SKK-IME
"
" Last Change: 23-Apr-2003.
" Written By:  Muraoka Taro <koron@tka.att.ne.jp>
"

let s:verbose = 0
let s:candidate_file = globpath($VIM.','.&runtimepath, 'SKK-JISYO.L')
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
  "hide
  exe "normal! 1\<C-W>_"
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

function! s:Candidate_GeneratePattern(keyword)
  return '^'.a:keyword.' '
endfunction

" 検索に使用する状態変数
let s:last_keyword = ''
let s:last_found = 0
let s:last_candidate = ''
let s:last_candidate_str = ''
let s:last_candidate_num = 0

" 辞書から未確定文字列を検索
function! s:CandidateSearch(keyword)
  let pat = s:Candidate_GeneratePattern(a:keyword)
  let found_num = s:last_found

  " 検索文字列が前回と同じ時は省略
  if s:last_keyword !=# a:keyword
    let s:last_keyword = a:keyword
    if !s:Candidate_FileOpen()
      return 0
    endif
    let in_candidate_window = 1
    " 実際の検索
    execute "silent normal! gg/".pat."\<CR>"
    let s:last_candidate = ''
    let s:last_candidate_str = substitute(getline('.'), pat, '', '')
    let s:last_candidate_num = 1
    let found_num = line('.')
    execute "normal! \<C-w>p"
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
    call s:StatusEcho()
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
  execute "silent normal! gg/^." . a:ch . "$\<CR>"
  let found_num = line('.')
  if found_num > 1
    execute "normal! l"
    let retchar = strpart(getline('.'), 0, col('.') - 1)
  else
    let retchar = a:ch
  endif
  execute "normal! \<C-w>p"
  return retchar
endfunction

" char1とchar2をこの順番で合成してできる文字を検索して返す。
" 見つからない場合は''を返す
function! s:BushuSearchCompose(char1, char2)
  if !s:Bushu_FileOpen()
    return ''
  endif
  execute "silent normal! gg/^." . a:char1 . a:char2 . "\<CR>"
  let found_num = line('.')
  if found_num > 1
    execute "normal! l"
    let retchar = strpart(getline('.'), 0, col('.') - 1)
  else
    let retchar = ''
  endif
  execute "normal! \<C-w>p"
  return retchar
endfunction

" 部首合成変換辞書を検索
function! s:BushuSearch(char1, char2)
  " そのまま合成できる?
  let retchar = s:BushuSearchCompose(a:char1, a:char2)
  if retchar !=# '' && retchar !=# a:char1 && retchar !=# a:char2
    return retchar
  endif

  " 等価文字どうしで合成できる?
  let ch1alt = s:BushuAlternative(a:char1)
  let ch2alt = s:BushuAlternative(a:char2)
  let retchar = s:BushuSearchCompose(ch1alt, ch2alt)
  if retchar !=# '' && retchar !=# a:char1 && retchar !=# a:char2
    return retchar
  endif

  " 引き算
  " XXX:
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

function! s:InputNullSpace()
  call s:StatusSet()
endfunction

function! s:InputConvert()
  if !s:StatusIsEnable()
    execute "normal! gi \<ESC>`^"
    call s:StatusReset()
  else
    let status = s:StatusGet()
    let len = strlen(status)
    if len > 0
      call s:CandidateSearch(status)
    else
      let s:last_keyword = ''
      execute "normal! gi \<ESC>`^"
      call s:StatusReset()
    endif
  endif
endfunction

function! s:InputCR()
  if !s:StatusIsEnable()
    execute "normal! a\<CR>\<ESC>"
  else
    let str = s:StatusGet()
    let len = strlen(str)
    if len > 0
      if s:last_keyword ==# str
	call s:CandidateSelect(len)
      endif
    else
      execute "normal! a\<CR>\<ESC>"
    endif
  endif
  call s:StatusReset()
endfunction

function! s:InputStart()
  call s:StatusSet()
endfunction

" 直前の2文字の部首合成変換を行う
function! s:InputConvertBushu()
  let col3 = col("'^")
  if col3 > 3
    let save_ve = &ve
    let &ve = 'all'
    execute "normal! " . col3 . "|h"
    let col2 = col(".")
    execute "normal! h"
    let col1 = col(".")
    execute "normal! " . col3 . "|"
    let &ve = save_ve
    let str = getline('.')
    let char1 = strpart(str, col1 - 1, col2 - col1)
    let char2 = strpart(str, col2 - 1, col3 - col2)
    let retchar = s:BushuSearch(char1, char2)
    let len = strlen(retchar)
    if len > 0
      call s:BushuReplace(line("."), col1, col3, retchar)
    endif
  endif
endfunction

" 今の位置以前の2文字を部首合成変換する
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  call s:InputConvertBushu()
endfunction

" 今の位置以前のcount文字を変換する
function! s:ConvertCount(count)
  if a:count < 1
    call s:StatusReset()
    execute "normal! 1 "
  else
    let s:status_line = line(".")
    let save_col = col(".")
    execute "normal! a\<ESC>"
    let count = a:count - 1
    if count > 0
      execute "normal! " . count . "h"
    endif
    let s:status_column = col(".")
    execute "normal! " . save_col . "|"
    if !s:StatusIsEnable()
      call s:StatusReset()
    else
      let status = s:StatusGet()
      let len = strlen(status)
      if len > 0
	call s:CandidateSearch(status)
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
  if !s:StatusIsEnable()
    execute "normal! \<CR>"
  else
    let str = s:StatusGet()
    let len = strlen(str)
    if len > 0
      if s:last_keyword ==# str
	call s:CandidateSelect(len)
	execute "normal! " . (s:status_column - 1) . "|"
      endif
    else
      execute "normal! \<CR>"
    endif
  endif
  call s:StatusReset()
endfunction

"==============================================================================
"				  キートラップ
"

"   マッピングを有効化
function! s:MappingOn()
  inoremap <buffer> <CR> <C-O>:call <SID>InputCR()<CR>
  inoremap <buffer> M <C-O>:call <SID>InputStart()<CR>
  inoremap <buffer> <Space> <C-O>:call <SID>InputConvert()<CR>
  inoremap <buffer> B <C-O>:call <SID>InputConvertBushu()<CR>
  nnoremap <buffer> <CR> :<C-U>call <SID>FixCandidate()<CR>
  nnoremap <buffer> <Space> :<C-U>call <SID>ConvertCount(v:count)<CR>
  nnoremap <buffer> <C-N> :<C-U>call <SID>ConvertBushu()<CR>
endfunction

"   マッピングを無効化
function! s:MappingOff()
  imapclear <buffer>
  nmapclear <buffer>
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
