" init2.vim because init.vim have special meaning in neovim

function! NetrwMapping()
	nmap <buffer> H u
	nmap <buffer> h -^
	nmap <buffer> l <CR>

	nmap <buffer> . gh
	nmap <buffer> P <C-w>z

	nmap <buffer> <TAB> mfj
	nmap <buffer> <S-TAB> kmf
	vmap <buffer> <TAB> :'<,'>normal mf<CR>
	silent! nunmap <buffer> v
endfunction

augroup netrw_mapping
	autocmd!
	autocmd filetype netrw call NetrwMapping()
augroup END

