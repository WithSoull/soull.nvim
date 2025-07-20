local function get_ollama_models()
  local models = {}
  local handle = io.popen('ollama list 2>/dev/null | awk \'NR>1 {print $1}\'')
  if handle then
    local output = handle:read("*a")
    handle:close()
    for model_name in string.gmatch(output, "[^\r\n]+") do
      models[model_name] = {
        __inherited_from = "ollama",
        model = model_name
      }
    end
  end
  return models
end

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = function()
    local providers = {
      ollama = {
        endpoint = "http://127.0.0.1:11434",
        model = "deepseek-r1", 
      },
    }
    
    -- Merge discovered models with existing providers
    for name, config in pairs(get_ollama_models()) do
      providers[name] = config
    end
    
    return {
      providers = providers
    }
  end,
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
