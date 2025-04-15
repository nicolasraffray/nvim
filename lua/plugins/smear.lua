return {
    "sphamba/smear-cursor.nvim",
    opts = {
        cursor_color = "#79d071"
    },
    config = function ()
        vim.keymap.set('n', '<leader>ct', function() require('smear_cursor').toggle() end, { desc = "Toggle smear_cursor"})
    end
}
