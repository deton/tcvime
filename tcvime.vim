" vi:set ts=8 sts=2 sw=2 tw=0:
"
" tcvime.vim - tcode.vim“™‚ÌŠ¿š’¼Ú“ü—Íkeymap‚Å‚Ì“ü—Í•â•‹@”\:
"              Œğ‚º‘‚«•ÏŠ·A•”ñ‡¬•ÏŠ·A‘ÅŒ®ƒwƒ‹ƒv•\¦‹@”\B
"
" Last Change: $Date: 2003/05/19 14:38:42 $
" Maintainer: deton(KIHARA Hideto)@m1.interq.or.jp
" Original Plugin: vime.vim by Muraoka Taro <koron@tka.att.ne.jp>

scriptencoding cp932

" Description:
" g—p–@:
"   mazegaki.dic‚Æbushu.rev‚Í$VIM‚©'runtimepath'‚Å¦‚³‚ê‚éƒfƒBƒŒƒNƒgƒŠ‚É
"   ’u‚¢‚Ä‚¨‚¢‚Ä‚­‚¾‚³‚¢B
"
"   :TcvimeOnƒRƒ}ƒ“ƒh‚Åƒ}ƒbƒsƒ“ƒO‚ª—LŒø‚É‚È‚è‚Ü‚·B
"   tcvime‚Ì‹@”\‚Í'mapleader'‚Åw’è‚³‚ê‚½ƒL[‚ÌŒã‚É
"   'q'‚È‚Ç‚ÌƒL[‚ğ“ü—Í‚·‚é‚±‚Æ‚ÅÀs‚³‚ê‚Ü‚·B
"   'mapleader'‚ÌƒfƒtƒHƒ‹ƒg‚Í"\<C-K>"(CTRLƒL[‚ğ‰Ÿ‚µ‚È‚ª‚çk)‚Å‚·B
"   ˆÈ~‚Ìà–¾’†‚Ì<Leader>‚Æ‚¢‚¤•¶š—ñ‚Ímapleader‚ğ•\‚µ‚Ä‚¢‚Ü‚·B
"   ‚Â‚Ü‚èAmapleader‚ª"\<C-K>"‚Ìê‡A<Leader>q ‚Í CTRL-J‚ÌŒã‚Éq‚ğ“ü—Í‚·‚éA
"   ‚Æ‚¢‚¤‚±‚Æ‚Å‚·B
"   ‚Ü‚½A<Space>‚ÍƒXƒy[ƒXƒL[A<CR>‚ÍƒGƒ“ƒ^[ƒL[‚Å‚·B
"
"  Insert Mode‚Å‚ÌŒğ‚º‘‚«•ÏŠ·:
"    <Leader>q ‚Å•ÏŠ·‘ÎÛ•¶š—ñ‚Ìn‚Ü‚è‚ğƒ}[ƒN‚µ‚Ü‚·B
"    <Leader><Space> ‚ÅŒğ‚º‘‚«•ÏŠ·‚ğs‚¢‚Ü‚·B
"      <Leader>q ‚Åƒ}[ƒN‚µ‚½ˆÊ’u‚©‚çŒ»İ‚ÌƒJ[ƒ\ƒ‹ˆÊ’u‚ÌŠÔ‚É‚ ‚é•¶š—ñ‚ğ
"      “Ç‚İ‚Æ‚µ‚Ämazegaki.dic‚ÅŒŸõ‚µ‚Ü‚·B
"      Œó•â‚ªˆê‚Â‚µ‚©‚È‚¢ê‡‚Í•ÏŠ·‘ÎÛ•¶š—ñ‚ğ’u‚«Š·‚¦‚Ü‚·B
"      Œó•â‚ª•¡”‚ ‚éê‡‚ÍAƒRƒ}ƒ“ƒhs‚Ìã‚ÉCANDIDATE: ‚ÅŒó•â‚ª•\¦‚³‚ê‚Ü‚·B
"      “¯‚¶•ÏŠ·‘ÎÛ•¶š—ñ‚É‘Î‚µ‚Ä<Leader><Space>‚ğŒJ‚è•Ô‚µ‘Å‚Â‚ÆA
"      Œó•â‚ğ‡‚É•\¦‚µ‚Ä‚¢‚«‚Ü‚·B
"      Œó•â‚ÌƒŠƒXƒg‚ÌÅŒã‚Ü‚Ås‚­‚ÆƒŠƒXƒg‚ÌÅ‰‚É–ß‚è‚Ü‚·B
"    <Leader><CR> ‚ÅCANDIDATE: ‚Æ‚µ‚Ä•\¦‚³‚ê‚Ä‚¢‚éŒó•â‚ğ‘I‘ğ‚µ‚Ä
"      •ÏŠ·‘ÎÛ•¶š—ñ‚ğ’u‚«Š·‚¦‚Ü‚·B
"
"    —á: "<Leader>q‚ ‚¢<Leader><Space>"‚Æ‘Å‚Â‚ÆA
"        "CANDIDATE: ˆ¡"‚Æ•\¦‚³‚ê‚Ü‚·B
"        ‚³‚ç‚É"<Leader><Space>"‚ğ‘Å‚Â‚Æ"CANDIDATE: ˆ£"‚Æ‚È‚è‚Ü‚·B
"        ‚±‚Ìó‘Ô‚Å"<Leader><CR>"‚ğ‘Å‚Â‚ÆA"‚ ‚¢"‚ª"ˆ£"‚É’u‚«Š·‚¦‚ç‚ê‚Ü‚·B
"
"  Insert Mode‚Å‚ÌŒğ‚º‘‚«•ÏŠ·(Šˆ—p‚·‚éŒê):
"    Šî–{“I‚É‚ÍŠˆ—p‚µ‚È‚¢Œê‚ÌŒğ‚º‘‚«•ÏŠ·‚Æ“¯‚¶‚Å‚·B
"    "\"‚ğ‚Â‚¯‚Ä<Leader><Space>‚Å•ÏŠ·‚·‚é‚©AŠˆ—p‚µ‚È‚¢•”•ª‚Ü‚Å“ü—Í‚µ‚Ä‚©‚çA
"    <Leader>o ‚Å•ÏŠ·‚µ‚Ü‚·B
"    <Leader>o ‚Í<Leader>q ‚Åƒ}[ƒN‚µ‚½ˆÊ’u‚©‚çŒ»İ‚ÌƒJ[ƒ\ƒ‹ˆÊ’u‚ÌŠÔ‚Ì•¶š—ñ‚É
"    "\"‚ğ•t‰Á‚µ‚½•¶š—ñ‚ğ“Ç‚İ‚Æ‚µ‚Ämazegaki.dic‚©‚çŒŸõ‚µ‚Ü‚·B
"
"    —á: "<Leader>q‚È‚ª‚ß<Leader>o"‚Æ‘Å‚Â‚ÆA"CANDIDATE: ’­‚ß"‚Æ•\¦‚³‚ê‚Ü‚·B
"        "<Leader><CR>"‚Æ‘Å‚Â‚ÆA"‚È‚ª‚ß"‚ª"’­‚ß"‚É’u‚«Š·‚¦‚ç‚ê‚Ü‚·B
"
"  Insert Mode‚Å‚Ì•”ñ‡¬•ÏŠ·:
"    <Leader>b ‚ÅƒJ[ƒ\ƒ‹ˆÊ’u‚Ì’¼‘O‚Ì2•¶š‚Ì•”ñ‡¬•ÏŠ·‚ğs‚¢‚Ü‚·B
"
"    —á: "–ØŒû<Leader>b"‚Æ‘Å‚Â‚ÆA"–ØŒû"‚ª"ˆÇ"‚É’u‚«Š·‚¦‚ç‚ê‚Ü‚·B
"
"  Normal Mode‚Å‚ÌŒğ‚º‘‚«•ÏŠ·:
"    [count]<Leader><Space> ƒJ[ƒ\ƒ‹ˆÊ’uˆÈ‘O‚Ì[count]•¶š‚ÌŒğ‚º‘‚«•ÏŠ·‚ğ
"      s‚¢‚Ü‚·B
"    <Leader><CR> ‚ÅCANDIDATE: ‚Æ‚µ‚Ä•\¦‚³‚ê‚Ä‚¢‚éŒó•â‚ğ‘I‘ğ‚µ‚Ä
"      •ÏŠ·‘ÎÛ•¶š—ñ‚ğ’u‚«Š·‚¦‚Ü‚·B
"
"    —á: "‚ ‚¢"‚Æ•\¦‚³‚ê‚Ä‚¢‚é‚Æ‚«A"‚¢"‚Ìã‚ÉƒJ[ƒ\ƒ‹‚ğ’u‚¢‚Ä
"        "2<Leader><Space>"‚Æ‘Å‚Â‚ÆA"CANDIDATE: ˆ¡"‚Æ•\¦‚³‚ê‚Ü‚·B
"        ‚³‚ç‚É"<Leader><Space>"‚Æ‘Å‚Â‚ÆA"CANDIDATE: ˆ£"‚Æ•\¦‚³‚ê‚Ü‚·B
"        ‚±‚Ìó‘Ô‚Å"<Leader><CR>"‚ğ‘Å‚Â‚ÆA"‚ ‚¢"‚ª"ˆ£"‚É’u‚«Š·‚¦‚ç‚ê‚Ü‚·B
"
"  Normal Mode‚Å‚ÌŒğ‚º‘‚«•ÏŠ·(Šˆ—p‚µ‚È‚¢Œê):
"    [count]<Leader>o ƒJ[ƒ\ƒ‹ˆÊ’uˆÈ‘O‚Ì[count]•¶š‚É"\"‚ğ•t‰Á‚µ‚½•¶š—ñ‚ğ
"      “Ç‚İ‚Æ‚µ‚Ämazegaki.dic‚©‚çŒŸõ‚µ‚Ü‚·B
"
"    —á: "‚È‚ª‚ß"‚Æ•\¦‚³‚ê‚Ä‚¢‚é‚Æ‚«A"‚ß"‚Ìã‚ÉƒJ[ƒ\ƒ‹‚ğ’u‚¢‚Ä
"        "3<Leader>o"‚Æ‘Å‚Â‚ÆA"CANDIDATE: ’­‚ß"‚Æ•\¦‚³‚ê‚Ü‚·B
"        "<Leader><CR>"‚Æ‘Å‚Â‚ÆA"‚È‚ª‚ß"‚ª"’­‚ß"‚É’u‚«Š·‚¦‚ç‚ê‚Ü‚·B
"
"  Normal Mode‚Å‚Ì•”ñ‡¬•ÏŠ·:
"    <Leader>b ƒJ[ƒ\ƒ‹ˆÊ’uˆÈ‘O‚Ì2•¶š‚Ì•”ñ‡¬•ÏŠ·‚ğs‚¢‚Ü‚·B
"
"    —á: "–ØŒû"‚Æ•\¦‚³‚ê‚Ä‚¢‚é‚Æ‚«A"Œû"‚Ìã‚ÉƒJ[ƒ\ƒ‹‚ğ’u‚¢‚Ä
"        "<Leader>b"‚Æ‘Å‚Â‚ÆA"–ØŒû"‚ª"ˆÇ"‚É’u‚«Š·‚¦‚ç‚ê‚Ü‚·B
"
" ‘ÅŒ®ƒwƒ‹ƒv•\¦(Normal Mode):
"    <Leader>? ‚ÅƒJ[ƒ\ƒ‹ˆÊ’u‚Ì•¶š‚Ì‘ÅŒ®‚ğ•\¦‚µ‚Ü‚·B
"      g—p’†‚Ìkeymap‚Å’¼Ú“ü—Í‚Å‚«‚È‚¢•¶š‚Ìê‡‚ÍA
"      •”ñ‡¬•ÏŠ·«‘‚ğŒŸõ‚µ‚ÄAw’è‚³‚ê‚½•¶š‚ªŠÜ‚Ü‚ê‚és‚ğ•\¦‚µ‚Ü‚·B
"
"    —á: "Œ®"‚Æ‚¢‚¤•¶š‚Ìã‚ÉƒJ[ƒ\ƒ‹‚ğ’u‚¢‚Ä"<Leader>?"‚Æ‘Å‚Â‚ÆA
"        "[TcvimeHelp]"‚Æ‚¢‚¤ƒoƒbƒtƒ@‚ªŠJ‚¢‚ÄŸ‚Ì‚æ‚¤‚É•\¦‚³‚ê‚Ü‚·
"        (keymap‚ªtutcode‚Ìê‡)B
"        EEEE    EEEE    Œ®
"        EEEE  3 EEEE
"        EEEE    EEEE
"        EE1 2     EEEE
"
" ƒIƒvƒVƒ‡ƒ“:
"    'tcvime_keyboard'
"       ‘ÅŒ®ƒwƒ‹ƒv•\¦—p‚ÌƒL[ƒ{[ƒh”z—ñ‚ğ•\‚·•¶š—ñB
"       ƒL[‚ÌŒã‚ÉƒXƒy[ƒXA‚ğ2‰ñ‚¸‚Â‹Lq‚·‚éB
"       —á:
"         let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
"
"    'mapleader'
"       |mapleader|

