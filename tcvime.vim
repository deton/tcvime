" vi:set ts=8 sts=2 sw=2 tw=0:
"
" tcvime.vim - tcode.vim���δ���ľ������keymap�Ǥ����Ϥ�������롣
"              �򤼽��Ѵ�����������Ѵ����Ǹ��إ��ɽ����ǽ��
"
" Last Change: $Date: 2003/05/14 13:04:40 $
" Maintainer: deton(KIHARA Hideto)@m1.interq.or.jp
" Original Plugin: vime.vim by Muraoka Taro <koron@tka.att.ne.jp>

" Description:
" ����ˡ:
"   mazegaki.dic��bushu.rev��$VIM��'runtimepath'�Ǽ������ǥ��쥯�ȥ��
"   �֤��Ƥ����Ƥ���������
"
"   :TcvimeOn���ޥ�ɤǥޥåԥ󥰤�ͭ���ˤʤ�ޤ���
"
"  Insert Mode�Ǥθ򤼽��Ѵ�:
"    <Leader>q ���Ѵ��о�ʸ����λϤޤ��ޡ������ޤ���
"    <Leader><Space> �Ǹ򤼽��Ѵ���Ԥ��ޤ���
"      <Leader>q �ǥޡ����������֤��鸽�ߤΥ���������֤δ֤ˤ���ʸ�����
"      mazegaki.dic�Ǹ������ޤ���
"      ���䤬��Ĥ����ʤ������Ѵ��о�ʸ������֤������ޤ���
"      ���䤬ʣ��������ϡ����ޥ�ɹԤξ��CANDIDATE: �Ǹ��䤬ɽ������ޤ���
"      Ʊ���Ѵ��о�ʸ������Ф���<Leader><Space>�򷫤��֤��ǤĤȡ�
"      �������ɽ�����Ƥ����ޤ���
"      ����Υꥹ�ȤκǸ�ޤǹԤ��ȥꥹ�Ȥκǽ�����ޤ���
"    <Leader><CR> ��CANDIDATE: �Ȥ���ɽ������Ƥ����������򤷤�
"      �Ѵ��о�ʸ������֤������ޤ���
"
"  Insert Mode�Ǥθ򤼽��Ѵ�(���ѤΤ����):
"    ����Ū�ˤϳ��ѤΤʤ���θ򤼽��Ѵ���Ʊ���Ǥ���
"    "��"��Ĥ���<Leader><Space>���Ѵ����뤫�����Ѥ��ʤ���ʬ�ޤ����Ϥ��Ƥ��顢
"    <Leader>o ���Ѵ����ޤ���
"    <Leader>o ��<Leader>q �ǥޡ����������֤��鸽�ߤΥ���������֤δ֤�ʸ�����
"    "��"���ղä���ʸ�����mazegaki.dic���鸡�����ޤ���
"
"  Insert Mode�Ǥ���������Ѵ�:
"    <Leader>b �ǥ���������֤�ľ����2ʸ������������Ѵ���Ԥ��ޤ���
"
"  Normal Mode�Ǥθ򤼽��Ѵ�:
"    [count]<Leader><Space> ����������ְ�����[count]ʸ���θ򤼽��Ѵ���
"      �Ԥ��ޤ���
"    <Leader><CR> ��CANDIDATE: �Ȥ���ɽ������Ƥ����������򤷤�
"      �Ѵ��о�ʸ������֤������ޤ���
"
"  Normal Mode�Ǥθ򤼽��Ѵ�(���ѤΤ����):
"    [count]<Leader>o ����������ְ�����[count]ʸ����"��"���ղä���ʸ�����
"      mazegaki.dic���鸡�����ޤ���
"
"  Normal Mode�Ǥ���������Ѵ�:
"    <Leader>b ����������ְ�����2ʸ������������Ѵ���Ԥ��ޤ���
"
" �Ǹ��إ��ɽ��(Normal Mode):
"    <Leader>? �ǥ���������֤�ʸ�����Ǹ���ɽ�����ޤ���
"      �������keymap��ľ�����ϤǤ��ʤ�ʸ���ξ��ϡ�
"      ��������Ѵ�����򸡺����ơ����ꤵ�줿ʸ�����ޤޤ��Ԥ�ɽ�����ޤ���
"
" ���ץ����:
"    'tcvime_keyboard'
"       �Ǹ��إ��ɽ���ѤΥ����ܡ��������ɽ��ʸ����
"       �����θ�˥��ڡ�������2�󤺤ĵ��Ҥ��롣
"       ��:
"         let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
"
"    'mapleader'
"       |mapleader|

