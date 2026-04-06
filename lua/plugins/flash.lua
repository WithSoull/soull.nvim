return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    { 'ss', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash jump' },
    { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash treesitter' },
  },
}
