" vi:set ts=8 sts=2 sw=2 tw=0:
"
" tcvime.vim - tcode.vimÅù¤Î´Á»úÄ¾ÀÜÆþÎÏkeymap¤Ç¤ÎÆþÎÏÊä½õµ¡Ç½:
"              ¸ò¤¼½ñ¤­ÊÑ´¹¡¢Éô¼ó¹çÀ®ÊÑ´¹¡¢ÂÇ¸°¥Ø¥ë¥×É½¼¨µ¡Ç½¡£
"
" Last Change: $Date: 2003/05/19 12:48:03 $
" Maintainer: deton(KIHARA Hideto)@m1.interq.or.jp
" Original Plugin: vime.vim by Muraoka Taro <koron@tka.att.ne.jp>

" Description:
" »ÈÍÑË¡:
"   mazegaki.dic¤Èbushu.rev¤Ï$VIM¤«'runtimepath'¤Ç¼¨¤µ¤ì¤ë¥Ç¥£¥ì¥¯¥È¥ê¤Ë
"   ÃÖ¤¤¤Æ¤ª¤¤¤Æ¤¯¤À¤µ¤¤¡£
"
"   :TcvimeOn¥³¥Þ¥ó¥É¤Ç¥Þ¥Ã¥Ô¥ó¥°¤¬Í­¸ú¤Ë¤Ê¤ê¤Þ¤¹¡£
"   tcvime¤Îµ¡Ç½¤Ï'mapleader'¤Ç»ØÄê¤µ¤ì¤¿¥­¡¼¤Î¸å¤Ë
"   'q'¤Ê¤É¤Î¥­¡¼¤òÆþÎÏ¤¹¤ë¤³¤È¤Ç¼Â¹Ô¤µ¤ì¤Þ¤¹¡£
"   'mapleader'¤Î¥Ç¥Õ¥©¥ë¥È¤Ï"\<C-J>"(CTRL¥­¡¼¤ò²¡¤·¤Ê¤¬¤éj)¤Ç¤¹¡£
"   °Ê¹ß¤ÎÀâÌÀÃæ¤Î<Leader>¤È¤¤¤¦Ê¸»úÎó¤Ïmapleader¤òÉ½¤·¤Æ¤¤¤Þ¤¹¡£
"   ¤Ä¤Þ¤ê¡¢mapleader¤¬"\<C-J>"¤Î¾ì¹ç¡¢<Leader>q ¤Ï CTRL-J¤Î¸å¤Ëq¤òÆþÎÏ¤¹¤ë¡¢
"   ¤È¤¤¤¦¤³¤È¤Ç¤¹¡£
"   ¤Þ¤¿¡¢<Space>¤Ï¥¹¥Ú¡¼¥¹¥­¡¼¡¢<CR>¤Ï¥¨¥ó¥¿¡¼¥­¡¼¤Ç¤¹¡£
"
"  Insert Mode¤Ç¤Î¸ò¤¼½ñ¤­ÊÑ´¹:
"    <Leader>q ¤ÇÊÑ´¹ÂÐ¾ÝÊ¸»úÎó¤Î»Ï¤Þ¤ê¤ò¥Þ¡¼¥¯¤·¤Þ¤¹¡£
"    <Leader><Space> ¤Ç¸ò¤¼½ñ¤­ÊÑ´¹¤ò¹Ô¤¤¤Þ¤¹¡£
"      <Leader>q ¤Ç¥Þ¡¼¥¯¤·¤¿°ÌÃÖ¤«¤é¸½ºß¤Î¥«¡¼¥½¥ë°ÌÃÖ¤Î´Ö¤Ë¤¢¤ëÊ¸»úÎó¤ò
"      ÆÉ¤ß¤È¤·¤Æmazegaki.dic¤Ç¸¡º÷¤·¤Þ¤¹¡£
"      ¸õÊä¤¬°ì¤Ä¤·¤«¤Ê¤¤¾ì¹ç¤ÏÊÑ´¹ÂÐ¾ÝÊ¸»úÎó¤òÃÖ¤­´¹¤¨¤Þ¤¹¡£
"      ¸õÊä¤¬Ê£¿ô¤¢¤ë¾ì¹ç¤Ï¡¢¥³¥Þ¥ó¥É¹Ô¤Î¾å¤ËCANDIDATE: ¤Ç¸õÊä¤¬É½¼¨¤µ¤ì¤Þ¤¹¡£
"      Æ±¤¸ÊÑ´¹ÂÐ¾ÝÊ¸»úÎó¤ËÂÐ¤·¤Æ<Leader><Space>¤ò·«¤êÊÖ¤·ÂÇ¤Ä¤È¡¢
"      ¸õÊä¤ò½ç¤ËÉ½¼¨¤·¤Æ¤¤¤­¤Þ¤¹¡£
"      ¸õÊä¤Î¥ê¥¹¥È¤ÎºÇ¸å¤Þ¤Ç¹Ô¤¯¤È¥ê¥¹¥È¤ÎºÇ½é¤ËÌá¤ê¤Þ¤¹¡£
"    <Leader><CR> ¤ÇCANDIDATE: ¤È¤·¤ÆÉ½¼¨¤µ¤ì¤Æ¤¤¤ë¸õÊä¤òÁªÂò¤·¤Æ
"      ÊÑ´¹ÂÐ¾ÝÊ¸»úÎó¤òÃÖ¤­´¹¤¨¤Þ¤¹¡£
"
"    Îã: "<Leader>q¤¢¤¤<Leader><Space>"¤ÈÂÇ¤Ä¤È¡¢
"        "CANDIDATE: °£"¤ÈÉ½¼¨¤µ¤ì¤Þ¤¹¡£
"        ¤µ¤é¤Ë"<Leader><Space>"¤òÂÇ¤Ä¤È"CANDIDATE: °¥"¤È¤Ê¤ê¤Þ¤¹¡£
"        ¤³¤Î¾õÂÖ¤Ç"<Leader><CR>"¤òÂÇ¤Ä¤È¡¢"¤¢¤¤"¤¬"°¥"¤ËÃÖ¤­´¹¤¨¤é¤ì¤Þ¤¹¡£
"
"  Insert Mode¤Ç¤Î¸ò¤¼½ñ¤­ÊÑ´¹(³èÍÑ¤¹¤ë¸ì):
"    ´ðËÜÅª¤Ë¤Ï³èÍÑ¤·¤Ê¤¤¸ì¤Î¸ò¤¼½ñ¤­ÊÑ´¹¤ÈÆ±¤¸¤Ç¤¹¡£
"    "¡½"¤ò¤Ä¤±¤Æ<Leader><Space>¤ÇÊÑ´¹¤¹¤ë¤«¡¢³èÍÑ¤·¤Ê¤¤ÉôÊ¬¤Þ¤ÇÆþÎÏ¤·¤Æ¤«¤é¡¢
"    <Leader>o ¤ÇÊÑ´¹¤·¤Þ¤¹¡£
"    <Leader>o ¤Ï<Leader>q ¤Ç¥Þ¡¼¥¯¤·¤¿°ÌÃÖ¤«¤é¸½ºß¤Î¥«¡¼¥½¥ë°ÌÃÖ¤Î´Ö¤ÎÊ¸»úÎó¤Ë
"    "¡½"¤òÉÕ²Ã¤·¤¿Ê¸»úÎó¤òÆÉ¤ß¤È¤·¤Æmazegaki.dic¤«¤é¸¡º÷¤·¤Þ¤¹¡£
"
"    Îã: "<Leader>q¤Ê¤¬¤á<Leader>o"¤ÈÂÇ¤Ä¤È¡¢"CANDIDATE: Ä¯¤á"¤ÈÉ½¼¨¤µ¤ì¤Þ¤¹¡£
"        "<Leader><CR>"¤ÈÂÇ¤Ä¤È¡¢"¤Ê¤¬¤á"¤¬"Ä¯¤á"¤ËÃÖ¤­´¹¤¨¤é¤ì¤Þ¤¹¡£
"
"  Insert Mode¤Ç¤ÎÉô¼ó¹çÀ®ÊÑ´¹:
"    <Leader>b ¤Ç¥«¡¼¥½¥ë°ÌÃÖ¤ÎÄ¾Á°¤Î2Ê¸»ú¤ÎÉô¼ó¹çÀ®ÊÑ´¹¤ò¹Ô¤¤¤Þ¤¹¡£
"
"    Îã: "ÌÚ¸ý<Leader>b"¤ÈÂÇ¤Ä¤È¡¢"ÌÚ¸ý"¤¬"°É"¤ËÃÖ¤­´¹¤¨¤é¤ì¤Þ¤¹¡£
"
"  Normal Mode¤Ç¤Î¸ò¤¼½ñ¤­ÊÑ´¹:
"    [count]<Leader><Space> ¥«¡¼¥½¥ë°ÌÃÖ°ÊÁ°¤Î[count]Ê¸»ú¤Î¸ò¤¼½ñ¤­ÊÑ´¹¤ò
"      ¹Ô¤¤¤Þ¤¹¡£
"    <Leader><CR> ¤ÇCANDIDATE: ¤È¤·¤ÆÉ½¼¨¤µ¤ì¤Æ¤¤¤ë¸õÊä¤òÁªÂò¤·¤Æ
"      ÊÑ´¹ÂÐ¾ÝÊ¸»úÎó¤òÃÖ¤­´¹¤¨¤Þ¤¹¡£
"
"    Îã: "¤¢¤¤"¤ÈÉ½¼¨¤µ¤ì¤Æ¤¤¤ë¤È¤­¡¢"¤¤"¤Î¾å¤Ë¥«¡¼¥½¥ë¤òÃÖ¤¤¤Æ
"        "2<Leader><Space>"¤ÈÂÇ¤Ä¤È¡¢"CANDIDATE: °£"¤ÈÉ½¼¨¤µ¤ì¤Þ¤¹¡£
"        ¤µ¤é¤Ë"<Leader><Space>"¤ÈÂÇ¤Ä¤È¡¢"CANDIDATE: °¥"¤ÈÉ½¼¨¤µ¤ì¤Þ¤¹¡£
"        ¤³¤Î¾õÂÖ¤Ç"<Leader><CR>"¤òÂÇ¤Ä¤È¡¢"¤¢¤¤"¤¬"°¥"¤ËÃÖ¤­´¹¤¨¤é¤ì¤Þ¤¹¡£
"
"  Normal Mode¤Ç¤Î¸ò¤¼½ñ¤­ÊÑ´¹(³èÍÑ¤·¤Ê¤¤¸ì):
"    [count]<Leader>o ¥«¡¼¥½¥ë°ÌÃÖ°ÊÁ°¤Î[count]Ê¸»ú¤Ë"¡½"¤òÉÕ²Ã¤·¤¿Ê¸»úÎó¤ò
"      ÆÉ¤ß¤È¤·¤Æmazegaki.dic¤«¤é¸¡º÷¤·¤Þ¤¹¡£
"
"    Îã: "¤Ê¤¬¤á"¤ÈÉ½¼¨¤µ¤ì¤Æ¤¤¤ë¤È¤­¡¢"¤á"¤Î¾å¤Ë¥«¡¼¥½¥ë¤òÃÖ¤¤¤Æ
"        "3<Leader>o"¤ÈÂÇ¤Ä¤È¡¢"CANDIDATE: Ä¯¤á"¤ÈÉ½¼¨¤µ¤ì¤Þ¤¹¡£
"        "<Leader><CR>"¤ÈÂÇ¤Ä¤È¡¢"¤Ê¤¬¤á"¤¬"Ä¯¤á"¤ËÃÖ¤­´¹¤¨¤é¤ì¤Þ¤¹¡£
"
"  Normal Mode¤Ç¤ÎÉô¼ó¹çÀ®ÊÑ´¹:
"    <Leader>b ¥«¡¼¥½¥ë°ÌÃÖ°ÊÁ°¤Î2Ê¸»ú¤ÎÉô¼ó¹çÀ®ÊÑ´¹¤ò¹Ô¤¤¤Þ¤¹¡£
"
"    Îã: "ÌÚ¸ý"¤ÈÉ½¼¨¤µ¤ì¤Æ¤¤¤ë¤È¤­¡¢"¸ý"¤Î¾å¤Ë¥«¡¼¥½¥ë¤òÃÖ¤¤¤Æ
"        "<Leader>b"¤ÈÂÇ¤Ä¤È¡¢"ÌÚ¸ý"¤¬"°É"¤ËÃÖ¤­´¹¤¨¤é¤ì¤Þ¤¹¡£
"
" ÂÇ¸°¥Ø¥ë¥×É½¼¨(Normal Mode):
"    <Leader>? ¤Ç¥«¡¼¥½¥ë°ÌÃÖ¤ÎÊ¸»ú¤ÎÂÇ¸°¤òÉ½¼¨¤·¤Þ¤¹¡£
"      »ÈÍÑÃæ¤Îkeymap¤ÇÄ¾ÀÜÆþÎÏ¤Ç¤­¤Ê¤¤Ê¸»ú¤Î¾ì¹ç¤Ï¡¢
"      Éô¼ó¹çÀ®ÊÑ´¹¼­½ñ¤ò¸¡º÷¤·¤Æ¡¢»ØÄê¤µ¤ì¤¿Ê¸»ú¤¬´Þ¤Þ¤ì¤ë¹Ô¤òÉ½¼¨¤·¤Þ¤¹¡£
"
"    Îã: "¸°"¤È¤¤¤¦Ê¸»ú¤Î¾å¤Ë¥«¡¼¥½¥ë¤òÃÖ¤¤¤Æ"<Leader>?"¤ÈÂÇ¤Ä¤È¡¢
"        "[TcvimeHelp]"¤È¤¤¤¦¥Ð¥Ã¥Õ¥¡¤¬³«¤¤¤Æ¼¡¤Î¤è¤¦¤ËÉ½¼¨¤µ¤ì¤Þ¤¹
"        (keymap¤¬tutcode¤Î¾ì¹ç)¡£
"        ¡¦¡¦¡¦¡¦    ¡¦¡¦¡¦¡¦    ¸°
"        ¡¦¡¦¡¦¡¦  3 ¡¦¡¦¡¦¡¦
"        ¡¦¡¦¡¦¡¦    ¡¦¡¦¡¦¡¦
"        ¡¦¡¦1 2     ¡¦¡¦¡¦¡¦
"
" ¥ª¥×¥·¥ç¥ó:
"    'tcvime_keyboard'
"       ÂÇ¸°¥Ø¥ë¥×É½¼¨ÍÑ¤Î¥­¡¼¥Ü¡¼¥ÉÇÛÎó¤òÉ½¤¹Ê¸»úÎó¡£
"       ¥­¡¼¤Î¸å¤Ë¥¹¥Ú¡¼¥¹¡¢¤ò2²ó¤º¤Äµ­½Ò¤¹¤ë¡£
"       Îã:
"         let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
"
"    'mapleader'
"       |mapleader|

