" vi:set ts=8 sts=2 sw=2 tw=0:
"
" tcvime.vim - tcode,tutcode���̊������ړ���keymap�ł̓��͕⏕�@�\:
"              ���������ϊ��A���񍇐��ϊ��A�����w���v�\�\���@�\�B
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2012-12-23
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
"   :TcvimeCloseHelp  �w���v�p�o�b�t�@�����
"   :TcvimeEditMazegaki ���������ϊ�������ҏW�p�ɊJ���Ē��O�ɕϊ������ǂ݂�����
"
" imap:
"   <Leader>q       ���������ϊ�: �ǂ݂��J�n
"   <Leader><Space> ���������ϊ�: �ϊ����s
"   <Leader>o       ���������ϊ�: ���p�����̕ϊ����s
"   <Leader>b       ���񍇐��ϊ�: ���O��2�����̕��񍇐��ϊ����s
"
" nmap:
"   [count]<Leader><Space>  ���������ϊ�: �J�[�\���ʒu�ȑO��[count]�����̕ϊ�
"   [count]<Leader>o        ���������ϊ�: [count]�����̊��p�����̕ϊ�
"   <Leader>b               ���񍇐��ϊ�: �J�[�\���ʒu�ȑO��2�����̕��񍇐��ϊ�
"   <Leader>?               �Ō��w���v�\��: �J�[�\���ʒu�̕����̃w���v�\��\��
"   <Leader>t               �����e�[�u���t�@�C���\��
"
" vmap:
"   <Leader>?               �Ō��w���v�\��: �I�𒆂�(����)�����̃w���v�\��\��
"   <Leader><Space>         ���������ϊ�: �I�𒆂̕�����̕ϊ�
"   <Leader>o               ���������ϊ�: �I�𒆂̕���������p�����Ƃ��ĕϊ�
"
" �L�[�ݒ�I�v�V����:
"  imap:
"    '<Plug>TcvimeIStart'
"       ���������ϊ�: �ǂ݂��J�n����L�[�B�ȗ��l: <Leader>q
"       ��(alj���w�肷��ꍇ):
"         lmap <silent> alj <Plug>TcvimeIStart
"    '<Plug>TcvimeIConvOrStart'
"       ���������ϊ�: �ϊ����s�L�[�B�ȗ��l: <Leader><Space>
"       ��(al<Space>���w�肷��ꍇ):
"         lmap <silent> al<Space> <Plug>TcvimeIConvOrStart
"    '<Plug>TcvimeIConvOrSpace'
"       ���������ϊ�: �ϊ����s�L�[�B�ǂ݂��������' '��}���B
"       �ȗ��l: (����: ��������)
"       ��(<Space>���w�肷��ꍇ):
"         imap <silent> <Space> <Plug>TcvimeIConvOrSpace
"       (lmap�ɂ���ƁAlmap�L������f��t�̌��<Space>���g�p�s��(<C-R>=�Ȃ̂�))
"    '<Plug>TcvimeIKatuyo'
"       ���������ϊ�: ���p�����̕ϊ����s�L�[�B�ȗ��l: <Leader>o
"       ��(alo���w�肷��ꍇ):
"         lmap <silent> alo <Plug>TcvimeIKatuyo
"    '<Plug>TcvimeIBushu'
"       ���񍇐��ϊ�: ���O��2�����̕��񍇐��ϊ����s�L�[�B�ȗ��l: <Leader>b
"       ��(ala���w�肷��ꍇ):
"         lmap <silent> ala <Plug>TcvimeIBushu
"
"  nmap:
"    '<Plug>TcvimeNConvert'
"       ���������ϊ�: �J�[�\���ʒu�ȑO��[count]�����̕ϊ����s���L�[�B
"       �ȗ��l: <Leader><Space>
"       <Leader><Space>���w�肷��ꍇ�̗�:
"         nmap <silent> <Leader><Space> <Plug>TcvimeNConvert
"    '<Plug>TcvimeNKatuyo'
"       ���������ϊ�: [count]�����̊��p�����̕ϊ����s���L�[�B
"       �ȗ��l: <Leader>o
"    '<Plug>TcvimeNBushu'
"       ���񍇐��ϊ�: �J�[�\���ʒu�ȑO��2�����̕��񍇐��ϊ����s���L�[�B
"       �ȗ��l: <Leader>b
"    '<Plug>TcvimeNKatakana'
"       �J�^�J�i�ϊ�: �J�[�\���ʒu�ȑO��[count]�����̃J�^�J�i�ւ̕ϊ����s���L�[
"       �ȗ��l: (����:��������)
"    '<Plug>TcvimeNKataHira'
"       �J�^�J�i�ϊ�: �J�[�\���ʒu�ȑO�łЂ炪�Ȃ�u�[�v�������ԃJ�^�J�i�ɕϊ��B
"       [count]�Ŏw�肵���������͂Ђ炪�ȂƂ��Ďc���B
"       �ȗ��l: (����: ��������)
"    '<Plug>TcvimeNHelp'
"       �Ō��w���v�\��: �J�[�\���ʒu�̕����̃w���v�\��\������L�[�B
"       �ȗ��l: <Leader>?
"    '<Plug>TcvimeNKanjiTable'
"       �����e�[�u���t�@�C���\�����s���L�[�B�ȗ��l: <Leader>t
"     '<Plug>TcvimeNOpConvert'
"       ���������ϊ�: ���̃L�[�����������{motion}�Ŏw�肳��镶�����ϊ��B
"       ����: �L�[���������ۂ�|'operatorfunc'|���㏑�����܂��B
"       �ȗ��l: (����: ��������)
"     '<Plug>TcvimeNOpKatuyo'
"       ���������ϊ�: ���̃L�[�����������{motion}�Ŏw�肳��镶�����
"       ���p�����Ƃ��ĕϊ��B
"       ����: �L�[���������ۂ�|'operatorfunc'|���㏑�����܂��B
"       �ȗ��l: (����: ��������)
"     '<Plug>TcvimeNOpKatakana'
"       �J�^�J�i�ϊ�: ���̃L�[�����������{motion}�Ŏw�肳��镶�����
"       �J�^�J�i�ϊ��B
"       ����: �L�[���������ۂ�|'operatorfunc'|���㏑�����܂��B
"       �ȗ��l: (����: ��������)
"
"  vmap:
"    '<Plug>TcvimeVHelp'
"       �Ō��w���v�\��: �I�𒆂�(����)�����̃w���v�\��\������L�[�B
"       �ȗ��l: <Leader>?
"       <Leader>? ���w�肷��ꍇ�̗�:
"         vmap <silent> <Leader>? <Plug>TcvimeVHelp
"    '<Plug>TcvimeVConvert'
"       ���������ϊ�: �I�𒆂̕�����̕ϊ����s���L�[�B
"       �ȗ��l: <Leader><Space>
"    '<Plug>TcvimeVKatuyo'
"       ���������ϊ�: �I�𒆂̕���������p�����Ƃ��ĕϊ����s���L�[�B
"       �ȗ��l: <Leader>o
"    '<Plug>TcvimeVKatakana'
"       �J�^�J�i�ϊ�: �I�𒆂̕�������J�^�J�i�ɕϊ�����L�[�B
"       �ȗ��l: (����: ��������)
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
"    TcvimeCustomKeymap()
"       lmap�̃J�X�^�}�C�Y�p�̊֐��Btcvime#SetKeymap()����R�[���o�b�N�����B
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

