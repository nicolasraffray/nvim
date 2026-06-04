return {
  'OXY2DEV/markview.nvim',
  -- Disabled due to treesitter markdown parser ABI incompatibility with nvim 0.12.1
  enabled = false,
  lazy = false,

  -- Completion for `blink.cmp`
  dependencies = { 'saghen/blink.cmp' },
}
