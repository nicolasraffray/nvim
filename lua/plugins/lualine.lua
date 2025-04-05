return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local palenight = require 'lualine.themes.iceberg_dark'
        require('lualine').setup {
            options = { theme = palenight }
        }
    end
}