" ���Υץ饰������ɹ��ߤ����ʤ�����.vimrc�˼��Τ褦�˽񤯤���:
"       :let plugin_tcvime_disable = 1

if exists('plugin_tcvime_disable')
  finish
endif

if !exists("tcvime_keyboard")
  " querty
  let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
  " �����������ʤ�ɽ�����ʤ����ϼ���ʸ�����Ȥ��褦�ˤ���(qwerty)
  let tcvime_keyboard = "q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
endif

" Mapping
command! TcvimeOn :call <SID>MappingOn()
command! TcvimeOff :call <SID>MappingOff()
" keymap�����ꤷ�ơ�TcvimeOn����
" ����: keymap̾
command! -nargs=1 TcvimeInit :call <SID>TcvimeInit(<f-args>)

"   �ޥåԥ󥰤�ͭ����
function! s:MappingOn()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-J>"
    let set_mapleader = 1
  endif
  let s:mapleader = g:mapleader
  inoremap <silent> <buffer> <Leader><CR> <C-O>:call <SID>InputFix()<CR>
  inoremap <silent> <buffer> <Leader>q <C-O>:call <SID>InputStart()<CR>
  inoremap <silent> <buffer> <Leader><Space> <C-O>:call <SID>InputConvert()<CR>
  inoremap <silent> <buffer> <Leader>o <C-O>:call <SID>InputConvertKatuyo()<CR>
  inoremap <silent> <buffer> <Leader>b <C-O>:call <SID>InputConvertBushu(1)<CR>
  nnoremap <silent> <buffer> <Leader><CR> :<C-U>call <SID>FixCandidate()<CR>
  nnoremap <silent> <buffer> <Leader><Space> :<C-U>call <SID>ConvertCount(v:count)<CR>
  nnoremap <silent> <buffer> <Leader>o :<C-U>call <SID>ConvertKatuyo(v:count)<CR>
  nnoremap <silent> <buffer> <Leader>b :<C-U>call <SID>ConvertBushu()<CR>
  nnoremap <silent> <buffer> <Leader>? :<C-U>call <SID>ShowStrokeHelp()<CR>
  if set_mapleader
    unlet g:mapleader
  endif
endfunction

"   �ޥåԥ󥰤�̵����
function! s:MappingOff()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-J>"
    let set_mapleader = 1
  else
    let save_mapleader = g:mapleader
  endif
  let g:mapleader = s:mapleader
  silent! iunmap <buffer> <Leader><CR>
  silent! iunmap <buffer> <Leader>q
  silent! iunmap <buffer> <Leader><Space>
  silent! iunmap <buffer> <Leader>o
  silent! iunmap <buffer> <Leader>b
  silent! nunmap <buffer> <Leader><CR>
  silent! nunmap <buffer> <Leader><Space>
  silent! nunmap <buffer> <Leader>o
  silent! nunmap <buffer> <Leader>b
  silent! nunmap <buffer> <Leader>?
  if set_mapleader
    unlet g:mapleader
  else
    let g:mapleader = save_mapleader
  endif
endfunction

" keymap�����ꤷ��Tcvime��Mapping��ͭ���ˤ���
function! s:TcvimeInit(keymapname)
  if &iminsert == 0 && &keymap !=# a:keymapname
    let &keymap = a:keymapname
    call s:MappingOn()
  endif
