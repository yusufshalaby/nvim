return {
	"cameron-wags/rainbow_csv.nvim",
	config = function()
		require("rainbow_csv").setup()
		vim.cmd(
			"let g:rcsv_colorlinks = ['Blue','Yellow','Aqua','Orange','Green','Red','Purple','Blue','Yellow','Aqua']"
		)
	end,
	ft = "csv",
}