" Mapping
if !exists(":TcvimeOn")
  command TcvimeOn :call tcvime#MappingOn()
endif
if !exists(":TcvimeOff")
  command TcvimeOff :call tcvime#MappingOff()
endif
" keymap��ݒ肷��
" ����: keymap��
if !exists(":TcvimeSetKeymap")
  command -nargs=1 TcvimeSetKeymap :call tcvime#SetKeymap(<args>)
endif
" �w�肳�ꂽ�����̃w���v�\��\������
" ����: �Ώۂ̕���
if !exists(":TcvimeHelp")
  command! -nargs=1 TcvimeHelp call tcvime#ShowHelpForStr(<q-args>, 0)
endif
" �w�肳�ꂽ�������܂ލs�𕔎񍇐��ϊ��������猟�����ĕ\������
" ����: �Ώۂ̕���
if !exists(":TcvimeHelpBushu")
  command! -nargs=1 TcvimeHelpBushu call tcvime#ShowHelpForStr(<q-args>, 1)
endif
" �����e�[�u����\������
if !exists(":TcvimeKanjiTable")
  command! TcvimeKanjiTable call tcvime#KanjiTable_FileOpen()
endif
" �w���v�p�o�b�t�@�����
if !exists(":TcvimeCloseHelp")
  command! TcvimeCloseHelp call tcvime#CloseHelpBuffer()
endif
" ���������ϊ������t�@�C����ҏW�p�ɊJ��
if !exists(":TcvimeEditMazegaki")
  command! TcvimeEditMazegaki call tcvime#MazegakiDic_Edit()
endif

TcvimeOn
