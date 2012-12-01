" vi:set ts=8 sts=2 sw=2 tw=0:
"
" tcvime.vim - tcode,tutcode“™‚ÌŠ¿š’¼Ú“ü—Íkeymap‚Å‚Ì“ü—Í•â•‹@”\:
"              Œğ‚º‘‚«•ÏŠ·A•”ñ‡¬•ÏŠ·A•¶šƒwƒ‹ƒv•\•\¦‹@”\B
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2012-12-01
" Original Plugin: vime.vim by Muraoka Taro <koron@tka.att.ne.jp>

scriptencoding cp932

" Description:
" ƒRƒ}ƒ“ƒh:
"   :TcvimeOn         ƒL[ƒ}ƒbƒsƒ“ƒO‚ğ—LŒø‰»‚·‚é
"   :TcvimeOff        ƒL[ƒ}ƒbƒsƒ“ƒO‚ğ–³Œø‰»‚·‚é
"   :TcvimeHelp       w’è‚µ‚½•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
"   :TcvimeHelpBushu  w’è‚µ‚½•¶š‚ğŠÜ‚Şs‚ğ•”ñ‡¬•ÏŠ·«‘‚©‚çŒŸõ‚µ‚Ä•\¦
"   :TcvimeSetKeymap  keymap‚ğset‚·‚é
"   :TcvimeKanjiTable Š¿šƒe[ƒuƒ‹ƒtƒ@ƒCƒ‹‚ğ•\¦‚µ‚ÄAŠ¿š‚ğ‘I‚ñ‚Å“ü—Í
"   :TcvimeCloseHelp  ƒwƒ‹ƒv—pƒoƒbƒtƒ@‚ğ•Â‚¶‚é
"
" imap:
"   <Leader>q       Œğ‚º‘‚«•ÏŠ·: “Ç‚İ‚ğŠJn
"   <Leader><Space> Œğ‚º‘‚«•ÏŠ·: •ÏŠ·Às
"   <Leader>o       Œğ‚º‘‚«•ÏŠ·: Šˆ—p‚·‚éŒê‚Ì•ÏŠ·Às
"   <Leader>b       •”ñ‡¬•ÏŠ·: ’¼‘O‚Ì2•¶š‚Ì•”ñ‡¬•ÏŠ·Às
"
" nmap:
"   [count]<Leader><Space>  Œğ‚º‘‚«•ÏŠ·: ƒJ[ƒ\ƒ‹ˆÊ’uˆÈ‘O‚Ì[count]•¶š‚Ì•ÏŠ·
"   [count]<Leader>o        Œğ‚º‘‚«•ÏŠ·: [count]•¶š‚ÌŠˆ—p‚·‚éŒê‚Ì•ÏŠ·
"   <Leader>b               •”ñ‡¬•ÏŠ·: ƒJ[ƒ\ƒ‹ˆÊ’uˆÈ‘O‚Ì2•¶š‚Ì•”ñ‡¬•ÏŠ·
"   <Leader>?               ‘ÅŒ®ƒwƒ‹ƒv•\¦: ƒJ[ƒ\ƒ‹ˆÊ’u‚Ì•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦
"   <Leader>t               Š¿šƒe[ƒuƒ‹ƒtƒ@ƒCƒ‹•\¦
"
" vmap:
"   <Leader>?               ‘ÅŒ®ƒwƒ‹ƒv•\¦: ‘I‘ğ’†‚Ì(•¡”)•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦
"
" ƒL[İ’èƒIƒvƒVƒ‡ƒ“:
"  imap:
"    '<Plug>TcvimeIStart'
"       Œğ‚º‘‚«•ÏŠ·: “Ç‚İ‚ğŠJn‚·‚éƒL[BÈ—ª’l: <Leader>q
"       <Leader><CR>‚ğw’è‚·‚éê‡‚Ì—á:
"         imap <Leader>q <Plug>TcvimeIStart
"    '<Plug>TcvimeIConvert'
"       Œğ‚º‘‚«•ÏŠ·: •ÏŠ·ÀsƒL[BÈ—ª’l: <Leader><Space>
"    '<Plug>TcvimeIKatuyo'
"       Œğ‚º‘‚«•ÏŠ·: Šˆ—p‚·‚éŒê‚Ì•ÏŠ·ÀsƒL[BÈ—ª’l: <Leader>o
"    '<Plug>TcvimeIBushu'
"       •”ñ‡¬•ÏŠ·: ’¼‘O‚Ì2•¶š‚Ì•”ñ‡¬•ÏŠ·ÀsƒL[BÈ—ª’l: <Leader>b
"
"  nmap:
"    '<Plug>TcvimeNConvert'
"       Œğ‚º‘‚«•ÏŠ·: ƒJ[ƒ\ƒ‹ˆÊ’uˆÈ‘O‚Ì[count]•¶š‚Ì•ÏŠ·‚ğs‚¤ƒL[B
"       È—ª’l: <Leader><Space>
"       <Leader><Space>‚ğw’è‚·‚éê‡‚Ì—á:
"         nmap <Leader><Space> <Plug>TcvimeNConvert
"    '<Plug>TcvimeNKatuyo'
"       Œğ‚º‘‚«•ÏŠ·: [count]•¶š‚ÌŠˆ—p‚·‚éŒê‚Ì•ÏŠ·‚ğs‚¤ƒL[B
"       È—ª’l: <Leader>o
"    '<Plug>TcvimeNBushu'
"       •”ñ‡¬•ÏŠ·: ƒJ[ƒ\ƒ‹ˆÊ’uˆÈ‘O‚Ì2•¶š‚Ì•”ñ‡¬•ÏŠ·‚ğs‚¤ƒL[B
"       È—ª’l: <Leader>b
"    '<Plug>TcvimeNKatakana'
"       ƒJƒ^ƒJƒi•ÏŠ·: ƒJ[ƒ\ƒ‹ˆÊ’uˆÈ‘O‚Ì[count]•¶š‚ÌƒJƒ^ƒJƒi‚Ö‚Ì•ÏŠ·‚ğs‚¤ƒL[
"       È—ª’l: (–³‚µ:–¢Š„“–‚Ä)
"    '<Plug>TcvimeNHelp'
"       ‘ÅŒ®ƒwƒ‹ƒv•\¦: ƒJ[ƒ\ƒ‹ˆÊ’u‚Ì•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚éƒL[B
"       È—ª’l: <Leader>?
"    '<Plug>TcvimeNKanjiTable'
"       Š¿šƒe[ƒuƒ‹ƒtƒ@ƒCƒ‹•\¦‚ğs‚¤ƒL[BÈ—ª’l: <Leader>t
"
"  vmap:
"    '<Plug>TcvimeVHelp'
"       ‘ÅŒ®ƒwƒ‹ƒv•\¦: ‘I‘ğ’†‚Ì(•¡”)•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚éƒL[B
"       È—ª’l: <Leader>?
"       <Leader>? ‚ğw’è‚·‚éê‡‚Ì—á:
"         vmap <Leader>? <Plug>TcvimeVHelp
"
" ƒIƒvƒVƒ‡ƒ“:
"    'tcvime_keyboard'
"       •¶šƒwƒ‹ƒv•\—p‚ÌƒL[ƒ{[ƒh”z—ñ‚ğ•\‚·•¶š—ñB
"       ƒL[‚ÌŒã‚ÉƒXƒy[ƒXA‚ğ2‰ñ‚¸‚Â‹Lq‚·‚éB
"       —á:
"         let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
"
"    'tcvime_keymap_for_help'
"       •¶šƒwƒ‹ƒv•\¦‚Ég‚¤keymapBŒ»İ‚Ìƒoƒbƒtƒ@‚Å&keymap‚ª–¢İ’è‚Ìê‡‚Ég—p
"
"    'mapleader'
"       ƒL[ƒ}ƒbƒsƒ“ƒO‚ÌƒvƒŒƒtƒBƒbƒNƒXB|mapleader|‚ğQÆBÈ—ª’l: CTRL-K
"       CTRL-K‚ğw’è‚·‚éê‡‚Ì—á:
"         let mapleader = "\<C-K>"
"
"    'plugin_tcvime_disable'
"       ‚±‚Ìƒvƒ‰ƒOƒCƒ“‚ğ“Ç‚İ‚İ‚½‚­‚È‚¢ê‡‚ÉŸ‚Ì‚æ‚¤‚Éİ’è‚·‚éB
"         let plugin_tcvime_disable = 1

