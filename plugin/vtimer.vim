"=========================================================================
"
"	FileName: vtimer.vim
"  Describle: automatic timer to measure time spent with vim
"   Commands: :Showtime	
"			  	show total time used
"			  :Resettime
"			  	reset total time
"
"	  Author: leaforestd
"	   Email: leaforestd@gmail.com
"
"	 Created: Sat May 12 07:51:25 CST 2012 
"	 Version: 1.0
"	 History: 1.0 | leaforestd | Sat May 12 07:51:25 CST 2012 | first released
"
"=========================================================================
"
"===========================totaltime=====================================
"0
"=========================================================================

function! Vtimer_enter()
	let s:v_start = localtime() 
endfunction

function! Vtimer_leave()
	let s:v_add = localtime() - s:v_start
	let s:v_file = readfile($HOME.'/.vim/plugin/vtimer.vim')
	let s:v_total = str2nr(strpart(s:v_file[19],1))
	let s:v_total = s:v_total + s:v_add
	let s:v_file[19] = '"'.s:v_total
	call writefile(s:v_file, $HOME.'/.vim/plugin/vtimer.vim')
endfunction

function! Vtimer_show()
	let s:v_add = localtime() - s:v_start
	let s:v_total = str2nr(strpart(readfile($HOME.'/.vim/plugin/vtimer.vim')[19],1))
	let s:v_total = s:v_total + s:v_add
	let s:v_h = s:v_total / 3600
	let s:v_m = (s:v_total % 3600) / 60
	let s:v_s = s:v_total % 60
	echo s:v_h . 'h ' . s:v_m . 'm ' . s:v_s .'s'
endfunction

function! Vtimer_reset()
	let s:v_file = readfile($HOME.'/.vim/plugin/vtimer.vim')
	let s:v_file[19] = '"0'
	call writefile(s:v_file, $HOME.'/.vim/plugin/vtimer.vim')
endfunction

autocmd VimEnter * call Vtimer_enter()
autocmd VimLeavePre * call Vtimer_leave()

command! Showtime call Vtimer_show()
command! Resettime call Vtimer_reset()
