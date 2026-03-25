return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    focus = true,
  },
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Diagnostics (project)' },
    { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Diagnostics (buffer)' },
    { '<leader>xq', '<cmd>Trouble qflist toggle<CR>', desc = 'Quickfix list' },
  },
}
