scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

function! jplus#getchar()
	let c = getchar()
	if type(c) == type(0)
		return nr2char(c)
	endif
	if c !~ '[[:print:]]'
		return 0
	endif
endfunction


function! jplus#join(c) range
 c = a:c
	let start = a:firstline
	let end = a:lastline + (a:firstline == a:lastline)

	let line = getline(start)
\			 . c
\			 . join(map(filter(getline(start + 1, end), 'len(v:val)'),
\				'matchstr(v:val, ''^\s*\zs.*'')'), c)
	call setline(start, line)

	if start+1 <= end
		silent execute start+1 . ',' . end 'delete _'
	endif
	normal! -1
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