" ‚±‚Ìƒvƒ‰ƒOƒCƒ“‚ğ“Ç‚İ‚½‚­‚È‚¢‚Í.vimrc‚ÉŸ‚Ì‚æ‚¤‚É‘‚­‚±‚Æ:
"       :let plugin_tcvime_disable = 1

if exists('plugin_tcvime_disable')
  finish
endif

if !exists("tcvime_keyboard")
  let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
  " ”šƒL[‚Ì’i‚ğ•\¦‚µ‚È‚¢ê‡‚ÍŸ‚Ì•¶š—ñ‚ğg‚¤‚æ‚¤‚É‚·‚é(qwerty)
"  let tcvime_keyboard = "q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
endif

" Mapping
command! TcvimeOn :call <SID>MappingOn()
command! TcvimeOff :call <SID>MappingOff()
" keymap‚ğİ’è‚µ‚ÄATcvimeOn‚·‚é
" ˆø”: keymap–¼
command! -nargs=1 TcvimeInit :call <SID>TcvimeInit(<f-args>)

"   ƒ}ƒbƒsƒ“ƒO‚ğ—LŒø‰»
function! s:MappingOn()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-J>"
    let set_mapleader = 1
  endif
  let s:mapleader = g:mapleader
  inoremap <silent> <Leader><CR> <C-O>:call <SID>InputFix()<CR>
  inoremap <silent> <Leader>q <C-O>:call <SID>InputStart()<CR>
  inoremap <silent> <Leader><Space> <C-O>:call <SID>InputConvert(0)<CR>
  inoremap <silent> <Leader>o <C-O>:call <SID>InputConvert(1)<CR>
  inoremap <silent> <Leader>b <C-O>:call <SID>InputConvertBushu(1)<CR>
  nnoremap <silent> <Leader><CR> :<C-U>call <SID>FixCandidate()<CR>
  nnoremap <silent> <Leader><Space> :<C-U>call <SID>ConvertCount(v:count, 0)<CR>
  nnoremap <silent> <Leader>o :<C-U>call <SID>ConvertCount(v:count, 1)<CR>
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

