local function close_hidden_buffers()
  local visible_buffers = {}
  
  for tab = 1, vim.fn.tabpagenr('$') do
    for _, bufnr in ipairs(vim.fn.tabpagebuflist(tab)) do
      visible_buffers[bufnr] = true
    end
  end
  
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) and 
       vim.bo[bufnr].buflisted and 
       not visible_buffers[bufnr] and
       not vim.bo[bufnr].modified then -- Защита от потери изменений
      vim.api.nvim_buf_delete(bufnr, { force = false })
    end
  end
end


return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    -- Исключить домашние директории
    suppressed_dirs = { "~/", "~/home", "~/home/01_Coding/", "/" },
    -- Автоматически сохранять и восстанавливать сессии
    auto_save = true,
    auto_restore = true,
    auto_create = true,

    pre_save_cmds = {
      "close_hidden_tabs",
      close_hidden_buffers
    },
  },
}
