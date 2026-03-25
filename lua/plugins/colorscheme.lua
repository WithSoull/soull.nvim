-- Per-theme configuration (edit these to customize each theme)
local theme_config = {
  mocha = { transparent = true },
  latte = { transparent = false },
}

-- Detect macOS system appearance
local function get_system_appearance()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  if result:match("Dark") then
    return "dark"
  end
  return "light"
end

local function flavor_for_appearance(appearance)
  return appearance == "dark" and "mocha" or "latte"
end

local function apply_theme(flavor)
  local conf = theme_config[flavor] or theme_config.mocha
  require('catppuccin').setup({
    flavour = flavor,
    transparent_background = conf.transparent,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      hop = true,
      barbar = true,
    },
  })
  vim.opt.background = (flavor == "latte") and "light" or "dark"
  vim.cmd("colorscheme catppuccin")
end

return {
  -- https://github.com/catppuccin/nvim
  'catppuccin/nvim',
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    local appearance = get_system_appearance()
    local flavor = flavor_for_appearance(appearance)
    apply_theme(flavor)

    -- :ThemeSync — re-read system appearance and apply
    vim.api.nvim_create_user_command('ThemeSync', function()
      local app = get_system_appearance()
      apply_theme(flavor_for_appearance(app))
    end, {})

    -- :ThemeToggle — toggle between mocha and latte
    vim.api.nvim_create_user_command('ThemeToggle', function()
      local current = require('catppuccin').flavour or "mocha"
      local next_flavor = (current == "mocha") and "latte" or "mocha"
      apply_theme(next_flavor)
    end, {})

    -- Custom diff colors
    vim.cmd([[
      autocmd VimEnter * hi DiffAdd guifg=#00FF00 guibg=#005500
      autocmd VimEnter * hi DiffDelete guifg=#FF0000 guibg=#550000
      autocmd VimEnter * hi DiffChange guifg=#CCCCCC guibg=#555555
      autocmd VimEnter * hi DiffText guifg=#00FF00 guibg=#005500
    ]])

    -- Custom border colors
    vim.cmd([[
      autocmd ColorScheme * hi NormalFloat guifg=#F9E7C0 guibg=#1F1F1F
      autocmd ColorScheme * hi FloatBorder guifg=#F9E7C0 guibg=#1F1F1F
    ]])
  end
}