"   ƒ}ƒbƒsƒ“ƒO‚ğ–³Œø‰»
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

" keymap‚ğİ’è‚µ‚ÄTcvime‚ÌMapping‚ğ—LŒø‚É‚·‚é
function! s:TcvimeInit(keymapname)
  if &keymap !=# a:keymapname
    let &keymap = a:keymapname
    call s:MappingOn()
  endif
endfunction


" İ’è
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
"echo "candidate_file: ".s:candidate_file
let s:helpbufname = '[TcvimeHelp]'
let s:helpbufpat = '\[TcvimeHelp\]'

"==============================================================================
"				    «‘ŒŸõ
"

" «‘ƒf[ƒ^ƒtƒ@ƒCƒ‹‚ğƒI[ƒvƒ“
function! s:Candidate_FileOpen()
  if filereadable(s:candidate_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:candidate_file) < 0
    execute 'silent normal! :sv '.s:candidate_file."\<CR>"
  endif
  return 1
endfunction

" ŒŸõ‚Ég—p‚·‚éó‘Ô•Ï”
let s:last_keyword = ''
let s:last_found = 0
let s:last_candidate = ''
let s:last_candidate_str = ''
let s:last_candidate_num = 0
let s:is_katuyo = 0

" «‘‚©‚ç–¢Šm’è•¶š—ñ‚ğŒŸõ
" @return -1:«‘‚ªŠJ‚¯‚È‚¢ê‡, 0:•¶š—ñ‚ªŒ©‚Â‚©‚ç‚È‚¢ê‡,
"   1:Œó•â‚ª1‚Â‚¾‚¯Œ©‚Â‚©‚Á‚½ê‡, 2:Œó•â‚ª2‚ÂˆÈãŒ©‚Â‚©‚Á‚½ê‡
function! s:CandidateSearch(keyword)
  let found_num = s:last_found
  let uniq = 0
  let ret = 0

  " ŒŸõ•¶š—ñ‚ª‘O‰ñ‚Æ“¯‚¶‚ÍÈ—ª
  if s:last_keyword !=# a:keyword
    let s:last_keyword = a:keyword
    if !s:Candidate_FileOpen()
      return -1
    endif

    " ÀÛ‚ÌŒŸõ
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
    " Ÿ‚Ì•ÏŠ·Œó•â‚ğ’T‚µo‚·‚½‚ß
    if s:last_candidate_num > 0 && s:last_candidate != ''
      let s:last_candidate_num = s:last_candidate_num + strlen(s:last_candidate) + 1
    endif
    " ‘O‰ñ•ÏŠ·‚µ‚½•¶š—ñ‚ğÄ“x•ÏŠ·‚·‚éê‡AŒó•â”‚ğƒ`ƒFƒbƒN‚µ’¼‚·
    if s:last_candidate_num == 1 && s:last_candidate == ''
      if s:last_candidate_str =~# '^/[^/]\+/$'
	let uniq = 1
      endif
    endif
  endif

  if found_num > 0
    " Œó•â‚ª‚İ‚Â‚©‚Á‚Ä‚¢‚é‚È‚ç‚ÎA‡”Ô‚É•\¦‚·‚é
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
    " Œó•â‚ª‚İ‚Â‚©‚ç‚È‚©‚Á‚½AƒŠƒZƒbƒg
    let s:last_candidate = ''
    let s:last_candidate_str = ''
    let s:last_candidate_num = 0
    let ret = 0
  endif
  let s:last_found = found_num
  return ret
