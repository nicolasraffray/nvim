return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'c_sharp',
        'sql',
        'diff',
        'html',
        'lua',
        'luadoc',
        'query',
        'vim',
        'vimdoc',
        'javascript',
        'typescript',
        'tsx',
        'java',
        'go',
        -- Note: Salesforce & markdown parsers disabled due to ABI incompatibility with nvim 0.12.1
        -- Markdown will use vim's built-in syntax highlighting instead
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Disable for filetypes that cause errors
        disable = function(lang, buf)
          -- Disable parsers with ABI incompatibility in nvim 0.12.1
          if vim.tbl_contains({ 'apex', 'soql', 'sosl', 'sflog', 'markdown', 'markdown_inline' }, lang) then
            return true
          end
          -- Also check buffer name for markdown files (catches previews)
          local bufname = vim.api.nvim_buf_get_name(buf)
          if bufname:match('%.md$') or bufname:match('%.markdown$') then
            return true
          end
          -- Disable for large files
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, bufname)
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby', 'markdown' },
      },
      indent = { enable = true, disable = { 'ruby', 'apex', 'soql', 'sosl', 'sflog', 'markdown' } },
    },
    init = function()
      vim.filetype.add {
        extension = {
          cls = 'apexcode',
          trigger = 'apexcode',
          apex = 'apexcode',
          soql = 'soql',
          sosl = 'sosl',
          sflog = 'sflog',
        },
      }

      -- Force stop treesitter for markdown due to builtin parser ABI issue in nvim 0.12.1
      -- Use multiple events to catch all cases including telescope previews
      vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufRead', 'BufWinEnter', 'FileType' }, {
        pattern = { '*.md', '*.markdown', 'markdown' },
        callback = function(args)
          -- Stop treesitter immediately
          pcall(vim.treesitter.stop, args.buf)
          -- Also disable treesitter attachment for this buffer
          vim.b[args.buf].ts_highlight = false
        end,
      })
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
-- vim: ts=2 sts=2 sw=2 et