if exists('plugin_tcvime_disable')
  finish
endif

if !exists("tcvime_keymap_for_help")
  let tcvime_keymap_for_help = &keymap
endif

if !exists("tcvime_keyboard")
  let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
  " ”šƒL[‚Ì’i‚ğ•\¦‚µ‚È‚¢ê‡‚ÍŸ‚Ì•¶š—ñ‚ğg‚¤‚æ‚¤‚É‚·‚é(qwerty)
"  let tcvime_keyboard = "q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
endif

" İ’è
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
let s:kanjitable_file = globpath($VIM.','.&runtimepath, 'kanjitable.txt')
let s:helpbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeHelp__'
let s:helpbufname = substitute(s:helpbufname, '\\', '/', 'g')
let s:candbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeCand__'
let s:candbufname = substitute(s:candbufname, '\\', '/', 'g')
" «‘ƒtƒ@ƒCƒ‹‚ª:ls“™‚Å•\¦‚³‚ê‚é‚æ‚¤‚É‚·‚é‚©‚Ç‚¤‚©B0:•\¦‚³‚ê‚È‚¢,1:•\¦‚·‚é
let s:buflisted = 0

" Mapping
if !exists(":TcvimeOn")
  command TcvimeOn :call <SID>MappingOn()
endif
if !exists(":TcvimeOff")
  command TcvimeOff :call <SID>MappingOff()