endfunction

" Œó•â‚ğƒoƒbƒtƒ@‚É‘}“ü
function! s:CandidateSelect(len)
  if strlen(s:last_candidate) > 0
    let str = getline(s:status_line)
    let str = strpart(str, 0, s:status_column - 1).s:last_candidate.strpart(str, s:status_column - 1 + a:len)
    call setline(s:status_line, str)
    let s:status_column = s:status_column + strlen(s:last_candidate)
    let s:last_candidate = ''
    let s:last_candidate_num = 1
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

" •”ñ‡¬«‘ƒf[ƒ^ƒtƒ@ƒCƒ‹‚ğƒI[ƒvƒ“
function! s:Bushu_FileOpen()
  if filereadable(s:bushu_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushu_file) < 0
    execute 'silent normal! :sv '.s:bushu_file."\<CR>"
  endif
  return 1
endfunction

" “™‰¿•¶š‚ğŒŸõ‚µ‚Ä•Ô‚·B“™‰¿•¶š‚ª‚È‚¢ê‡‚Í‚à‚Æ‚Ì•¶š‚»‚Ì‚à‚Ì‚ğ•Ô‚·
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

" char1‚Æchar2‚ğ‚±‚Ì‡”Ô‚Å‡¬‚µ‚Ä‚Å‚«‚é•¶š‚ğŒŸõ‚µ‚Ä•Ô‚·B
" Œ©‚Â‚©‚ç‚È‚¢ê‡‚Í''‚ğ•Ô‚·
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

