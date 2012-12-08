" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding cp932

" autoload/tcvime.vim - utility functions for tcvime.
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2012-12-08

let s:save_cpo = &cpo
set cpo&vim

" Œã’uŒ^ƒJƒ^ƒJƒi•ÏŠ·‚ÅA•¶š”‚ªw’è‚³‚ê‚Ä‚¢‚È‚¢Û‚ÉA
" ‚±‚Ìƒpƒ^[ƒ“‚Éƒ}ƒbƒ`‚·‚é•¶š‚ª‘±‚­ŠÔ‚ÍƒJƒ^ƒJƒi‚É•ÏŠ·‚·‚éB
let g:tcvime#hira2kata_pat = '[‚Ÿ-‚ñ[E=]*'

let g:tcvime#hira2kata_table = {
  \'‚ ':'ƒA','‚¢':'ƒC','‚¤':'ƒE','‚¦':'ƒG','‚¨':'ƒI',
  \'‚©':'ƒJ','‚«':'ƒL','‚­':'ƒN','‚¯':'ƒP','‚±':'ƒR',
  \'‚³':'ƒT','‚µ':'ƒV','‚·':'ƒX','‚¹':'ƒZ','‚»':'ƒ\',
  \'‚½':'ƒ^','‚¿':'ƒ`','‚Â':'ƒc','‚Ä':'ƒe','‚Æ':'ƒg',
  \'‚È':'ƒi','‚É':'ƒj','‚Ê':'ƒk','‚Ë':'ƒl','‚Ì':'ƒm',
  \'‚Í':'ƒn','‚Ğ':'ƒq','‚Ó':'ƒt','‚Ö':'ƒw','‚Ù':'ƒz',
  \'‚Ü':'ƒ}','‚İ':'ƒ~','‚Ş':'ƒ€','‚ß':'ƒ','‚à':'ƒ‚',
  \'‚â':'ƒ„','‚ä':'ƒ†','‚æ':'ƒˆ',
  \'‚ç':'ƒ‰','‚è':'ƒŠ','‚é':'ƒ‹','‚ê':'ƒŒ','‚ë':'ƒ',
  \'‚í':'ƒ','‚î':'ƒ','‚ï':'ƒ‘','‚ğ':'ƒ’',
  \'‚ª':'ƒK','‚¬':'ƒM','‚®':'ƒO','‚°':'ƒQ','‚²':'ƒS',
  \'‚´':'ƒU','‚¶':'ƒW','‚¸':'ƒY','‚º':'ƒ[','‚¼':'ƒ]',
  \'‚¾':'ƒ_','‚À':'ƒa','‚Ã':'ƒd','‚Å':'ƒf','‚Ç':'ƒh',
  \'‚Î':'ƒo','‚Ñ':'ƒr','‚Ô':'ƒu','‚×':'ƒx','‚Ú':'ƒ{',
  \'‚Ï':'ƒp','‚Ò':'ƒs','‚Õ':'ƒv','‚Ø':'ƒy','‚Û':'ƒ|',
  \'‚Ÿ':'ƒ@','‚¡':'ƒB','‚£':'ƒD','‚¥':'ƒF','‚§':'ƒH',
  \'‚á':'ƒƒ','‚ã':'ƒ…','‚å':'ƒ‡',
  \'‚ñ':'ƒ“','‚Á':'ƒb','‚ì':'ƒ',
\}

