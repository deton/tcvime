" vi:set ts=8 sts=2 sw=2 tw=0:
"
" tcvime.vim - tcode.vim���̊������ړ���keymap�ł̓��͕⏕�@�\:
"              ���������ϊ��A���񍇐��ϊ��A�Ō��w���v�\���@�\�B
"
" Last Change: $Date: 2003/05/19 14:38:42 $
" Maintainer: deton(KIHARA Hideto)@m1.interq.or.jp
" Original Plugin: vime.vim by Muraoka Taro <koron@tka.att.ne.jp>

scriptencoding cp932

" Description:
" �g�p�@:
"   mazegaki.dic��bushu.rev��$VIM��'runtimepath'�Ŏ������f�B���N�g����
"   �u���Ă����Ă��������B
"
"   :TcvimeOn�R�}���h�Ń}�b�s���O���L���ɂȂ�܂��B
"   tcvime�̋@�\��'mapleader'�Ŏw�肳�ꂽ�L�[�̌��
"   'q'�Ȃǂ̃L�[����͂��邱�ƂŎ��s����܂��B
"   'mapleader'�̃f�t�H���g��"\<C-K>"(CTRL�L�[�������Ȃ���k)�ł��B
"   �ȍ~�̐�������<Leader>�Ƃ����������mapleader��\���Ă��܂��B
"   �܂�Amapleader��"\<C-K>"�̏ꍇ�A<Leader>q �� CTRL-J�̌��q����͂���A
"   �Ƃ������Ƃł��B
"   �܂��A<Space>�̓X�y�[�X�L�[�A<CR>�̓G���^�[�L�[�ł��B
"
"  Insert Mode�ł̌��������ϊ�:
"    <Leader>q �ŕϊ��Ώە�����̎n�܂���}�[�N���܂��B
"    <Leader><Space> �Ō��������ϊ����s���܂��B
"      <Leader>q �Ń}�[�N�����ʒu���猻�݂̃J�[�\���ʒu�̊Ԃɂ��镶�����
"      �ǂ݂Ƃ���mazegaki.dic�Ō������܂��B
"      ��₪������Ȃ��ꍇ�͕ϊ��Ώە������u�������܂��B
"      ��₪��������ꍇ�́A�R�}���h�s�̏��CANDIDATE: �Ō�₪�\������܂��B
"      �����ϊ��Ώە�����ɑ΂���<Leader><Space>���J��Ԃ��łƁA
"      �������ɕ\�����Ă����܂��B
"      ���̃��X�g�̍Ō�܂ōs���ƃ��X�g�̍ŏ��ɖ߂�܂��B
"    <Leader><CR> ��CANDIDATE: �Ƃ��ĕ\������Ă������I������
"      �ϊ��Ώە������u�������܂��B
"
"    ��: "<Leader>q����<Leader><Space>"�ƑłƁA
"        "CANDIDATE: ��"�ƕ\������܂��B
"        �����"<Leader><Space>"��ł�"CANDIDATE: ��"�ƂȂ�܂��B
"        ���̏�Ԃ�"<Leader><CR>"��łƁA"����"��"��"�ɒu���������܂��B
"
"  Insert Mode�ł̌��������ϊ�(���p�����):
"    ��{�I�ɂ͊��p���Ȃ���̌��������ϊ��Ɠ����ł��B
"    "�\"������<Leader><Space>�ŕϊ����邩�A���p���Ȃ������܂œ��͂��Ă���A
"    <Leader>o �ŕϊ����܂��B
"    <Leader>o ��<Leader>q �Ń}�[�N�����ʒu���猻�݂̃J�[�\���ʒu�̊Ԃ̕������
"    "�\"��t�������������ǂ݂Ƃ���mazegaki.dic���猟�����܂��B
"
"    ��: "<Leader>q�Ȃ���<Leader>o"�ƑłƁA"CANDIDATE: ����"�ƕ\������܂��B
"        "<Leader><CR>"�ƑłƁA"�Ȃ���"��"����"�ɒu���������܂��B
"
"  Insert Mode�ł̕��񍇐��ϊ�:
"    <Leader>b �ŃJ�[�\���ʒu�̒��O��2�����̕��񍇐��ϊ����s���܂��B
"
"    ��: "�،�<Leader>b"�ƑłƁA"�،�"��"��"�ɒu���������܂��B
"
"  Normal Mode�ł̌��������ϊ�:
"    [count]<Leader><Space> �J�[�\���ʒu�ȑO��[count]�����̌��������ϊ���
"      �s���܂��B
"    <Leader><CR> ��CANDIDATE: �Ƃ��ĕ\������Ă������I������
"      �ϊ��Ώە������u�������܂��B
"
"    ��: "����"�ƕ\������Ă���Ƃ��A"��"�̏�ɃJ�[�\����u����
"        "2<Leader><Space>"�ƑłƁA"CANDIDATE: ��"�ƕ\������܂��B
"        �����"<Leader><Space>"�ƑłƁA"CANDIDATE: ��"�ƕ\������܂��B
"        ���̏�Ԃ�"<Leader><CR>"��łƁA"����"��"��"�ɒu���������܂��B
"
"  Normal Mode�ł̌��������ϊ�(���p���Ȃ���):
"    [count]<Leader>o �J�[�\���ʒu�ȑO��[count]������"�\"��t�������������
"      �ǂ݂Ƃ���mazegaki.dic���猟�����܂��B
"
"    ��: "�Ȃ���"�ƕ\������Ă���Ƃ��A"��"�̏�ɃJ�[�\����u����
"        "3<Leader>o"�ƑłƁA"CANDIDATE: ����"�ƕ\������܂��B
"        "<Leader><CR>"�ƑłƁA"�Ȃ���"��"����"�ɒu���������܂��B
"
"  Normal Mode�ł̕��񍇐��ϊ�:
"    <Leader>b �J�[�\���ʒu�ȑO��2�����̕��񍇐��ϊ����s���܂��B
"
"    ��: "�،�"�ƕ\������Ă���Ƃ��A"��"�̏�ɃJ�[�\����u����
"        "<Leader>b"�ƑłƁA"�،�"��"��"�ɒu���������܂��B
"
" �Ō��w���v�\��(Normal Mode):
"    <Leader>? �ŃJ�[�\���ʒu�̕����̑Ō���\�����܂��B
"      �g�p����keymap�Œ��ړ��͂ł��Ȃ������̏ꍇ�́A
"      ���񍇐��ϊ��������������āA�w�肳�ꂽ�������܂܂��s��\�����܂��B
"
"    ��: "��"�Ƃ��������̏�ɃJ�[�\����u����"<Leader>?"�ƑłƁA
"        "[TcvimeHelp]"�Ƃ����o�b�t�@���J���Ď��̂悤�ɕ\������܂�
"        (keymap��tutcode�̏ꍇ)�B
"        �E�E�E�E    �E�E�E�E    ��
"        �E�E�E�E  3 �E�E�E�E
"        �E�E�E�E    �E�E�E�E
"        �E�E1 2     �E�E�E�E
"
" �I�v�V����:
"    'tcvime_keyboard'
"       �Ō��w���v�\���p�̃L�[�{�[�h�z���\��������B
"       �L�[�̌�ɃX�y�[�X�A��2�񂸂L�q����B
"       ��:
"         let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
"
"    'mapleader'
"       |mapleader|

