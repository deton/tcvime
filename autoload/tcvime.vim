" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding cp932

" autoload/tcvime.vim - utility functions for tcvime.
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2012-12-08

let s:save_cpo = &cpo
set cpo&vim

" ��u�^�J�^�J�i�ϊ��ŁA���������w�肳��Ă��Ȃ��ۂɁA
" ���̃p�^�[���Ƀ}�b�`���镶���������Ԃ̓J�^�J�i�ɕϊ�����B
let g:tcvime#hira2kata_pat = '[��-��[�E=]*'

let g:tcvime#hira2kata_table = {
  \'��':'�A','��':'�C','��':'�E','��':'�G','��':'�I',
  \'��':'�J','��':'�L','��':'�N','��':'�P','��':'�R',
  \'��':'�T','��':'�V','��':'�X','��':'�Z','��':'�\',
  \'��':'�^','��':'�`','��':'�c','��':'�e','��':'�g',
  \'��':'�i','��':'�j','��':'�k','��':'�l','��':'�m',
  \'��':'�n','��':'�q','��':'�t','��':'�w','��':'�z',
  \'��':'�}','��':'�~','��':'��','��':'��','��':'��',
  \'��':'��','��':'��','��':'��',
  \'��':'��','��':'��','��':'��','��':'��','��':'��',
  \'��':'��','��':'��','��':'��','��':'��',
  \'��':'�K','��':'�M','��':'�O','��':'�Q','��':'�S',
  \'��':'�U','��':'�W','��':'�Y','��':'�[','��':'�]',
  \'��':'�_','��':'�a','��':'�d','��':'�f','��':'�h',
  \'��':'�o','��':'�r','��':'�u','��':'�x','��':'�{',
  \'��':'�p','��':'�s','��':'�v','��':'�y','��':'�|',
  \'��':'�@','��':'�B','��':'�D','��':'�F','��':'�H',
  \'��':'��','��':'��','��':'��',
  \'��':'��','��':'�b','��':'��',
\}

" insert mode���ɁA���O�̎w�肳�ꂽ�������̂Ђ炪�ȁ��J�^�J�i�ϊ����s��
" ���߂̕������Ԃ��B
"
" �������Ƃ���0���w�肷��ƁA
" g:tcvime#hira2kata_pat�Ƀ}�b�`���镶���������Ԃ̓J�^�J�i�ϊ����s���B
" (tutcode keymap�̏ꍇ�A�ȉ��̂悤�ɃJ�^�J�i���͂��\�B
"  �uRKtltugiehe siqljflall�v�A�Ղ肯�[����񁨃A�v���P�[�V����
" �ŏ��̕��������V�t�g�L�[�������Ȃ���Ō����ăJ�^�J�i�œ��͂��āA
" ��̓V�t�g�L�[�����łЂ炪�Ȃœ��͂��āA�Ō�Ɍ�u�^�J�^�J�i�ϊ��ŁA
" �ŏ��ɃJ�^�J�i�œ��͂��������܂ł��܂Ƃ߂ăJ�^�J�i�ϊ�)
" (�J�^�J�i���[�h�ɐ؂�ւ�����u'rktltugiehe siqljfl'�v�A
" �S�ăV�t�g�L�[�������Ȃ���Ō�������uRKTLTUGIEHe SIQLJFL�v�����y����)
"
" tutcode keymap�Ō�u�^�J�^�J�i�ϊ����s�����߂̐ݒ��:
"     lmap all <C-R>=tcvime#InputConvertKatakana(0)<CR>
"     lmap al1 <C-R>=tcvime#InputConvertKatakana(1)<CR>
"     lmap al2 <C-R>=tcvime#InputConvertKatakana(2)<CR>
"     lmap al3 <C-R>=tcvime#InputConvertKatakana(3)<CR>
"     lmap al4 <C-R>=tcvime#InputConvertKatakana(4)<CR>
"     lmap al5 <C-R>=tcvime#InputConvertKatakana(5)<CR>
"     lmap al6 <C-R>=tcvime#InputConvertKatakana(6)<CR>
"     lmap al7 <C-R>=tcvime#InputConvertKatakana(7)<CR>
"     lmap al8 <C-R>=tcvime#InputConvertKatakana(8)<CR>
"     lmap al9 <C-R>=tcvime#InputConvertKatakana(9)<CR>
function! tcvime#InputConvertKatakana(n)
  let col = col('.')
  let cnt = a:n
  if cnt == 0
    " �O�u�^���������ϊ��̓ǂ݂Ƃ��Ďw�肳�ꂽ�����񂪂���΁A�ϊ��ΏۂƂ���
    let yomi = s:StatusGet('.', col)
    if yomi != ''
      let cnt = strlen(substitute(yomi, '.', 'x', 'g'))
    endif
  endif
  return tcvime#InputConvertKatakanaPos(col, cnt)