" insert mode‚ÉA’¼‘O‚Ìw’è‚³‚ê‚½•¶š”‚Ì‚Ğ‚ç‚ª‚È¨ƒJƒ^ƒJƒi•ÏŠ·‚ğs‚¤
" ‚½‚ß‚Ì•¶š—ñ‚ğ•Ô‚·B
"
" •¶š”‚Æ‚µ‚Ä0‚ğw’è‚·‚é‚ÆA
" g:tcvime#hira2kata_pat‚Éƒ}ƒbƒ`‚·‚é•¶š‚ª‘±‚­ŠÔ‚ÍƒJƒ^ƒJƒi•ÏŠ·‚ğs‚¤B
" (tutcode keymap‚Ìê‡AˆÈ‰º‚Ì‚æ‚¤‚ÉƒJƒ^ƒJƒi“ü—Í‚ª‰Â”\B
"  uRKtltugiehe siqljflallvƒA‚Õ‚è‚¯[‚µ‚å‚ñ¨ƒAƒvƒŠƒP[ƒVƒ‡ƒ“
" Å‰‚Ì•¶š‚¾‚¯ƒVƒtƒgƒL[‚ğ‰Ÿ‚µ‚È‚ª‚ç‘ÅŒ®‚µ‚ÄƒJƒ^ƒJƒi‚Å“ü—Í‚µ‚ÄA
" Œã‚ÍƒVƒtƒgƒL[–³‚µ‚Å‚Ğ‚ç‚ª‚È‚Å“ü—Í‚µ‚ÄAÅŒã‚ÉŒã’uŒ^ƒJƒ^ƒJƒi•ÏŠ·‚ÅA
" Å‰‚ÉƒJƒ^ƒJƒi‚Å“ü—Í‚µ‚½•¶š‚Ü‚Å‚ğ‚Ü‚Æ‚ß‚ÄƒJƒ^ƒJƒi•ÏŠ·)
" (ƒJƒ^ƒJƒiƒ‚[ƒh‚ÉØ‚è‘Ö‚¦‚½‚èu'rktltugiehe siqljfl'vA
" ‘S‚ÄƒVƒtƒgƒL[‚ğ‰Ÿ‚µ‚È‚ª‚ç‘ÅŒ®‚µ‚½‚èuRKTLTUGIEHe SIQLJFLv‚æ‚è‚àŠy‚©‚à)
"
" tutcode keymap‚ÅŒã’uŒ^ƒJƒ^ƒJƒi•ÏŠ·‚ğs‚¤‚½‚ß‚Ìİ’è—á:
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
    " ‘O’uŒ^Œğ‚º‘‚«•ÏŠ·‚Ì“Ç‚İ‚Æ‚µ‚Äw’è‚³‚ê‚½•¶š—ñ‚ª‚ ‚ê‚ÎA•ÏŠ·‘ÎÛ‚Æ‚·‚é
    let yomi = s:StatusGet('.', col)
    if yomi != ''
      let cnt = strlen(substitute(yomi, '.', 'x', 'g'))
    endif
  endif
  return tcvime#InputConvertKatakanaPos(col, cnt)
endfunction

function! tcvime#InputConvertKatakanaPos(col, n)
  if a:n == 0
    " g:tcvime#hira2kata_pat‚Éƒ}ƒbƒ`‚·‚é•¶š‚ğæ“¾
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

" keymap‚ğİ’è‚·‚é
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

"   ƒ}ƒbƒsƒ“ƒO‚ğ—LŒø‰»
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

"   ƒ}ƒbƒsƒ“ƒO‚ğ–³Œø‰»
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
"				    “ü—Í§Œä

" “Ç‚İ‚Ì“ü—Í‚ğŠJn
function! s:InputStart()
  call s:StatusSet()
  return ''
endfunction

let s:completeyomi = ''

" Insert mode‚ÅŒã’uŒ^Œğ‚º‘‚«•ÏŠ·‚ğs‚¤B
" Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚Ìê‡‚ÍA
" •ÏŠ·‘ÎÛ•¶š—ñ‚Ì––”ö‚Éu\v‚ğ’Ç‰Á‚µ‚ÄŒğ‚º‘‚««‘‚ğŒŸõ‚·‚éB
"
" tc2“¯—l‚ÌŒã’uŒ^Œğ‚º‘‚«•ÏŠ·‚ğs‚¤‚½‚ß‚Ìİ’è—á:
"     " Šˆ—p‚µ‚È‚¢Œê
"     lmap 18 <C-R>=tcvime#InputPostConvert(1, 0)<CR>
"     lmap 28 <C-R>=tcvime#InputPostConvert(2, 0)<CR>
"     lmap 38 <C-R>=tcvime#InputPostConvert(3, 0)<CR>
"     lmap 48 <C-R>=tcvime#InputPostConvert(4, 0)<CR>
"     " Šˆ—p‚·‚éŒê(‚½‚¾‚µtc2‚Æˆá‚Á‚ÄA“Ç‚İ‚Ì•¶š”‚É‚ÍŠˆ—pŒê”ö‚ÍŠÜ‚Ü‚È‚¢)
"     lmap 29 <C-R>=tcvime#InputPostConvert(2, 1)<CR>
"     lmap 39 <C-R>=tcvime#InputPostConvert(3, 1)<CR>
"     lmap 49 <C-R>=tcvime#InputPostConvert(4, 1)<CR>
"     lmap 59 <C-R>=tcvime#InputPostConvert(5, 1)<CR>
" @param count Œğ‚º‘‚«•ÏŠ·‚Ì‘ÎÛ‚É‚·‚é“Ç‚İ‚Ì•¶š”
" @param katuyo Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚©‚Ç‚¤‚©B0:Šˆ—p‚µ‚È‚¢, 1:Šˆ—p‚·‚é
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
    let key = yomi . '\'
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
    echo 'Œğ‚º‘‚««‘’†‚É‚ÍŒ©‚Â‚©‚è‚Ü‚¹‚ñ: <' . yomi . '>'
  else
    echo 'Œğ‚º‘‚«•ÏŠ·«‘ƒtƒ@ƒCƒ‹‚ÌƒI[ƒvƒ“‚É¸”s‚µ‚Ü‚µ‚½: ' . s:candidate_file
  endif
  return inschars
