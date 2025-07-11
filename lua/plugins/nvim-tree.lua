-- File Explorer / Tree
return {
  -- https://github.com/nvim-tree/nvim-tree.lua
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-tree/nvim-web-devicons', -- Fancy icon support
  },
  opts = {
    actions = {
      open_file = {
        window_picker = {
          enable = false
        },
      }
    },
    filters = {
      dotfiles = false, -- Показывать скрытые файлы
    },
    git = {
      ignore = false, -- Показывать .gitignore файлы
    },
  },
  config = function (_, opts)
    -- Recommended settings to disable default netrw file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup(opts)
    
    --[[ 
    I AM A FCKING SCHIZ cuz a love this one tree bu default 

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
      vim.cmd("cd your/path/to/working/folder/")
      require("nvim-tree.api").tree.open()
    end
    })
    ]]--

  end
}

