" vi:set ts=8 sts=2 sw=2 tw=0 nowrap:
"
" vime.vim - �ʰ�SKK-IME
"
" Last Change: 23-Apr-2003.
" Written By:  Muraoka Taro <koron@tka.att.ne.jp>
"

let s:verbose = 0
let s:candidate_file = globpath($VIM.','.&runtimepath, 'SKK-JISYO.L')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
"echo "candidate_file: ".s:candidate_file

"==============================================================================
"				    ���񸡺�
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

" ����ǡ����ե�����򥪡��ץ�
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

" �����˻��Ѥ�������ѿ�
let s:last_keyword = ''
let s:last_found = 0
let s:last_candidate = ''
let s:last_candidate_str = ''
let s:last_candidate_num = 0

" ���񤫤�̤����ʸ����򸡺�
function! s:CandidateSearch(keyword)
  let pat = s:Candidate_GeneratePattern(a:keyword)
  let found_num = s:last_found

  " ����ʸ���������Ʊ�����Ͼ�ά
  if s:last_keyword !=# a:keyword
    let s:last_keyword = a:keyword
    if !s:Candidate_FileOpen()
      return 0
    endif
    let in_candidate_window = 1
    " �ºݤθ���
    execute "silent normal! gg/".pat."\<CR>"
    let s:last_candidate = ''
    let s:last_candidate_str = substitute(getline('.'), pat, '', '')
    let s:last_candidate_num = 1
    let found_num = line('.')
    execute "normal! \<C-w>p"
  else
    " �����Ѵ������õ���Ф�����
    if s:last_candidate_num > 0 && s:last_candidate != ''
      let s:last_candidate_num = s:last_candidate_num + strlen(s:last_candidate) + 1
    endif
  endif

  if found_num > 1
    " ���䤬�ߤĤ��äƤ���ʤ�С����֤�ɽ������
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
    " ���䤬�ߤĤ���ʤ��ä������ꥻ�å�
    let s:last_candidate = ''
    let s:last_candidate_str = ''
    let s:last_candidate_num = 0
  endif
  let s:last_found = found_num
endfunction

" �����Хåե�������
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

" �����������ǡ����ե�����򥪡��ץ�
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

" ����ʸ���򸡺������֤�������ʸ�����ʤ����Ϥ�Ȥ�ʸ�����Τ�Τ��֤�
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

" char1��char2�򤳤ν��֤ǹ������ƤǤ���ʸ���򸡺������֤���
" ���Ĥ���ʤ�����''���֤�
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

" ��������Ѵ�����򸡺�
function! s:BushuSearch(char1, char2)
  " ���Τޤ޹����Ǥ���?
  let retchar = s:BushuSearchCompose(a:char1, a:char2)
  if retchar !=# '' && retchar !=# a:char1 && retchar !=# a:char2
    return retchar
  endif

  " ����ʸ���ɤ����ǹ����Ǥ���?
  let ch1alt = s:BushuAlternative(a:char1)
  let ch2alt = s:BushuAlternative(a:char2)
  let retchar = s:BushuSearchCompose(ch1alt, ch2alt)
  if retchar !=# '' && retchar !=# a:char1 && retchar !=# a:char2
    return retchar
  endif

  " ������
  " XXX:
  return ''
endfunction

" �����������ʸ����Хåե�������
function! s:BushuReplace(linenum, stcol, endcol, ch)
  let str = getline(a:linenum)
  let str = strpart(str, 0, a:stcol - 1) . a:ch . strpart(str, a:endcol - 1)
  call setline(a:linenum, str)
endfunction

"==============================================================================
"				    ��������
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

" ľ����2ʸ������������Ѵ���Ԥ�
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

" ���ΰ��ְ�����2ʸ������������Ѵ�����
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  call s:InputConvertBushu()
endfunction

" ���ΰ��ְ�����countʸ�����Ѵ�����
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

" ConvertCount()���Ѵ��򳫻Ϥ����������ꤹ��
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
"				  �����ȥ�å�
"

"   �ޥåԥ󥰤�ͭ����
function! s:MappingOn()
  inoremap <buffer> <CR> <C-O>:call <SID>InputCR()<CR>
  inoremap <buffer> M <C-O>:call <SID>InputStart()<CR>
  inoremap <buffer> <Space> <C-O>:call <SID>InputConvert()<CR>
  inoremap <buffer> B <C-O>:call <SID>InputConvertBushu()<CR>
  nnoremap <buffer> <CR> :<C-U>call <SID>FixCandidate()<CR>
  nnoremap <buffer> <Space> :<C-U>call <SID>ConvertCount(v:count)<CR>
  nnoremap <buffer> <C-N> :<C-U>call <SID>ConvertBushu()<CR>
endfunction

"   �ޥåԥ󥰤�̵����
function! s:MappingOff()
  imapclear <buffer>
  nmapclear <buffer>
endfunction

"==============================================================================
"			     ̤����ʸ�������Ѵؿ���
"

"   ̤����ʸ����¸�ߤ��뤫�����å�����
function! s:StatusIsEnable()
  if s:status_line != line('.') || s:status_column <= 0 || s:status_column > col('.')
    return 0
  endif
  return 1
endfunction

"   ̤����ʸ����򳫻Ϥ���
function! s:StatusSet()
  let s:status_line = line("'^")
  let s:status_column = col("'^")
  call s:StatusEcho()
  if s:verbose
    echo "StatusSet: SLINE=".s:status_line." SCOLUMN=".s:status_column
  endif
endfunction

"   ̤����ʸ�����ꥻ�åȤ���
function! s:StatusReset()
  let s:status_line = 0
  let s:status_column = 0
endfunction

"   ̤����ʸ�����־��֡פȤ��Ƽ�������
function! s:StatusGet()
  if !s:StatusIsEnable()
    return ''
  endif

  " ɬ�פʥѥ�᡼�������
  let stpos = s:status_column - 1
  let ccl = col("'^")
  let len = ccl - s:status_column
  let str = getline('.')

  if s:verbose
    echo "SLINE=".s:status_line." SCOLUMN=".s:status_column." CCOLUMN=".ccl." LEN=".len
  endif
  return strpart(str, stpos, len)
endfunction

"   ̤����ʸ����γ��ϰ��֤Ƚ�λ���֤�ɽ��(�ǥХå���)
function! s:StatusEcho(...)
  echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

"==============================================================================
"				   �������
"

call s:StatusReset()
command! VImeOn :call <SID>MappingOn()
command! VImeOff :call <SID>MappingOff()