endif
" keymap‚ğİ’è‚·‚é
" ˆø”: keymap–¼
if !exists(":TcvimeSetKeymap")
  command -nargs=1 TcvimeSetKeymap :call <SID>SetKeymap(<args>)
endif
" w’è‚³‚ê‚½•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
" ˆø”: ‘ÎÛ‚Ì•¶š
if !exists(":TcvimeHelp")
  command! -nargs=1 TcvimeHelp call <SID>ShowHelpForStr(<q-args>, 0)
endif
" w’è‚³‚ê‚½•¶š‚ğŠÜ‚Şs‚ğ•”ñ‡¬•ÏŠ·«‘‚©‚çŒŸõ‚µ‚Ä•\¦‚·‚é
" ˆø”: ‘ÎÛ‚Ì•¶š
if !exists(":TcvimeHelpBushu")
  command! -nargs=1 TcvimeHelpBushu call <SID>ShowHelpForStr(<q-args>, 1)
endif
" Š¿šƒe[ƒuƒ‹‚ğ•\¦‚·‚é
if !exists(":TcvimeKanjiTable")
  command! TcvimeKanjiTable call <SID>KanjiTable_FileOpen()
endif
" ƒwƒ‹ƒv—pƒoƒbƒtƒ@‚ğ•Â‚¶‚é
if !exists(":TcvimeCloseHelp")
  command! TcvimeCloseHelp call <SID>CloseHelpBuffer()
endif

" keymap‚ğİ’è‚·‚é
function! s:SetKeymap(keymapname)
  if &keymap !=# a:keymapname
    let &keymap = a:keymapname
  endif
endfunction

"   ƒ}ƒbƒsƒ“ƒO‚ğ—LŒø‰»
function! s:MappingOn()
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
  nnoremap <script> <silent> <Plug>TcvimeNKanjiTable :<C-U>call <SID>KanjiTable_FileOpen()<CR>
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

"   ƒ}ƒbƒsƒ“ƒO‚ğ–³Œø‰»
function! s:MappingOff()
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

TcvimeOn

"==============================================================================
"				    “ü—Í§Œä

" “Ç‚İ‚Ì“ü—Í‚ğŠJn
function! s:InputStart()
  call s:StatusSet()
  return ''
endfunction

let s:completeyomi = ''

" Insert mode‚ÅŒğ‚º‘‚«•ÏŠ·‚ğs‚¤B
" Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚Ìê‡‚ÍA
" •ÏŠ·‘ÎÛ•¶š—ñ‚Ì––”ö‚Éu\v‚ğ’Ç‰Á‚µ‚ÄŒğ‚º‘‚««‘‚ğŒŸõ‚·‚éB
" @param katuyo Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚©‚Ç‚¤‚©B0:Šˆ—p‚µ‚È‚¢, 1:Šˆ—p‚·‚é
function! s:InputConvert(katuyo)
  let inschars = ''
  let s:is_katuyo = 0
  let s:completeyomi = ''
  let status = s:StatusGet(col('.'))
  let len = strlen(status)
  if len > 0
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let key = status . '\'
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
      echo 'Œğ‚º‘‚««‘’†‚É‚ÍŒ©‚Â‚©‚è‚Ü‚¹‚ñ: <' . status . '>'
    else
      echo 'Œğ‚º‘‚«•ÏŠ·«‘ƒtƒ@ƒCƒ‹‚ÌƒI[ƒvƒ“‚É¸”s‚µ‚Ü‚µ‚½: ' . s:candidate_file
    endif
  else
    let s:last_keyword = ''
    call s:InputStart()
  endif
  return inschars