" w’è‚³‚ê‚½•¶š‚ğ2‚Â‚Ì•”ñ‚É•ª‰ğ‚·‚éB
" •ª‰ğ‚µ‚½•”ñ‚ğs:decomp1, s:decomp2‚ÉƒZƒbƒg‚·‚éB
" @return 1: •ª‰ğ‚É¬Œ÷‚µ‚½ê‡A0: •ª‰ğ‚Å‚«‚È‚©‚Á‚½ê‡
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

" ‡¬Œã‚Ì•¶š‚ª‹ó‚Å‚È‚­AŒ³‚Ì•¶š‚Å‚à‚È‚¢‚±‚Æ‚ğŠm”F
" @param ch ‡¬Œã‚Ì•¶š
" @param char1 Œ³‚Ì•¶š
" @param char2 Œ³‚Ì•¶š
" @return 1: ch‚ª‹ó‚Å‚àchar1‚Å‚àchar2‚Å‚à‚È‚¢ê‡B0: ‚»‚êˆÈŠO‚Ìê‡
function! s:BushuCharOK(ch, char1, char2)
  if a:ch !=# '' && a:ch !=# a:char1 && a:ch !=# a:char2
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

    " ˆø‚«Z
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

    " ˆê•û‚ª•”•i‚É‚æ‚é‘«‚µZ
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

    " —¼•û‚ª•”•i‚É‚æ‚é‘«‚µZ
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

    " •”•i‚É‚æ‚éˆø‚«Z
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