endfunction


" ����
let s:helpbufname = "[TcvimeHelp]"
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
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
  hide
  "exe "normal! 1\<C-W>_"
endfunction

" ����ǡ����ե�����򥪡��ץ�
function! s:Candidate_FileOpen()
  if filereadable(s:candidate_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:candidate_file) < 0
    execute "augroup Tcvime"
    execute "autocmd!"
    execute "autocmd WinEnter ".s:candidate_file." call <SID>Candidate_WinEnter()"
    execute "autocmd WinLeave ".s:candidate_file." call <SID>Candidate_WinLeave()"
    execute "augroup END"
    execute 'silent normal! :sv '.s:candidate_file."\<CR>"
  endif
  return 1
endfunction

" �����˻��Ѥ�������ѿ�
let s:last_keyword = ''
let s:last_found = 0
let s:last_candidate = ''
let s:last_candidate_str = ''
let s:last_candidate_num = 0
let s:is_katuyo = 0

" ���񤫤�̤����ʸ����򸡺�
" ���䤬��Ĥ����ʤ�����1���֤������䤬ʣ���������0���֤���
function! s:CandidateSearch(keyword)
  let found_num = s:last_found
  let uniq = 0

  " ����ʸ���������Ʊ�����Ͼ�ά
  if s:last_keyword !=# a:keyword
    let s:last_keyword = a:keyword
    if !s:Candidate_FileOpen()
      return 0
    endif

    " �ºݤθ���
    let v:errmsg = ""
    silent! execute "normal! gg/^" . a:keyword . " \<CR>"
    if v:errmsg != ""
      let found_num = 0
    else
      let s:last_candidate = ''
      let s:last_candidate_str = substitute(getline('.'), '^' . a:keyword . ' ', '', '')
      let s:last_candidate_num = 1
      let found_num = line('.')
      if s:last_candidate_str =~# '^/[^/]\+/$'
	let uniq = 1
      endif
    endif
    execute "normal! \<C-w>p"
  else
    " �����Ѵ������õ���Ф�����
    if s:last_candidate_num > 0 && s:last_candidate != ''
      let s:last_candidate_num = s:last_candidate_num + strlen(s:last_candidate) + 1
    endif
    " �����Ѵ�����ʸ���������Ѵ������硢�����������å���ľ��
    if s:last_candidate_num == 1 && s:last_candidate == ''
      if s:last_candidate_str =~# '^/[^/]\+/$'
	let uniq = 1
      endif
    endif
  endif

  if found_num > 0
    " ���䤬�ߤĤ��äƤ���ʤ�С����֤�ɽ������
    let str = ''
    while strlen(str) < 1
      let str = matchstr(s:last_candidate_str, '[^/]\+', s:last_candidate_num)
      if strlen(str) < 1
	let s:last_candidate_num = 1
      endif
    endwhile
    let s:last_candidate = str
    if !uniq
      echo "CANDIDATE: ".str
    endif
  else
    " ���䤬�ߤĤ���ʤ��ä������ꥻ�å�
    let s:last_candidate = ''
    let s:last_candidate_str = ''
    let s:last_candidate_num = 0
  endif
  let s:last_found = found_num
  return uniq
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

" �����������ǡ����ե�����򥪡��ץ�
function! s:Bushu_FileOpen()
  if filereadable(s:bushu_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushu_file) < 0
    execute "augroup Tcvime"
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
  let v:errmsg = ""
  silent! execute "normal! gg/^." . a:ch . "$\<CR>"
  if v:errmsg == ""
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
  let v:errmsg = ""
  silent! execute "normal! gg/^." . a:char1 . a:char2 . "\<CR>"
  if v:errmsg == ""
    execute "normal! l"
    let retchar = strpart(getline('.'), 0, col('.') - 1)
  else
    let retchar = ''
  endif
  execute "normal! \<C-w>p"
  return retchar
