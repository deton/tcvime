" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding cp932

" autoload/tcvime.vim - utility functions for tcvime.
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2013-06-08

let s:save_cpo = &cpo
set cpo&vim

if !exists("tcvime_mazegaki_edit_nocand")
  let tcvime_mazegaki_edit_nocand = 0
endif
if !exists("tcvime_keymap_for_help")
  let tcvime_keymap_for_help = &keymap
endif

if !exists("tcvime_keyboard")
  let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
  " �����L�[�̒i��\�����Ȃ��ꍇ�͎��̕�������g���悤�ɂ���(qwerty)
"  let tcvime_keyboard = "q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
endif

" ���������ϊ��Ŋm�肵�����́A��⃊�X�g���̈ړ���ʒu(0���擪�B-1�͈ړ�����)
if !exists("tcvime_movecandto")
  let tcvime_movecandto = -1
endif

" ���������ϊ����I��p�L�[�B
"   let g:tcvime#selectkeys = ['1','2','3','4','5','6','7','8','9','0']
" ��: Insert mode�ł̌��I���̏ꍇ�A
"     ���̃L�[�Ŏn�܂�lmap��imap������ꍇ�́A|'timeoutlen'|�҂��������B
if !exists('g:tcvime#selectkeys')
  let g:tcvime#selectkeys = []
endif

" ��u�^�V�[�P���X�������ϊ��ŁA���������w�肳��Ă��Ȃ��ۂɁA
" ���̃p�^�[���Ƀ}�b�`���镶���������Ԃ͊����ɕϊ�����B
if !exists("g:tcvime#seq2kanji_pat")
  let g:tcvime#seq2kanji_pat = "[0-9a-z ;,\\./']*"
endif

" ��u�^�J�^�J�i�ϊ��ŁA���������w�肳��Ă��Ȃ��ۂɁA
" ���̃p�^�[���Ƀ}�b�`���镶���������Ԃ̓J�^�J�i�ɕϊ�����B
let g:tcvime#hira2kata_pat = '[��-��][��-��[]*'
" �ǂ݊J�n�ʒu�}�[�N��' '���͂ő�ւ���ꍇ�̐ݒ��:
"   let g:tcvime#yomimarkchar = ' '
" '* �A�C�e��'�̂悤�ɁA*���̌��' '�͎c�������ꍇ�̐ݒ��:
"   let g:tcvime#yomimarkchar = '\%([[:graph:]] \zs\| \)'
if exists('g:tcvime#yomimarkchar')
  let g:tcvime#hira2kata_pat = g:tcvime#yomimarkchar . '\=' . tcvime#hira2kata_pat
endif

let g:tcvime#hiragana = '�����������������������������������������������������������������������ÂĂłƂǂȂɂʂ˂̂͂΂ςЂт҂ӂԂՂւׂ؂قڂۂ܂݂ނ߂��������������������'
let g:tcvime#katakana = '�@�A�B�C�D�E�F�G�H�I�J�K�L�M�N�O�P�Q�R�S�T�U�V�W�X�Y�Z�[�\�]�^�_�`�a�b�c�d�e�f�g�h�i�j�k�l�m�n�o�p�q�r�s�t�u�v�w�x�y�z�{�|�}�~����������������������������������������'

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
" �������Ƃ��ĕ��̒l���w�肷��ƁA�Ђ炪�ȂƂ��Ďc���������̎w��Ƃ݂Ȃ��B
" (�J�^�J�i�ɕϊ����镶���񂪒����ĕ������𐔂���̂��ʓ|�ȏꍇ����)
" �u�Ⴆ�΂��Ղ肯�[�����vel2���u�Ⴆ�΃A�v���P�[�V�����v
"
" tutcode keymap�Ō�u�^�J�^�J�i�ϊ����s�����߂̐ݒ��:
"     lmap <silent> e0 <C-R>=tcvime#InputConvertKatakana(0)<CR>
"     lmap <silent> e1 <C-R>=tcvime#InputConvertKatakana(1)<CR>
"     lmap <silent> e2 <C-R>=tcvime#InputConvertKatakana(2)<CR>
"     ...
"     lmap <silent> e9 <C-R>=tcvime#InputConvertKatakana(9)<CR>
" �w�肵���������̂Ђ炪�Ȃ��c���ăJ�^�J�i�ϊ�����ꍇ�̐ݒ��:
"     lmap <silent> el1 <C-R>=tcvime#InputConvertKatakana(-1)<CR>
"     lmap <silent> el2 <C-R>=tcvime#InputConvertKatakana(-2)<CR>
"     lmap <silent> el3 <C-R>=tcvime#InputConvertKatakana(-3)<CR>
"     lmap <silent> el4 <C-R>=tcvime#InputConvertKatakana(-4)<CR>
"     lmap <silent> el5 <C-R>=tcvime#InputConvertKatakana(-5)<CR>
"     lmap <silent> el6 <C-R>=tcvime#InputConvertKatakana(-6)<CR>
function! tcvime#InputConvertKatakana(n)
  return tcvime#InputConvertKatakanaPos(col('.'), a:n)
endfunction

" ��u�^�ŃJ�^�J�i�������L�΂�
function! tcvime#InputConvertKatakanaExtend(n)
  let line = getline('.')
  let col = col('.')
  let pat = '\([�@-���[]*\)\%' . col . 'c' " ���ʒu�ȑO�̘A������J�^�J�i
  if a:n == 0
    " �A������J�^�J�i�ȑO�̘A������Ђ炪�Ȃ��J�^�J�i��
    let pat = '\([��-��][��-��[]*\)' . pat
  else
    " ���ʒu�ȑO�Ɉʒu����A�A������J�^�J�i�Ǝw�蕶�����ȉ��̂Ђ炪�Ȃ��擾
    let pat = '\([��-��[]\{,' . a:n . '}\)' . pat
  endif
  if exists('g:tcvime#yomimarkchar')
    let pat = g:tcvime#yomimarkchar . '\=' . pat
  endif
  let m = matchlist(line, pat)
  if empty(m)
    return ''
  endif
  let yomi = m[0]
  let s:prev_str = m[1] . m[2]
  let s:commit_str = tcvime#hira2kata(m[1]) . m[2]
  return substitute(yomi, '.', "\<BS>", 'g') . s:commit_str
endfunction

let s:prev_str = ''
let s:commit_str = ''

" ���O�̌�u�^�J�^�J�i�ϊ����k�߂�
function! tcvime#InputConvertKatakanaShrink(n)
  if s:prev_str == ''
    return ''
  endif
  " �J�[�\���ʒu�O���A���O�ɕϊ������J�^�J�i������łȂ��ꍇ�́A�������Ȃ��B
  " �J�^�J�i�ϊ���ɕʂ̕�������͂�����ŊԈ���Ă��̊֐����Ă΂�āA
  " �Â��J�^�J�i�ϊ��̓��e�����Ƃɏ㏑������ƍ���̂ŁB
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{,' . cnt . '}\%' . col('.') . 'c')
  if chars != s:commit_str
    let s:prev_str = ''
    return ''
  endif
  let cnt = a:n
  if cnt == 0
    let cnt = 1
  endif
  let str = s:prev_str
  let strlist = matchlist(str, '\(.\{,' . cnt . '}\)\(.*\)')
  let kata = tcvime#hira2kata(strlist[2])
  let newstr = tcvime#kata2hira(strlist[1]) . kata
  " Shrink���J��Ԃ��Ă񂾍ۂ�1�������J�^�J�i���k�߂邽�߁Aprev_str���k�߂�
  let s:prev_str = strlist[2]
  " undo�p��prev_str�ɑΉ�����commit_str���Z�b�g
  let s:commit_str = kata
  return substitute(str, '.', "\<BS>", 'g') . newstr