endfunction

" complete()‚Å‘I‘ğ‚³‚ê‚½Œó•â‚ğæ“¾‚µ‚ÄA©“®ƒwƒ‹ƒv‚ğ•\¦‚·‚é
function! s:OnCursorMovedI()
  if s:completeyomi == ''
    return
  endif
  let status = s:StatusGet(col('.'))
  if status == s:completeyomi
    return
  endif
  " XXX: ƒ|ƒbƒvƒAƒbƒvƒƒjƒ…[–³Œø‚Ìê‡A©“®ƒwƒ‹ƒv•\¦‚Å‚«‚È‚¢
  call s:ShowAutoHelp(s:completeyomi, status)
  let s:completeyomi = ''
endfunction

" Šm’è‚µ‚æ‚¤‚Æ‚µ‚Ä‚¢‚éŒó•â‚ª–â‘è‚È‚¢‚©‚Ç‚¤‚©ƒ`ƒFƒbƒN
function! s:IsCandidateOK(str)
  if strlen(a:str) > 0 && strlen(s:last_candidate) > 0
    if s:is_katuyo && s:last_keyword ==# (a:str . '\') || s:last_keyword ==# a:str
      return 1
    endif
  endif
  return 0
endfunction

" Œó•â‚ğŠm’è‚µ‚ÄAŠm’è‚µ‚½•¶š—ñ‚ğ•Ô‚·
function! s:InputFix(col)
  let inschars = ''
  let str = s:StatusGet(a:col)
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

" ’¼‘O‚Ì2•¶š‚Ì•”ñ‡¬•ÏŠ·‚ğs‚¤
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
      echo '•”ñ‡¬•ÏŠ·‚ª‚Å‚«‚Ü‚¹‚ñ‚Å‚µ‚½: <' . char1 . '>, <' . char2 . '>'
    endif
  endif
  return inschars
endfunction

" ˆÈ‘O‚ÌConvertCount()‚É“n‚³‚ê‚½countˆø”‚Ì’lB
" count‚ª0‚ÅÀs‚³‚ê‚½ê‡‚ÉˆÈ‘O‚Ìcount’l‚ğg‚¤‚æ‚¤‚É‚·‚é‚½‚ßB
let s:last_count = 0

" ¡‚ÌˆÊ’uˆÈ‘O‚Ìcount•¶š‚ğ•ÏŠ·‚·‚é
" @param count •ÏŠ·‚·‚é•¶š—ñ‚Ì’·‚³
" @param katuyo Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚©‚Ç‚¤‚©B0:Šˆ—p‚µ‚È‚¢, 1:Šˆ—p‚·‚é
function! s:ConvertCount(count, katuyo)
  let cnt = a:count
  if cnt == 0
    let cnt = s:last_count
    if cnt == 0
      let cnt = 1
    endif
  endif
  let s:last_count = cnt

  " cnt’·‚Ì•¶š—ñ‚Éƒ}ƒbƒ`‚·‚é³‹K•\Œ»‚ğì‚é
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
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let chars = chars . '\'
    endif
    let ncands = s:CandidateSearch(chars)
    if ncands > 1
      call s:Candwin_SetCands(s:last_candidate_list)
      call s:SelectWindowByName(s:candbufname)
    elseif ncands == 1
      call s:FixCandidate()
    elseif ncands == 0
      echo 'Œğ‚º‘‚««‘’†‚É‚ÍŒ©‚Â‚©‚è‚Ü‚¹‚ñ: <' . chars . '>'
    else
      echo 'Œğ‚º‘‚«•ÏŠ·«‘ƒtƒ@ƒCƒ‹‚ÌƒI[ƒvƒ“‚É¸”s‚µ‚Ü‚µ‚½: ' . s:candidate_file
    endif
  else
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
  endif
endfunction

" ConvertCount()‚Å•ÏŠ·‚ğŠJn‚µ‚½Œó•â‚ğŠm’è‚·‚é
function! s:FixCandidate()
  execute "normal! a\<ESC>"
  let inschars = s:InputFix(col("'^"))
  let s:last_count = 0
  call s:InsertString(inschars)
