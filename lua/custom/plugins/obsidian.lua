return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '/Users/nicolasraffray/Developer/notes',
      },
    },
    completion = {
      blink = true,
      nvim_cmp = false,
      min_chars = 2,
    },
    legacy_commands = false,
    -- Keymaps are now set via autocmd - see below
    daily_notes = {
      folder = 'daily',
      date_format = '%Y-%m-%d',
      default_tags = { 'daily' },
    },
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = 'telescope.nvim',
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = '<C-x>',
        -- Insert a link to the selected note.
        insert_link = '<C-l>',
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = '<C-x>',
        -- Insert a tag at the current location.
        insert_tag = '<C-l>',
      },
    },
  },
  config = function(_, opts)
    require('obsidian').setup(opts)

    -- Set up keymaps for obsidian (new approach)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      group = vim.api.nvim_create_augroup('ObsidianKeymaps', { clear = true }),
      callback = function(ev)
        -- Only apply in obsidian vault
        local obsidian = require('obsidian').get_client()
        if not obsidian then
          return
        end

        -- Overrides 'gf' to work on markdown/wiki links
        vim.keymap.set('n', 'gf', function()
          return require('obsidian').util.gf_passthrough()
        end, { noremap = false, expr = true, buffer = ev.buf, desc = 'Obsidian follow link' })

        -- Toggle check-boxes
        vim.keymap.set('n', '<leader>ch', function()
          return require('obsidian').util.toggle_checkbox()
        end, { buffer = ev.buf, desc = 'Obsidian toggle checkbox' })

        -- Smart action depending on context
        vim.keymap.set('n', '<cr>', function()
          return require('obsidian').util.smart_action()
        end, { buffer = ev.buf, expr = true, desc = 'Obsidian smart action' })
      end,
    })
  end,
}
