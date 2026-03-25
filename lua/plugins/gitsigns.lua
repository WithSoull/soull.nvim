-- Читаем флаг окружения (возвращает true, если USE_ARC равно "1")
local is_arc_env = vim.env.USE_ARC == "1"

return {
  -- 1. Стандартный Gitsigns (загружается по умолчанию)
  {
    "lewis6991/gitsigns.nvim",
    cond = not is_arc_env,
    config = function()
      require("gitsigns").setup()
    end
  },

  -- 2. Локальный Arcsigns (загружается ТОЛЬКО если есть флаг)
  {
    dir = vim.fn.stdpath("config") .. "/lua/custom/arcsigns",
    cond = is_arc_env,
    config = function()
      require("gitsigns").setup()
    end
  }
}