endfunction

" ¡‚ÌˆÊ’uˆÈ‘O‚Ìcount•¶š‚ğƒJƒ^ƒJƒi‚É•ÏŠ·‚·‚é
" @param count •ÏŠ·‚·‚é•¶š—ñ‚Ì’·‚³
function! s:ConvertKatakana(count)
  execute "normal! a\<ESC>"
  let inschars = tcvime#InputConvertKatakanaPos(col("'^"), a:count)
  call s:InsertString(inschars)
endfunction

" ¡‚ÌˆÊ’uˆÈ‘O‚Ì2•¶š‚ğ•”ñ‡¬•ÏŠ·‚·‚é
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  let inschars = s:InputConvertBushu(col("'^"))
  call s:InsertString(inschars)
endfunction

" w’è‚³‚ê‚½•¶š—ñ‚ğƒoƒbƒtƒ@‚Éappend‚·‚é
function! s:InsertString(inschars)
  if strlen(a:inschars) > 0
    let save_bs = &backspace
    set backspace=2
    execute "normal! a" . a:inschars . "\<ESC>"
    let &backspace = save_bs
  endif
endfunction

"==============================================================================
"			     –¢Šm’è•¶šŠÇ——pŠÖ”ŒQ

"   –¢Šm’è•¶š—ñ‚ª‘¶İ‚·‚é‚©ƒ`ƒFƒbƒN‚·‚é
function! s:StatusIsEnable(col)
  if s:status_line != line('.') || s:status_column <= 0 || s:status_column > a:col
    return 0
  endif
  return 1
endfunction

"   –¢Šm’è•¶š—ñ‚ğŠJn‚·‚é
function! s:StatusSet()
  let s:status_line = line('.')
  let s:status_column = col('.')
  call s:StatusEcho()
endfunction

"   –¢Šm’è•¶š—ñ‚ğƒŠƒZƒbƒg‚·‚é
function! s:StatusReset()
  let s:status_line = 0
  let s:status_column = 0
endfunction

"   –¢Šm’è•¶š—ñ‚ğuó‘Ôv‚Æ‚µ‚Äæ“¾‚·‚é
function! s:StatusGet(col)
  if !s:StatusIsEnable(a:col)
    return ''
  endif

  " •K—v‚Èƒpƒ‰ƒ[ƒ^‚ğûW
  let stpos = s:status_column - 1
  let len = a:col - s:status_column
  let str = getline('.')

  return strpart(str, stpos, len)
endfunction

"   –¢Šm’è•¶š—ñ‚ÌŠJnˆÊ’u‚ÆI—¹ˆÊ’u‚ğ•\¦(ƒfƒoƒbƒO—p)
function! s:StatusEcho(...)
  echo '“Ç‚İ“ü—ÍŠJn;<Leader><Space>:•ÏŠ·,<Leader>o:Šˆ—p‚·‚éŒê‚Ì•ÏŠ·,<Leader><CR>:Šm’è'
  "echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

" ó‘ÔƒŠƒZƒbƒg
call s:StatusReset()

"==============================================================================
" ƒwƒ‹ƒv•\¦

" ‹ó‚Ìƒwƒ‹ƒv—pƒoƒbƒtƒ@‚ğì‚é
function! s:Help_BufReadCmd()
endfunction

" ƒwƒ‹ƒv—pƒoƒbƒtƒ@‚ğŠJ‚­
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
  %d _
  5wincmd _
endfunction

" ƒwƒ‹ƒv—pƒoƒbƒtƒ@‚ğ•Â‚¶‚é
function! s:CloseHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) > 0
    bwipeout!
  endif
endfunction

" ƒJ[ƒ\ƒ‹ˆÊ’u‚Ì•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowStrokeHelp()
  let ch = matchstr(getline('.'), '\%' . col('.') . 'c.')
  call s:ShowHelp([ch], 0)
endfunction

" Visual mode‚Å‘I‘ğ‚³‚ê‚Ä‚¢‚é•¶š—ñ‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowHelpVisual()
  let save_reg = @@
  silent execute 'normal! `<' . visualmode() . '`>y'
  call s:ShowHelpForStr(substitute(@@, '\n', '', 'g'), 0)
  let @@ = save_reg
endfunction