" ¤³¤Î¥×¥é¥°¥¤¥ó¤òÆÉ¹þ¤ß¤¿¤¯¤Ê¤¤»þ¤Ï.vimrc¤Ë¼¡¤Î¤è¤¦¤Ë½ñ¤¯¤³¤È:
"       :let plugin_tcvime_disable = 1

if exists('plugin_tcvime_disable')
  finish
endif

if !exists("tcvime_keyboard")
  let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
  " ¿ô»ú¥­¡¼¤ÎÃÊ¤òÉ½¼¨¤·¤Ê¤¤¾ì¹ç¤Ï¼¡¤ÎÊ¸»úÎó¤ò»È¤¦¤è¤¦¤Ë¤¹¤ë(qwerty)
"  let tcvime_keyboard = "q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
endif

" Mapping
command! TcvimeOn :call <SID>MappingOn()
command! TcvimeOff :call <SID>MappingOff()
" keymap¤òÀßÄê¤·¤Æ¡¢TcvimeOn¤¹¤ë
" °ú¿ô: keymapÌ¾
command! -nargs=1 TcvimeInit :call <SID>TcvimeInit(<f-args>)

"   ¥Þ¥Ã¥Ô¥ó¥°¤òÍ­¸ú²½
function! s:MappingOn()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-J>"
    let set_mapleader = 1
  endif
  let s:mapleader = g:mapleader
  inoremap <silent> <Leader><CR> <C-O>:call <SID>InputFix()<CR>
  inoremap <silent> <Leader>q <C-O>:call <SID>InputStart()<CR>
  inoremap <silent> <Leader><Space> <C-O>:call <SID>InputConvert()<CR>
  inoremap <silent> <Leader>o <C-O>:call <SID>InputConvertKatuyo()<CR>
  inoremap <silent> <Leader>b <C-O>:call <SID>InputConvertBushu(1)<CR>
  nnoremap <silent> <Leader><CR> :<C-U>call <SID>FixCandidate()<CR>
  nnoremap <silent> <Leader><Space> :<C-U>call <SID>ConvertCount(v:count)<CR>
  nnoremap <silent> <Leader>o :<C-U>call <SID>ConvertKatuyo(v:count)<CR>
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

