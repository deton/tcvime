" vi:set ts=8 sts=2 sw=2 tw=0:
"
" tcvime.vim - tcode,tutcode���̊������ړ���keymap�ł̓��͕⏕�@�\:
"              ���������ϊ��A���񍇐��ϊ��A�����w���v�\�\���@�\�B
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2012-11-17
" Original Plugin: vime.vim by Muraoka Taro <koron@tka.att.ne.jp>

scriptencoding cp932

" Description:
" �R�}���h:
"   :TcvimeOn         �L�[�}�b�s���O��L��������
"   :TcvimeOff        �L�[�}�b�s���O�𖳌�������
"   :TcvimeHelp       �w�肵�������̃w���v�\��\������
"   :TcvimeHelpBushu  �w�肵���������܂ލs�𕔎񍇐��ϊ��������猟�����ĕ\��
"   :TcvimeSetKeymap  keymap��set����
"   :TcvimeKanjiTable �����e�[�u���t�@�C����\�����āA������I��œ���
"
" imap:
"   <Leader>q       ���������ϊ�: �ǂ݂��J�n
"   <Leader><Space> ���������ϊ�: �ϊ����s
"   <Leader><CR>    ���������ϊ�: ���m��
"   <Leader>o       ���������ϊ�: ���p�����̕ϊ����s
"   <Leader>b       ���񍇐��ϊ�: ���O��2�����̕��񍇐��ϊ����s
"
" nmap:
"   [count]<Leader><Space>  ���������ϊ�: �J�[�\���ʒu�ȑO��[count]�����̕ϊ�
"   <Leader><CR>            ���������ϊ�: ���m��
"   [count]<Leader>o        ���������ϊ�: [count]�����̊��p�����̕ϊ�
"   <Leader>b               ���񍇐��ϊ�: �J�[�\���ʒu�ȑO��2�����̕��񍇐��ϊ�
"   <Leader>?               �Ō��w���v�\��: �J�[�\���ʒu�̕����̃w���v�\��\��
"   <Leader>t               �����e�[�u���t�@�C���\��
"
" vmap:
"   <Leader>?               �Ō��w���v�\��: �I�𒆂�(����)�����̃w���v�\��\��
"
" �I�v�V����:
"    'tcvime_keyboard'
"       �����w���v�\�p�̃L�[�{�[�h�z���\��������B
"       �L�[�̌�ɃX�y�[�X�A��2�񂸂L�q����B
"       ��:
"         let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
"
"    'tcvime_keymap_for_help'
"       �����w���v�\���Ɏg��keymap�B���݂̃o�b�t�@��&keymap�����ݒ�̏ꍇ�Ɏg�p
"
"    'mapleader'
"       �L�[�}�b�s���O�̃v���t�B�b�N�X�B|mapleader|���Q�ƁB�ȗ��l: CTRL-K
"       CTRL-K���w�肷��ꍇ�̗�:
"         let mapleader = "\<C-K>"
"
"    'plugin_tcvime_disable'
"       ���̃v���O�C����ǂݍ��݂����Ȃ��ꍇ�Ɏ��̂悤�ɐݒ肷��B
"         let plugin_tcvime_disable = 1

if exists('plugin_tcvime_disable')
  finish
endif

if !exists("tcvime_keymap_for_help")
  let tcvime_keymap_for_help = &keymap
endif

if !exists("tcvime_keyboard")
  let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
  " �����L�[�̒i��\�����Ȃ��ꍇ�͎��̕�������g���悤�ɂ���(qwerty)
"  let tcvime_keyboard = "q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
endif

" �ݒ�
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
let s:kanjitable_file = globpath($VIM.','.&runtimepath, 'kanjitable.txt')
let s:helpbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeHelp__'
let s:helpbufname = substitute(s:helpbufname, '\\', '/', 'g')
" �����t�@�C����:ls���ŕ\�������悤�ɂ��邩�ǂ����B0:�\������Ȃ�,1:�\������
let s:buflisted = 0

