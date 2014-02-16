" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding utf-8

" kanji2seq.vim: 漢字から入力シーケンスを取得するための関数。
" keymapは入力シーケンス→漢字だが、その逆変換(漢字→入力シーケンス)を行う。

" 指定された文字を入力するためのストロークを取得する
function! tcvime#kanji2seq#get(ch)
  if exists('s:kanji2seqdict')
    return get(s:kanji2seqdict, a:ch, '')
  endif
  let keymap = s:keymapname()
  try
    let s:kanji2seqdict = g:tcvime#kanji2seq_{keymap}#dict
  catch /^Vim\%((\a\+)\)\=:E121/ " E121: Undefined variable
    let s:kanji2seqdict = {}
    call s:loadkeymapfile(keymap)
  endtry
  return get(s:kanji2seqdict, a:ch, '')
endfunction

function! s:loadkeymapfile(keymap)
  let kmfile = globpath(&rtp, "keymap/" . a:keymap . "_" . &encoding . ".vim")
  if filereadable(kmfile) != 1
    let kmfile = globpath(&rtp, "keymap/" . a:keymap . ".vim")
    if filereadable(kmfile) != 1
      return -1
    endif
  endif
  if kmfile == ''
    return -1
  endif
  silent execute 'sv ' . kmfile
  if search('loadkeymap', 'w') == 0
    quit!
    return -1
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
  return 0
endfunction

function! s:keymapname()
  let keymap = &keymap
  if strlen(keymap) == 0
    let keymap = g:tcvime_keymap_for_help
    if strlen(keymap) == 0
      echo 'tcvime文字ヘルプ表示には、keymapオプションかg:tcvime_keymap_for_helpの設定要'
      return ''
    endif
  endif
  return keymap
endfunction