" •”ñ‡¬‚µ‚½•¶š‚ğƒoƒbƒtƒ@‚É‘}“ü
function! s:BushuReplace(linenum, stcol, endcol, ch)
  let str = getline(a:linenum)
  let str = strpart(str, 0, a:stcol - 1) . a:ch . strpart(str, a:endcol - 1)
  call setline(a:linenum, str)
endfunction

"==============================================================================
"				    “ü—Í§Œä
"

" Insert mode‚ÅŒğ‚º‘‚«•ÏŠ·‚ğs‚¤B
" Šˆ—p‚Ì‚ ‚éŒê‚Ì•ÏŠ·‚Ìê‡‚ÍA
" •ÏŠ·‘ÎÛ•¶š—ñ‚Ì––”ö‚Éu\v‚ğ’Ç‰Á‚µ‚ÄŒğ‚º‘‚««‘‚ğŒŸõ‚·‚éB
" @param katuyo Šˆ—p‚Ì‚ ‚éŒê‚Ì•ÏŠ·‚©‚Ç‚¤‚©B0:Šˆ—p‚È‚µ, 1:Šˆ—p‚ ‚è
function! s:InputConvert(katuyo)
  let col = col("'^")
  let s:is_katuyo = 0
  let status = s:StatusGet()
  let len = strlen(status)
  if len > 0
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let status = status . '\'
    endif
    let found = s:CandidateSearch(status)
  else
    let s:last_keyword = ''
    call s:InputStart()
  endif
  execute "normal! " . col . "|"
  if exists('found')
    if found == 2
      echo 'CANDIDATE: ' . s:last_candidate
    elseif found == 1
      call s:InputFix()
    elseif found == 0
      echo 'Not found: ' . status
    elseif found == -1
      echo 'Œğ‚º‘‚«•ÏŠ·«‘ƒtƒ@ƒCƒ‹‚ÌƒI[ƒvƒ“‚É¸”s‚µ‚Ü‚µ‚½: ' . s:candidate_file
    endif
  endif
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