"   ¥Þ¥Ã¥Ô¥ó¥°¤òÌµ¸ú²½
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

" keymap¤òÀßÄê¤·¤ÆTcvime¤ÎMapping¤òÍ­¸ú¤Ë¤¹¤ë
function! s:TcvimeInit(keymapname)
  if &keymap !=# a:keymapname
    let &keymap = a:keymapname
    call s:MappingOn()
  endif
endfunction


" ÀßÄê
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
"echo "candidate_file: ".s:candidate_file
let s:helpbufname = '[TcvimeHelp]'
let s:helpbufpat = '\[TcvimeHelp\]'

"==============================================================================
"				    ¼­½ñ¸¡º÷
"

" ¼­½ñ¥Ç¡¼¥¿¥Õ¥¡¥¤¥ë¤ò¥ª¡¼¥×¥ó
function! s:Candidate_FileOpen()
  if filereadable(s:candidate_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:candidate_file) < 0
    execute 'silent normal! :sv '.s:candidate_file."\<CR>"
  endif
  return 1
endfunction

" ¸¡º÷¤Ë»ÈÍÑ¤¹¤ë¾õÂÖÊÑ¿ô
let s:last_keyword = ''
let s:last_found = 0
let s:last_candidate = ''
let s:last_candidate_str = ''
let s:last_candidate_num = 0
let s:is_katuyo = 0

