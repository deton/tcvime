" vi:set ts=8 sts=2 sw=2 tw=0 nowrap:
"
" vime.vim - �Ȉ�SKK-IME
"
" Last Change: 02-Jul-2001.
" Written By:  Muraoka Taro <koron@tka.att.ne.jp>
"

let s:verbose = 0
let s:candidate_file = globpath($VIM.','.&runtimepath, 'SKK-JISYO.L')
"echo "candidate_file: ".s:candidate_file

"==============================================================================
"				    ��������
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
  exe "normal! 1\<C-W>_"
endfunction

" �����f�[�^�t�@�C�����I�[�v��
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

" �����Ɏg�p�����ԕϐ�
let s:last_keyword = ''
let s:last_found = 0
let s:last_candidate = ''
let s:last_candidate_str = ''
let s:last_candidate_num = 0

" �������疢�m�蕶���������
function! s:CandidateSearch(keyword)
  let pat = s:Candidate_GeneratePattern(a:keyword)
  let found_num = s:last_found

  " ���������񂪑O��Ɠ������͏ȗ�
  if s:last_keyword !=# a:keyword
    let s:last_keyword = a:keyword
    if !s:Candidate_FileOpen()
      return 0
    endif
    let in_candidate_window = 1
    " ���ۂ̌���
    execute "silent normal! gg/".pat."\<CR>"
    let s:last_candidate = ''
    let s:last_candidate_str = substitute(getline('.'), pat, '', '')
    let s:last_candidate_num = 1
    let found_num = line('.')
    execute "normal! \<C-w>p"
  else
    " ���̕ϊ�����T���o������
    if s:last_candidate_num > 0 && s:last_candidate != ''
      let s:last_candidate_num = s:last_candidate_num + strlen(s:last_candidate) + 1
    endif
  endif

  if found_num > 1
    " ��₪�݂����Ă���Ȃ�΁A���Ԃɕ\������
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
    " ��₪�݂���Ȃ��������A���Z�b�g
    let s:last_candidate = ''
    let s:last_candidate_str = ''
    let s:last_candidate_num = 0
  endif
  let s:last_found = found_num
endfunction

" �����o�b�t�@�ɑ}��
function! s:CandidateSelect(len)
  if strlen(s:last_candidate) > 0
    let str = getline(s:status_line)
    let str = strpart(str, 0, s:status_column - 1).s:last_candidate.strpart(str, s:status_column + a:len)
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

"==============================================================================
"				    ���͐���
"

function! s:InputNullSpace()
  call s:StatusSet()
endfunction

function! s:InputConvert()
  if !s:StatusIsEnable()
    call s:StatusSet()
  else
    let status = s:StatusGet()
    let len = strlen(status)
    if len > 0
      call s:CandidateSearch(status)
    else
      let s:last_keyword = ''
      call s:StatusSet()
    endif
  endif
endfunction

function! s:InputCR()
  if !s:StatusIsEnable()
    execute "normal! a\<CR>\<ESC>"
    call s:StatusSet()
  else
    let str = s:StatusGet()
    let len = strlen(str)
    if len > 0
      if s:last_keyword ==# str
	call s:CandidateSelect(len)
      else
	call s:StatusReset()
	call s:StatusSet()
      endif
    else
      execute "normal! a\<CR>\<ESC>"
    endif
  endif
endfunction

function! s:InputStart()
  call s:StatusSet()
endfunction

"==============================================================================
"				  �L�[�g���b�v
"

"   �}�b�s���O��L����
function! s:MappingOn()
  inoremap <buffer> <CR> <C-O>:call <SID>InputCR()<CR>
  inoremap <buffer> <Space> <C-O>:call <SID>InputConvert()<CR>
  inoremap <buffer> <S-Space> <Space><C-O>:call <SID>InputNullSpace()<CR>

  let normal_hook = 'iIaACRS'
  let i = 0
  let len = strlen(normal_hook)
  while i < len
    let char = normal_hook[i]
    let i = i + 1
    execute "nnoremap <buffer> ".char." ".char."\<C-O>:call <SID>InputStart()\<CR>"
  endwhile
endfunction

"   �}�b�s���O�𖳌���
function! s:MappingOff()
  imapclear <buffer>
endfunction

"==============================================================================
"			     ���m�蕶���Ǘ��p�֐��Q
"

"   ���m�蕶���񂪑��݂��邩�`�F�b�N����
function! s:StatusIsEnable()
  if s:status_line != line('.') || s:status_column <= 0 || s:status_column > col('.')
    return 0
  endif
  return 1
endfunction

"   ���m�蕶������J�n����
function! s:StatusSet()
  let s:status_line = line("'^")
  let s:status_column = col("'^")
  call s:StatusEcho()
  if s:verbose
    echo "StatusSet: SLINE=".s:status_line." SCOLUMN=".s:status_column
  endif
endfunction

"   ���m�蕶��������Z�b�g����
function! s:StatusReset()
  let s:status_line = 0
  let s:status_column = 0
endfunction

"   ���m�蕶������u��ԁv�Ƃ��Ď擾����
function! s:StatusGet()
  if !s:StatusIsEnable()
    return ''
  endif

  " �K�v�ȃp�����[�^�����W
  let stpos = s:status_column - 1
  let ccl = col("'^")
  let len = ccl - s:status_column
  let str = getline('.')

  if s:verbose
    echo "SLINE=".s:status_line." SCOLUMN=".s:status_column." CCOLUMN=".ccl." LEN=".len
  endif
  return strpart(str, stpos, len)
endfunction

"   ���m�蕶����̊J�n�ʒu�ƏI���ʒu��\��(�f�o�b�O�p)
function! s:StatusEcho(...)
  echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

"==============================================================================
"				   �����ݒ�
"

call s:StatusReset()
command! VImeOn :call <SID>MappingOn()
command! VImeOff :call <SID>MappingOff()
