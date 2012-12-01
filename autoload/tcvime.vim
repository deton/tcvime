" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding cp932

" autoload/tcvime.vim - utility functions for tcvime.
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2012-12-01

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
  return tcvime#InputConvertKatakanaPos(col('.'), a:n)
endfunction

function! tcvime#InputConvertKatakanaPos(col, n)
  if a:n == 0
    " g:tcvime#hira2kata_pat�Ƀ}�b�`���镶�����擾
    let chars = matchstr(getline('.'), g:tcvime#hira2kata_pat . '\%' . a:col . 'c')
    let bs = substitute(chars, '.', "\<BS>", 'g')
  elseif a:col > a:n
    " �w�肳�ꂽ�������̕�������擾
    let pat = ''
    let i = 0
    while i < a:n
      let pat .= '.'
      let i += 1
    endwhile
    let chars = matchstr(getline('.'), pat . '\%' . a:col . 'c')
    let bs = substitute(pat, '\.', "\<BS>", 'g')
  else
    return ''
  endif
  let subst = substitute(chars, '.', '\=tcvime#hira2kata(submatch(0))', 'g')
  return bs . subst
endfunction

function! tcvime#hira2kata(s)
  return get(g:tcvime#hira2kata_table, a:s, a:s)
endfunction

let &cpo = s:save_cpo