endfunction

" ���O�̕ϊ���������
function! tcvime#InputConvertUndo()
  if s:prev_str == ''
    return ''
  endif
  " �J�[�\���ʒu�O���A���O�ɕϊ��m�肵��������łȂ��ꍇ�́A�������Ȃ��B
  " �ϊ��m���ɕʂ̕�������͂�����ŊԈ���Ă��̊֐����Ă΂�āA
  " �Â��ϊ��̓��e�����Ƃɏ㏑������ƍ���̂ŁB
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{' . cnt . '}\%' . col('.') . 'c')
  if chars != s:commit_str
    let s:prev_str = ''
    return ''
  endif
  let str = s:commit_str
  let prev = s:prev_str
  " XXX: ���iundo�͖��Ή�
  let s:prev_str = ''
  let s:commit_str = prev
  return substitute(str, '.', "\<BS>", 'g') . prev
endfunction

" insert mode���ɁA�w��ʒu����w�肳�ꂽ�������̕�������擾���āA
" �Ђ炪�ȁ��J�^�J�i�ϊ����s�����߂̕������Ԃ��B
function! tcvime#InputConvertKatakanaPos(col, n)
  let chars = s:AcquireYomi(g:tcvime#hira2kata_pat, a:col, a:n)
  if strlen(chars) == 0
    return ''
  endif
  let s:prev_str = chars
  let s:commit_str = tcvime#hira2kata(chars)
  if exists('g:tcvime#yomimarkchar')
    let s:prev_str = substitute(s:prev_str, '^' . g:tcvime#yomimarkchar . '\=', '', '')
    let s:commit_str = substitute(s:commit_str, '^' . g:tcvime#yomimarkchar . '\=', '', '')
  endif
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" insert mode���ɁA�w��ʒu����w�肳�ꂽ�������̕�������擾����
function! s:AcquireYomi(pat, col, n)
  if a:n > 0
    return matchstr(getline('.'), '.\{,' . a:n . '}\%' . a:col . 'c')
  endif
  let col = a:col
  if a:n == 0
    " �O�u�^���������ϊ��̓ǂ݂Ƃ��Ďw�肳�ꂽ�����񂪂���΁A�ϊ��ΏۂƂ���
    let yomi = s:StatusGet('.', col)
    if yomi != ''
      return yomi
    endif
  endif
  let line = getline('.')
  if s:insert_line == line('.') && s:insert_col < a:col
    " Insert mode�J�n�ʒu�ȍ~��ϊ��ΏۂƂ���
    " XXX: CTRL-D�ŃC���f���g�����炵���ꍇ�ɂ͖��Ή�
    let line = strpart(line, s:insert_col - 1)
    let col = a:col - s:insert_col + 1
  endif
  " pat�Ƀ}�b�`���镶�����擾
  let chars = matchstr(line, a:pat . '\%' . col . 'c')
  if a:n < 0 " ���O���镶����
    let excnt = -a:n
    let chars = matchstr(chars, '.\{' . excnt . '}\zs.*$')
  endif
  return chars
endfunction

" ��������J�^�J�i�ɕϊ�����
function! tcvime#hira2kata(str)
  return tr(a:str, g:tcvime#hiragana, g:tcvime#katakana)
endfunction

" ��������Ђ炪�Ȃɕϊ�����
function! tcvime#kata2hira(str)
  return tr(a:str, g:tcvime#katakana, g:tcvime#hiragana)
endfunction

" ���̓V�[�P���X�������ɕϊ�����B
" lmap�����̂܂ܓ��͂�����������Almap�L���ɂ�������Ɋ����ɕϊ����邽�߁B
"   lmap t0 <C-R>=tcvime#InputConvertSeq2Kanji(0)<CR>
" ���̓V�[�P���X���Ɍ�u�^���񍇐��ϊ����������Ă�OK�B
function! tcvime#InputConvertSeq2Kanji(n)
  let chars = s:AcquireYomi(g:tcvime#seq2kanji_pat, col('.'), a:n)
  if chars == ''
    return ''
  endif
  call feedkeys(chars, 't')
  return substitute(chars, '.', "\<BS>", 'g')
endfunction

" ���̓V�[�P���X�������ɕϊ�����B
" ���̓V�[�P���X���̌�u�^���񍇐��ϊ����ɂ͖��Ή��B
" tcvime#InputConvertSeq2KanjiShrink()�ɂ��A�ォ��ϊ����k�߂鑀��ɑΉ��B
function! tcvime#InputConvertSeq2KanjiWithShrink(n)
  let chars = s:AcquireYomi(g:tcvime#seq2kanji_pat, col('.'), a:n)
  if chars == ''
    return ''
  endif
  let kanji = s:Seq2Kanji(chars)
  let s:prev_str = chars
  let s:commit_str = kanji
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" ���O�̓��̓V�[�P���X�������ϊ����k�߂�
" @param drop �k�߂��������폜���邩�ǂ���
function! tcvime#InputConvertSeq2KanjiShrink(drop)
  if s:prev_str == ''
    return ''
  endif
  " �J�[�\���ʒu�O���A���O�ɕϊ�����������łȂ��ꍇ�́A�������Ȃ�
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{,' . cnt . '}\%' . col('.') . 'c')
  if chars != s:commit_str
    let s:prev_str = ''
    return ''
  endif
  let str = s:prev_str
  let strlist = matchlist(str, '\(.\)\(.*\)')
  " �k�߂�1�����͍폜�BCTRL-J�ŃI���ɂ������˂�j�����������ꍇ�ɍ폜�������B
  let kanji = s:Seq2Kanji(strlist[2])
  let newstr = kanji
  if !a:drop
    let newstr = strlist[1] . kanji
  endif
  " Shrink���J��Ԃ��Ă񂾍ۂ�1�������k�߂邽�߁Aprev_str���k�߂�
  let s:prev_str = strlist[2]
  " undo�p��prev_str�ɑΉ�����commit_str���Z�b�g
  let commitprev = s:commit_str
  let s:commit_str = kanji
  return substitute(commitprev, '.', "\<BS>", 'g') . newstr
endfunction

" ���̓V�[�P���X������������ɒu�����邽�߂̕������Ԃ��B
function! s:Seq2Kanji(str)
  if a:str == ''
    return ''
  endif
  let hassetkeymap = 0
  let keymap = &keymap
  if empty(keymap)
    let keymap = g:tcvime_keymap_for_help
    if empty(keymap)
      echo 'tcvime���̓V�[�P���X�������ϊ��ɂ́Akeymap�I�v�V������g:tcvime_keymap_for_help�̐ݒ�v'
      return ''
    endif
    call tcvime#SetKeymap(keymap)
    let hassetkeymap = 1
  endif

  let kstr = ''
  let s = a:str
  while !empty(s)
    let len = strlen(s)
    let kanji = ''
    let i = 1
    let seq = strpart(s, 0, i)
    while i <= len && !empty(mapcheck(seq, 'l'))
      let kanji = maparg(seq, 'l')
      if !empty(kanji)
	break
      endif
      let i += 1
      let seq = strpart(s, 0, i)
    endwhile
    if empty(kanji)
      let kstr .= seq
    else
      " XXX: <Plug>��<C-R>=���ɂ͖��Ή�
      let kstr .= kanji
    endif
    let s = strpart(s, i)
  endwhile
  if hassetkeymap
    set iminsert=0
  endif
  return kstr
endfunction

" �������������̓V�[�P���X�ɕϊ�����B
" ���������w�肵�Ȃ��ꍇ�A�p�P����͑O�ɃX�y�[�X����͂��Ă����ƁA
" �X�y�[�X�ȍ~�̕������p���ɕϊ����āA��؂�p�ɓ��͂����X�y�[�X���폜�B
" ��:" code "�ƑŌ������" ���e "�ƕ\������A�J�n�L�[�ŁA"code"�ɕϊ��B
function! tcvime#InputConvertKanji2Seq(n)
  " "undo "��"��E"�A"code "��"���e "
  let chars = s:AcquireYomi(' \=[^ ]\+ \=', col('.'), a:n)
  let seq = s:Kanji2Seq(chars, 1)
  let s:commit_str = seq
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" �������������̓V�[�P���X�ɕϊ�����B
" �Ώە�����́AInsert mode�J�n�ʒu�ȍ~�������͌��ݍs�S�āB
" lmap�L���ɂȂ��Ă���̂ɁAURL�����y�[�X�g�����ꍇ�ɁA���ɖ߂����߁B
function! tcvime#InputConvertKanji2SeqAll()
  let line = getline('.')
  let col = col('.')
  if s:insert_line == line('.') && s:insert_col < col
    " Insert mode�J�n�ʒu�ȍ~��ϊ��ΏۂƂ���
    " XXX: CTRL-D�ŃC���f���g�����炵���ꍇ�ɂ͖��Ή�
    let line = strpart(line, s:insert_col - 1)
    let col = col - s:insert_col + 1
  endif
  let chars = matchstr(line, '.*' . '\%' . col . 'c')
  let seq = s:Kanji2Seq(chars, 0)
  let s:commit_str = seq
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" �������������̓V�[�P���X�ɒu�����邽�߂̕������Ԃ��B
function! s:Kanji2Seq(str, trim)
  if a:str == ''
    return ''
  endif
  let arr = split(a:str, '\zs')
  call map(arr, 's:Kanji2SeqChar(v:val)')
  let s:prev_str = a:str
  let seq = join(arr, '')
  if a:trim
    let seq = substitute(seq, '^ \+', '', '')
    let seq = substitute(seq, ' \+$', '', '')
  endif
  return seq
endfunction

" ����1��������̓V�[�P���X�ɕϊ�����B
function! s:Kanji2SeqChar(ch)
  if char2nr(a:ch) < 0x80
    return a:ch
  endif
  let seq = s:SearchKeymap(a:ch)
  if seq == ''
    return a:ch
  endif
  return seq
endfunction

" �ݒ�
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
let s:bushuhelp_file = globpath($VIM.','.&runtimepath, 'bushu.help')
let s:kanjitable_file = globpath($VIM.','.&runtimepath, 'kanjitable.txt')
let s:helpbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeHelp__'
let s:helpbufname = substitute(s:helpbufname, '\\', '/', 'g')
let s:candbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeCand__'
let s:candbufname = substitute(s:candbufname, '\\', '/', 'g')

" keymap��ݒ肷��
function! tcvime#SetKeymap(keymapname)
  if &l:keymap !=# a:keymapname
    execute 'set keymap=' . a:keymapname
    if exists('*TcvimeCustomKeymap')
      call TcvimeCustomKeymap()
    endif
  else
    set iminsert=1
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
    silent! imap <unique> <silent> <Leader>q <Plug>TcvimeIStart
  endif
  if !hasmapto('<Plug>TcvimeIConvOrStart')
    silent! imap <unique> <silent> <Leader><Space> <Plug>TcvimeIConvOrStart
  endif
  if !hasmapto('<Plug>TcvimeIKatuyo')
    silent! imap <unique> <silent> <Leader>o <Plug>TcvimeIKatuyo
  endif
  if !hasmapto('<Plug>TcvimeIBushu')
    silent! imap <unique> <silent> <Leader>b <Plug>TcvimeIBushu
  endif
  if !hasmapto('<Plug>TcvimeNConvert')
    silent! nmap <unique> <silent> <Leader><Space> <Plug>TcvimeNConvert
  endif
  if !hasmapto('<Plug>TcvimeNKatuyo')
    silent! nmap <unique> <silent> <Leader>o <Plug>TcvimeNKatuyo
  endif
  if !hasmapto('<Plug>TcvimeNBushu')
    silent! nmap <unique> <silent> <Leader>b <Plug>TcvimeNBushu
  endif
  if !hasmapto('<Plug>TcvimeNHelp')
    silent! nmap <unique> <silent> <Leader>? <Plug>TcvimeNHelp
  endif
  if !hasmapto('<Plug>TcvimeNKanjiTable')
    silent! nmap <unique> <silent> <Leader>t <Plug>TcvimeNKanjiTable
  endif
  if !hasmapto('<Plug>TcvimeVHelp')
    silent! vmap <unique> <silent> <Leader>? <Plug>TcvimeVHelp
  endif
  if !hasmapto('<Plug>TcvimeVConvert')
    silent! vmap <unique> <silent> <Leader><Space> <Plug>TcvimeVConvert
  endif
  if !hasmapto('<Plug>TcvimeVKatuyo')
    silent! vmap <unique> <silent> <Leader>o <Plug>TcvimeVKatuyo
  endif

  inoremap <script> <silent> <Plug>TcvimeIStart <C-R>=<SID>InputStart()<CR>
  inoremap <script> <silent> <Plug>TcvimeIConvOrStart <C-R>=<SID>InputConvertOrStart(0)<CR>
  inoremap <script> <silent> <Plug>TcvimeIConvOrSpace <C-R>=<SID>InputConvertOrSpace()<CR>
  inoremap <script> <silent> <Plug>TcvimeIKatuyo <C-R>=<SID>InputConvertOrStart(1)<CR>
  inoremap <script> <silent> <Plug>TcvimeIBushu <C-R>=<SID>InputConvertBushu(col('.'))<CR>
  inoremap <script> <silent> <Plug>TcvimeIShrink <C-R>=tcvime#InputConvertUndo()<CR><C-R>=<SID>InputConvertShrinkLatest()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNConvert :<C-U>call <SID>ConvertCount(v:count, 0)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKatuyo :<C-U>call <SID>ConvertCount(v:count, 1)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKatakana :<C-U>call <SID>ConvertKatakana(v:count)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKataHira :<C-U>call <SID>ConvertKatakana(-v:count)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNBushu :<C-U>call <SID>ConvertBushu()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNHelp :<C-U>call <SID>ShowStrokeHelp()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKanjiTable :<C-U>call tcvime#KanjiTable_FileOpen()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNOpConvert :set opfunc=tcvime#ConvertOp<CR>g@
  nnoremap <script> <silent> <Plug>TcvimeNOpKatuyo :set opfunc=tcvime#ConvertOpKatuyo<CR>g@
  nnoremap <script> <silent> <Plug>TcvimeNOpKatakana :set opfunc=tcvime#ConvertOpKatakana<CR>g@
  vnoremap <script> <silent> <Plug>TcvimeVHelp :<C-U>call <SID>ShowHelpVisual()<CR>
  vnoremap <script> <silent> <Plug>TcvimeVConvert :<C-U>call tcvime#ConvertOp(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVKatuyo :<C-U>call tcvime#ConvertOpKatuyo(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVKatakana :<C-U>call tcvime#ConvertOpKatakana(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVKanji2Seq :<C-U>call tcvime#ConvertOpKanji2Seq(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVSeq2Kanji :<C-U>call tcvime#ConvertOpSeq2Kanji(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVShiftSeq :<C-U>call tcvime#ConvertOpShiftSeq(visualmode(), 1)<CR>

  if set_mapleader
    unlet g:mapleader
  endif

  augroup Tcvime
  autocmd!
  autocmd InsertEnter * call <SID>OnInsertEnter()
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
  " TODO: tcvime�ȊO��map���ꂽ���̂�unmap���Ȃ��悤�ɂ���
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
  silent! vunmap <Leader><Space>
  silent! vunmap <Leader>o
  if set_mapleader
    unlet g:mapleader
  else
    let g:mapleader = save_mapleader
  endif

  augroup Tcvime
  autocmd!
  augroup END
endfunction

let s:insert_line = 0
let s:insert_col = 1

" ��u�^�ϊ��p�ɁA�}���J�n�ʒu���L�^
function! s:OnInsertEnter()
  let s:insert_line = line('.')
  let s:insert_col = col('.')
endfunction

"==============================================================================
"				    ���͐���

" �ǂ݂̓��͂��J�n
function! s:InputStart()
  call s:StatusSet()
  return ''
endfunction

let s:completeyomi = ''
let s:completeop = 0

" Insert mode�Ō�u�^���������ϊ����s���B
" ���p�����̕ϊ��̏ꍇ�́A
" �ϊ��Ώە�����̖����Ɂu�\�v��ǉ����Č���������������������B
"
" tc2���l�̌�u�^���������ϊ����s�����߂̐ݒ��:
"     " ���p���Ȃ���
"     lmap <silent> 18 <C-R>=tcvime#InputPostConvert(1, 0)<CR>
"     lmap <silent> 28 <C-R>=tcvime#InputPostConvert(2, 0)<CR>
"     lmap <silent> 38 <C-R>=tcvime#InputPostConvert(3, 0)<CR>
"     lmap <silent> 48 <C-R>=tcvime#InputPostConvert(4, 0)<CR>
"     " ���p�����(������tc2�ƈ���āA�ǂ݂̕������ɂ͊��p����͊܂܂Ȃ�)
"     lmap <silent> 29 <C-R>=tcvime#InputPostConvert(2, 1)<CR>
"     lmap <silent> 39 <C-R>=tcvime#InputPostConvert(3, 1)<CR>
"     lmap <silent> 49 <C-R>=tcvime#InputPostConvert(4, 1)<CR>
"     lmap <silent> 59 <C-R>=tcvime#InputPostConvert(5, 1)<CR>
" @param count ���������ϊ��̑Ώۂɂ���ǂ݂̕�����
" @param katuyo ���p�����̕ϊ����ǂ����B0:���p���Ȃ�, 1:���p����
function! tcvime#InputPostConvert(count, katuyo)
  let s:status_line = line(".")
  let yomi = matchstr(getline('.'), '.\{' . a:count . '}\%' . col('.') . 'c')
  let len = strlen(yomi)
  if len == 0
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
    return ''
  endif
  let s:status_column = col('.') - len
  return s:InputConvertSub(yomi, a:katuyo, 1)
endfunction

" ��u�^���������ϊ��ŁA���������w�肳��Ă��Ȃ��ۂɁA
" ���̃p�^�[���Ƀ}�b�`���镶����ǂ݂Ƃ��Ď擾����B
let g:tcvime#yomi_pat = '[^	-~�A�B�C�D�E�u�v�i�j]'
let s:mazegaki_yomi_max = 10

" Insert mode�Ō�u�^���������ϊ����J�n����B�ǂݕ������w�薳���B
function! tcvime#InputPostConvertStart(katuyo)
  let col = col('.')
  " �O�u�^���������ϊ��̓ǂ݂Ƃ��Ďw�肳�ꂽ�����񂪂���΁A�ϊ��ΏۂƂ���
  let yomi = s:StatusGet('.', col)
  if yomi == ''
    let line = getline('.')
    let c = col
    if s:insert_line == line('.') && s:insert_col < col
      " Insert mode�J�n�ʒu�ȍ~��ϊ��ΏۂƂ���
      " XXX: CTRL-D�ŃC���f���g�����炵���ꍇ�ɂ͖��Ή�
      let line = strpart(line, s:insert_col - 1)
      let c = col - s:insert_col + 1
    endif
    let yomi = matchstr(line, g:tcvime#yomi_pat . '\{,' . s:mazegaki_yomi_max . '}\%' . c . 'c')
    let s:status_line = line('.')
  endif
  while yomi != ''
    let len = strlen(yomi)
    let s:status_column = col - len
    let ret = s:InputConvertSub(yomi, a:katuyo, 0)
    " ��₪���������ꍇ�͏I��
    if ret != '' || s:completeyomi != ''
      return ret
    endif
    " ��₪������Ȃ�������A�ǂ݂�1�������炵�Č���
    let strlist = matchlist(yomi, '.\(.*\)')
    let yomi = strlist[1]
  endwhile
  let s:last_keyword = ''
  let s:last_count = 0
  call s:StatusReset()
  return ''
endfunction

" ���������ϊ��̓ǂ݂��k�߂�
function! tcvime#InputConvertShrink()
  if !pumvisible()
    return '>'
  endif
  return s:InputConvertShrinkPum()
endfunction

" ���������ϊ��̓ǂ݂��k�߂�Bpopup menu���\������Ă���ꍇ�̏����B
function! s:InputConvertShrinkPum()
  let ret = s:InputConvertShrink()
  " ��╡���̏ꍇ�A<C-E>��return����popup�������OnCursorMovedI()�����popup
  if ret == ''
    let s:completeop = 1
  endif
  return "\<C-E>" . ret
endfunction

" ���������ϊ��̓ǂ݂��k�߂�B
function! s:InputConvertShrink()
  let yomi = s:completeyomi
  let oldlen = strlen(yomi)
  " �ǂ݂�1�������炵�Č���
  let strlist = matchlist(yomi, '.\(.*\)')
  let yomi = strlist[1]
  while yomi != ''
    let len = strlen(yomi)
    let s:status_column += oldlen - len
    let ret = s:InputConvertSub(yomi, s:is_katuyo, 0)
    " ��₪���������ꍇ�͏I��
    if s:last_candidate != ''
      return ret
    endif
    " ��₪������Ȃ�������A�ǂ݂�1�������炵�Č���
    let oldlen = strlen(yomi)
    let strlist = matchlist(yomi, '.\(.*\)')
    let yomi = strlist[1]
  endwhile
  let s:last_keyword = ''
  let s:last_count = 0
  call s:StatusReset()
  return ''
endfunction

" ���O�̌�u�^���������ϊ����k�߂�B
" ���1�̂��ߎ����m�肳�ꂽ�ꍇ�p�B
function! s:InputConvertShrinkLatest()
  if pumvisible()
    return s:InputConvertShrinkPum()
  endif
  " �J�[�\���ʒu�O���A���O�ɕϊ�����������łȂ��ꍇ�́A�������Ȃ��B
  " �ϊ���ɕʂ̕�������͂�����ŊԈ���Ă��̊֐����Ă΂�āA
  " �Â��ϊ��̓��e�����Ƃɏ㏑������ƍ���̂ŁB
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{,' . cnt . '}\%' . col('.') . 'c')
  if chars != s:commit_str
    return ''
  endif
  let strlist = matchlist(chars, '.\(.*\)')
  if len(strlist) < 1
    return ''
  endif
  let yomi = strlist[1]
  let s:status_line = line('.')
  while yomi != ''
    let len = strlen(yomi)
    let s:status_column = col('.') - len
    let ret = s:InputConvertSub(yomi, s:is_katuyo, 0)
    " ��₪���������ꍇ�͏I��
    if ret != '' || s:completeyomi != ''
      return ret
    endif
    " ��₪������Ȃ�������A�ǂ݂�1�������炵�Č���
    let strlist = matchlist(yomi, '.\(.*\)')
    let yomi = strlist[1]
  endwhile
  let s:last_keyword = ''
  let s:last_count = 0
  call s:StatusReset()
  return ''
endfunction

" Insert mode�ŁA�ǂ݂�����Ό��������ϊ����J�n���A�������' '��Ԃ��B
function! s:InputConvertOrSpace()
  let status = s:StatusGet('.', col('.'))
  if status == ''
    let s:last_keyword = ''
    return ' '
  endif
  let lastyomi = s:last_keyword
  let ret = s:InputConvertSub(status, 0, 1)
  " ��△�� && �O��Ɠ����ǂ݁��O����ϊ��s�B�ēx<Space>�Ȃ̂�' '��Ԃ��B
  " �łȂ��ƁA' '��}���ł��Ȃ��Ȃ����悤�Ɍ�����̂ŁB
  " <Plug>TcvimeIStart�L�[�������ēǂ݊J�n�ʒu���Z�b�g����Α}���ł��邯�ǁB
  " XXX: �Č��������ɁA�O��Ɠ����ǂ݂ƈʒus:status_column�����m�F���������ǂ�?
  if ret == '' && s:completeyomi == '' && lastyomi == status
    call s:StatusReset()
    return ' '
  endif
  return ret
endfunction

" Insert mode�Ō��������ϊ����s���B�ǂ݂������ꍇ�͓ǂ݊J�n�}�[�N��t����B
" @param katuyo ���p�����̕ϊ����ǂ����B0:���p���Ȃ�, 1:���p����
function! s:InputConvertOrStart(katuyo)
  let status = s:StatusGet('.', col('.'))
  if status == ''
    let s:last_keyword = ''
    return s:InputStart()
  endif
  return s:InputConvertSub(status, a:katuyo, 1)
endfunction

" Insert mode�Ō��������ϊ����s���B
" ���p�����̕ϊ��̏ꍇ�́A
" �ϊ��Ώە�����̖����Ɂu�\�v��ǉ����Č���������������������B
" @param katuyo ���p�����̕ϊ����ǂ����B0:���p���Ȃ�, 1:���p����
" @param finish ��₪������Ȃ���������echo���邩�ǂ����B
function! s:InputConvertSub(yomi, katuyo, finish)
  let s:completeyomi = ''
  let inschars = ''
  let s:is_katuyo = a:katuyo
  if s:is_katuyo
    let key = a:yomi . '�\'
  else
    let key = a:yomi
  endif
  let ncands = s:CandidateSearch(key, a:finish)
  if ncands == 1
    if !pumvisible()
      let inschars = s:InputFix(col('.'))
    else
      " InputConvertShrink()����Ăяo���ꂽ�ꍇ�B
      " �����Shrink���邽�߂�s:commit_str�X�V�⎩���w���v�\����
      " OnCursorMovedI()���ł�邽�߁As:completeyomi���X�V
      let s:completeyomi = a:yomi
      let inschars = substitute(a:yomi, '.', "\<BS>", 'g') . s:last_candidate
    endif
  elseif ncands > 0
    if !pumvisible()
      call s:InputConvertShowPopup(a:yomi)
    endif
  elseif ncands == 0
    if a:finish
      echo '���������������ɂ͌�����܂���: <' . a:yomi . '>'
    endif
  else
    echo '���������ϊ������t�@�C���̃I�[�v���Ɏ��s���܂���: ' . s:candidate_file
  endif
  return inschars
endfunction

" ���I��p�|�b�v�A�b�v���j���[��\������
function! s:InputConvertShowPopup(yomi)
  let s:completeyomi = a:yomi
  inoremap > <C-R>=tcvime#InputConvertShrink()<CR>
  autocmd Tcvime CursorMovedI * call <SID>OnCursorMovedI()
  " ���I��pmenu�L�[�ǉ�
  let items = []
  let i = 0
  let len = len(s:last_candidate_list)
  while i < len
    let menu = ''
    if i < len(g:tcvime#selectkeys)
      let menu = g:tcvime#selectkeys[i]
      execute 'inoremap ' . g:tcvime#selectkeys[i] . ' <C-R>=tcvime#InputConvertSelectCand(' . i . ')<CR>'
    endif
    call add(items, {'word': s:last_candidate_list[i], 'menu': menu})
    let i += 1
  endwhile
  call complete(s:status_column, items)
endfunction

" complete()�őI�����ꂽ�����擾���āA�����w���v��\������
function! s:OnCursorMovedI()
  if s:completeyomi == ''
    return
  endif
  autocmd! Tcvime CursorMovedI *

  " �|�b�v�A�b�v���j���[����p�̈ꎞmap���폜
  silent! iunmap >
  let i = 0
  let len = len(s:last_candidate_list)
  while i < len
    if i < len(g:tcvime#selectkeys)
      silent! execute 'iunmap ' . g:tcvime#selectkeys[i]
    endif
    let i += 1
  endwhile

  " �ǂ݂̐L�k����ɂ��Č����ŕ�����₪���������ꍇ�A�ēxpopup menu��\��
  if s:completeop == 1
    let s:completeop = 0
    call s:InputConvertShowPopup(s:StatusGet('.', col('.')))
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
  if status != s:completeyomi
    if g:tcvime_movecandto >= 0
      call s:LearnCand(status)
    endif
    " XXX: �|�b�v�A�b�v���j���[�����̏ꍇ�A�����w���v�\���ł��Ȃ�
    call s:ShowAutoHelp(s:completeyomi, status)
  endif
  let s:completeyomi = ''
  call s:StatusReset()
endfunction

" �|�b�v�A�b�v���j���[�\�����ɁA�w�肳�ꂽ�ԍ��̌����m�肷��
function! tcvime#InputConvertSelectCand(idx)
  if !pumvisible()
    return g:tcvime#selectkeys[a:idx]
  endif
  let s:last_candidate = s:last_candidate_list[a:idx]
  let bs = substitute(s:completeyomi, '.', "\<BS>", 'g')
  return "\<C-E>" . bs . s:last_candidate
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
    let inschars = s:last_candidate
    if strlen(inschars) > 0
      if g:tcvime_movecandto >= 0
	call s:LearnCand(inschars)
      endif
      call s:ShowAutoHelp(str, inschars)
      let bs = substitute(str, '.', "\<BS>", "g")
      let inschars = bs . inschars
    endif
  else
    " echom str s:last_candidate s:is_katuyo s:last_keyword " DEBUG
  endif
  call s:StatusReset()
  return inschars
endfunction

" ���O��2�����̕��񍇐��ϊ����s��
function! s:InputConvertBushu(col)
  if a:col <= 2
    return ''
  endif
  let chars = matchlist(getline('.'), '\(.\)\(.\)\%' . a:col . 'c')
  if empty(chars)
    return ''
  endif
  let char1 = chars[1]
  let char2 = chars[2]
  let retchar = s:BushuConvert(char1, char2)
  if retchar == ''
    echo '���񍇐��ϊ����ł��܂���ł���: <' . char1 . '>, <' . char2 . '>'
    return ''
  endif
  call s:ShowAutoHelp(chars[0], retchar)
  let inschars = "\<BS>\<BS>" . retchar
  return inschars
endfunction

" operatorfunc�Ƃ��āA�I�����ꂽ����������������ϊ�����
function! tcvime#ConvertOp(type, ...)
  let visual = 0
  if a:0  " Invoked from Visual mode
    let visual = 1
  endif
  call s:ConvertOpSub(a:type, visual, 0)
endfunction

" operatorfunc�Ƃ��āA�I�����ꂽ����������p�����Ƃ��Č��������ϊ�����
function! tcvime#ConvertOpKatuyo(type, ...)
  let visual = 0
  if a:0  " Invoked from Visual mode
    let visual = 1
  endif
  call s:ConvertOpSub(a:type, visual, 1)
endfunction

function! s:ConvertOpSub(type, visual, katuyo)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:visual  " Invoked from Visual mode, use '< and '> marks.
    let s:status_line = line("'<")
    let s:status_column = col("'<")
    let s:status_colend = col("'>")
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'char'
    let s:status_line = line("'[")
    let s:status_column = col("'[")
    let s:status_colend = col("']")
    silent exe "normal! `[v`]y"
  elseif a:type == 'block'
    let s:status_line = line("'[")
    let s:status_column = col("'[")
    let s:status_colend = col("']")
    silent exe "normal! `[\<C-V>`]y"
  else
    let @@ = ''
    call s:StatusReset()
  endif

  if @@ != ''
    call s:ConvertSub(@@, a:katuyo)
  endif

  let &selection = sel_save
  let @@ = reg_save
endfunction

" operatorfunc�Ƃ��āA�I�����ꂽ��������J�^�J�i�ɕϊ�����
function! tcvime#ConvertOpKatakana(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    call s:ConvertOpKatakanaSub(col("'<"), col("'>"))
  elseif a:type == 'char'
    call s:ConvertOpKatakanaSub(col("'["), col("']"))
  endif

  let &selection = sel_save
endfunction

function! s:ConvertOpKatakanaSub(beg, end)
  let col = col('.')
  call cursor(0, a:end)
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '\%' . a:beg . 'c.*\%' . col("'^") . 'c')
  let inschars = substitute(chars, '.', "\<BS>", 'g') . tcvime#hira2kata(chars)
  call s:InsertString(inschars)
  " XXX: undo����ƍs���Ɉړ�����̂ł��܂���
  "execute 's/\%' . a:beg . 'c.*\%' . col("'^") . 'c/\=tcvime#hira2kata(submatch(0))/'
  " XXX: �Ō�̕������ϊ��Ɋ܂܂�Ȃ��B\%>'>�ɂ���ƍs���܂ŕϊ������
  "s/\%'<.*\%'>/\=tcvime#hira2kata(submatch(0))/
  call cursor(0, col)
endfunction

" operatorfunc�Ƃ��āA�I�����ꂽ���������̓V�[�P���X�ɕϊ�����
function! tcvime#ConvertOpKanji2Seq(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    call s:ConvertOpKanji2SeqSub(col("'<"), col("'>"))
  elseif a:type == 'char'
    call s:ConvertOpKanji2SeqSub(col("'["), col("']"))
  endif

  let &selection = sel_save
endfunction

function! s:ConvertOpKanji2SeqSub(beg, end)
  let col = col('.')
  call cursor(0, a:end)
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '\%' . a:beg . 'c.*\%' . col("'^") . 'c')
  let seq = s:Kanji2Seq(chars, 0)
  let inschars = substitute(chars, '.', "\<BS>", 'g') . seq
  call s:InsertString(inschars)
  call cursor(0, col)
endfunction

" operatorfunc�Ƃ��āA�I�����ꂽ���������̓V�[�P���X�Ƃ݂Ȃ��Ċ����ɕϊ�����
function! tcvime#ConvertOpSeq2Kanji(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    call s:ConvertOpSeq2KanjiSub(col("'<"), col("'>"))
  elseif a:type == 'char'
    call s:ConvertOpSeq2KanjiSub(col("'["), col("']"))
  endif

  let &selection = sel_save
endfunction

function! s:ConvertOpSeq2KanjiSub(beg, end)
  let col = col('.')
  call cursor(0, a:end)
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '\%' . a:beg . 'c.*\%' . col("'^") . 'c')
  let kstr = s:Seq2Kanji(chars)
  let inschars = substitute(chars, '.', "\<BS>", 'g') . kstr
  call s:InsertString(inschars)
  call cursor(0, col)
endfunction

" operatorfunc�Ƃ��āA�I�����ꂽ������̓��̓V�[�P���X�����炵�Ċ����ɕϊ��B
" �V�[�P���X������ĈӖ��s���Ȋ���������ɂȂ������̂��C�����邽�߁B
" ��: �u�d�n���������c�V�� �v���u����������܂���B�v
function! tcvime#ConvertOpShiftSeq(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    call s:ConvertOpShiftSeqSub(col("'<"), col("'>"))
  elseif a:type == 'char'
    call s:ConvertOpShiftSeqSub(col("'["), col("']"))
  endif

  let &selection = sel_save
endfunction

function! s:ConvertOpShiftSeqSub(beg, end)
  let col = col('.')
  call cursor(0, a:end)
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '\%' . a:beg . 'c.*\%' . col("'^") . 'c')
  let seq = s:Kanji2Seq(chars, 0)
  let m = matchlist(seq, '.\(.*\)')
  if !empty(m)
    let kstr = s:Seq2Kanji(m[1])
    let inschars = substitute(chars, '.', "\<BS>", 'g') . kstr
    call s:InsertString(inschars)
  endif
  call cursor(0, col)
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
  let s:status_colend = col(".")
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '.\{' . cnt . '}\%' . col("'^") . 'c')
  let s:status_column = col("'^") - strlen(chars)
  call s:ConvertSub(chars, a:katuyo)
endfunction

function! s:ConvertSub(yomi, katuyo)
  let chars = a:yomi
  if chars != ''
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let chars = chars . '�\'
    endif
    let ncands = s:CandidateSearch(chars, 1)
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
  call cursor(s:status_line, s:status_colend)
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
  if s:status_line != ln || s:status_column <= 0 || s:status_column >= a:col
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
  let s:status_colend = 0
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

" �w���v�p�o�b�t�@���J��
function! s:OpenHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) < 0
    silent execute 'sp ' . s:helpbufname
    set buftype=nofile
    set bufhidden=delete
    set noswapfile
    set winfixheight
    set nobuflisted
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
  let s:prev_str = a:yomi
  let s:commit_str = a:str
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
      let ret = s:ShowHelpChar(ch)
    endif
    if ret == -1 " �X�g���[�N�\�����񍇐��������\���ł��Ȃ������ꍇ
      call add(skipchars, ch)
      continue
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
    .,$-1g/^/s//  /
    call cursor(ln, 1)
    let save_reg = @@
    silent! execute "normal! \<C-V>Gk$x" . lastfrom . "G$p"
    let @@ = save_reg
    let lastcol = col('$')
    silent! execute ln . ',$-1g/^$/d _'
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
function! s:ShowHelpChar(ch)
  let keyseq = s:SearchKeymap(a:ch)
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
  call append(line('.') - 1, split(g:tcvime_keyboard, "\<CR>"))
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
  call append(to - 1, '    ' . a:ch)
  call cursor(from, 1)
  return 1
endfunction

" ���񍇐���������A�w�肳�ꂽ�������܂ލs���������ĕ\������
function! s:ShowHelpBushuDic(ch)
  let lines = s:ListBushuHelp(a:ch)
  call s:SelectWindowByName(s:helpbufname)
  if empty(lines)
    return -1
  endif
  let lnum = line('.')
  if lnum == 1
    let lnum = 0
  else
    " �o�b�t�@���łȂ���΋�؂�̋�s�}���B���O�������s�̕��񎫏����e�̎��K�v
    call add(lines, '')
  endif
  let failed = append(lnum, lines)
  if failed
    return -2
  endif
  return 0
endfunction

" ���񍇐��ϊ��w���v�ɕ\������s�̔z���Ԃ�
function! s:ListBushuHelp(ch)
  let lines = s:SearchBushuHelp(a:ch)
  if !empty(lines)
    return lines
  endif
  return s:SearchBushuDic(a:ch)
endfunction

" bushu.help�t�@�C������A�w�肳�ꂽ�������܂ލs����������
function! s:SearchBushuHelp(ch)
  let lines = []
  if !s:BushuHelp_FileOpen()
    return lines
  endif
  silent! normal! G$
  if search('^' . a:ch, 'w') != 0
    call add(lines, getline('.'))
    while search('^' . a:ch, 'W') != 0
      call add(lines, getline('.'))
    endwhile
  endif
  quit!
  return lines
endfunction

" ���񍇐���������A�w�肳�ꂽ�������܂ލs����������
function! s:SearchBushuDic(ch)
  let lines = []
  if !s:Bushu_FileOpen()
    return lines
  endif
  silent! normal! G$
  if search(a:ch, 'w') != 0
    call add(lines, getline('.'))
    while search(a:ch, 'W') != 0
      call add(lines, getline('.'))
    endwhile
  endif
  quit!
  return lines
endfunction

function! s:KeymapFile_GetName()
  let keymap = &keymap
  if strlen(keymap) == 0
    let keymap = g:tcvime_keymap_for_help
    if strlen(keymap) == 0
      echo 'tcvime�����w���v�\���ɂ́Akeymap�I�v�V������g:tcvime_keymap_for_help�̐ݒ�v'
      return ''
    endif
  endif

  let kmfile = globpath(&rtp, "keymap/" . keymap . "_" . &encoding . ".vim")
  if filereadable(kmfile) != 1
    let kmfile = globpath(&rtp, "keymap/" . keymap . ".vim")
    if filereadable(kmfile) != 1
      return ''
    endif
  endif
  return kmfile
endfunction

" �w�肳�ꂽ��������͂��邽�߂̃X�g���[�N��keymap�t�@�C�����猟������
function! s:SearchKeymap(ch)
  if exists('s:kanji2seqdict')
    return get(s:kanji2seqdict, a:ch, '')
  endif
  let s:kanji2seqdict = {}

  let kmfile = s:KeymapFile_GetName()
  if kmfile == ''
    return ''
  endif
  silent execute 'sv ' . kmfile
  if search('loadkeymap', 'w') == 0
    quit!
    return ''
  endif
  let lines = getline(line('.') + 1, '$')
  quit!

  call filter(lines, 'v:val !~ "^\""')
  call filter(lines, 'v:val !~ "^$"')
  for line in lines
    let m = matchlist(line, '\([^ 	]\+\)[ 	]\+\([^ 	]\+\)')
    if !empty(m)
      let s:kanji2seqdict[m[2]] = substitute(m[1], '<Space>', ' ', 'g')
    endif
  endfor
  return get(s:kanji2seqdict, a:ch, '')
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
function! s:Candidate_FileOpen(foredit)
  if s:SelectWindowByName(s:candidate_file) > 0
    if a:foredit
      set noreadonly
      set buflisted
    endif
    return 1
  endif
  if filereadable(s:candidate_file) != 1
    return 0
  endif
  let cmd = 'sv '
  if a:foredit
    let cmd = 'sp '
  endif
  silent execute cmd . s:candidate_file
  nnoremap <buffer> <silent> <C-Y> :<C-U>call <SID>MazegakiDic_CandSelect()<CR>
  " ��△�����A�����J�n���ꂽ�����ҏW���L�����Z���������ꍇ�p�B
  nnoremap <buffer> <silent> <C-E> :<C-U>call <SID>MazegakiDic_Cancel()<CR>
  if !a:foredit
    set nobuflisted
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
function! s:CandidateSearch(keyword, finish)
  let s:last_keyword = a:keyword
  let s:last_candidate = ''
  let altbufnr = bufnr('')
  if !s:Candidate_FileOpen(0)
    return -1
  endif

  let origpos = getpos('.')
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
  " ��△�����������������ҏW�����������ϊ��̏ꍇ�ɁA�ҏW���̈ʒu�ɖ߂�����
  call setpos('.', origpos)
  if ret > 0
    if !&modified
      quit
    endif
    return ret
  endif
  " ��△��
  " ���������ϊ������ҏW�������J�n
  if a:finish && g:tcvime_mazegaki_edit_nocand
    if bufnr('') != altbufnr
      " �m�葀��Ō��̃o�b�t�@�ɖ߂��悤�ɁA���O�ɂ����o�b�t�@�ԍ�������Ă���
      let b:altbufnr = altbufnr
    " else �������������ҏW���ɂ���Ɍ��������ϊ������ꍇ�͂��̂܂�
    endif
    call tcvime#MazegakiDic_Edit(1)
  elseif !&modified
    quit
  endif
  return ret
endfunction

" �������������̕ҏW���������A��������������̃J�[�\���ʒu�̌����m�肷��
function! s:MazegakiDic_CandSelect()
  let [lnum, beg] = searchpos('/\zs', 'bc', line('.'))
  if beg == 0
    let [lnum, beg] = searchpos('/\zs', '', line('.'))
  endif
  let [lnum, end] = searchpos('\ze/', '', line('.'))
  let chars = matchstr(getline('.'), '\%' . beg . 'c' . '.*\%' . end . 'c')
  let s:last_candidate = chars
  let s:last_keyword = matchstr(getline('.'), '^[^ ]*')
  let bufnr = b:altbufnr
  xit

  execute bufwinnr(bufnr) . 'wincmd w'
  let s:status_line = line('.')
  execute "normal! a\<ESC>"
  let s:status_colend = col("'^.")
  let s:status_column = s:status_colend - strlen(s:last_keyword)
  let inschars = s:InputFix(col("'^"))
  let s:last_count = 0
  call s:InsertString(inschars)
endfunction

" ��������������ҏW�p�ɊJ���āA���O�ɕϊ������ǂ݂���������
function! tcvime#MazegakiDic_Edit(addnew)
  let altbufnr = bufnr('')
  if !s:Candidate_FileOpen(1)
    return -2
  endif
  " :TcvimeEditMazegaki�R�}���h���s���p
  if !exists('b:altbufnr')
    let b:altbufnr = altbufnr
  endif
  " ���O�����������ϊ��łȂ��ꍇ���A�����t�@�C���͊J��
  if s:last_keyword == ''
    return -1
  endif
  let ret = search('^' . s:last_keyword . ' ', 'cw')
  if ret
    call search(' /', 'e')
    return ret
  endif
  " �ǂ݂�������ΐV���ɑ}��
  if a:addnew
    execute 'normal! ggO' . s:last_keyword . ' /' . s:last_keyword . "/\<ESC>"
  endif
  return 0
endfunction

" ��△�����A�����J�n���ꂽ�����ҏW���L�����Z���������ꍇ�p�B
function! s:MazegakiDic_Cancel()
  " (�V�G���g���p�̍s�}����undo����quit�B
  " :quit!���ƁA������{���ɕҏW���̏ꍇ�ɁA�����<C-E>�������ƍ�Ƃ�������)
  if &modified
    undo
  endif
  quit
endfunction

" ���������ϊ��Ŋm�肵�������w�K���āA��⃊�X�g���ʒu���ړ����āA�����ۑ�
function! s:LearnCand(str)
  let origpos = getpos('.')
  let ret = tcvime#MazegakiDic_Edit(0)
  if ret == -2
    return
  elseif ret <= 0
    quit
    return
  endif
  let editing = &modified " �����ҏW���̌��������ϊ��̊m�肩�ǂ���
  let candstr = strpart(getline('.'), col('.') - 1)
  let candlist = split(candstr, '/', 1)
  " ['', '���1', '���2', '���3', ...., '']
  let i = index(candlist, a:str)
  let moveto = g:tcvime_movecandto + 1
  if i <= moveto " �w�K�ΏۊO�̈ʒu�ɂ��邩�A���Ɋw�K�ς݂̈ʒu�̏ꍇ�͕ύX�s�v
    if !editing
      quit
    else
      call setpos('.', origpos)
    endif
    return
  endif
  call remove(candlist, i)
  call insert(candlist, a:str, moveto)
  call setline('.', s:last_keyword . ' ' . join(candlist, '/'))
  if !editing
    wq
  else
    call setpos('.', origpos)
  endif
endfunction

" ����w���v�t�@�C�����I�[�v��
function! s:BushuHelp_FileOpen()
  if filereadable(s:bushuhelp_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushuhelp_file) < 0
    silent execute 'sv '.s:bushuhelp_file
    set nobuflisted
  endif
  return 1
endfunction

" ���񍇐������f�[�^�t�@�C�����I�[�v��
function! s:Bushu_FileOpen()
  if filereadable(s:bushu_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushu_file) < 0
    silent execute 'sv '.s:bushu_file
    set nobuflisted
  endif
  return 1
endfunction

" ���񍇐��ϊ�
function! s:BushuConvert(char1, char2)
  let retchar = s:BushuHelpSearch(a:char1, a:char2)
  if s:BushuCharOK(retchar, a:char1, a:char2)
    return retchar
  endif
  return s:BushuSearch(a:char1, a:char2)
endfunction

" ����w���v�t�@�C�����������ĕ��񍇐��ϊ�
function! s:BushuHelpSearch(char1, char2)
  if !s:BushuHelp_FileOpen()
    return ''
  endif
  " ��: "�B�C��* �`�E" (*����u����Ă���΋t���ł�OK)
  if search('\%(^.\| \)\%(' . a:char1 . a:char2 . '\*\?\|' . a:char2 . a:char1 . '\*\)\%( \|$\)', 'cw') != 0
    let retchar = matchstr(getline('.'), '^.')
  else
    let retchar = ''
  endif
  quit!
  return retchar
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
    silent execute 'sv '.s:kanjitable_file
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
    set nobuflisted
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

  " ���I��p�L�[�̃��x����ǉ�
  let lenlist = map(copy(a:candlist), 'strlen(v:val)')
  let maxlen = max(lenlist)
  let items = []
  let i = 0
  let len = len(a:candlist)
  while i < len
    let key = ''
    if i < len(g:tcvime#selectkeys)
      let key = repeat(' ', maxlen - lenlist[i] + 1) . g:tcvime#selectkeys[i]
      execute 'nnoremap <buffer> <silent> ' . key . ' :<C-U>call <SID>Candwin_SelectIndex(' . i . ')<CR>'
    endif
    call add(items, a:candlist[i] . key)
    let i += 1
  endwhile
  call append(0, items)
  silent! $g/^$/d _
  setlocal nomodifiable
  call cursor(1, 1)
  wincmd p
endfunction

" ���ݍs�̌����m�肷��
function! s:Candwin_Select()
  let s:last_candidate = s:last_candidate_list[line('.') - 1]
  bwipeout!
  call s:FixCandidate()
endfunction

" �w��index�̌����m�肷��
function! s:Candwin_SelectIndex(index)
  call cursor(a:index + 1, 1)
  call s:Candwin_Select()
endfunction

let &cpo = s:save_cpo