" Mapping
command! TcvimeOn call <SID>MappingOn()
command! TcvimeOff call <SID>MappingOff()
" keymap��ݒ肷��
" ����: keymap��
command! -nargs=1 TcvimeSetKeymap call <SID>SetKeymap(<args>)
" �w�肳�ꂽ������̃w���v�\��\������
" ����: �Ώۂ̕�����
command! -nargs=1 TcvimeHelp call <SID>ShowHelpForStr(<q-args>, 0)
" �w�肳�ꂽ��������̊e�������܂ލs�𕔎񍇐��ϊ��������猟�����ĕ\������
" ����: �Ώۂ̕�����
command! -nargs=1 TcvimeHelpBushu call <SID>ShowHelpForStr(<q-args>, 1)
" �����e�[�u����\������
command! TcvimeKanjiTable call <SID>KanjiTable_FileOpen()

" keymap��ݒ肷��
function! s:SetKeymap(keymapname)
  if &keymap !=# a:keymapname
    let &keymap = a:keymapname
  endif
endfunction

"   �}�b�s���O��L����
function! s:MappingOn()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-K>"
    let set_mapleader = 1
  endif
  let s:mapleader = g:mapleader
  inoremap <silent> <Leader><CR> <C-R>=<SID>InputFix(col('.'))<CR>
  inoremap <silent> <Leader>q <C-R>=<SID>InputStart()<CR>
  inoremap <silent> <Leader><Space> <C-R>=<SID>InputConvert(0)<CR>
  inoremap <silent> <Leader>o <C-R>=<SID>InputConvert(1)<CR>
  inoremap <silent> <Leader>b <C-R>=<SID>InputConvertBushu(col('.'))<CR>
  nnoremap <silent> <Leader><CR> :<C-U>call <SID>FixCandidate()<CR>
  nnoremap <silent> <Leader><Space> :<C-U>call <SID>ConvertCount(v:count, 0)<CR>
  nnoremap <silent> <Leader>o :<C-U>call <SID>ConvertCount(v:count, 1)<CR>
  nnoremap <silent> <Leader>b :<C-U>call <SID>ConvertBushu()<CR>
  nnoremap <silent> <Leader>? :<C-U>call <SID>ShowStrokeHelp()<CR>
  nnoremap <silent> <Leader>t :<C-U>call <SID>KanjiTable_FileOpen()<CR>
  vnoremap <silent> <Leader>? :<C-U>call <SID>ShowHelpVisual()<CR>
  if set_mapleader
    unlet g:mapleader
  endif

  augroup Tcvime
  autocmd!
  execute "autocmd BufReadCmd ".s:helpbufname." call <SID>Help_BufReadCmd()"
  augroup END

  "if !exists('s:save_cmdheight')
  "  let s:save_cmdheight = &cmdheight
  "endif
endfunction

"   �}�b�s���O�𖳌���
function! s:MappingOff()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-K>"
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
  silent! nunmap <Leader>t
  if set_mapleader
    unlet g:mapleader
  else
    let g:mapleader = save_mapleader
  endif

  augroup Tcvime
  autocmd!
  augroup END
  "unlet s:save_cmdheight
endfunction

TcvimeOn

"==============================================================================
"				    ���͐���

" �ǂ݂̓��͂��J�n
function! s:InputStart()
  call s:SetCmdheight()
  call s:StatusSet()
  return ''
endfunction

" Insert mode�Ō��������ϊ����s���B
" ���p�����̕ϊ��̏ꍇ�́A
" �ϊ��Ώە�����̖����Ɂu�\�v��ǉ����Č���������������������B
" @param katuyo ���p�����̕ϊ����ǂ����B0:���p���Ȃ�, 1:���p����
function! s:InputConvert(katuyo)
  let inschars = ''
  let s:is_katuyo = 0
  let status = s:StatusGet(col('.'))
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
  if exists('found')
    if found == 2
      echo 'CANDIDATE: ' . s:last_candidate
    elseif found == 1
      let inschars = s:InputFix(col('.'))
    elseif found == 0
      echo '���������������ɂ͌�����܂���: <' . status . '>'
    elseif found == -1
      echo '���������ϊ������t�@�C���̃I�[�v���Ɏ��s���܂���: ' . s:candidate_file
    endif
  endif
  return inschars
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

