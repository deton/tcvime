tcvime - �������ړ��͕⏕�@�\�v���O�C���X�N���v�g
							     Version: 1.2.1
							     Date: 2011-12-12

���
  tcode,tutcode���̊������ړ���keymap�p�̓��͕⏕�@�\��񋟂���
  �v���O�C���X�N���v�g�ł��B
  4�̋@�\��񋟂��܂�:
   * ���������ϊ�: ���Ȋ����ϊ��ŁA���ȕ����Ɋ������������Ă��Ă��ϊ�
   * ���񍇐��ϊ�: �������� �̂悤�ɕ���̑����Z/�����Z���s���Ċ���������
   * �����w���v�\�\��: ���镶������͂���ۂ̃L�[�̈ʒu�Ɠ��͏�����\��
   * �����e�[�u���t�@�C���̕\���ƕ����I���ɂ�����

�K�v����
  Vim 6.1�ȍ~�B
  ���{��̕\�����ł��邱�ƂƁAtcode/tutcode keymap�ł̓��͂��ł��邱�ƁB
  tcode/tutcode��keymap�t�@�C���́A���艮��Vim
  <http://www.kaoriya.net/software/vim>�Ɋ܂܂�Ă��܂��B
  �Ȃ��Atutcode keymap�͂���tcvime�̃A�[�J�C�u�ɂ��܂܂�Ă��܂��B

UNIX�ł̎g�p��̒���
  keymap���g�����߂ɁAconfigure����--with-features=big���w�肵��
  �R���p�C�����Ă����Ă��������B

  tcvime.vim, mazegaki.dic, bushu.rev, kanjitable.txt��cp932�G���R�[�f�B���O
  �ɂȂ��Ă��܂��B
  ���������̂܂܎g���ɂ́AVim��iconv����ō���Ă���A
  ���A(���艮�łɊ܂܂�Ă���vimrc�Őݒ肳��Ă���悤��)�Afileencodings��
  cp932���܂܂�Ă���K�v������܂��B

  ���邢�́A�����̃t�@�C���̃G���R�[�f�B���O��
  euc-jp�Ȃǂɕϊ����Ă����Ă��������B
  (���̏ꍇ�A�X�N���v�g(*.vim)����scriptencoding cp932�̕ύX�����Y��Ȃ��B)

����
  �A�[�J�C�u�Ɋ܂܂��t�@�C�������̏ꏊ�ɒu���Ă��������B

    �t�@�C��            �u���ꏊ              �t�@�C���̐���
  tcvime.vim          'runtimepath'/plugin  �v���O�C���X�N���v�g�{��
  tcvime.txt          'runtimepath'/doc     �X�N���v�g�̐�����
  mazegaki.dic        'runtimepath'��$VIM   ���������ϊ��p����
  bushu.rev           'runtimepath'��$VIM   ���񍇐��ϊ��p����
  kanjitable.txt      'runtimepath'��$VIM   �����e�[�u���t�@�C��
  tutcodek_cp932.vim  'runtimepath'/keymap  '�łЂ炪��/�J�^�J�i���[�h�؂�ւ�
					    ���ł���悤�ɂ���tutcode��keymap

  'runtimepath'��$VIM�Ŏ������f�B���N�g���́AVim���
  :echo &runtimepath �� :echo $VIM �����s���邱�ƂŊm�F�ł��܂��B

�g����
  tcvime.txt���Q�Ƃ��Ă��������B

~/.vimrc�̐ݒ��
  <C-J>��tutcode��L���ɂ��A<C-L>��tutcode�𖳌��ɂ���ݒ�̗�ł��B
  (<C-^>�ł̃g�O������ɂ�����A���݂̏�Ԃ��ӎ����镉�S�𖳂��������ꍇ�p)

  if has('keymap')
    set iminsert=0 imsearch=0
    " �ؑ֎��ɃC���f���g�����������̂�������邽�߁A1<C-H>
    imap <C-J> 1<C-H><C-O>:call <SID>SetKeymap('tutcodek')<CR>
    imap <C-L> 1<C-H><C-O>:set iminsert=0<CR>
    imap <silent> <ESC> <ESC>:set imsearch=0<CR>
  endif
  function! s:SetKeymap(keymapname)
    if &keymap !=# a:keymapname
      let &keymap = a:keymapname
    else
      let &iminsert = 1
    endif
  endfunction

�ӎ�
  - ���������vime.vim���x�[�X�ɂ����Ă��������Ă��܂��B
    tcvime.vim�̌��������ϊ������͂قƂ��vime.vim���̂��̂ł��B

  - tserv�̕��񍇐��A���S���Y�����g���Ă��܂��B
    ���Ƃ��Ƃ�Emacs�p��T�R�[�h���͊�tc�Ŏg���Ă����A���S���Y���̂悤�ł��B

  - mazegaki.dic, bushu.rev��Emacs�p��T�R�[�h���͊�tc2(tc-2.3.1)��
    �܂܂�Ă�����̂ł��B

�X�V����
  - 1.2.1 (2011-12-12)
   - backspace�I�v�V���������l�̏ꍇ�ɃG���[��������������C���B
   - cmdheight�l�̑ޔ��͕ύX���O�ɍs���悤�ɕύX�B
     tcvime�Ǎ���ɐݒ�l���ύX���ꂽ�ꍇ�ɑΉ����邽�߁B
   - �J�^�J�i�P����V�t�g�L�[���g���ē��͂���ۂɁA�P�ꒆ��
     �u�[�v���V�t�g�L�[���������ςȂ��œ��͂ł���悤�Ɉȉ��̒�`��
     tutcodek_cp932.vim�ɒǉ��B
       e<S-Space>     �[
       E<S-Space>     �[
   - ���艮��vim�Ɋ܂܂�Ă���tutcode_cp932.vim�ɂ���A
     �V�[�P���X�ŏ��̕����݂̂��啶���̃J�^�J�i��`(��:Rk	�A)��
     tutcodek_cp932.vim�ɒǉ��B

  - 1.2 (2005-03-10)
   - �����e�[�u���t�@�C����\�����āA������I�����ē��͂���@�\��ǉ��B

  - 1.1 (2004-08-13)
   - �^�u�̂���s�ŕ��񍇐��ϊ������ł��Ȃ��o�O���C���B

  - 1.0.1 (2003-09-04)
   - �w���v�o�b�t�@����"[TcvimeHelp]"����"__TcvimeHelp__"�ɕύX�B
   - TcvimeHelpBushu�R�}���h��ǉ�:
     �w�肵���������܂ލs�𕔎񍇐��ϊ��������猟�����ĕ\���B

  - 1.0 (2003-05-25)
    �ŏ��̃����[�X�B

-- 
�،� �p�l / KIHARA, Hideto
http://www1.interq.or.jp/~deton/tcvime/
$Id: README_j.txt,v 1.10 2011/12/12 11:18:18 deton Exp $
