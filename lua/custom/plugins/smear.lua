return {
  'sphamba/smear-cursor.nvim',
  config = function()
    require('smear_cursor').setup {
      -- cursor_color = '#79d071',
      stiffness = 0.9, -- 0.6      [0, 1]
      trailing_stiffness = 0.7, -- 0.4      [0, 1]
      stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      distance_stop_animating = 0.6, -- 0.1      > 0
    }
  end,
}
