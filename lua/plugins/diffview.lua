local is_arc_env = vim.env.USE_ARC == "1"

return {
  -- 1. Стандартный Diffview (загружается по умолчанию)
  {
    "sindrets/diffview.nvim",
    cond = not is_arc_env,
    opts = {},
    keys = {
      { "<leader>do", "<cmd>DiffviewOpen<CR>", desc = "Diffview open" },
      { "<leader>dc", "<cmd>DiffviewClose<CR>", desc = "Diffview close" },
      { "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
      { "<leader>dH", "<cmd>DiffviewFileHistory<CR>", desc = "Branch history" },
    },
  },

  -- 2. Локальный Arc Diffview (загружается ТОЛЬКО если есть флаг)
  {
    dir = vim.fn.stdpath("config") .. "/lua/custom/arc_diffview",
    cond = is_arc_env,
    opts = {},
    keys = {
      { "<leader>do", "<cmd>DiffviewOpen<CR>", desc = "Diffview open (arc)" },
      { "<leader>dc", "<cmd>DiffviewClose<CR>", desc = "Diffview close (arc)" },
      { "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history (arc)" },
      { "<leader>dH", "<cmd>DiffviewFileHistory<CR>", desc = "Branch history (arc)" },
    },
  },
}
