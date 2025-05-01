-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    sources = {
      'filesystem',
      'buffers',
      'git_status',
      'document_symbols',
    },
    source_selector = {
      winbar = true, -- toggle to show selector on winbar
      statusline = false, -- toggle to show selector on statusline
      show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
      -- of the top visible node when scrolled down.
      sources = {
        { source = 'filesystem' },
        { source = 'buffers' },
        { source = 'git_status' },
        { source = 'document_symbols' },
      },
    },
    filesystem = {
      window = {
        position = 'right',
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    event_handlers = {
      event = 'file_opened',
      handler = function()
        require('neo-tree.command').execute { action = 'focus' }
      end,
    },
  },
}