" ¼­½ñ¤«¤éÌ¤³ÎÄêÊ¸»úÎó¤ò¸¡º÷
" ¸õÊä¤¬°ì¤Ä¤·¤«¤Ê¤¤¾ì¹ç¤Ï1¤òÊÖ¤¹¡£¸õÊä¤¬Ê£¿ô¤¢¤ë¾ì¹ç¤Ï0¤òÊÖ¤¹¡£
function! s:CandidateSearch(keyword)
  let found_num = s:last_found
  let uniq = 0

  " ¸¡º÷Ê¸»úÎó¤¬Á°²ó¤ÈÆ±¤¸»þ¤Ï¾ÊÎ¬
  if s:last_keyword !=# a:keyword
    let s:last_keyword = a:keyword
    if !s:Candidate_FileOpen()
      return 0
    endif

    " ¼ÂºÝ¤Î¸¡º÷
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
    " ¼¡¤ÎÊÑ´¹¸õÊä¤òÃµ¤·½Ð¤¹¤¿¤á
    if s:last_candidate_num > 0 && s:last_candidate != ''
      let s:last_candidate_num = s:last_candidate_num + strlen(s:last_candidate) + 1
    endif
    " Á°²óÊÑ´¹¤·¤¿Ê¸»úÎó¤òºÆÅÙÊÑ´¹¤¹¤ë¾ì¹ç¡¢¸õÊä¿ô¤ò¥Á¥§¥Ã¥¯¤·Ä¾¤¹
    if s:last_candidate_num == 1 && s:last_candidate == ''
      if s:last_candidate_str =~# '^/[^/]\+/$'
	let uniq = 1
      endif
    endif
  endif

  if found_num > 0
    " ¸õÊä¤¬¤ß¤Ä¤«¤Ã¤Æ¤¤¤ë¤Ê¤é¤Ð¡¢½çÈÖ¤ËÉ½¼¨¤¹¤ë
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
    " ¸õÊä¤¬¤ß¤Ä¤«¤é¤Ê¤«¤Ã¤¿»þ¡¢¥ê¥»¥Ã¥È
    let s:last_candidate = ''
    let s:last_candidate_str = ''
    let s:last_candidate_num = 0
  endif
  let s:last_found = found_num
  return uniq
