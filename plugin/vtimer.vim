"=========================================================================
"
"	FileName: vtimer.vim
"  Describle: recording total time spent on vim, and lines you write via vim
"   Commands: :Showtime	
"			  	show total time on vim
"
"             :Resettime
"			  	reset total time
"
"             :Showline
"               show total line added with vim
"
"             :Resetline
"               reset total line
"                               
"	  Author: leaforestd
"	   Email: leaforestd@gmail.com
"
"	 Created: Sat May 12 07:51:25 CST 2012 
"	 Version: 1.0
"	 History: 1.0 | leaforestd | Sat May 12 07:51:25 CST 2012 | first time released
"	          1.1 | leaforestd | Sat Jul 21 10:13:23 CST 2012 | add a function to count totalline
"
"=====================totaltime & totalline===============================
"
"0
"0
"
"=========================================================================

function! Vtimer_enter()
	let s:t_start = localtime() 
	let s:l_start = line("$")	
endfunction

function! Vtimer_leave()
"read file
	let s:tl_file = readfile($HOME.'/.vim/plugin/vtimer.vim')

"time
	let s:t_inc = localtime() - s:t_start
	let s:t_total = str2nr(strpart(s:tl_file[26],1))
	let s:t_total = s:t_total + s:t_inc
	let s:tl_file[26] = '"'.s:t_total

"line
	let s:l_inc = line("$") - s:l_start
	if s:l_inc < 0
		let s:l_inc = 0
	endif
	let s:l_total = str2nr(strpart(s:tl_file[27],1))
	let s:l_total = s:l_total + s:l_inc
	let s:tl_file[27] = '"'.s:l_total

"write file
	call writefile(s:tl_file, $HOME.'/.vim/plugin/vtimer.vim')
endfunction

function! Vtimer_Showtime()
	let s:t_inc = localtime() - s:t_start
	let s:t_total = str2nr(strpart(readfile($HOME.'/.vim/plugin/vtimer.vim')[26],1))
	let s:t_total = s:t_total + s:t_inc
	let s:t_h = s:t_total / 3600
	let s:t_m = (s:t_total % 3600) / 60
	let s:t_s = s:t_total % 60
	echo s:t_h . 'h ' . s:t_m . 'm ' . s:t_s .'s'
endfunction

function! Vtimer_Showline()
	let s:l_inc = line("$") - s:l_start
	let s:l_total = str2nr(strpart(readfile($HOME.'/.vim/plugin/vtimer.vim')[27],1))
	let s:l_total = s:l_total + s:l_inc
	echo s:l_total . 'line(s)'
endfunction

function! Vtimer_Resettime()
	let s:tl_file = readfile($HOME.'/.vim/plugin/vtimer.vim')
	let s:tl_file[26] = '"0'
	call writefile(s:tl_file, $HOME.'/.vim/plugin/vtimer.vim')
endfunction

function! Vtimer_Resetline()
	let s:l_file = readfile($HOME.'/.vim/plugin/vtimer.vim')
	let s:l_file[27] = '"0'
	call writefile(s:l_file, $HOME.'/.vim/plugin/vtimer.vim')
endfunction

autocmd VimEnter * call Vtimer_enter()
autocmd VimLeavePre * call Vtimer_leave()

command! Showtime call Vtimer_Showtime()
command! Resettime call Vtimer_Resettime()
command! Showline call Vtimer_Showline()
command! Resetline call Vtimer_Resetline()