" �����m�肵�āA�m�肵���������Ԃ�
function! s:InputFix(col)
  let inschars = ''
  let str = s:StatusGet(a:col)
  if s:IsCandidateOK(str)
    let inschars = s:CandidateSelect()
    if strlen(inschars) > 0
      let bs = substitute(str, '.', "\<BS>", "g")
      let inschars = bs . inschars
    endif
  endif
  call s:StatusReset()
  if exists('s:save_cmdheight')
    let &cmdheight = s:save_cmdheight
  endif
  return inschars
endfunction

" &cmdheight��2��菬����������2�ɐݒ肷��BCANDIDATE:�\���̂��߁B
function! s:SetCmdheight()
  let s:save_cmdheight = &cmdheight
  if &cmdheight < 2
    let &cmdheight = 2
  endif
endfunction

" ���O��2�����̕��񍇐��ϊ����s��
function! s:InputConvertBushu(col)
  let inschars = ''
  if a:col > 2
    let chars = matchstr(getline('.'), '..\%' . a:col . 'c')
    let char1 = matchstr(chars, '^.')
    let char2 = matchstr(chars, '.$')
    let retchar = s:BushuSearch(char1, char2)
    let len = strlen(retchar)
    if len > 0
      let inschars = "\<BS>\<BS>" . retchar
    else
      echo '���񍇐��ϊ����ł��܂���ł���: <' . char1 . '>, <' . char2 . '>'
    endif
  endif
  return inschars
endfunction

" �ȑO��ConvertCount()�ɓn���ꂽcount�����̒l�B
" count��0�Ŏ��s���ꂽ�ꍇ�ɈȑO��count�l���g���悤�ɂ��邽�߁B
let s:last_count = 0

" ���̈ʒu�ȑO��count������ϊ�����
" @param count �ϊ����镶����̒���
" @param katuyo ���p�����̕ϊ����ǂ����B0:���p���Ȃ�, 1:���p����
function! s:ConvertCount(count, katuyo)
  let cnt = a:count
  if cnt == 0
    let cnt = s:last_count
    if cnt == 0
      let cnt = 1
    endif
  endif
  let s:last_count = cnt

  " cnt���̕�����Ƀ}�b�`���鐳�K�\�������
  let i = 0
  let mstr = ''
  while i < cnt
    let mstr = mstr . '.'
    let i = i + 1
  endwhile

  let s:is_katuyo = 0
  let s:status_line = line(".")
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), mstr . '\%' . col("'^") . 'c')

  let len = strlen(chars)
  if len > 0
    let s:status_column = col("'^") - len
    "call s:SetCmdheight()
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let chars = chars . '�\'
    endif
    let found = s:CandidateSearch(chars)
    if found == 2
      echo 'CANDIDATE: ' . s:last_candidate
    elseif found == 1
      call s:FixCandidate()
    elseif found == 0
      echo '���������������ɂ͌�����܂���: <' . chars . '>'
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
  let inschars = s:InputFix(col("'^"))
  let s:last_count = 0
  call s:InsertString(inschars)
endfunction

" ���̈ʒu�ȑO��2�����𕔎񍇐��ϊ�����
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  let inschars = s:InputConvertBushu(col("'^"))
  call s:InsertString(inschars)
endfunction

" �w�肳�ꂽ��������o�b�t�@��append����
function! s:InsertString(inschars)
  if strlen(a:inschars) > 0
    let save_bs = &backspace
    set backspace=2
    execute "normal! a" . a:inschars . "\<ESC>"
    let &backspace = save_bs
  endif
endfunction

"==============================================================================
"			     ���m�蕶���Ǘ��p�֐��Q

"   ���m�蕶���񂪑��݂��邩�`�F�b�N����
function! s:StatusIsEnable(col)
  if s:status_line != line('.') || s:status_column <= 0 || s:status_column > a:col
    return 0
  endif
  return 1
endfunction

"   ���m�蕶������J�n����
function! s:StatusSet()
  let s:status_line = line('.')
  let s:status_column = col('.')
  call s:StatusEcho()
endfunction

"   ���m�蕶��������Z�b�g����
function! s:StatusReset()
  let s:status_line = 0
  let s:status_column = 0
endfunction

