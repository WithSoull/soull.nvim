-- File Explorer / Tree
return {
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    popup_border_style = "rounded",
    window = {
      position = "float",
      popup = {
        size = { width = "70%", height = "80%" },
        position = "50%",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,         -- Показывать скрытые файлы (затенённые)
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true,
      },
    },
    git_status = {
      window = {
        position = "float",
      },
    },
    buffers = {
      window = {
        position = "float",
      },
    },
  },
  config = function(_, opts)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("neo-tree").setup(opts)
  end,
}