endfunction

" ¸õÊä¤ò¥Ð¥Ã¥Õ¥¡¤ËÁÞÆþ
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

" Éô¼ó¹çÀ®¼­½ñ¥Ç¡¼¥¿¥Õ¥¡¥¤¥ë¤ò¥ª¡¼¥×¥ó
function! s:Bushu_FileOpen()
  if filereadable(s:bushu_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushu_file) < 0
    execute 'silent normal! :sv '.s:bushu_file."\<CR>"
  endif
  return 1
endfunction

" Åù²ÁÊ¸»ú¤ò¸¡º÷¤·¤ÆÊÖ¤¹¡£Åù²ÁÊ¸»ú¤¬¤Ê¤¤¾ì¹ç¤Ï¤â¤È¤ÎÊ¸»ú¤½¤Î¤â¤Î¤òÊÖ¤¹
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

" char1¤Èchar2¤ò¤³¤Î½çÈÖ¤Ç¹çÀ®¤·¤Æ¤Ç¤­¤ëÊ¸»ú¤ò¸¡º÷¤·¤ÆÊÖ¤¹¡£
" ¸«¤Ä¤«¤é¤Ê¤¤¾ì¹ç¤Ï''¤òÊÖ¤¹
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

" »ØÄê¤µ¤ì¤¿Ê¸»ú¤ò2¤Ä¤ÎÉô¼ó¤ËÊ¬²ò¤¹¤ë¡£
" Ê¬²ò¤·¤¿Éô¼ó¤òs:decomp1, s:decomp2¤Ë¥»¥Ã¥È¤¹¤ë¡£
" @return 1: Ê¬²ò¤ËÀ®¸ù¤·¤¿¾ì¹ç¡¢0: Ê¬²ò¤Ç¤­¤Ê¤«¤Ã¤¿¾ì¹ç
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