" ���̃v���O�C����Ǎ��݂����Ȃ�����.vimrc�Ɏ��̂悤�ɏ�������:
"       :let plugin_tcvime_disable = 1

if exists('plugin_tcvime_disable')
  finish
endif

if !exists("tcvime_keyboard")
  let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
  " �����L�[�̒i��\�����Ȃ��ꍇ�͎��̕�������g���悤�ɂ���(qwerty)
"  let tcvime_keyboard = "q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
endif

" Mapping
command! TcvimeOn :call <SID>MappingOn()
command! TcvimeOff :call <SID>MappingOff()
" keymap��ݒ肵�āATcvimeOn����
" ����: keymap��
command! -nargs=1 TcvimeInit :call <SID>TcvimeInit(<f-args>)

"   �}�b�s���O��L����
function! s:MappingOn()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-J>"
    let set_mapleader = 1
  endif
  let s:mapleader = g:mapleader
  inoremap <silent> <Leader><CR> <C-O>:call <SID>InputFix()<CR>
  inoremap <silent> <Leader>q <C-O>:call <SID>InputStart()<CR>
  inoremap <silent> <Leader><Space> <C-O>:call <SID>InputConvert(0)<CR>
  inoremap <silent> <Leader>o <C-O>:call <SID>InputConvert(1)<CR>
  inoremap <silent> <Leader>b <C-O>:call <SID>InputConvertBushu(1)<CR>
  nnoremap <silent> <Leader><CR> :<C-U>call <SID>FixCandidate()<CR>
  nnoremap <silent> <Leader><Space> :<C-U>call <SID>ConvertCount(v:count, 0)<CR>
  nnoremap <silent> <Leader>o :<C-U>call <SID>ConvertCount(v:count, 1)<CR>
  nnoremap <silent> <Leader>b :<C-U>call <SID>ConvertBushu()<CR>
  nnoremap <silent> <Leader>? :<C-U>call <SID>ShowStrokeHelp()<CR>
  if set_mapleader
    unlet g:mapleader
  endif

  augroup Tcvime
  autocmd!
  execute "autocmd BufReadCmd ".s:helpbufpat." call <SID>Help_BufReadCmd()"
  augroup END

  call s:StatusReset()