" •ÏŠ·‚ÅŠm’è‚µ‚½•¶š—ñ‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowAutoHelp(yomi, str)
  let yomichars = split(a:yomi, '\zs')
  let chars = split(a:str, '\zs')
  " “Ç‚İ‚Å“ü—Í‚µ‚½Š¿š‚Íƒwƒ‹ƒv•\¦•s—v‚È‚Ì‚Åæ‚èœ‚­
  call filter(chars, 'index(yomichars, v:val) == -1')
  call s:ShowHelp(chars, 0)
endfunction

" w’è‚³‚ê‚½•¶š—ñ‚ÌŠe•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowHelpForStr(str, forcebushu)
  let ar = split(a:str, '\zs')
  call s:ShowHelp(ar, a:forcebushu)
endfunction

" w’è‚³‚ê‚½•¶š”z—ñ‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowHelp(ar, forcebushu)
  let keymap = &keymap
  if strlen(keymap) == 0
    let keymap = g:tcvime_keymap_for_help
    if strlen(keymap) == 0
      echo 'tcvime•¶šƒwƒ‹ƒv•\¦‚É‚ÍAkeymapƒIƒvƒVƒ‡ƒ“‚©g:tcvime_keymap_for_help‚Ìİ’è—v'
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
      " echo '•¶šƒwƒ‹ƒv•\•\¦‚Éw’è‚³‚ê‚½•¶š‚ª‹ó‚Å‚·B–³‹‚µ‚Ü‚·'
      continue
    endif
    call cursor(line('$'), 1)
    if a:forcebushu == 1
      let ret = s:ShowHelpBushuDic(ch)
    else
      let ret = s:ShowHelpChar(ch, keymap)
    endif
    if ret == -1 " ƒXƒgƒ[ƒN•\‚à•”ñ‡¬«‘‚à•\¦‚Å‚«‚È‚©‚Á‚½ê‡
      call add(skipchars, ch)
      continue
    elseif ret == -2 " XXX: ƒ|ƒbƒvƒAƒbƒvƒƒjƒ…[–³Œø
      call s:CloseHelpBuffer()
      return
    endif
    let numch += 1
    if ret == 0 " ShowHelpBushuDic
      continue
    endif
    " •\‚ğ‰¡‚É•À‚×‚é
    if lastcol == 0 " Å‰‚Ì•\‚Ìê‡‚Í•Ï”‰Šú‰»‚¾‚¯
      let lastcol = col('$')
      let lastfrom = line('.')
      let width = lastcol + 2
      continue
    endif
    if lastcol + width >= winwidth " ‚³‚ç‚É•À‚×‚é‚Æ‚Í‚İo‚·ê‡‚Í‚»‚Ì‚Ü‚Ü‚É
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
    call s:CloseHelpBuffer()
  else
    silent! $g/^$/d _ " ––”ö‚Ì—]•ª‚È‹ós‚ğíœ
    normal 1G
    " wincmd p
    execute bufwinnr(curbuf) . 'wincmd w'
  endif
  if len(skipchars) > 0
    redraw
    echo '•¶šƒwƒ‹ƒv‚Å•\¦‚Å‚«‚éî•ñ‚ª‚ ‚è‚Ü‚¹‚ñ: <' . join(skipchars, ',') . '>'
  endif
endfunction

" w’è‚³‚ê‚½•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowHelpChar(ch, keymap)
  let keyseq = s:SearchKeymap(a:ch, a:keymap)
  if strlen(keyseq) > 0
    call s:SelectWindowByName(s:helpbufname)
    return s:ShowHelpSequence(a:ch, keyseq)
  else
    return s:ShowHelpBushuDic(a:ch)
  endif
endfunction

" w’è‚³‚ê‚½•¶š‚Æ‚»‚ÌƒXƒgƒ[ƒN‚ğ•\‚É‚µ‚Ä•\¦‚·‚é
function! s:ShowHelpSequence(ch, keyseq)
  let from = line('$')
  let v:errmsg = ''
  silent! execute 'normal! O' . g:tcvime_keyboard . "\<CR>\<ESC>"
  if v:errmsg != '' " XXX: ƒ|ƒbƒvƒAƒbƒvƒƒjƒ…[–³ŒøAE523: Not allowed here
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
  silent! execute range . 's@. . @E@g'
  silent! execute range . 's@@ @ge'
  call cursor(to - 1, 1)
  silent! execute 'normal! A    ' . a:ch . "\<ESC>"
  call cursor(from, 1)
  return 1