endfunction

" ���ꤵ�줿ʸ����2�Ĥ������ʬ�򤹤롣
" ʬ�򤷤������s:decomp1, s:decomp2�˥��åȤ��롣
" @return 1: ʬ�������������硢0: ʬ��Ǥ��ʤ��ä����
function! s:BushuDecompose(ch)
  if !s:Bushu_FileOpen()
    return 0
  endif
  let v:errmsg = ""
  silent! execute "normal! gg/^" . a:ch . "..\<CR>"
  if v:errmsg == ""
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
  execute "normal! \<C-w>p"
  return ret
endfunction

" �������ʸ�������Ǥʤ�������ʸ���Ǥ�ʤ����Ȥ��ǧ
" @param ch �������ʸ��
" @param char1 ����ʸ��
" @param char2 ����ʸ��
" @return 1: ch�����Ǥ�char1�Ǥ�char2�Ǥ�ʤ���硣0: ����ʳ��ξ��
function! s:BushuCharOK(ch, char1, char2)
  if a:ch !=# '' && a:ch !=# a:char1 && a:ch !=# a:char2
    return 1
  else
    return 0
  endif
endfunction

" ��������Ѵ�����򸡺�
function! s:BushuSearch(char1, char2)
  let char1 = a:char1
  let char2 = a:char2
  let i = 0
  while i < 2
    " ���Τޤ޹����Ǥ���?
    let retchar = s:BushuSearchCompose(char1, char2)
    if s:BushuCharOK(retchar, char1, char2)
      return retchar
    endif

    " ����ʸ���ɤ����ǹ����Ǥ���?
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

    " ����ʸ���������ʬ��
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

    " ������
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

    " ���������ʤˤ��­����
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

    " ξ�������ʤˤ��­����
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

    " ���ʤˤ�������
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

    " ʸ���ν��դˤ��Ƥ�äƤߤ�
    let t = char1  | let char1  = char2  | let char2 = t
    let t = ch1alt | let ch1alt = ch2alt | let ch2alt = t
    let t = ch1a1  | let ch1a1  = ch2a1  | let ch2a1 = t
    let t = ch1a2  | let ch1a2  = ch2a2  | let ch2a2 = t
    let i = i + 1
  endwhile

  " �����Ǥ��ʤ��ä�
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

function! s:InputConvert()
  let col = col("'^")
  let s:is_katuyo = 0
  let status = s:StatusGet()
  let uniq = 0
  let len = strlen(status)
  if len > 0
    let uniq = s:CandidateSearch(status)
  else
    let s:last_keyword = ''
    call s:StatusReset()
  endif
  execute "normal! " . col . "|"
  if uniq
    call s:InputFix()
  endif
endfunction

" ���ѤΤ���ñ����Ѵ���Ԥ���
" �Ѵ��о�ʸ����������ˡ֡��פ��ɲä��Ƹ򤼽񤭼���򸡺����롣
function! s:InputConvertKatuyo()
  let col = col("'^")
  let status = s:StatusGet()
  let uniq = 0
  let len = strlen(status)
  if len > 0
    let s:is_katuyo = 1
    let uniq = s:CandidateSearch(status . "��")
  else
    let s:last_keyword = ''
    call s:StatusReset()
  endif
  execute "normal! " . col . "|"
  if uniq
    call s:InputFix()
  endif
endfunction

" ���ꤷ�褦�Ȥ��Ƥ�����䤬����ʤ����ɤ��������å�
function! s:IsCandidateOK(str)
  if strlen(a:str) > 0 && strlen(s:last_candidate) > 0
    if s:is_katuyo && s:last_keyword ==# a:str . "��" || s:last_keyword ==# a:str
      return 1
    endif
  endif
  return 0
endfunction

