-- Status line
return {
  -- https://github.com/nvim-lualine/lualine.nvim
  'nvim-lualine/lualine.nvim',
  dependencies = {
    -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-tree/nvim-web-devicons', -- fancy icons
    -- https://github.com/linrongbin16/lsp-progress.nvim
    'linrongbin16/lsp-progress.nvim', -- LSP loading progress
  },
  opts = {
    options = {
      -- For more themes, see https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
      theme = "catppuccin", -- "auto, tokyonight, catppuccin, codedark, nord" 
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(_)
            local m = vim.api.nvim_get_mode().mode
            local map = {
              -- Normal
              n = 'N', no = 'N', nov = 'N', noV = 'N', ['no\22'] = 'N',
              niI = 'N', niR = 'N', niV = 'N', nt = 'N', ntT = 'N',
              -- Insert
              i = 'I', ic = 'I', ix = 'I',
              -- Visual
              v = 'V', V = 'L', ['\22'] = 'B',
              -- Select (опционально)
              s = 'S', S = 'S', ['\19'] = 'S',
              -- Replace
              R = 'R', Rc = 'R', Rx = 'R', Rv = 'R',
              -- Command
              c = 'C', cv = 'C', ce = 'C',
              -- Terminal (если нужно)
              t = 'T',
            }
            return map[m] or 'N'
          end,
          padding = { left = 1, right = 1 },
        },
      },
      lualine_c = {
        {
          -- Customize the filename part of lualine to be parent/filename
          'filename',
          file_status = true,      -- Displays file status (readonly status, modified status)
          newfile_status = false,  -- Display new file status (new file means no write after created)
          path = 3,                -- 0: Just the filename
                                   -- 1: Relative path
                                   -- 2: Absolute path
                                   -- 3: Absolute path, with tilde as the home directory
                                   -- 4: Filename and parent dir, with tilde as the home directory
          symbols = {
            modified = '',      -- Text to show when the file is modified.
            readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
          }

      }
    }
  },
  config = function(_, opts)
    require'lualine'.setup(opts) -- загрузка настроек opts в barbar

    -- Установка пользовательских цветов для буферов
    vim.api.nvim_set_hl(0, 'lualine_c_normal', { bg = "none"})

  end,
  }
}
