return {
  'folke/todo-comments.nvim',
  event = 'BufReadPost',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  keys = {
    { '<leader>xt', '<cmd>Trouble todo toggle<CR>', desc = 'TODOs (Trouble)' },
    { '<leader>ft', '<cmd>TodoTelescope<CR>', desc = 'Find TODOs' },
  },
}
