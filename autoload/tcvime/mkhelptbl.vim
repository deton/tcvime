" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding utf-8

let s:keytbl = [
\['q','w','e','r','t','y','u','i','o','p'],
\['a','s','d','f','g','h','j','k','l',';'],
\['z','x','c','v','b','n','m',',','.','/']]

function! s:initvar()
  let s:keytblflat = []
  for i in range(len(s:keytbl))
    let s:keytblflat += s:keytbl[i]
  endfor

  " 2打鍵目のソート順番(TUT-Codeの3打鍵用ヘルプ表作成用)
  let s:key2order = []
  let s:key2order += reverse(s:keytbl[0][4:5]) " ['y','t']
  let s:key2order += reverse(s:keytbl[1][4:5]) " ['h','g']
  call add(s:key2order, s:keytbl[2][6]) " 'm'
  call add(s:key2order, s:keytbl[2][3]) " 'v'
  let s:key2order += reverse(s:keytbl[2][4:5]) " ['n','b']
endfunction
call s:initvar()

" autoload/tcvime/helptbl_tutcode.vim等を作るための文字列を作成。
" keymapからヘルプ表を生成すると、不要な行も含まれるので、手で加工する想定。
"
" 操作例: 新しいファイルを開いて、以下の2行を貼り付けて、:wして:so%
" :call append(line('$'), tcvime#mkhelptbl#dict2list(tcvime#mkhelptbl#mktbl2(tcvime#mkhelptbl#keymap2dict('tutcodep'))))
" :call append(line('$'), tcvime#mkhelptbl#dict2list(tcvime#mkhelptbl#mktbl3tutcode(tcvime#mkhelptbl#keymap2dict('tutcodep'))))
" 不要な行を削除した後、以下の操作でVim script化。
" :$a
" }
" .
" :0a
" scriptencoding utf-8
" let tcvime#helptbl_tutcodep#tbl = {
" .
" :.,$j!
function! tcvime#mkhelptbl#dict2list(helpdict)
  let list = []
  for k in sort(keys(a:helpdict), function('s:cmpkeytbl'))
    let ek = substitute(k, "'", "''", 'g')
    let ev = escape(a:helpdict[k], '"')
    call add(list, "'" . ek . "':\"" . ev . '",')
  endfor
  return list
endfunction

" s:keytbl順にソートするための比較関数
function! s:cmpkeytbl(s1, s2)
  let len1 = strlen(a:s1)
  let len2 = strlen(a:s2)
  if len1 != len2
    return len1 - len2
  endif
  if len1 == 1
    let i1 = s:cmpkeytblidx(s:keytblflat, a:s1)
    let i2 = s:cmpkeytblidx(s:keytblflat, a:s2)
    return i1 - i2
  endif
  if len2 == 2
    let mkey1 = a:s1[0]
    let mkey2 = a:s2[0]
    if mkey1 == mkey2
      return s:cmpkeytbl(a:s1[1], a:s2[1])
    endif
    let i1 = s:cmpkeytblidx(s:key2order, mkey1)
    let i2 = s:cmpkeytblidx(s:key2order, mkey2)
    return i1 - i2
  endif
  return a:s1 ==# a:s2 ? 0 : a:s1 > a:s2 ? 1 : -1
endfunction

function! s:cmpkeytblidx(keytbl, key)
  let i = index(a:keytbl, a:key)
  if i >= 0
    return i
  endif
  return len(a:keytbl) + char2nr(a:key)
endfunction

" 2打鍵用ヘルプ表作成
function! tcvime#mkhelptbl#mktbl2(keymapdict)
  let keymapdict2 = {}
  for [k, v] in items(a:keymapdict)
    if strlen(k) > 2
      " 3打鍵以降がある場合は、2打鍵ヘルプ表には'＿'を表示
      let keymapdict2[k[:1]] = '＿'
    else
      let keymapdict2[k] = v
    endif
  endfor
  let commonkeys = s:mkcommonkeys(keymapdict2)
  return s:mktbl(keymapdict2, commonkeys)
endfunction

" 3打鍵用ヘルプ表作成(TUT-Code用)
function! tcvime#mkhelptbl#mktbl3tutcode(keymapdict)
  let commonkeys = s:mkcommonkeys(a:keymapdict)
  call filter(commonkeys, 'strlen(v:val) == 2')
  return s:mktbl(a:keymapdict, commonkeys)
