return {
  "okuuva/auto-save.nvim",
  version = "^1.0.0",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" }, --Events for immediate saving
      defer_save = { "InsertLeave", "TextChanged" }, -- Events for saving in 1 sec after  
      cancel_deferred_save = { "InsertEnter" },
    },
    -- Condition to save buffer
    condition = function()
      local excluded_filetypes = {
        "gitcommit", "NvimTree", "TelescopePrompt", "alpha", "dashboard",
        "lazygit", "neo-tree", "oil", "prompt", "toggleterm"
      }
      local ft = vim.bo.filetype
      for _, v in ipairs(excluded_filetypes) do
        if ft == v then
          return false
        end
      end
      return true
    end,
    write_all_buffers = false,  -- Save buffer
    noautocmd = false,          -- Do autocommands while saving (change to true if troubles with undo)
    lockmarks = false,
    debounce_delay = 1000,      -- Delay (milliseconds)
    debug = false,
  },
}
--