function! s:InputFix()
  let str = s:StatusGet()
  if s:IsCandidateOK(str)
    let len = strlen(str)
    call s:CandidateSelect(len)
    execute "normal! " . s:status_column . "|"
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

" ľ����2ʸ������������Ѵ���Ԥ�
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

" ���ΰ��ְ�����2ʸ������������Ѵ�����
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  call s:InputConvertBushu(0)
endfunction

" ������ConvertCount(), ConvertKatuyo()���Ϥ��줿count�������͡�
" count��0�Ǽ¹Ԥ��줿���˰�����count�ͤ�Ȥ��褦�ˤ��뤿�ᡣ
let s:last_count = 0

" ���ΰ��ְ�����countʸ�����Ѵ�����
function! s:ConvertCount(count)
  let cnt = a:count
  if cnt == 0
    let cnt = s:last_count
    if cnt == 0
      let cnt = 1
    endif
  endif
  let s:last_count = cnt

  let s:is_katuyo = 0
  let s:status_line = line(".")
  let save_col = col(".")
  execute "normal! a\<ESC>"
  let cnt = cnt - 1
  if cnt > 0
    execute "normal! " . cnt . "h"
  endif
  let s:status_column = col(".")
  execute "normal! " . save_col . "|"

  let status = s:StatusGet()
  let len = strlen(status)
  if len > 0
    let s:save_cmdheight = &cmdheight
    if &cmdheight < 2
      let &cmdheight = 2
    endif
    let uniq = s:CandidateSearch(status)
    if uniq
      call s:FixCandidate()
    endif
  else
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
  endif
endfunction

" ���ΰ��ְ�����countʸ������ѤΤ����Ȥ����Ѵ�����
function! s:ConvertKatuyo(count)
  let cnt = a:count
  if cnt == 0
    let cnt = s:last_count
    if cnt == 0
      let cnt = 1
    endif
  endif
  let s:last_count = cnt

  let s:status_line = line(".")
  let save_col = col(".")
  execute "normal! a\<ESC>"
  let cnt = cnt - 1
  if cnt > 0
    execute "normal! " . cnt . "h"
  endif
  let s:status_column = col(".")
  execute "normal! " . save_col . "|"

  let status = s:StatusGet()
  let len = strlen(status)
  if len > 0
    let s:save_cmdheight = &cmdheight
    if &cmdheight < 2
      let &cmdheight = 2
    endif
    let s:is_katuyo = 1
    let uniq = s:CandidateSearch(status . "��")
    if uniq
      call s:FixCandidate()
    endif
  else
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
  endif
endfunction

" ConvertCount()���Ѵ��򳫻Ϥ����������ꤹ��
function! s:FixCandidate()
  execute "normal! a\<ESC>"
  let str = s:StatusGet()
  if s:IsCandidateOK(str)
    let len = strlen(str)
    call s:CandidateSelect(len)
    execute "normal! " . (s:status_column - 1) . "|"
  endif
  let s:last_count = 0
  call s:StatusReset()
endfunction

"==============================================================================
" �إ��ɽ��

" �إ���ѥХåե��򳫤�
function! s:OpenHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) < 0
    execute "augroup Tcvime"
    execute "autocmd!"
    execute "autocmd WinEnter ".s:helpbufname." call <SID>Candidate_WinEnter()"
    execute "autocmd WinLeave ".s:helpbufname." call <SID>Candidate_WinLeave()"
    execute "augroup END"
    execute "silent normal! :sp " . s:helpbufname . "\<CR>"
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal noswapfile
  else
    execute "normal! :%d\<CR>"
  endif
  execute "normal! 4\<C-W>\<C-_>"
endfunction

" ����������֤�ʸ�����Ǹ���ɽ������
function! s:ShowStrokeHelp()
  let col1 = col(".")
  execute "normal! a\<ESC>"
  let col2 = col("'^")
  let ch = strpart(getline("."), col1 - 1, col2 - col1)
  call s:ShowHelp(ch)
endfunction

