return {
  "yetone/avante.nvim",
  version = false,
  event = "VeryLazy",
  lazy = false,
  build = "make", -- Для Windows: "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",

    -- Опциональные зависимости
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          use_absolute_path = true,
          drag_and_drop = { insert_mode = true },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "Avante" },
      opts = { file_types = { "markdown", "Avante" } },
    },
  },

  opts = {
    provider = "openai",
    auto_suggestions_provider = "openai",

    openai = {
      endpoint = "https://openrouter.ai/api/v1",
      model = "deepseek/deepseek-r1:free",
      api_key_name = "OpenRouter API KEY",
      temperature = 0,
      timeout = 30000,
    },

    windows = {
      position = "right",
      wrap = true,
      width = 30,
      height = 30,

      sidebar_header = {
        enabled = false,
        align = "center",
        rounded = false,
      },

      input = {
        prefix = "> ",
        height = 8,
      },

      edit = {
        border = "rounded",
        start_insert = true,
      },

      ask = {
        floating = false,
        border = "rounded",
        start_insert = true,
        focus_on_apply = "ours",
      },
    },
  },

  config = function(_, opts)
    vim.opt.laststatus = 3
    require("avante").setup(opts)
  end,
}