"   ���m�蕶������u��ԁv�Ƃ��Ď擾����
function! s:StatusGet(col)
  if !s:StatusIsEnable(a:col)
    return ''
  endif

  " �K�v�ȃp�����[�^�����W
  let stpos = s:status_column - 1
  let len = a:col - s:status_column
  let str = getline('.')

  return strpart(str, stpos, len)
endfunction

"   ���m�蕶����̊J�n�ʒu�ƏI���ʒu��\��(�f�o�b�O�p)
function! s:StatusEcho(...)
  echo '�ǂݓ��͊J�n;<Leader><Space>:�ϊ�,<Leader>o:���p�����̕ϊ�,<Leader><CR>:�m��'
  "echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

" ��ԃ��Z�b�g
call s:StatusReset()

"==============================================================================
" �w���v�\��

" ��̃w���v�p�o�b�t�@�����
function! s:Help_BufReadCmd()
endfunction

" �w���v�p�o�b�t�@���J��
function! s:OpenHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) < 0
    execute "silent normal! :sp " . s:helpbufname . "\<CR>"
    set buftype=nofile
    set bufhidden=delete
    set noswapfile
    set winfixheight
    if !s:buflisted
      set nobuflisted
    endif
  endif
  execute "normal! :%d _\<CR>4\<C-W>\<C-_>"
endfunction

" �w���v�p�o�b�t�@�����
function! s:CloseHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) > 0
    bwipeout!
  endif
endfunction

" �J�[�\���ʒu�̕����̃w���v�\��\������
function! s:ShowStrokeHelp()
  let ch = matchstr(getline('.'), '\%' . col('.') . 'c.')
  call s:ShowHelp([ch], 0)
endfunction

" Visual mode�őI������Ă��镶����̃w���v�\��\������
function! s:ShowHelpVisual()
  let save_reg = @@
  silent execute 'normal! `<' . visualmode() . '`>y'
  call s:ShowHelpForStr(substitute(@@, '\n', '', 'g'), 0)
  let @@ = save_reg
endfunction

" �w�肳�ꂽ������̊e�����̃w���v�\��\������
function! s:ShowHelpForStr(str, forcebushu)
  let ar = split(a:str, '\zs')
  call s:ShowHelp(ar, a:forcebushu)
endfunction

" �w�肳�ꂽ�����z��̃w���v�\��\������
function! s:ShowHelp(ar, forcebushu)
  let keymap = &keymap
  if strlen(keymap) == 0
    let keymap = g:tcvime_keymap_for_help
    if strlen(keymap) == 0
      echo 'tcvime�����w���v�\���ɂ́Akeymap�I�v�V������g:tcvime_keymap_for_help�̐ݒ�v'
      return
    endif
  endif
  call s:OpenHelpBuffer()
  let numch = 0
  let skipchars = []
  for ch in a:ar
    if strlen(ch) == 0 || ch == "\<CR>"
      " echo '�����w���v�\�\���Ɏw�肳�ꂽ��������ł��B�������܂�'
      continue
    endif
    call cursor(line('$'), 1)
    if a:forcebushu == 1
      let ret = s:ShowHelpBushuDic(ch)
    else
      let ret = s:ShowHelpChar(ch, keymap)
    endif
    if ret == 0
      let numch += 1
    else
      call add(skipchars, ch)
    endif
  endfor
  if numch == 0
    call s:CloseHelpBuffer()
  else
    $-1,$d _ " �����̗]���ȋ�s2�s���폜
    normal 1G
    wincmd p
  endif
  if len(skipchars) > 0
    redraw
    echo '�����w���v�ŕ\���ł����񂪂���܂���: <' . join(skipchars, ',') . '>'
  endif
endfunction

" �w�肳�ꂽ�����̃w���v�\��\������
function! s:ShowHelpChar(ch, keymap)
  let keyseq = s:SearchKeymap(a:ch, a:keymap)
  if strlen(keyseq) > 0
    call s:SelectWindowByName(s:helpbufname)
    return s:ShowHelpSequence(a:ch, keyseq)
  else
    return s:ShowHelpBushuDic(a:ch)
  endif
endfunction

