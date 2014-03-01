" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding utf-8

" mkverboselmap.vim: 1打鍵目をそのまま入力するlmapの生成用スクリプト。
" (1打鍵目を入力後timeoutを待つのはかったるいので。)
" (参考: tc.elのtcode-verbose-stroke-list)
"
" 2打鍵以上あるシーケンスに対して、
" そのまま確定用シーケンス(2打鍵目がverbosekey)を生成。

" :call append(line('.'), tcvime#mkverboselmap#mklist(':', tcvime#mkhelptbl#keymap2dict('tutcodep')))

function! tcvime#mkverboselmap#mklist(verbosekey, keymapdict)
  let seqdict = {}
  for [k, v] in items(a:keymapdict)
    if strlen(k) >= 2
      let firstkey = k[0]
      let seqdict[firstkey] = ''
    endif
  endfor

  let list = []
  for k in keys(seqdict)
    call add(list, k . a:verbosekey . "\t" . k)
  endfor
  return list
endfunction