endfunction

function! tcvime#mkhelptbl#keymap2dict(keymapname)
  let dict = {}

  let kmfile = globpath(&rtp, "keymap/" . a:keymapname . "_" . &encoding . ".vim")
  if filereadable(kmfile) != 1
    let kmfile = globpath(&rtp, "keymap/" . a:keymapname . ".vim")
    if filereadable(kmfile) != 1
      return []
    endif
  endif
  silent execute 'sv ' . kmfile
  if search('loadkeymap', 'w') == 0
    quit!
    return []
  endif
  let lines = getline(line('.') + 1, '$')
  quit!

  call filter(lines, 'v:val !~ "^\""')
  call filter(lines, 'v:val !~ "^$"')
  for line in lines
    let m = matchlist(line, '\([^ 	]\+\)[ 	]\+\([^ 	]\+\)')
    if !empty(m)
      let seq = substitute(m[1], '<Space>', ' ', 'g')
      let dict[seq] = m[2]
    endif
  endfor
  return dict
endfunction

" 1打鍵目を削って、同じキーシーケンスをまとめたリストを作る。
" 1打鍵目以外が共通するヘルプ表を作るため。
function! s:mkcommonkeys(keymapdict)
  let keys = keys(a:keymapdict)
  call map(keys, 'v:val[1:]')
  let tmpdict = {}
  for v in keys
    let tmpdict[v] = 1
  endfor
  return keys(tmpdict)
endfunction

function! s:mktbl(keymapdict, commonkeys)
  let dict = {}
  for key23 in a:commonkeys
    let tbl1 = s:mktbl1(a:keymapdict, key23)
    if empty(tbl1)
      continue
    endif
    let key3 = key23[-1:]
    call s:addlastmark(tbl1, key3)
    let key2 = key23[:-2] " 2打鍵の場合''になって、そのまま動くように
    call s:addrlsep(tbl1, key2)
    call map(tbl1, 'join(v:val, "")')
    let tbl1str = join(tbl1, '\n') . '\n'
    let dict[key23] = tbl1str
  endfor
  return dict
endfunction

" 1打鍵目を除いたキーシーケンスが共通する文字のヘルプ表を作る
function! s:mktbl1(keymapdict, key23)
  let tbl1 = []
  let haskanji = 0
  for tl in s:keytbl
    let cols = []
    for key1 in tl
      let kanji = get(a:keymapdict, key1 . a:key23, '・')
      if strwidth(kanji) == 1 " T-CodeでASCII文字が定義されている場所用
	let kanji .= '_'
      endif
      call add(cols, kanji)
      if kanji != '・'
	let haskanji = 1
      endif
    endfor
    call add(tbl1, cols)
  endfor
  " テーブル内に表示する文字が無い場合は、テーブルごと省く
  if haskanji
    return tbl1
  endif
  return []
endfunction

function! s:addlastmark(tbl, key3)
  let [x3, y3] = s:tblindex(s:keytbl, a:key3)
  if x3 == -1
    return
  endif
  for y in range(len(a:tbl))
    if y == y3
      if a:tbl[y][x3] == '・'
	let a:tbl[y][x3] = '$△'
      else
	let a:tbl[y][x3] = '$' . a:tbl[y][x3]
      endif
    else
      let a:tbl[y][x3] = ' ' . a:tbl[y][x3] " padding
    endif
  endfor
endfunction

function! s:tblindex(tbl, key)
  for y in range(len(a:tbl))
    let x = index(a:tbl[y], a:key)
    if x >= 0
      return [x, y]
    endif
  endfor
  return [-1, -1]
endfunction

" 右手ブロックと左手ブロックの区切り|を入れる
function! s:addrlsep(tbl, key2)
  let [x2, y2] = s:tblindex(s:keytbl, a:key2)
  if x2 == -1
    let mark = '|' " 2打鍵の場合
  elseif x2 == 3
    let mark = '<' " 左手側: 'v'
  elseif x2 == 4
    let mark = '>' " 左手側: 't','g','b'
  elseif x2 == 5
    let mark = '<' " 右手側: 'y','h','n'
  else
    let mark = '>' " 右手側: 'm'
  endif
  for y in range(len(a:tbl))
    if y == y2
      let a:tbl[y][4] .= mark
    else
      let a:tbl[y][4] .= '|'
    endif
  endfor
endfunction