" ¹çÀ®¸å¤ÎÊ¸»ú¤¬¶õ¤Ç¤Ê¤¯¡¢¸µ¤ÎÊ¸»ú¤Ç¤â¤Ê¤¤¤³¤È¤ò³ÎÇ§
" @param ch ¹çÀ®¸å¤ÎÊ¸»ú
" @param char1 ¸µ¤ÎÊ¸»ú
" @param char2 ¸µ¤ÎÊ¸»ú
" @return 1: ch¤¬¶õ¤Ç¤âchar1¤Ç¤âchar2¤Ç¤â¤Ê¤¤¾ì¹ç¡£0: ¤½¤ì°Ê³°¤Î¾ì¹ç
function! s:BushuCharOK(ch, char1, char2)
  if a:ch !=# '' && a:ch !=# a:char1 && a:ch !=# a:char2
    return 1
  else
    return 0
  endif
endfunction

" Éô¼ó¹çÀ®ÊÑ´¹¼­½ñ¤ò¸¡º÷
function! s:BushuSearch(char1, char2)
  let char1 = a:char1
  let char2 = a:char2
  let i = 0
  while i < 2
    " ¤½¤Î¤Þ¤Þ¹çÀ®¤Ç¤­¤ë?
    let retchar = s:BushuSearchCompose(char1, char2)
    if s:BushuCharOK(retchar, char1, char2)
      return retchar
    endif

    " Åù²ÁÊ¸»ú¤É¤¦¤·¤Ç¹çÀ®¤Ç¤­¤ë?
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

    " Åù²ÁÊ¸»ú¤òÉô¼ó¤ËÊ¬²ò
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

    " °ú¤­»»
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

    " °ìÊý¤¬ÉôÉÊ¤Ë¤è¤ëÂ­¤·»»
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

    " Î¾Êý¤¬ÉôÉÊ¤Ë¤è¤ëÂ­¤·»»
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

    " ÉôÉÊ¤Ë¤è¤ë°ú¤­»»
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

    " Ê¸»ú¤Î½ç¤òµÕ¤Ë¤·¤Æ¤ä¤Ã¤Æ¤ß¤ë
    let t = char1  | let char1  = char2  | let char2 = t
    let t = ch1alt | let ch1alt = ch2alt | let ch2alt = t
    let t = ch1a1  | let ch1a1  = ch2a1  | let ch2a1 = t
    let t = ch1a2  | let ch1a2  = ch2a2  | let ch2a2 = t
    let i = i + 1
  endwhile

  " ¹çÀ®¤Ç¤­¤Ê¤«¤Ã¤¿
  return ''
