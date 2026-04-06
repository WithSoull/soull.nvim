-- Fuzzy finder
return {
  -- https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    { 'nvim-lua/plenary.nvim' },
    {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  opts = {
    defaults = {
      dynamic_preview_title = true,
      layout_strategy = 'flex',
      layout_config = {
        flex = {
          flip_columns = 120,
        },
        horizontal = {
          width = 0.85,
          height = 0.85,
          preview_width = 0.55,
          prompt_position = 'top',
        },
        vertical = {
          width = 0.8,
          height = 0.85,
          preview_height = 0.4,
          prompt_position = 'top',
          mirror = true,
        },
      },
      sorting_strategy = 'ascending',
      path_display = {
        filename_first = {
          reverse_directories = true
        }
      },
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    },
    pickers = {
      find_files = {
        theme = 'cursor',
        layout_config = { width = { 0.8, max = 120 }, height = { 0.6, max = 30 } },
        path_display = { 'truncate' },
      },
      buffers = {
        theme = 'cursor',
        layout_config = { width = { 0.8, max = 120 }, height = { 0.6, max = 30 } },
        path_display = { 'truncate' },
      },
      lsp_references = {
        theme = 'cursor',
        layout_config = { width = { 0.75, max = 120 }, height = { 0.35, max = 15 } },
        path_display = { 'tail' },
      },
      lsp_definitions = {
        theme = 'cursor',
        layout_config = { width = { 0.75, max = 120 }, height = { 0.35, max = 15 } },
        path_display = { 'tail' },
      },
      lsp_implementations = {
        theme = 'cursor',
        layout_config = { width = { 0.75, max = 120 }, height = { 0.35, max = 15 } },
        path_display = { 'tail' },
      },
      lsp_type_definitions = {
        theme = 'cursor',
        layout_config = { width = { 0.75, max = 120 }, height = { 0.35, max = 15 } },
        path_display = { 'tail' },
      },
      live_grep = {
        layout_strategy = 'vertical',
        layout_config = {
          width = { 0.85, max = 120 },
          height = { 0.85, max = 45 },
          prompt_position = 'top',
          mirror = true,
          preview_height = 0.65,
        },
      },
    },
  }
}