function! s:InputFix()
  let str = s:StatusGet()
  if s:IsCandidateOK(str)
    let len = strlen(str)
    call s:CandidateSelect(len)
    execute "normal! " . s:status_column . "|"
  endif
  call s:StatusReset()
  let &cmdheight = s:save_cmdheight
  unlet s:save_cmdheight
endfunction

" &cmdheight‚ª2‚æ‚è¬‚³‚©‚Á‚½‚ç2‚Éİ’è‚·‚éBCANDIDATE:•\¦‚Ì‚½‚ßB
function! s:SetCmdheight()
  if !exists('s:save_cmdheight')
    let s:save_cmdheight = &cmdheight
  endif
  if &cmdheight < 2
    let &cmdheight = 2
  endif
endfunction

function! s:InputStart()
  call s:SetCmdheight()
  call s:StatusSet()
endfunction

" ’¼‘O‚Ì2•¶š‚Ì•”ñ‡¬•ÏŠ·‚ğs‚¤
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
      echo '•”ñ‡¬•ÏŠ·‚ª‚Å‚«‚Ü‚¹‚ñ‚Å‚µ‚½: ' . char1 . ', ' . char2
    endif
    let &ve = save_ve
  endif
endfunction

" ¡‚ÌˆÊ’uˆÈ‘O‚Ì2•¶š‚ğ•”ñ‡¬•ÏŠ·‚·‚é
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  call s:InputConvertBushu(0)
endfunction

" ˆÈ‘O‚ÌConvertCount()‚É“n‚³‚ê‚½countˆø”‚Ì’lB
" count‚ª0‚ÅÀs‚³‚ê‚½ê‡‚ÉˆÈ‘O‚Ìcount’l‚ğg‚¤‚æ‚¤‚É‚·‚é‚½‚ßB
let s:last_count = 0

" ¡‚ÌˆÊ’uˆÈ‘O‚Ìcount•¶š‚ğ•ÏŠ·‚·‚é
" @param count •ÏŠ·‚·‚é•¶š—ñ‚Ì’·‚³
" @param katuyo Šˆ—p‚Ì‚ ‚éŒê‚Ì•ÏŠ·‚©‚Ç‚¤‚©B0:Šˆ—p‚È‚µ, 1:Šˆ—p‚ ‚è
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
    call s:SetCmdheight()
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let status = status . '\'
    endif
    let found = s:CandidateSearch(status)
    if found == 2
      echo 'CANDIDATE: ' . s:last_candidate
    elseif found == 1
      call s:FixCandidate()
    elseif found == 0
      echo 'Not found: ' . status
    elseif found == -1
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
  let str = s:StatusGet()
  if s:IsCandidateOK(str)
    let len = strlen(str)
    call s:CandidateSelect(len)
    execute "normal! " . (s:status_column - 1) . "|"
  endif
  let s:last_count = 0
  call s:StatusReset()
  let &cmdheight = s:save_cmdheight
  unlet s:save_cmdheight
endfunction

"==============================================================================
" ƒwƒ‹ƒv•\¦

" ‹ó‚Ìƒwƒ‹ƒv—pƒoƒbƒtƒ@‚ğì‚é
function! s:Help_BufReadCmd()
  set ft=
  set buftype=nofile
  set bufhidden=delete
  set noswapfile