endfunction

" Éô¼ó¹çÀ®¤·¤¿Ê¸»ú¤ò¥Ð¥Ã¥Õ¥¡¤ËÁÞÆþ
function! s:BushuReplace(linenum, stcol, endcol, ch)
  let str = getline(a:linenum)
  let str = strpart(str, 0, a:stcol - 1) . a:ch . strpart(str, a:endcol - 1)
  call setline(a:linenum, str)
endfunction

"==============================================================================
"				    ÆþÎÏÀ©¸æ
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

" ³èÍÑ¤Î¤¢¤ëÃ±¸ì¤ÎÊÑ´¹¤ò¹Ô¤¦¡£
" ÊÑ´¹ÂÐ¾ÝÊ¸»úÎó¤ÎËöÈø¤Ë¡Ö¡½¡×¤òÄÉ²Ã¤·¤Æ¸ò¤¼½ñ¤­¼­½ñ¤ò¸¡º÷¤¹¤ë¡£
function! s:InputConvertKatuyo()
  let col = col("'^")
  let status = s:StatusGet()
  let uniq = 0
  let len = strlen(status)
  if len > 0
    let s:is_katuyo = 1
    let uniq = s:CandidateSearch(status . '¡½')
  else
    let s:last_keyword = ''
    call s:StatusReset()
  endif
  execute "normal! " . col . "|"
  if uniq
    call s:InputFix()
  endif
endfunction

" ³ÎÄê¤·¤è¤¦¤È¤·¤Æ¤¤¤ë¸õÊä¤¬ÌäÂê¤Ê¤¤¤«¤É¤¦¤«¥Á¥§¥Ã¥¯
function! s:IsCandidateOK(str)
  if strlen(a:str) > 0 && strlen(s:last_candidate) > 0
    if s:is_katuyo && s:last_keyword ==# (a:str . '¡½') || s:last_keyword ==# a:str
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

" Ä¾Á°¤Î2Ê¸»ú¤ÎÉô¼ó¹çÀ®ÊÑ´¹¤ò¹Ô¤¦
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

" º£¤Î°ÌÃÖ°ÊÁ°¤Î2Ê¸»ú¤òÉô¼ó¹çÀ®ÊÑ´¹¤¹¤ë
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  call s:InputConvertBushu(0)
endfunction

" °ÊÁ°¤ÎConvertCount(), ConvertKatuyo()¤ËÅÏ¤µ¤ì¤¿count°ú¿ô¤ÎÃÍ¡£
" count¤¬0¤Ç¼Â¹Ô¤µ¤ì¤¿¾ì¹ç¤Ë°ÊÁ°¤ÎcountÃÍ¤ò»È¤¦¤è¤¦¤Ë¤¹¤ë¤¿¤á¡£
let s:last_count = 0

" º£¤Î°ÌÃÖ°ÊÁ°¤ÎcountÊ¸»ú¤òÊÑ´¹¤¹¤ë
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

" º£¤Î°ÌÃÖ°ÊÁ°¤ÎcountÊ¸»ú¤ò³èÍÑ¤Î¤¢¤ë¸ì¤È¤·¤ÆÊÑ´¹¤¹¤ë
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
    let uniq = s:CandidateSearch(status . '¡½')
    if uniq
      call s:FixCandidate()
    endif
  else
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
  endif
endfunction

" ConvertCount()¤ÇÊÑ´¹¤ò³«»Ï¤·¤¿¸õÊä¤ò³ÎÄê¤¹¤ë
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
" ¥Ø¥ë¥×É½¼¨

" ¶õ¤Î¥Ø¥ë¥×ÍÑ¥Ð¥Ã¥Õ¥¡¤òºî¤ë
function! s:Help_BufReadCmd()
  set ft=
  set buftype=nofile
  set bufhidden=delete
  set noswapfile
endfunction

" ¥Ø¥ë¥×ÍÑ¥Ð¥Ã¥Õ¥¡¤ò³«¤¯
function! s:OpenHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) < 0
    execute "silent normal! :sp " . s:helpbufname . "\<CR>"
  endif
  execute "normal! :%d\<CR>4\<C-W>\<C-_>"