" �w�肳�ꂽ�����Ƃ��̃X�g���[�N��\�ɂ��ĕ\������
function! s:ShowHelpSequence(ch, keyseq)
  let from = line('$')
  execute 'normal! O' . g:tcvime_keyboard . "\<CR>\<ESC>"
  let to = line('$')
  let range = from . ',' . to
  let keyseq = a:keyseq
  let i = 0
  while strlen(keyseq) > 0
    let i = i + 1
    let key = strpart(keyseq, 0, 1)
    let keyseq = strpart(keyseq, 1)
    silent! execute range . 's@\V' . key . ' @' . i . '@'
  endwhile
  silent! execute range . 's@^\(....................\). . @\1@e'
  silent! execute range . 's@^\(................\). . @\1@e'
  silent! execute range . 's@\(.\)\(.\)@\1\2@ge'
  silent! execute range . 's@\(.\). @\1@ge'
  silent! execute range . 's@. . @�E@g'
  silent! execute range . 's@@ @ge'
  call cursor(from, 1)
  execute 'normal! A    ' . a:ch . "\<ESC>"
  return 0
endfunction

" ���񍇐���������A�w�肳�ꂽ�������܂ލs���������ĕ\������
function! s:ShowHelpBushuDic(ch)
  let lines = s:SearchBushuDic(a:ch)
  call s:SelectWindowByName(s:helpbufname)
  if strlen(lines) > 0
    execute "normal! O" . lines . "\<CR>\<ESC>"
    return 0
  else
    return -3
  endif
endfunction

" ���񍇐���������A�w�肳�ꂽ�������܂ލs����������
function! s:SearchBushuDic(ch)
  if !s:Bushu_FileOpen()
    return ""
  endif
  let lines = ""
  silent! normal! G$
  if search(a:ch, 'w') != 0
    let lines = getline('.')
    while search(a:ch, 'W') != 0
      let lines = lines . "\<CR>" . getline('.')
    endwhile
  endif
  quit!
  return lines
endfunction

" �w�肳�ꂽ��������͂��邽�߂̃X�g���[�N��keymap�t�@�C�����猟������
function! s:SearchKeymap(ch, keymap)
  let kmfile = globpath(&rtp, "keymap/" . a:keymap . "_" . &encoding . ".vim")
  if filereadable(kmfile) != 1
    let kmfile = globpath(&rtp, "keymap/" . a:keymap . ".vim")
    if filereadable(kmfile) != 1
      return ""
    endif
  endif
  execute "silent normal! :sv " . kmfile . "\<CR>"
  if !s:buflisted
    set nobuflisted
  endif
  let dummy = search('loadkeymap', 'w')
  if search('^[^"].*[^ 	]\+[ 	]\+' . a:ch, 'w') != 0
    let keyseq = substitute(getline('.'), '[ 	]\+.*$', '', '')
  else
    let keyseq = ""
  endif
  quit!
  return keyseq
endfunction

"==============================================================================
"				    ��������

" SelectWindowByName(name)
"   Acitvate selected window by a:name.
function! s:SelectWindowByName(name)
  let num = bufwinnr(a:name)
  if num >= 0 && num != winnr()
    execute 'normal! ' . num . "\<C-W>\<C-W>"
  endif
  return num
endfunction

" ���������ϊ������f�[�^�t�@�C�����I�[�v��
function! s:Candidate_FileOpen()
  if filereadable(s:candidate_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:candidate_file) < 0
    execute 'silent normal! :sv '.s:candidate_file."\<CR>"
    if !s:buflisted
      set nobuflisted
    endif
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
    if search('^' . a:keyword . ' ', 'w') == 0
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

" �m�蕶������擾
function! s:CandidateSelect()
  let inschars = ''
  if strlen(s:last_candidate) > 0
    let i = 0
    let inschars = inschars . s:last_candidate
    let s:status_column = s:status_column + strlen(s:last_candidate)
    let s:last_candidate = ''
    let s:last_candidate_num = 1
  endif
  return inschars
endfunction

" ���񍇐������f�[�^�t�@�C�����I�[�v��
function! s:Bushu_FileOpen()
  if filereadable(s:bushu_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushu_file) < 0
    execute 'silent normal! :sv '.s:bushu_file."\<CR>"
    if !s:buflisted
      set nobuflisted
    endif
  endif
  return 1