endfunction

" ƒwƒ‹ƒv—pƒoƒbƒtƒ@‚ğŠJ‚­
function! s:OpenHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) < 0
    execute "silent normal! :sp " . s:helpbufname . "\<CR>"
  endif
  execute "normal! :%d\<CR>4\<C-W>\<C-_>"
endfunction

" ƒJ[ƒ\ƒ‹ˆÊ’u‚Ì•¶š‚Ì‘ÅŒ®‚ğ•\¦‚·‚é
function! s:ShowStrokeHelp()
  let col1 = col(".")
  execute "normal! a\<ESC>"
  let col2 = col("'^")
  let ch = strpart(getline("."), col1 - 1, col2 - col1)
  call s:ShowHelp(ch)
endfunction

" w’è‚³‚ê‚½•¶š‚ğ“ü—Í‚·‚é‚½‚ß‚Ì‘ÅŒ®‚ğ•\¦‚·‚é
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

" w’è‚³‚ê‚½•¶š‚Æ‚»‚Ì‘ÅŒ®‚ğ•\‚É‚µ‚Ä•\¦‚·‚é
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
  execute "normal! :%s@. . @E@g\<CR>"
  execute "normal! :%s@@ @ge\<CR>"
  execute "normal! 1GA    " . a:ch . "\<ESC>"
  execute "normal! \<C-W>p"
endfunction

" •”ñ‡¬«‘‚©‚çAw’è‚³‚ê‚½•¶š‚ğŠÜ‚Şs‚ğŒŸõ‚µ‚Ä•\¦‚·‚é
function! s:ShowHelpBushuDic(ch)
  let lines = s:SearchBushuDic(a:ch)
  if strlen(lines) > 0
    call s:OpenHelpBuffer()
    execute "normal! a" . lines . "\<ESC>1G"
    execute "normal! \<C-W>p"
  endif
endfunction

" •”ñ‡¬«‘‚©‚çAw’è‚³‚ê‚½•¶š‚ğŠÜ‚Şs‚ğŒŸõ‚·‚é
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

" w’è‚³‚ê‚½•¶š‚ğ“ü—Í‚·‚é‚½‚ß‚Ì‘ÅŒ®‚ğkeymapƒtƒ@ƒCƒ‹‚©‚çŒŸõ‚·‚é
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
"			     –¢Šm’è•¶šŠÇ——pŠÖ”ŒQ
"

"   –¢Šm’è•¶š—ñ‚ª‘¶İ‚·‚é‚©ƒ`ƒFƒbƒN‚·‚é
function! s:StatusIsEnable()
  if s:status_line != line('.') || s:status_column <= 0 || s:status_column > col('.')
    return 0
  endif
  return 1
endfunction

"   –¢Šm’è•¶š—ñ‚ğŠJn‚·‚é
function! s:StatusSet()
  let s:status_line = line("'^")
  let s:status_column = col("'^")
  call s:StatusEcho()
endfunction

"   –¢Šm’è•¶š—ñ‚ğƒŠƒZƒbƒg‚·‚é
function! s:StatusReset()
  let s:status_line = 0
  let s:status_column = 0
endfunction

"   –¢Šm’è•¶š—ñ‚ğuó‘Ôv‚Æ‚µ‚Äæ“¾‚·‚é
function! s:StatusGet()
  if !s:StatusIsEnable()
    return ''
  endif

  " •K—v‚Èƒpƒ‰ƒ[ƒ^‚ğûW
  let stpos = s:status_column - 1
  let ccl = col("'^")
  let len = ccl - s:status_column
  let str = getline('.')

  return strpart(str, stpos, len)
endfunction

"   –¢Šm’è•¶š—ñ‚ÌŠJnˆÊ’u‚ÆI—¹ˆÊ’u‚ğ•\¦(ƒfƒoƒbƒO—p)
function! s:StatusEcho(...)
  echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

call s:StatusReset()
