" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding cp932

" autoload/tcvime/tcvime.vim - utility functions for Kanji direct input keymaps
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2012-11-24

" insert mode���ɁA���O�̎w�肳�ꂽ�������̂Ђ炪�ȁ��J�^�J�i�ϊ����s��
" ���߂̕������Ԃ��B
" tutcode keymap�Ō�u�^�J�^�J�i�ϊ����s�����߂̐ݒ��:
"     lmap al1 <C-R>=tcvime#tcvime#InputConvertKatakana(1)<CR>
"     lmap al2 <C-R>=tcvime#tcvime#InputConvertKatakana(2)<CR>
"     lmap al3 <C-R>=tcvime#tcvime#InputConvertKatakana(3)<CR>
"     lmap al4 <C-R>=tcvime#tcvime#InputConvertKatakana(4)<CR>
"     lmap al5 <C-R>=tcvime#tcvime#InputConvertKatakana(5)<CR>
"     lmap al6 <C-R>=tcvime#tcvime#InputConvertKatakana(6)<CR>
"     lmap al7 <C-R>=tcvime#tcvime#InputConvertKatakana(7)<CR>
"     lmap al8 <C-R>=tcvime#tcvime#InputConvertKatakana(8)<CR>
"     lmap al9 <C-R>=tcvime#tcvime#InputConvertKatakana(9)<CR>
function! tcvime#tcvime#InputConvertKatakana(n)
  return tcvime#tcvime#InputConvertKatakanaPos(col('.'), a:n)
endfunction

function! tcvime#tcvime#InputConvertKatakanaPos(col, n)
  let inschars = ''
  if a:col > a:n
    " �w�肳�ꂽ�������̕�������擾
    let pat = ''
    let i = 0
    while i < a:n
      let pat .= '.'
      let i += 1
    endwhile
    let chars = matchstr(getline('.'), pat . '\%' . a:col . 'c')
    let subst = substitute(chars, '.', '\=tcvime#tcvime#hira2kata(submatch(0))', 'g')
    let inschars = substitute(pat, '\.', "\<BS>", 'g') . subst
  endif
  return inschars
endfunction

function! tcvime#tcvime#hira2kata(s)
  return get(g:tcvime#hira2kata#hira2kata, a:s, a:s)
endfunction
