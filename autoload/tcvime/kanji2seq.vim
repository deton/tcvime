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
  if keymap == ''
    return ''
  endif
  try
    let s:kanji2seqdict = g:tcvime#kanji2seq_{keymap}#dict
  catch /^Vim\%((\a\+)\)\=:E121/ " E121: Undefined variable
    let s:kanji2seqdict = tcvime#kanji2seq#keymap2revdict(keymap)
  endtry
  return get(s:kanji2seqdict, a:ch, '')
endfunction

" autoload/tcvime/kanji2seq_tutcode.vim等を作るための文字列を作成。
" keymapから逆変換表を生成すると、不要な行も含まれるので、手で加工する想定。
" (例: 'e 'と'E 'の両方で'ー'に変換されるよう定義している場合、
" 'ー'からの逆変換では'e 'にしたいが、Dictionaryへの変換時に'E 'になる場合あり)
"
" 操作例: 新しいファイルを開いて、
" :call append(line('$'), tcvime#kanji2seq#dict2list(tcvime#kanji2seq#keymap2revdict('tutcodep')))
" 不要な行を削除した後、以下の操作でVim script化。
" :$a
" }
" .
" :0a
" scriptencoding utf-8
" let tcvime#kanji2seq_tutcodep#dict = {
" .
" :.,$j!
function! tcvime#kanji2seq#dict2list(dict)
  let list = []
  for k in sort(keys(a:dict))
    let ek = substitute(k, "'", "''", 'g')
    let ev = substitute(a:dict[k], "'", "''", 'g')
    call add(list, "'" . ek . "':'" . ev . "',")
  endfor
  return list
endfunction

" :や,の後にスペースが入るが無駄なのでうれしくない。
function! tcvime#kanji2seq#echodict(keymapname)
  redir => str
    execute "silent echo tcvime#kanji2seq#keymap2revdict(a:keymapname)"
  redir END
  return str
endfunction

function! tcvime#kanji2seq#keymap2revdict(keymap)
  let dict = {}
  let kmfile = globpath(&rtp, "keymap/" . a:keymap . "_" . &encoding . ".vim")
  if filereadable(kmfile) != 1
    let kmfile = globpath(&rtp, "keymap/" . a:keymap . ".vim")
    if filereadable(kmfile) != 1
      return dict
    endif
  endif
  if kmfile == ''
    return dict
  endif
  silent execute 'sv ' . kmfile
  if search('loadkeymap', 'w') == 0
    quit!
    return dict
  endif
  let lines = getline(line('.') + 1, '$')
  quit!

  call filter(lines, 'v:val !~ "^\""')
  call filter(lines, 'v:val !~ "^$"')
  for line in lines
    let m = matchlist(line, '\([^ 	]\+\)[ 	]\+\([^ 	]\+\)')
    if !empty(m)
      let dict[m[2]] = substitute(m[1], '<[Ss]pace>', ' ', 'g')
    endif
  endfor
  return dict
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
