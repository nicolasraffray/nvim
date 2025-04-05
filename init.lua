-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.relativenumber = true

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


vim.keymap.set("i", "jj", "<Esc>")

vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.mouse = 'a'
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- bufferviews
vim.opt.laststatus = 3

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.confirm = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

require("config.lazy")

vim.keymap.set("n", '<C-[>', "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", '<C-]>', "<cmd>BufferLineCycleNext<cr>", { desc = "Prev buffer" })

vim.keymap.set('n', '<C-n>', function()
  -- Get the current buffer and window numbers
  local current_buf = vim.api.nvim_get_current_buf()
  local current_win = vim.api.nvim_get_current_win()

  -- Check for unsaved changes
  if vim.bo[current_buf].modified then
    print("Save changes before closing the buffer.")
    return
  end

  -- Check if 'winfixbuf' is set for the current window
  if vim.wo[current_win].winfixbuf then
    -- Temporarily unset 'winfixbuf' to allow buffer switching
    vim.cmd('q')
  end

  -- Get the list of buffers
  local buffers = vim.fn.getbufinfo({buflisted = 1})
  local current_index = nil

  -- Find the index of the current buffer in the list
  for i, buf in ipairs(buffers) do
    if buf.bufnr == current_buf then
      current_index = i
      break
    end
  end

  -- Determine the buffer to switch to
  local target_buf = nil
  if current_index then
    if current_index == 1 and #buffers > 1 then
      -- If on the first buffer, move to the next buffer
      target_buf = buffers[current_index + 1].bufnr
    elseif current_index > 1 then
      -- Otherwise, move to the previous buffer
      target_buf = buffers[current_index - 1].bufnr
    end
  end

  -- Switch to the target buffer if it exists
  if target_buf then
    vim.api.nvim_set_current_buf(target_buf)
    -- Delete the previous buffer
    vim.api.nvim_buf_delete(current_buf, {})
  else
    vim.cmd('bd')
    vim.cmd("Oil")
  end
end, { desc = 'Close current buffer and move to previous or next' })
