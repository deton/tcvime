VIme - SKK-IME�̐�����
					    Muraoka Taro <koron@tka.att.ne.jp>
						     Last Change: 07-Aug-2001.

���
  vim6 + skk���� �����œ��{����͂��s�Ȃ����Ƃ����X�N���v�g�ł��B���{�ꉼ����
  �͂̓��[�}��keymap�ŁA�����̕ϊ��͍���̃X�N���v�g+skk�����ōs�Ȃ��܂��B���J
  �ȗ��قƂ�ǂ������ĂȂ��̂Ń��łƂ������Ƃł��肢���܂��B���ł͗v�]�ɂ��
  SKK-JISYO.L�͓������Ă��܂���B�ʓr���肵�Ă��������B

  SKK-JISYO.L��$VIM��'runtimepath'�Ŏ������f�B���N�g���ɁAjapanese_cp932.vim
  ��runtime/keymap�ɁAvime.vim��runtime/plugin�ɒu���Ă��������B������vim���N
  �����܂��B���Ƃ͉��L�̎g�p��ɏ]���Ă��������B

UNIX�ł̎g�p��̒���
  keymap�A�����A�y��vime.vim�̊����R�[�h�A���s�R�[�h�̕ϊ���Y��Ȃ��ŉ������B
  �܂��f�t�H���g��keymap�@�\�͖����ɂȂ��Ă��܂��B
    ./configure --with-features=big
  �ŃR���p�C���������Ă��������B

�g�p��
  �������p�o�b�t�@�ŁA�Ȃɂ��l�����Ɏ��̃R�}���h�����s���܂��B
    :VImeOn
    :set cmdheight=2
    :set keymap=japanese
  �R���ŏ��������B

  �C���T�[�g���[�h�ŁA���Ɏ����悤�ɃL�[�^�C�v���Ă��������B�e�s�̐擪�́u:�v
  �͑ł��Ȃ��ŉ������B<Space>��<Enter>�͂��ꂼ��X�y�[�X�L�[�ƃG���^�[�L�[����
  �����܂��B�����s�ɓn���Ă��܂����A�s�ƍs�̊ԂŃG���^�[�L�[�������K�v�͂����
  ����B
    :<Space>ai<Space><Enter>wo<Enter>kudasai<Space><Enter><Enter>
    :<Space>hosi<Space><Enter>no<Enter>ouji<Space>sama<Space><Enter><Enter>
    :<Space>ik<Space><Space><Space><Space>tte<Enter>yos<Space><Space><Enter>si!!<Enter><Enter>
  �Ȃ��󔒂�}������̂�Shift+Space�Ɋ����ĂĂ���܂��B

�Q�l
  �����̘A����͂��̃t�@�C���̐擪�ƍŌ�ɏ����Ă���܂��B
  �����Vim�f���ł��󂯕t���܂��B

  - SKK-JISYO.L(sjis)
      http://ixeris.bios.ics.saitama-u.ac.jp/~koron/software/vim/SKK-JISYO.L.bz2
  - Vim�f����
      http://ixeris.bios.ics.saitama-u.ac.jp/~koron/bbs/bbs.cgi
  - Vim���{��ŏ��
      http://ixeris.bios.ics.saitama-u.ac.jp/~koron/

-------------------------------------------------------------------------------
vime-1.0a(����)�Ɍ����Ă̕���
�������̂��o�����܂�����������܂���BVim 6+SKK�̎��������œ��{����͂�����
�܂����A�Ƃ������̂ł��B���{�ꂩ�ȓ��͂̓��[�}��lmap�ŁA�����ւ̕ϊ��͍����
�X�N���v�g+SKK�����ōs�Ȃ��܂��B�܂莗��IME�ł��B�o�����ăz���z���̃��ł�
�������J���܂��B���Agvim6.0aj�ȊO�ł̓���ۏ؂͂��܂���B

�܂����̃t�@�C�����_�E�����[�h���ĉ𓀂��Ă��������BSKK�̃f�J���������t����
����̂Ō��\����܂�(��974KB)�B
http://ixeris.bios.ics.saitama-u.ac.jp/~koron/software/vim/vime-1.0a.tar.bz2
���ꂩ��𓀂���SKK-JISYO.L��gvim.exe�Ɠ����f�B���N�g���ɒu���܂��B����gvim
���N������vime.vim��source���܂��Bruntime/plugin�ɒu���Ă����΋N�����Ɏ����I
��source����܂��B�����Ă������p�o�b�t�@�ŁA�Ȃɂ��l�����Ɏ��̃R�}���h�����s
���܂��B
:VImeOn
:set cmdheight=2
:set keymap=japanese
�R���ŏ��������B

���悢��{�Ԃł��B�C���T�[�g���[�h�ŁA���Ɏ����悤�ɃL�[�^�C�v���Ă��������B
�e�s�̐擪�́u:�v�͑ł��Ȃ��ŉ������B����i�̓C���T�[�g���[�h�ɓ��邽�߂�i��
���B<Space>��<Enter>�͂��ꂼ��X�y�[�X�L�[�ƃG���^�[�L�[���Ӗ����܂��B�����s
�ɓn���Ă��܂����A�s�ƍs�̊ԂŃG���^�[�L�[�������K�v�͂���܂���B
:<Space>ai<Space><Enter>wo<Enter>kudasai<Space><Enter><Enter>
:<Space>hosi<Space><Enter>no<Enter>ouji<Space>sama<Space><Enter><Enter>
:<Space>ik<Space><Space><Space><Space>tte<Enter>yos<Space><Space><Enter>si!!<Enter><Enter>
�Ȃ��󔒂�}������̂�Shift+Space�Ɋ����ĂĂ���܂��B

-------------------------------------------------------------------------------
                  �����鎖�ւ̋����ӎu�������Ɏ����ƈقȂ鐶���������ԐS�ƂȂ�
                                    Muraoka Taro/�������Y<koron@tka.att.ne.jp>
 vi:set ts=8 sts=2 sw=2 tw=78:
