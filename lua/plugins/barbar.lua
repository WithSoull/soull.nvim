return {
  'romgrk/barbar.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    clickable = true,
    focus_on_close = 'previous',
    icons = {
      separator = {left = '', right = ''},
      inactive = {
        separator = {left = '', right = ''},
      },
      separator_at_end = false,
      filetype = {
        custom_colors = true,
        enabled = true,
      },
    },
    tabpages = true,
  },
  version = '^1.0.0',

  config = function(_, opts)
    require'barbar'.setup(opts) -- загрузка настроек opts в barbar
    --
    -- Подключаем модуль для управления цветами буферов
    require('custom.barbar_colors')
  end,
}
