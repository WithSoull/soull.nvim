return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
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
  },
  version = '^1.0.0',

  config = function(_, opts)
    require'barbar'.setup(opts) -- загрузка настроек opts в barbar
 
    local bg_current = "#94e2d5"
    local bg_inactive = "#12111b"

    local fg_base = "#181926"
    local fg_light = "#eff1f5"
    local fg_pink = "#f5c2e7"
    --
    -- Установка пользовательских цветов для буферов
    vim.api.nvim_set_hl(0, 'BufferCurrent', { bg = bg_current, fg = fg_base })
    vim.api.nvim_set_hl(0, 'BufferCurrentIcon', { bg = bg_current, fg = fg_base})
    vim.api.nvim_set_hl(0, 'BufferCurrentSign', { bg = fg_base, fg = bg_current})
    vim.api.nvim_set_hl(0, 'BufferCurrentSignRight', { bg = fg_base, fg = bg_current })

    vim.api.nvim_set_hl(0, 'BufferCurrentMod', { bg = bg_current, fg = fg_base })
    vim.api.nvim_set_hl(0, 'BufferCurrentTarget', { bg = bg_current, fg = fg_base })
    vim.api.nvim_set_hl(0, 'BufferInactiveTarget', { bg = bg_inactive, fg = fg_pink })

    vim.api.nvim_set_hl(0, 'BufferVisible', { bg = bg_current, fg = fg_base })
    vim.api.nvim_set_hl(0, 'BufferVisibleIcon', { bg = bg_current, fg = fg_base})
    vim.api.nvim_set_hl(0, 'BufferVisibleSign', { bg = fg_base, fg = bg_current})
    vim.api.nvim_set_hl(0, 'BufferVisibleSignRight', { bg = fg_base, fg = bg_current })

    vim.api.nvim_set_hl(0, 'BufferInactive', { bg = bg_inactive, fg=fg_light })
    vim.api.nvim_set_hl(0, 'BufferInactiveIcon', { bg = bg_inactive, fg=fg_light })
    vim.api.nvim_set_hl(0, 'BufferInactiveSign', { bg = fg_base, fg=bg_inactive })
    vim.api.nvim_set_hl(0, 'BufferInactiveSignRigh', { bg = fg_base, fg=bg_inactive })
  end,
}