endfunction

" Insert mode‚ÅŒğ‚º‘‚«•ÏŠ·‚ğs‚¤B
" Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚Ìê‡‚ÍA
" •ÏŠ·‘ÎÛ•¶š—ñ‚Ì––”ö‚Éu\v‚ğ’Ç‰Á‚µ‚ÄŒğ‚º‘‚««‘‚ğŒŸõ‚·‚éB
" @param katuyo Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚©‚Ç‚¤‚©B0:Šˆ—p‚µ‚È‚¢, 1:Šˆ—p‚·‚é
function! s:InputConvert(katuyo)
  let inschars = ''
  let s:is_katuyo = 0
  let s:completeyomi = ''
  let status = s:StatusGet('.', col('.'))
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
  let col = col('.')
  if col == 1
    " <CR>‚ÅŠm’è‚µ‚Ä‰üs‚ª‘}“ü‚³‚ê‚Äs“ª‚É‚È‚Á‚½ê‡BTODO: autoindent‘Î‰
    let lnum = line('.') - 1
    let col = col([lnum, '$'])
    let status = s:StatusGet(lnum, col)
  else
    let status = s:StatusGet('.', col)
  endif
  if status == s:completeyomi
    return
  endif
  " XXX: ƒ|ƒbƒvƒAƒbƒvƒƒjƒ…[–³Œø‚Ìê‡A©“®ƒwƒ‹ƒv•\¦‚Å‚«‚È‚¢
  call s:ShowAutoHelp(s:completeyomi, status)
  let s:completeyomi = ''
  call s:StatusReset()
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

  let s:is_katuyo = 0
  let s:status_line = line(".")
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '.\{' . cnt . '}\%' . col("'^") . 'c')

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
function! s:StatusGet(lnum, col)
  if !s:StatusIsEnable(a:lnum, a:col)
    return ''
  endif

  " •K—v‚Èƒpƒ‰ƒ[ƒ^‚ğûW
  let stpos = s:status_column - 1
  let len = a:col - s:status_column
  let str = getline(a:lnum)

  return strpart(str, stpos, len)
endfunction

"   –¢Šm’è•¶š—ñ‚ÌŠJnˆÊ’u‚ÆI—¹ˆÊ’u‚ğ•\¦(ƒfƒoƒbƒO—p)
function! s:StatusEcho(...)
  echo '“Ç‚İ“ü—ÍŠJn;<Leader><Space>:•ÏŠ·,<Leader>o:Šˆ—p‚·‚éŒê‚Ì•ÏŠ·'
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
    nnoremap <buffer> <silent> q :<C-U>quit<CR>
  endif
  %d _
  5wincmd _
endfunction

" ƒwƒ‹ƒv—pƒoƒbƒtƒ@‚ğ•Â‚¶‚é
function! tcvime#CloseHelpBuffer()
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
  call tcvime#ShowHelpForStr(substitute(@@, '\n', '', 'g'), 0)
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
function! tcvime#ShowHelpForStr(str, forcebushu)
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
      call tcvime#CloseHelpBuffer()
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
    call tcvime#CloseHelpBuffer()
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
function! tcvime#KanjiTable_FileOpen()
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

let &cpo = s:save_cpo