endfunction

function! tcvime#InputConvertKatakanaPos(col, n)
  if a:n == 0
    " g:tcvime#hira2kata_pat�Ƀ}�b�`���镶�����擾
    let chars = matchstr(getline('.'), g:tcvime#hira2kata_pat . '\%' . a:col . 'c')
  else
    let chars = matchstr(getline('.'), '.\{,' . a:n . '}\%' . a:col . 'c')
  endif
  if strlen(chars) == 0
    return ''
  endif
  let subst = substitute(chars, '.', '\=tcvime#hira2kata(submatch(0))', 'g')
  return substitute(chars, '.', "\<BS>", 'g') . subst
endfunction

function! tcvime#hira2kata(s)
  return get(g:tcvime#hira2kata_table, a:s, a:s)
endfunction

" �ݒ�
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
let s:kanjitable_file = globpath($VIM.','.&runtimepath, 'kanjitable.txt')
let s:helpbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeHelp__'
let s:helpbufname = substitute(s:helpbufname, '\\', '/', 'g')
let s:candbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeCand__'
let s:candbufname = substitute(s:candbufname, '\\', '/', 'g')
" �����t�@�C����:ls���ŕ\�������悤�ɂ��邩�ǂ����B0:�\������Ȃ�,1:�\������
let s:buflisted = 0

" keymap��ݒ肷��
function! tcvime#SetKeymap(keymapname)
  if &l:keymap !=# a:keymapname
    let &l:keymap = a:keymapname
    if exists('*TcvimeCustomKeymap')
      call TcvimeCustomKeymap()
    endif
  else
    let &l:iminsert = 1
  endif
endfunction

"   �}�b�s���O��L����
function! tcvime#MappingOn()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-K>"
    let set_mapleader = 1
  endif
  let s:mapleader = g:mapleader

  if !hasmapto('<Plug>TcvimeIStart')
    imap <unique> <silent> <Leader>q <Plug>TcvimeIStart
  endif
  if !hasmapto('<Plug>TcvimeIConvert')
    imap <unique> <silent> <Leader><Space> <Plug>TcvimeIConvert
  endif
  if !hasmapto('<Plug>TcvimeIKatuyo')
    imap <unique> <silent> <Leader>o <Plug>TcvimeIKatuyo
  endif
  if !hasmapto('<Plug>TcvimeIBushu')
    imap <unique> <silent> <Leader>b <Plug>TcvimeIBushu
  endif
  if !hasmapto('<Plug>TcvimeNConvert')
    nmap <unique> <silent> <Leader><Space> <Plug>TcvimeNConvert
  endif
  if !hasmapto('<Plug>TcvimeNKatuyo')
    nmap <unique> <silent> <Leader>o <Plug>TcvimeNKatuyo
  endif
  if !hasmapto('<Plug>TcvimeNBushu')
    nmap <unique> <silent> <Leader>b <Plug>TcvimeNBushu
  endif
  if !hasmapto('<Plug>TcvimeNHelp')
    nmap <unique> <silent> <Leader>? <Plug>TcvimeNHelp
  endif
  if !hasmapto('<Plug>TcvimeNKanjiTable')
    nmap <unique> <silent> <Leader>t <Plug>TcvimeNKanjiTable
  endif
  if !hasmapto('<Plug>TcvimeVHelp')
    vmap <unique> <silent> <Leader>? <Plug>TcvimeVHelp
  endif

  inoremap <script> <silent> <Plug>TcvimeIStart <C-R>=<SID>InputStart()<CR>
  inoremap <script> <silent> <Plug>TcvimeIConvert <C-R>=<SID>InputConvert(0)<CR>
  inoremap <script> <silent> <Plug>TcvimeIKatuyo <C-R>=<SID>InputConvert(1)<CR>
  inoremap <script> <silent> <Plug>TcvimeIBushu <C-R>=<SID>InputConvertBushu(col('.'))<CR>
  nnoremap <script> <silent> <Plug>TcvimeNConvert :<C-U>call <SID>ConvertCount(v:count, 0)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKatuyo :<C-U>call <SID>ConvertCount(v:count, 1)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKatakana :<C-U>call <SID>ConvertKatakana(v:count)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNBushu :<C-U>call <SID>ConvertBushu()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNHelp :<C-U>call <SID>ShowStrokeHelp()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKanjiTable :<C-U>call tcvime#KanjiTable_FileOpen()<CR>
  vnoremap <script> <silent> <Plug>TcvimeVHelp :<C-U>call <SID>ShowHelpVisual()<CR>

  if set_mapleader
    unlet g:mapleader
  endif

  augroup Tcvime
  autocmd!
  execute "autocmd BufReadCmd ".s:helpbufname." call <SID>Help_BufReadCmd()"
  autocmd CursorMovedI * call <SID>OnCursorMovedI()
  augroup END
endfunction

"   �}�b�s���O�𖳌���
function! tcvime#MappingOff()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-K>"
    let set_mapleader = 1
  else
    let save_mapleader = g:mapleader
  endif
  let g:mapleader = s:mapleader
  silent! iunmap <Leader>q
  silent! iunmap <Leader><Space>
  silent! iunmap <Leader>o
  silent! iunmap <Leader>b
  silent! nunmap <Leader><Space>
  silent! nunmap <Leader>o
  silent! nunmap <Leader>b
  silent! nunmap <Leader>?
  silent! nunmap <Leader>t
  silent! vunmap <Leader>?
  if set_mapleader
    unlet g:mapleader
  else
    let g:mapleader = save_mapleader
  endif

  augroup Tcvime
  autocmd!
  augroup END
endfunction

"==============================================================================
"				    ���͐���

" �ǂ݂̓��͂��J�n
function! s:InputStart()
  call s:StatusSet()
  return ''
endfunction

let s:completeyomi = ''

" Insert mode�Ō�u�^���������ϊ����s���B
" ���p�����̕ϊ��̏ꍇ�́A
" �ϊ��Ώە�����̖����Ɂu�\�v��ǉ����Č���������������������B
"
" tc2���l�̌�u�^���������ϊ����s�����߂̐ݒ��:
"     " ���p���Ȃ���
"     lmap 18 <C-R>=tcvime#InputPostConvert(1, 0)<CR>
"     lmap 28 <C-R>=tcvime#InputPostConvert(2, 0)<CR>
"     lmap 38 <C-R>=tcvime#InputPostConvert(3, 0)<CR>
"     lmap 48 <C-R>=tcvime#InputPostConvert(4, 0)<CR>
"     " ���p�����(������tc2�ƈ���āA�ǂ݂̕������ɂ͊��p����͊܂܂Ȃ�)
"     lmap 29 <C-R>=tcvime#InputPostConvert(2, 1)<CR>
"     lmap 39 <C-R>=tcvime#InputPostConvert(3, 1)<CR>
"     lmap 49 <C-R>=tcvime#InputPostConvert(4, 1)<CR>
"     lmap 59 <C-R>=tcvime#InputPostConvert(5, 1)<CR>
" @param count ���������ϊ��̑Ώۂɂ���ǂ݂̕�����
" @param katuyo ���p�����̕ϊ����ǂ����B0:���p���Ȃ�, 1:���p����
function! tcvime#InputPostConvert(count, katuyo)
  let s:is_katuyo = 0
  let s:completeyomi = ''
  let s:status_line = line(".")
  let yomi = matchstr(getline('.'), '.\{' . a:count . '}\%' . col('.') . 'c')
  let len = strlen(yomi)
  if len == 0
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
    return ''
  endif
  let inschars = ''
  let s:status_column = col('.') - len
  let s:is_katuyo = a:katuyo
  if s:is_katuyo
    let key = yomi . '�\'
  else
    let key = yomi
  endif
  let ncands = s:CandidateSearch(key)
  if ncands == 1
    let inschars = s:InputFix(col('.'))
  elseif ncands > 0
    let s:completeyomi = yomi
    call complete(s:status_column, s:last_candidate_list)
  elseif ncands == 0
    echo '���������������ɂ͌�����܂���: <' . yomi . '>'
  else
    echo '���������ϊ������t�@�C���̃I�[�v���Ɏ��s���܂���: ' . s:candidate_file
  endif
  return inschars
endfunction

" Insert mode�Ō��������ϊ����s���B
" ���p�����̕ϊ��̏ꍇ�́A
" �ϊ��Ώە�����̖����Ɂu�\�v��ǉ����Č���������������������B
" @param katuyo ���p�����̕ϊ����ǂ����B0:���p���Ȃ�, 1:���p����
function! s:InputConvert(katuyo)
  let inschars = ''
  let s:is_katuyo = 0
  let s:completeyomi = ''
  let status = s:StatusGet('.', col('.'))
  let len = strlen(status)
  if len > 0
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let key = status . '�\'
    else
      let key = status
    endif
    let ncands = s:CandidateSearch(key)
    if ncands == 1
      let inschars = s:InputFix(col('.'))
    elseif ncands > 0
      let s:completeyomi = status
      call complete(s:status_column, s:last_candidate_list)
    elseif ncands == 0
      echo '���������������ɂ͌�����܂���: <' . status . '>'
    else
      echo '���������ϊ������t�@�C���̃I�[�v���Ɏ��s���܂���: ' . s:candidate_file
    endif
  else
    let s:last_keyword = ''
    call s:InputStart()
  endif
  return inschars
endfunction

" complete()�őI�����ꂽ�����擾���āA�����w���v��\������
function! s:OnCursorMovedI()
  if s:completeyomi == ''
    return
  endif
  let col = col('.')
  if col == 1
    " <CR>�Ŋm�肵�ĉ��s���}������čs���ɂȂ����ꍇ�BTODO: autoindent�Ή�
    let lnum = line('.') - 1
    let col = col([lnum, '$'])
    let status = s:StatusGet(lnum, col)
  else
    let status = s:StatusGet('.', col)
  endif
  if status == s:completeyomi
    return
  endif
  " XXX: �|�b�v�A�b�v���j���[�����̏ꍇ�A�����w���v�\���ł��Ȃ�
  call s:ShowAutoHelp(s:completeyomi, status)
  let s:completeyomi = ''
  call s:StatusReset()
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
  let str = s:StatusGet('.', a:col)
  if s:IsCandidateOK(str)
    let inschars = s:CandidateSelect()
    if strlen(inschars) > 0
      call s:ShowAutoHelp(str, inschars)
      let bs = substitute(str, '.', "\<BS>", "g")
      let inschars = bs . inschars
    endif
  endif
  call s:StatusReset()
  return inschars
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
      call s:ShowAutoHelp(chars, retchar)
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

  let s:is_katuyo = 0
  let s:status_line = line(".")
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '.\{' . cnt . '}\%' . col("'^") . 'c')

  let len = strlen(chars)
  if len > 0
    let s:status_column = col("'^") - len
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let chars = chars . '�\'
    endif
    let ncands = s:CandidateSearch(chars)
    if ncands > 1
      call s:Candwin_SetCands(s:last_candidate_list)
      call s:SelectWindowByName(s:candbufname)
    elseif ncands == 1
      call s:FixCandidate()
    elseif ncands == 0
      echo '���������������ɂ͌�����܂���: <' . chars . '>'
    else
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

" ���̈ʒu�ȑO��count�������J�^�J�i�ɕϊ�����
" @param count �ϊ����镶����̒���
function! s:ConvertKatakana(count)
  execute "normal! a\<ESC>"
  let inschars = tcvime#InputConvertKatakanaPos(col("'^"), a:count)
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
function! s:StatusIsEnable(lnum, col)
  let ln = a:lnum
  if ln == '.'
    let ln = line(ln)
  endif
  if s:status_line != ln || s:status_column <= 0 || s:status_column > a:col
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
function! s:StatusGet(lnum, col)
  if !s:StatusIsEnable(a:lnum, a:col)
    return ''
  endif

  " �K�v�ȃp�����[�^�����W
  let stpos = s:status_column - 1
  let len = a:col - s:status_column
  let str = getline(a:lnum)

  return strpart(str, stpos, len)
endfunction

"   ���m�蕶����̊J�n�ʒu�ƏI���ʒu��\��(�f�o�b�O�p)
function! s:StatusEcho(...)
  echo '�ǂݓ��͊J�n;<Leader><Space>:�ϊ�,<Leader>o:���p�����̕ϊ�'
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
    nnoremap <buffer> <silent> q :<C-U>quit<CR>
  endif
  %d _
  5wincmd _
endfunction

" �w���v�p�o�b�t�@�����
function! tcvime#CloseHelpBuffer()
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
  call tcvime#ShowHelpForStr(substitute(@@, '\n', '', 'g'), 0)
  let @@ = save_reg
endfunction

" �ϊ��Ŋm�肵��������̃w���v�\��\������
function! s:ShowAutoHelp(yomi, str)
  let yomichars = split(a:yomi, '\zs')
  let chars = split(a:str, '\zs')
  " �ǂ݂œ��͂��������̓w���v�\���s�v�Ȃ̂Ŏ�菜��
  call filter(chars, 'index(yomichars, v:val) == -1')
  call s:ShowHelp(chars, 0)
endfunction

" �w�肳�ꂽ������̊e�����̃w���v�\��\������
function! tcvime#ShowHelpForStr(str, forcebushu)
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
  let curbuf = bufnr('')
  call s:OpenHelpBuffer()
  let winwidth = winwidth(0)
  let lastcol = 0
  let lastfrom = 1
  let width = 0
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
    if ret == -1 " �X�g���[�N�\�����񍇐��������\���ł��Ȃ������ꍇ
      call add(skipchars, ch)
      continue
    elseif ret == -2 " XXX: �|�b�v�A�b�v���j���[������
      call tcvime#CloseHelpBuffer()
      return
    endif
    let numch += 1
    if ret == 0 " ShowHelpBushuDic
      continue
    endif
    " �\�����ɕ��ׂ�
    if lastcol == 0 " �ŏ��̕\�̏ꍇ�͕ϐ�����������
      let lastcol = col('$')
      let lastfrom = line('.')
      let width = lastcol + 2
      continue
    endif
    if lastcol + width >= winwidth " ����ɕ��ׂ�Ƃ͂ݏo���ꍇ�͂��̂܂܂�
      let lastcol = col('$')
      let lastfrom = line('.')
      continue
    endif
    let ln = line('.')
    let save_reg = @@
    execute "normal! \<C-V>GkI  \<ESC>\<C-V>Gk$x" . lastfrom . "G$p"
    let @@ = save_reg
    let lastcol = col('$')
    silent! execute ln . ',$-1d _'
  endfor
  if numch == 0
    call tcvime#CloseHelpBuffer()
  else
    silent! $g/^$/d _ " �����̗]���ȋ�s���폜
    normal 1G
    " wincmd p
    execute bufwinnr(curbuf) . 'wincmd w'
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
  let v:errmsg = ''
  silent! execute 'normal! O' . g:tcvime_keyboard . "\<CR>\<ESC>"
  if v:errmsg != '' " XXX: �|�b�v�A�b�v���j���[�������AE523: Not allowed here
    return -2
  endif
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
  call cursor(to - 1, 1)
  silent! execute 'normal! A    ' . a:ch . "\<ESC>"
  call cursor(from, 1)
  return 1
endfunction

" ���񍇐���������A�w�肳�ꂽ�������܂ލs���������ĕ\������
function! s:ShowHelpBushuDic(ch)
  let lines = s:SearchBushuDic(a:ch)
  call s:SelectWindowByName(s:helpbufname)
  if strlen(lines) > 0
    " �o�b�t�@���łȂ���΋�؂�̋�s�}���B���O�������s�̕��񎫏����e�̎��K�v
    if line('.') > 1
      silent! execute "normal! o\<ESC>"
    endif
    let v:errmsg = ''
    silent! execute 'normal! O' . lines . "\<ESC>"
    if v:errmsg != '' " XXX: �|�b�v�A�b�v���j���[�������AE523: Not allowed here
      return -2
    endif
    return 0
  else
    return -1
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
  let num = bufwinnr('^' . a:name . '$')
  if num > 0 && num != winnr()
    execute num . 'wincmd w'
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
let s:last_candidate = ''
let s:last_candidate_list = []
let s:is_katuyo = 0

" �������疢�m�蕶���������
" @return -1:�������J���Ȃ��ꍇ, 0:�����񂪌�����Ȃ��ꍇ,
"   1:��₪1�������������ꍇ, 2:��₪2�ȏ㌩�������ꍇ
function! s:CandidateSearch(keyword)
  let s:last_keyword = a:keyword
  if !s:Candidate_FileOpen()
    return -1
  endif

  let s:last_candidate = ''
  if search('^' . a:keyword . ' ', 'cw') == 0
    let s:last_candidate_list = []
    let ret = 0
  else
    let candstr = substitute(getline('.'), '^' . a:keyword . ' ', '', '')
    let s:last_candidate_list = split(candstr, '/')
    let ret = len(s:last_candidate_list)
    if ret > 0
      let s:last_candidate = s:last_candidate_list[0]
    endif
  endif
  quit!
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
function! tcvime#KanjiTable_FileOpen()
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

"==============================================================================
" ���I���o�b�t�@

" ���I���o�b�t�@���J��
function! s:Candwin_Open()
  if s:SelectWindowByName(s:candbufname) < 0
    execute "silent normal! :sp " . s:candbufname . "\<CR>"
    set buftype=nofile
    set bufhidden=delete
    set noswapfile
    if !s:buflisted
      set nobuflisted
    endif
  endif
  %d _
  nnoremap <buffer> <silent> <CR> :<C-U>call <SID>Candwin_Select()<CR>
  nnoremap <buffer> <silent> <C-Y> :<C-U>call <SID>Candwin_Select()<CR>
  nnoremap <buffer> <silent> q :<C-U>quit<CR>
  nnoremap <buffer> <silent> <C-E> :<C-U>quit<CR>
endfunction

" ���I���o�b�t�@�����
function! s:Candwin_Close()
  if s:SelectWindowByName(s:candbufname) > 0
    bwipeout!
  endif
endfunction

" �����Z�b�g����
function! s:Candwin_SetCands(candlist)
  call s:Candwin_Open()
  execute 'normal! a' . join(a:candlist, "\n") . "\<ESC>"
  normal! 1G
  wincmd p
endfunction

" ���ݍs�̌����m�肷��
function! s:Candwin_Select()
  let s:last_candidate = getline('.')
  bwipeout!
  call s:FixCandidate()
endfunction

let &cpo = s:save_cpo
