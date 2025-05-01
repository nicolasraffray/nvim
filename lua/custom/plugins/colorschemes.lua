return {
  'vague2k/vague.nvim',
  priority = 1001,
  config = function()
    -- NOTE: you do not need to call setup if you don't want to.
    require('vague').setup {
      -- optional configuration here
      transparent = true,
    }

    vim.cmd 'colorscheme vague'
    vim.cmd ':hi statusline guibg=None'
  end,
}