endfunction

" •”ñ‡¬«‘‚©‚çAw’è‚³‚ê‚½•¶š‚ğŠÜ‚Şs‚ğŒŸõ‚µ‚Ä•\¦‚·‚é
function! s:ShowHelpBushuDic(ch)
  let lines = s:SearchBushuDic(a:ch)
  call s:SelectWindowByName(s:helpbufname)
  if strlen(lines) > 0
    " ƒoƒbƒtƒ@“ª‚Å‚È‚¯‚ê‚Î‹æØ‚è‚Ì‹ós‘}“üB’¼‘O‚ª•¡”s‚Ì•”ñ«‘“à—e‚Ì•K—v
    if line('.') > 1
      silent! execute "normal! o\<ESC>"
    endif
    let v:errmsg = ''
    silent! execute 'normal! O' . lines . "\<ESC>"
    if v:errmsg != '' " XXX: ƒ|ƒbƒvƒAƒbƒvƒƒjƒ…[–³ŒøAE523: Not allowed here
      return -2
    endif
    return 0
  else
    return -1
  endif
endfunction

" •”ñ‡¬«‘‚©‚çAw’è‚³‚ê‚½•¶š‚ğŠÜ‚Şs‚ğŒŸõ‚·‚é
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

" w’è‚³‚ê‚½•¶š‚ğ“ü—Í‚·‚é‚½‚ß‚ÌƒXƒgƒ[ƒN‚ğkeymapƒtƒ@ƒCƒ‹‚©‚çŒŸõ‚·‚é
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
"				    «‘ŒŸõ

" SelectWindowByName(name)
"   Acitvate selected window by a:name.
function! s:SelectWindowByName(name)
  let num = bufwinnr('^' . a:name . '$')
  if num > 0 && num != winnr()
    execute num . 'wincmd w'
  endif
  return num
endfunction

" Œğ‚º‘‚«•ÏŠ·«‘ƒf[ƒ^ƒtƒ@ƒCƒ‹‚ğƒI[ƒvƒ“
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

" ŒŸõ‚Ég—p‚·‚éó‘Ô•Ï”
let s:last_keyword = ''
let s:last_candidate = ''
let s:last_candidate_list = []
let s:is_katuyo = 0

" «‘‚©‚ç–¢Šm’è•¶š—ñ‚ğŒŸõ
" @return -1:«‘‚ªŠJ‚¯‚È‚¢ê‡, 0:•¶š—ñ‚ªŒ©‚Â‚©‚ç‚È‚¢ê‡,
"   1:Œó•â‚ª1‚Â‚¾‚¯Œ©‚Â‚©‚Á‚½ê‡, 2:Œó•â‚ª2‚ÂˆÈãŒ©‚Â‚©‚Á‚½ê‡
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

" Šm’è•¶š—ñ‚ğæ“¾
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

" •”ñ‡¬«‘ƒf[ƒ^ƒtƒ@ƒCƒ‹‚ğƒI[ƒvƒ“
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

" “™‰¿•¶š‚ğŒŸõ‚µ‚Ä•Ô‚·B“™‰¿•¶š‚ª‚È‚¢ê‡‚Í‚à‚Æ‚Ì•¶š‚»‚Ì‚à‚Ì‚ğ•Ô‚·
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

" char1‚Æchar2‚ğ‚±‚Ì‡”Ô‚Å‡¬‚µ‚Ä‚Å‚«‚é•¶š‚ğŒŸõ‚µ‚Ä•Ô‚·B
" Œ©‚Â‚©‚ç‚È‚¢ê‡‚Í''‚ğ•Ô‚·
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

" w’è‚³‚ê‚½•¶š‚ğ2‚Â‚Ì•”ñ‚É•ª‰ğ‚·‚éB
" •ª‰ğ‚µ‚½•”ñ‚ğs:decomp1, s:decomp2‚ÉƒZƒbƒg‚·‚éB
" @return 1: •ª‰ğ‚É¬Œ÷‚µ‚½ê‡A0: •ª‰ğ‚Å‚«‚È‚©‚Á‚½ê‡
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