endfunction

"   �}�b�s���O�𖳌���
function! s:MappingOff()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-J>"
    let set_mapleader = 1
  else
    let save_mapleader = g:mapleader
  endif
  let g:mapleader = s:mapleader
  silent! iunmap <Leader><CR>
  silent! iunmap <Leader>q
  silent! iunmap <Leader><Space>
  silent! iunmap <Leader>o
  silent! iunmap <Leader>b
  silent! nunmap <Leader><CR>
  silent! nunmap <Leader><Space>
  silent! nunmap <Leader>o
  silent! nunmap <Leader>b
  silent! nunmap <Leader>?
  if set_mapleader
    unlet g:mapleader
  else
    let g:mapleader = save_mapleader
  endif

  augroup Tcvime
  autocmd!
  augroup END
endfunction

" keymap��ݒ肵��Tcvime��Mapping��L���ɂ���
function! s:TcvimeInit(keymapname)
  if &keymap !=# a:keymapname
    let &keymap = a:keymapname
    call s:MappingOn()
  endif
endfunction


" �ݒ�
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
"echo "candidate_file: ".s:candidate_file
let s:helpbufname = '[TcvimeHelp]'
let s:helpbufpat = '\[TcvimeHelp\]'

"==============================================================================
"				    ��������
"

" �����f�[�^�t�@�C�����I�[�v��
function! s:Candidate_FileOpen()
  if filereadable(s:candidate_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:candidate_file) < 0
    execute 'silent normal! :sv '.s:candidate_file."\<CR>"
  endif
  return 1
endfunction

" �����Ɏg�p�����ԕϐ�
let s:last_keyword = ''
let s:last_found = 0
let s:last_candidate = ''
let s:last_candidate_str = ''
let s:last_candidate_num = 0
let s:is_katuyo = 0

" �������疢�m�蕶���������
" @return -1:�������J���Ȃ��ꍇ, 0:�����񂪌�����Ȃ��ꍇ,
"   1:��₪1�������������ꍇ, 2:��₪2�ȏ㌩�������ꍇ
function! s:CandidateSearch(keyword)
  let found_num = s:last_found
  let uniq = 0
  let ret = 0

  " ���������񂪑O��Ɠ������͏ȗ�
  if s:last_keyword !=# a:keyword
    let s:last_keyword = a:keyword
    if !s:Candidate_FileOpen()
      return -1
    endif

    " ���ۂ̌���
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
    quit!
  else
    " ���̕ϊ�����T���o������
    if s:last_candidate_num > 0 && s:last_candidate != ''
      let s:last_candidate_num = s:last_candidate_num + strlen(s:last_candidate) + 1
    endif
    " �O��ϊ�������������ēx�ϊ�����ꍇ�A��␔���`�F�b�N������
    if s:last_candidate_num == 1 && s:last_candidate == ''
      if s:last_candidate_str =~# '^/[^/]\+/$'
	let uniq = 1
      endif
    endif
  endif

  if found_num > 0
    " ��₪�݂����Ă���Ȃ�΁A���Ԃɕ\������
    let str = ''
    while strlen(str) < 1
      let str = matchstr(s:last_candidate_str, '[^/]\+', s:last_candidate_num)
      if strlen(str) < 1
	let s:last_candidate_num = 1
      endif
    endwhile
    let s:last_candidate = str
    if uniq
      let ret = 1
    else
      let ret = 2
    endif
  else
    " ��₪�݂���Ȃ��������A���Z�b�g
    let s:last_candidate = ''
    let s:last_candidate_str = ''
    let s:last_candidate_num = 0
    let ret = 0
  endif
  let s:last_found = found_num
  return ret
endfunction

" �����o�b�t�@�ɑ}��
function! s:CandidateSelect(len)
  if strlen(s:last_candidate) > 0
    let str = getline(s:status_line)
    let str = strpart(str, 0, s:status_column - 1).s:last_candidate.strpart(str, s:status_column - 1 + a:len)
    call setline(s:status_line, str)
    let s:status_column = s:status_column + strlen(s:last_candidate)
    let s:last_candidate = ''
    let s:last_candidate_num = 1
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

