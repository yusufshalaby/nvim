return {
	"jpalardy/vim-slime",
	init = function()
		vim.g.slime_target = "neovim"
	end,
	config = function()
		vim.g.slime_input_pid = false
		vim.g.slime_suggest_default = true
		vim.g.slime_menu_config = false
		vim.g.slime_neovim_ignore_unlisted = false
		vim.api.nvim_command([[
				let g:slime_python_ipython = 1
				let g:slime_config_defaults["dispatch_ipython_pause"] = 100

				function! _EscapeText_python(text)
				  if slime#config#resolve("python_ipython") && len(split(a:text,"\n")) > 1
				    return ["%cpaste -q\n", slime#config#resolve("dispatch_ipython_pause"), a:text, "--\n"]
				  else
				    let empty_lines_pat = '\(^\|\n\)\zs\(\s*\n\+\)\+'
				    let no_empty_lines = substitute(a:text, empty_lines_pat, "", "g")
				    let dedent_pat = '\(^\|\n\)\zs'.matchstr(no_empty_lines, '^\s*')
				    let dedented_lines = substitute(no_empty_lines, dedent_pat, "", "g")
				    let except_pat = '\(elif\|else\|except\|finally\)\@!'
				    let add_eol_pat = '\n\s[^\n]\+\n\zs\ze\('.except_pat.'\S\|$\)'
				    return substitute(dedented_lines, add_eol_pat, "\n", "g")
				  end
				endfunction

				let g:slime_config_defaults["scala_ammonite"] = 0
				function! _EscapeText_scala(text)
				  if slime#config#resolve("scala_ammonite")
				    return ["{\n", a:text, "}\n"]
				  end
				  " \x04 is ctrl-d
				  return [":paste\n", a:text, "\x04"]
				endfunction
				]])
	end,
}
