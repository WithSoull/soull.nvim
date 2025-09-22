-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps
keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })
keymap.set("n", "<leader>qq", ":q!<CR>", { desc = "Quit without saving" })
keymap.set("n", "<leader>wqa", ":wqa<CR>", { desc = "Save and quit all" })
keymap.set("n", "<leader>qa", ":qa<CR>", { desc = "Quit all without saving" })
keymap.set("n", "<leader>ww", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>E", ":e", { desc = "Reload page" })
keymap.set("n", "gx", ":!open <c-r><c-a><CR>", { desc = "Open URL under cursor" })
keymap.set("n", ";", ":", { noremap = true, silent = false, desc = "Enter command mode" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set("n", "<leader>", ":WhichKey <leader><CR>", { desc = "Show WhichKey" })

-- Split window management
keymap.set("n", "<leader>sV", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sH", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close split window" })
keymap.set("n", "<leader>sj", "<C-w>-", { desc = "Make split shorter" })
keymap.set("n", "<leader>sk", "<C-w>+", { desc = "Make split taller" })
keymap.set("n", "<leader>sl", "<C-w>>5", { desc = "Make split wider" })
keymap.set("n", "<leader>sh", "<C-w><5", { desc = "Make split narrower" })

-- Tab management  
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":BufferClose<CR>", { desc = "Close buffer" })
keymap.set("n", "<leader>tn", ":BufferNext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>tp", ":BufferPrevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<C-t>n", ":BufferMoveNext<CR>", { desc = "Move buffer next" })
keymap.set("n", "<C-t>p", ":BufferMovePrevious<CR>", { desc = "Move buffer previous" })
keymap.set("n", "<leader>tt", ":BufferPick<CR>", { desc = "Pick buffer" })

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>", { desc = "Put diff to other file" })
keymap.set("n", "<leader>cj", ":diffget 1<CR>", { desc = "Get diff from left (local)" })
keymap.set("n", "<leader>ck", ":diffget 3<CR>", { desc = "Get diff from right (remote)" })
keymap.set("n", "<leader>cn", "]c", { desc = "Next diff hunk" })
keymap.set("n", "<leader>cp", "[c", { desc = "Previous diff hunk" })

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
keymap.set("n", "<leader>qf", ":cfirst<CR>", { desc = "First quickfix item" })
keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "Next quickfix item" })
keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "Previous quickfix item" })
keymap.set("n", "<leader>ql", ":clast<CR>", { desc = "Last quickfix item" })
keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })

-- Nvim-tree
keymap.set("n", "<leader>et", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })
keymap.set("n", "<leader>eg", ":NvimTreeFindFile<CR>", { desc = "Find file in explorer" })

-- Telescope
keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find files" })
keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Live grep" })
keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Find buffers" })
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Help tags" })
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, { desc = "Search in current buffer" })
keymap.set('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, { desc = "Document symbols" })
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, { desc = "LSP incoming calls" })
keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({symbols={'function', 'method'}}) end, { desc = "Find methods" })
keymap.set('n', '<leader>ft', function()
  local success, node = pcall(function() return require('nvim-tree.lib').get_node_at_cursor() end)
  if not success or not node then return end;
  require('telescope.builtin').live_grep({search_dirs = {node.absolute_path}})
end, { desc = "Grep in tree node" })

-- LSP
keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "LSP hover" })
keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "Go to definition" })
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "Go to declaration" })
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "Go to implementation" })
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "Go to type definition" })
keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = "Show references" })
keymap.set('n', '<leader>gc', '<cmd>lua vim.lsp.buf.clear_references()<CR>', { desc = "Clear references" })
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Signature help" })
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "LSP rename" })
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "Format code" })
keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "Format selection" })
keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "Code actions" })
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Show line diagnostics" })
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = "Previous diagnostic" })
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = "Next diagnostic" })
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', { desc = "Document symbols" })

-- Hop (easy-motion)
keymap.set("n", '<leader>h', ":HopWord<CR>", { desc = "Hop to word" })

-- Copy Error's description 
keymap.set('n', '<leader>ec', function()
  local diag = vim.diagnostic.get()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = cursor_pos[1] - 1

  for _, d in ipairs(diag) do
    if d.lnum == line then
      vim.fn.setreg('+', d.message)
      vim.notify("Error's description copied: " .. d.message, vim.log.levels.INFO)
      return
    end
  end

  vim.notify("No error in your string", vim.log.levels.WARN)
end, { desc = "Copy error description" })

-- Show error
keymap.set('n', '<leader>ee', function()
  vim.diagnostic.open_float(nil, { focus = true, border = "rounded" })
end, { noremap = true, silent = true, desc = "Show diagnostics" })

-- Ufo
keymap.set('n', 'zO', require('ufo').openAllFolds, { desc = "Open all folds" })
keymap.set('n', 'zC', require('ufo').closeAllFolds, { desc = "Close all folds" })
keymap.set('n', 'Z', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "Peek fold or hover" })

-- Ollama/Avante
keymap.set("n", "<leader>om", require("custom.ollama_switcher").show_ollama_models, { desc = "Switch Ollama model" })
keymap.set("n", "<leader>on", ":AvanteChatNew<cr>", { desc = "New Avante chat" })
keymap.set("n", "<leader>os", ":AvanteStop<cr>", { desc = "Stop Avante chat" })

-- Go tests
keymap.set("n", "<leader>Tr", ":Neotest run<CR>", { desc = "Run test under cursor" })
keymap.set("n", "<leader>TT", ":Neotest summary<CR>", { desc = "Show test summary" })
