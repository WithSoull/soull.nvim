return {
  -- https://github.com/catppuccin/nvim
  'catppuccin/nvim',
  name = "catppuccin", -- name is needed otherwise plugin shows up as "nvim" due to github URI
  lazy = false, -- We want the colorscheme to load immediately when starting Neovim
  priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
  opts = {
  -- Replace this with your scheme-specific settings or remove to use the defaults
    transparent = true,
    flavour = "mocha", -- "latte, frappe, macchiato, mocha"
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    hop = true,
    barbar = true,
  },
  config = function(_, opts)
    require('catppuccin').setup(opts) -- Replace this with your favorite colorscheme
    vim.cmd("colorscheme catppuccin") -- Replace this with your favorite colorscheme

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

    -- Custom border colors
    vim.cmd([[
      autocmd ColorScheme * hi NormalFloat guifg=#F9E7C0 guibg=#1F1F1F
      autocmd ColorScheme * hi FloatBorder guifg=#F9E7C0 guibg=#1F1F1F
    ]])
  end
}
