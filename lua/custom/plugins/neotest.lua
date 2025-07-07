return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-neotest/neotest-plenary',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-jest',
    'marilari88/neotest-vitest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-plenary',
        require 'neotest-jest' {
          jestCommand = 'npm test -- --silent=false',
          jestConfigFile = 'custom.jest.config.ts',
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        },
        require 'neotest-vitest' {
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
        },
      },
    }

    vim.keymap.set('n', '<leader>ta', require('neotest').run.attach, { desc = '[t]est [a]ttach' })
    vim.keymap.set('n', '<leader>tn', function()
      require('neotest').run.run()
    end, { desc = '[t]est [n]earest' })
    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = '[t]est [f]ile' })
    vim.keymap.set('n', '<leader>ts', function()
      require('neotest').run.stop()
    end, { desc = '[t]est [s]top' })
    vim.keymap.set('n', '<leader>to', function()
      require('neotest').output_panel.toggle()
    end, { desc = '[t]est [o]utput' })
  end,
}