" ‡¬Œã‚Ì•¶š‚ª‹ó‚Å‚È‚­AŒ³‚Ì•¶š‚Å‚à‚È‚¢‚±‚Æ‚ğŠm”F
" @param ch ‡¬Œã‚Ì•¶š
" @param char1 Œ³‚Ì•¶š
" @param char2 Œ³‚Ì•¶š
" @return 1: ch‚ª‹ó‚Å‚àchar1‚Å‚àchar2‚Å‚à‚È‚¢ê‡B0: ‚»‚êˆÈŠO‚Ìê‡
function! s:BushuCharOK(ch, char1, char2)
  if strlen(a:ch) > 0 && a:ch !=# a:char1 && a:ch !=# a:char2
    return 1
  else
    return 0
  endif
endfunction

" •”ñ‡¬•ÏŠ·«‘‚ğŒŸõ
function! s:BushuSearch(char1, char2)
  let char1 = a:char1
  let char2 = a:char2
  let i = 0
  while i < 2
    " ‚»‚Ì‚Ü‚Ü‡¬‚Å‚«‚é?
    let retchar = s:BushuSearchCompose(char1, char2)
    if s:BushuCharOK(retchar, char1, char2)
      return retchar
    endif

    " “™‰¿•¶š‚Ç‚¤‚µ‚Å‡¬‚Å‚«‚é?
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

    " “™‰¿•¶š‚ğ•”ñ‚É•ª‰ğ
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

    " ˆø‚«Z
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

    " ˆê•û‚ª•”•i‚É‚æ‚é‘«‚µZ
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

    " —¼•û‚ª•”•i‚É‚æ‚é‘«‚µZ
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

    " •”•i‚É‚æ‚éˆø‚«Z
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

    " •¶š‚Ì‡‚ğ‹t‚É‚µ‚Ä‚â‚Á‚Ä‚İ‚é
    let t = char1  | let char1  = char2  | let char2 = t
    let t = ch1alt | let ch1alt = ch2alt | let ch2alt = t
    let t = ch1a1  | let ch1a1  = ch2a1  | let ch2a1 = t
    let t = ch1a2  | let ch1a2  = ch2a2  | let ch2a2 = t
    let i = i + 1
  endwhile

  " ‡¬‚Å‚«‚È‚©‚Á‚½
  return ''
endfunction

"==============================================================================
"				  Š¿šƒe[ƒuƒ‹

" Š¿šƒe[ƒuƒ‹ƒtƒ@ƒCƒ‹‚ğŠJ‚­
function! s:KanjiTable_FileOpen()
  if filereadable(s:kanjitable_file) != 1
    echo 'Š¿šƒe[ƒuƒ‹ƒtƒ@ƒCƒ‹‚ª“Ç‚ß‚Ü‚¹‚ñ: <' . s:kanjitable_file . '>'
    return
  endif
  if s:SelectWindowByName(s:kanjitable_file) < 0
    execute 'silent normal! :sv '.s:kanjitable_file."\<CR>"
  endif
  nnoremap <buffer> <silent> <CR> :<C-U>call <SID>KanjiTable_CopyChar()<CR>
  nnoremap <buffer> <silent> q :<C-U>quit<CR>
endfunction

" Š¿šƒe[ƒuƒ‹ƒoƒbƒtƒ@‚©‚ç’¼‹ß‚Ìƒoƒbƒtƒ@‚ÉŠ¿š‚ğƒRƒs[‚·‚é
function! s:KanjiTable_CopyChar()
  let ch = matchstr(getline('.'), '\%' . col('.') . 'c.')
  execute "normal! \<C-W>pa" . ch . "\<ESC>\<C-W>p"
endfunction

"==============================================================================
" Œó•â‘I‘ğƒoƒbƒtƒ@

" Œó•â‘I‘ğƒoƒbƒtƒ@‚ğŠJ‚­
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

" Œó•â‘I‘ğƒoƒbƒtƒ@‚ğ•Â‚¶‚é
function! s:Candwin_Close()
  if s:SelectWindowByName(s:candbufname) > 0
    bwipeout!
  endif
endfunction

" Œó•â‚ğƒZƒbƒg‚·‚é
function! s:Candwin_SetCands(candlist)
  call s:Candwin_Open()
  execute 'normal! a' . join(a:candlist, "\n") . "\<ESC>"
  normal! 1G
  wincmd p
endfunction

" Œ»İs‚ÌŒó•â‚ğŠm’è‚·‚é
function! s:Candwin_Select()
  let s:last_candidate = getline('.')
  bwipeout!
  call s:FixCandidate()
endfunction