" ���񍇐������f�[�^�t�@�C�����I�[�v��
function! s:Bushu_FileOpen()
  if filereadable(s:bushu_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushu_file) < 0
    execute 'silent normal! :sv '.s:bushu_file."\<CR>"
  endif
  return 1
endfunction

" �����������������ĕԂ��B�����������Ȃ��ꍇ�͂��Ƃ̕������̂��̂�Ԃ�
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
  quit!
  return retchar
endfunction

" char1��char2�����̏��Ԃō������Ăł��镶�����������ĕԂ��B
" ������Ȃ��ꍇ��''��Ԃ�
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
  quit!
  return retchar
endfunction

" �w�肳�ꂽ������2�̕���ɕ�������B
" �������������s:decomp1, s:decomp2�ɃZ�b�g����B
" @return 1: �����ɐ��������ꍇ�A0: �����ł��Ȃ������ꍇ
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
  quit!
  return ret
endfunction

" ������̕�������łȂ��A���̕����ł��Ȃ����Ƃ��m�F
" @param ch ������̕���
" @param char1 ���̕���
" @param char2 ���̕���
" @return 1: ch����ł�char1�ł�char2�ł��Ȃ��ꍇ�B0: ����ȊO�̏ꍇ
function! s:BushuCharOK(ch, char1, char2)
  if a:ch !=# '' && a:ch !=# a:char1 && a:ch !=# a:char2
    return 1
  else
    return 0
  endif
endfunction

" ���񍇐��ϊ�����������
function! s:BushuSearch(char1, char2)
  let char1 = a:char1
  let char2 = a:char2
  let i = 0
  while i < 2
    " ���̂܂܍����ł���?
    let retchar = s:BushuSearchCompose(char1, char2)
    if s:BushuCharOK(retchar, char1, char2)
      return retchar
    endif

    " ���������ǂ����ō����ł���?
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

    " ���������𕔎�ɕ���
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

    " �����Z
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

    " ��������i�ɂ�鑫���Z
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

    " ���������i�ɂ�鑫���Z
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

    " ���i�ɂ������Z
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

    " �����̏����t�ɂ��Ă���Ă݂�
    let t = char1  | let char1  = char2  | let char2 = t
    let t = ch1alt | let ch1alt = ch2alt | let ch2alt = t
    let t = ch1a1  | let ch1a1  = ch2a1  | let ch2a1 = t
    let t = ch1a2  | let ch1a2  = ch2a2  | let ch2a2 = t
    let i = i + 1
  endwhile

  " �����ł��Ȃ�����
  return ''
endfunction

" ���񍇐������������o�b�t�@�ɑ}��
function! s:BushuReplace(linenum, stcol, endcol, ch)
  let str = getline(a:linenum)
  let str = strpart(str, 0, a:stcol - 1) . a:ch . strpart(str, a:endcol - 1)
  call setline(a:linenum, str)
endfunction

"==============================================================================
"				    ���͐���
"

" Insert mode�Ō��������ϊ����s���B
" ���p�̂����̕ϊ��̏ꍇ�́A
" �ϊ��Ώە�����̖����Ɂu�\�v��ǉ����Č���������������������B
" @param katuyo ���p�̂����̕ϊ����ǂ����B0:���p�Ȃ�, 1:���p����
function! s:InputConvert(katuyo)
  let col = col("'^")
  let s:is_katuyo = 0
  let status = s:StatusGet()
  let len = strlen(status)
  if len > 0
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let status = status . '�\'
    endif
    let found = s:CandidateSearch(status)
  else
    let s:last_keyword = ''
    call s:InputStart()
  endif
  execute "normal! " . col . "|"
  if exists('found')
    if found == 2
      echo 'CANDIDATE: ' . s:last_candidate
    elseif found == 1
      call s:InputFix()
    elseif found == 0
      echo 'Not found: ' . status
    elseif found == -1
      echo '���������ϊ������t�@�C���̃I�[�v���Ɏ��s���܂���: ' . s:candidate_file
    endif
  endif
endfunction

" �m�肵�悤�Ƃ��Ă����₪���Ȃ����ǂ����`�F�b�N
function! s:IsCandidateOK(str)
  if strlen(a:str) > 0 && strlen(s:last_candidate) > 0
    if s:is_katuyo && s:last_keyword ==# (a:str . '�\') || s:last_keyword ==# a:str
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
  let &cmdheight = s:save_cmdheight
  unlet s:save_cmdheight
endfunction