" ���ꤵ�줿ʸ�������Ϥ��뤿����Ǹ���ɽ������
function! s:ShowHelp(ch)
  if &keymap == ""
    return
  endif
  let keyseq = s:SearchKeymap(a:ch)
  if strlen(keyseq) > 0
    call s:ShowHelpSequence(a:ch, keyseq)
  else
    call s:ShowHelpBushuDic(a:ch)
  endif
endfunction

" ���ꤵ�줿ʸ���Ȥ����Ǹ���ɽ�ˤ���ɽ������
function! s:ShowHelpSequence(ch, keyseq)
  call s:OpenHelpBuffer()
  execute "normal! a" . tcvime_keyboard . "\<ESC>"
  let keyseq = a:keyseq
  let i = 0
  while strlen(keyseq) > 0
    let i = i + 1
    let key = strpart(keyseq, 0, 1)
    let keyseq = strpart(keyseq, 1)
    execute "normal! :%s@\\V" . key . " @" . i . "@\<CR>"
  endwhile
  execute "normal! :%s@^\\(....................\\). . @\\1@e\<CR>"
  execute "normal! :%s@^\\(................\\). . @\\1@e\<CR>"
  execute "normal! :%s@\\(.\\)\\(.\\)@\\1\\2@ge\<CR>"
  execute "normal! :%s@\\(.\\). @\\1@ge\<CR>"
  execute "normal! :%s@. . @��@g\<CR>"
  execute "normal! :%s@@ @ge\<CR>"
  execute "normal! 1GA    " . a:ch . "\<ESC>"
endfunction

" ����������񤫤顢���ꤵ�줿ʸ����ޤ�Ԥ򸡺�����ɽ������
function! s:ShowHelpBushuDic(ch)
  let lines = s:SearchBushuDic(a:ch)
  if strlen(lines) > 0
    call s:OpenHelpBuffer()
    execute "normal! a" . lines . "\<ESC>1G"
  endif
endfunction

" ����������񤫤顢���ꤵ�줿ʸ����ޤ�Ԥ򸡺�����
function! s:SearchBushuDic(ch)
  if !s:Bushu_FileOpen()
    return ""
  endif
  let lines = ""
  let v:errmsg = ""
  silent! execute "normal! gg/" . a:ch . "\<CR>"
  if v:errmsg == ""
    let lines = getline('.')
    let save_wrapscan = &wrapscan
    let &wrapscan = 0
    while v:errmsg == ""
      let v:errmsg = ""
      silent! execute "normal! n"
      if v:errmsg == ""
	let lines = lines . "\<CR>" . getline('.')
      endif
    endwhile
    let &wrapscan = save_wrapscan
  endif
  quit!
  return lines
endfunction

" ���ꤵ�줿ʸ�������Ϥ��뤿����Ǹ���keymap�ե����뤫�鸡������
function! s:SearchKeymap(ch)
  let kmfile = globpath(&rtp, "keymap/" . &keymap . "_" . &encoding . ".vim")
  if filereadable(kmfile) != 1
    let kmfile = globpath(&rtp, "keymap/" . &keymap . ".vim")
    if filereadable(kmfile) != 1
      return ""
    endif
  endif
  execute "silent normal! :sv " . kmfile . "\<CR>"
  let v:errmsg = ""
  execute "normal! /loadkeymap/\<CR>"
  silent! execute 'normal! /^[^"].*[^ 	]\+[ 	]\+' . a:ch . "/\<CR>"
  if v:errmsg == ""
    let keyseq = substitute(getline('.'), '[ 	]\+.*$', '', '')
  else
    let keyseq = ""
  endif
  quit!
  return keyseq
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

  return strpart(str, stpos, len)
endfunction

"   ̤����ʸ����γ��ϰ��֤Ƚ�λ���֤�ɽ��(�ǥХå���)
function! s:StatusEcho(...)
  echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

call s:StatusReset()
