return {
    {
        'windwp/nvim-ts-autotag',
        ft = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact'
        },
        config = function()
            require('nvim-ts-autotag').setup()
        end
    },
    {
        'm4xshen/autoclose.nvim',
        config = function ()
            require("autoclose").setup()
        end
    }
}
