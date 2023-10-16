return function()
  local telescope = require "telescope"
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  })
  pcall(require('telescope').load_extension, 'fzf')
end