endfunction

" �����������������ĕԂ��B�����������Ȃ��ꍇ�͂��Ƃ̕������̂��̂�Ԃ�
function! s:BushuAlternative(ch)
  if !s:Bushu_FileOpen()
    return a:ch
  endif
  if search('^.' . a:ch . '$', 'w') != 0
    let retchar = matchstr(getline('.'), '^.')
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
  if search('^.' . a:char1 . a:char2, 'w') != 0
    let retchar = matchstr(getline('.'), '^.')
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
  if search('^' . a:ch . '..', 'w') != 0
    let chars = matchstr(getline('.'), '^...')
    let s:decomp1 = substitute(chars, '^.\(.\).', '\1', '')
    let s:decomp2 = matchstr(chars, '.$')
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
  if strlen(a:ch) > 0 && a:ch !=# a:char1 && a:ch !=# a:char2
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

    let lench1a1 = strlen(ch1a1)
    let lench1a2 = strlen(ch1a2)
    let lench2a1 = strlen(ch2a1)
    let lench2a2 = strlen(ch2a2)
    let lench1alt = strlen(ch1alt)
    let lench2alt = strlen(ch2alt)

    " �����Z
    if lench1a1 > 0 && lench1a2 > 0 && ch1a2 ==# ch2alt
      let retchar = ch1a1
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a1 > 0 && lench1a2 > 0 && ch1a1 ==# ch2alt
      let retchar = ch1a2
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " ��������i�ɂ�鑫���Z
    if lench1alt > 0 && lench2a1 > 0
      let retchar = s:BushuSearchCompose(ch1alt, ch2a1)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1alt > 0 && lench2a2 > 0
      let retchar = s:BushuSearchCompose(ch1alt, ch2a2)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a1 > 0 && lench2alt > 0
      let retchar = s:BushuSearchCompose(ch1a1, ch2alt)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a2 > 0 && lench2alt > 0
      let retchar = s:BushuSearchCompose(ch1a2, ch2alt)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " ���������i�ɂ�鑫���Z
    if lench1a1 > 0 && lench2a1 > 0
      let retchar = s:BushuSearchCompose(ch1a1, ch2a1)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a1 > 0 && lench2a2 > 0
      let retchar = s:BushuSearchCompose(ch1a1, ch2a2)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a2 > 0 && lench2a1 > 0
      let retchar = s:BushuSearchCompose(ch1a2, ch2a1)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a2 > 0 && lench2a2 > 0
      let retchar = s:BushuSearchCompose(ch1a2, ch2a2)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " ���i�ɂ������Z
    if lench1a2 > 0 && lench2a1 > 0 && ch1a2 ==# ch2a1
      let retchar = ch1a1
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a2 > 0 && lench2a2 > 0 && ch1a2 ==# ch2a2
      let retchar = ch1a1
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a1 > 0 && lench2a1 > 0 && ch1a1 ==# ch2a1
      let retchar = ch1a2
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a1 > 0 && lench2a2 > 0 && ch1a1 ==# ch2a2
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

"==============================================================================
"				  �����e�[�u��

" �����e�[�u���t�@�C�����J��
function! s:KanjiTable_FileOpen()
  if filereadable(s:kanjitable_file) != 1
    echo '�����e�[�u���t�@�C�����ǂ߂܂���: <' . s:kanjitable_file . '>'
    return
  endif
  if s:SelectWindowByName(s:kanjitable_file) < 0
    execute 'silent normal! :sv '.s:kanjitable_file."\<CR>"
  endif
  nnoremap <buffer> <silent> <CR> :<C-U>call <SID>KanjiTable_CopyChar()<CR>
  nnoremap <buffer> <silent> q :<C-U>quit<CR>
endfunction

" �����e�[�u���o�b�t�@���璼�߂̃o�b�t�@�Ɋ������R�s�[����
function! s:KanjiTable_CopyChar()
  let ch = matchstr(getline('.'), '\%' . col('.') . 'c.')
  execute "normal! \<C-W>pa" . ch . "\<ESC>\<C-W>p"
endfunction