" &cmdheight��2��菬����������2�ɐݒ肷��BCANDIDATE:�\���̂��߁B
function! s:SetCmdheight()
  if !exists('s:save_cmdheight')
    let s:save_cmdheight = &cmdheight
  endif
  if &cmdheight < 2
    let &cmdheight = 2
  endif
endfunction

function! s:InputStart()
  call s:SetCmdheight()
  call s:StatusSet()
endfunction

" ���O��2�����̕��񍇐��ϊ����s��
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
      echo '���񍇐��ϊ����ł��܂���ł���: ' . char1 . ', ' . char2
    endif
    let &ve = save_ve
  endif
endfunction

" ���̈ʒu�ȑO��2�����𕔎񍇐��ϊ�����
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  call s:InputConvertBushu(0)
endfunction

" �ȑO��ConvertCount()�ɓn���ꂽcount�����̒l�B
" count��0�Ŏ��s���ꂽ�ꍇ�ɈȑO��count�l���g���悤�ɂ��邽�߁B
let s:last_count = 0

" ���̈ʒu�ȑO��count������ϊ�����
" @param count �ϊ����镶����̒���
" @param katuyo ���p�̂����̕ϊ����ǂ����B0:���p�Ȃ�, 1:���p����
function! s:ConvertCount(count, katuyo)
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
    call s:SetCmdheight()
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let status = status . '�\'
    endif
    let found = s:CandidateSearch(status)
    if found == 2
      echo 'CANDIDATE: ' . s:last_candidate
    elseif found == 1
      call s:FixCandidate()
    elseif found == 0
      echo 'Not found: ' . status
    elseif found == -1
      echo '���������ϊ������t�@�C���̃I�[�v���Ɏ��s���܂���: ' . s:candidate_file
    endif
  else
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
  endif
endfunction

" ConvertCount()�ŕϊ����J�n���������m�肷��
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
  let &cmdheight = s:save_cmdheight
  unlet s:save_cmdheight
endfunction

"==============================================================================
" �w���v�\��

" ��̃w���v�p�o�b�t�@�����
function! s:Help_BufReadCmd()
  set ft=
  set buftype=nofile
  set bufhidden=delete
  set noswapfile
endfunction

" �w���v�p�o�b�t�@���J��
function! s:OpenHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) < 0
    execute "silent normal! :sp " . s:helpbufname . "\<CR>"
  endif
  execute "normal! :%d\<CR>4\<C-W>\<C-_>"
endfunction

" �J�[�\���ʒu�̕����̑Ō���\������
function! s:ShowStrokeHelp()
  let col1 = col(".")
  execute "normal! a\<ESC>"
  let col2 = col("'^")
  let ch = strpart(getline("."), col1 - 1, col2 - col1)
  call s:ShowHelp(ch)
endfunction

" �w�肳�ꂽ��������͂��邽�߂̑Ō���\������
function! s:ShowHelp(ch)
  if strlen(a:ch) == 0 || &keymap == ""
    return
  endif
  let keyseq = s:SearchKeymap(a:ch)
  if strlen(keyseq) > 0
    call s:ShowHelpSequence(a:ch, keyseq)
  else
    call s:ShowHelpBushuDic(a:ch)
  endif
endfunction

" �w�肳�ꂽ�����Ƃ��̑Ō���\�ɂ��ĕ\������
function! s:ShowHelpSequence(ch, keyseq)
  call s:OpenHelpBuffer()
  execute "normal! ggO" . g:tcvime_keyboard . "\<ESC>"
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
  execute "normal! :%s@. . @�E@g\<CR>"
  execute "normal! :%s@@ @ge\<CR>"
  execute "normal! 1GA    " . a:ch . "\<ESC>"
  execute "normal! \<C-W>p"
endfunction

" ���񍇐���������A�w�肳�ꂽ�������܂ލs���������ĕ\������
function! s:ShowHelpBushuDic(ch)
  let lines = s:SearchBushuDic(a:ch)
  if strlen(lines) > 0
    call s:OpenHelpBuffer()
    execute "normal! a" . lines . "\<ESC>1G"
    execute "normal! \<C-W>p"
  endif
endfunction

" ���񍇐���������A�w�肳�ꂽ�������܂ލs����������
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

" �w�肳�ꂽ��������͂��邽�߂̑Ō���keymap�t�@�C�����猟������
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

  return strpart(str, stpos, len)
endfunction

"   ���m�蕶����̊J�n�ʒu�ƏI���ʒu��\��(�f�o�b�O�p)
function! s:StatusEcho(...)
  echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

call s:StatusReset()
