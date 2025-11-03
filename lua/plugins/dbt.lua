return {
	"dbt.nvim",
	dir = "/Users/yusufshalaby/projects/personal/dbt.nvim",
	cond = function()
		local cwd = vim.uv.cwd()
		local path = cwd .. "/dbt_project.yml"
		local stat = vim.uv.fs_stat(path)
		return stat ~= nil
	end,
	config = function()
		require("dbt").setup({})
	end
}