endfunction

" ¥«¡¼¥½¥ë°ÌÃÖ¤ÎÊ¸»ú¤ÎÂÇ¸°¤òÉ½¼¨¤¹¤ë
function! s:ShowStrokeHelp()
  let col1 = col(".")
  execute "normal! a\<ESC>"
  let col2 = col("'^")
  let ch = strpart(getline("."), col1 - 1, col2 - col1)
  call s:ShowHelp(ch)
endfunction

" »ØÄê¤µ¤ì¤¿Ê¸»ú¤òÆþÎÏ¤¹¤ë¤¿¤á¤ÎÂÇ¸°¤òÉ½¼¨¤¹¤ë
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

" »ØÄê¤µ¤ì¤¿Ê¸»ú¤È¤½¤ÎÂÇ¸°¤òÉ½¤Ë¤·¤ÆÉ½¼¨¤¹¤ë
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
  execute "normal! :%s@. . @¡¦@g\<CR>"
  execute "normal! :%s@@ @ge\<CR>"
  execute "normal! 1GA    " . a:ch . "\<ESC>"
  execute "normal! \<C-W>p"
endfunction

" Éô¼ó¹çÀ®¼­½ñ¤«¤é¡¢»ØÄê¤µ¤ì¤¿Ê¸»ú¤ò´Þ¤à¹Ô¤ò¸¡º÷¤·¤ÆÉ½¼¨¤¹¤ë
function! s:ShowHelpBushuDic(ch)
  let lines = s:SearchBushuDic(a:ch)
  if strlen(lines) > 0
    call s:OpenHelpBuffer()
    execute "normal! a" . lines . "\<ESC>1G"
    execute "normal! \<C-W>p"
  endif
endfunction

" Éô¼ó¹çÀ®¼­½ñ¤«¤é¡¢»ØÄê¤µ¤ì¤¿Ê¸»ú¤ò´Þ¤à¹Ô¤ò¸¡º÷¤¹¤ë
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

" »ØÄê¤µ¤ì¤¿Ê¸»ú¤òÆþÎÏ¤¹¤ë¤¿¤á¤ÎÂÇ¸°¤òkeymap¥Õ¥¡¥¤¥ë¤«¤é¸¡º÷¤¹¤ë
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
"			     Ì¤³ÎÄêÊ¸»ú´ÉÍýÍÑ´Ø¿ô·²
"

"   Ì¤³ÎÄêÊ¸»úÎó¤¬Â¸ºß¤¹¤ë¤«¥Á¥§¥Ã¥¯¤¹¤ë
function! s:StatusIsEnable()
  if s:status_line != line('.') || s:status_column <= 0 || s:status_column > col('.')
    return 0
  endif
  return 1
endfunction

"   Ì¤³ÎÄêÊ¸»úÎó¤ò³«»Ï¤¹¤ë
function! s:StatusSet()
  let s:status_line = line("'^")
  let s:status_column = col("'^")
  call s:StatusEcho()
endfunction

"   Ì¤³ÎÄêÊ¸»úÎó¤ò¥ê¥»¥Ã¥È¤¹¤ë
function! s:StatusReset()
  let s:status_line = 0
  let s:status_column = 0
endfunction

"   Ì¤³ÎÄêÊ¸»úÎó¤ò¡Ö¾õÂÖ¡×¤È¤·¤Æ¼èÆÀ¤¹¤ë
function! s:StatusGet()
  if !s:StatusIsEnable()
    return ''
  endif

  " É¬Í×¤Ê¥Ñ¥é¥á¡¼¥¿¤ò¼ý½¸
  let stpos = s:status_column - 1
  let ccl = col("'^")
  let len = ccl - s:status_column
  let str = getline('.')

  return strpart(str, stpos, len)
endfunction

"   Ì¤³ÎÄêÊ¸»úÎó¤Î³«»Ï°ÌÃÖ¤È½ªÎ»°ÌÃÖ¤òÉ½¼¨(¥Ç¥Ð¥Ã¥°ÍÑ)
function! s:StatusEcho(...)
  echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

call s:StatusReset()
