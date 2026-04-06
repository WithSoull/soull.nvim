-- Set leader key to space
vim.g.mapleader = " "

-- Russian keyboard layout support in normal/visual mode
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

-- Russian duplicate keymap helper
local en_to_ru = {
  a='ф', b='и', c='с', d='в', e='у', f='а', g='п', h='р', i='ш', j='о',
  k='л', l='д', m='ь', n='т', o='щ', p='з', q='й', r='к', s='ы', t='е',
  u='г', v='м', w='ц', x='ч', y='н', z='я',
  A='Ф', B='И', C='С', D='В', E='У', F='А', G='П', H='Р', I='Ш', J='О',
  K='Л', L='Д', M='Ь', N='Т', O='Щ', P='З', Q='Й', R='К', S='Ы', T='Е',
  U='Г', V='М', W='Ц', X='Ч', Y='Н', Z='Я',
}

local function to_russian(lhs)
  local result = ''
  local i = 1
  while i <= #lhs do
    if lhs:sub(i, i) == '<' then
      local j = lhs:find('>', i)
      if j then
        result = result .. lhs:sub(i, j)
        i = j + 1
      else
        result = result .. lhs:sub(i, i)
        i = i + 1
      end
    else
      local ch = lhs:sub(i, i)
      result = result .. (en_to_ru[ch] or ch)
      i = i + 1
    end
  end
  return result
end

local function dual(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
  local ru_lhs = to_russian(lhs)
  if ru_lhs ~= lhs then
    vim.keymap.set(mode, ru_lhs, rhs, opts)
  end
end

-- General keymaps
dual("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })
dual("n", "<leader>qq", ":q!<CR>", { desc = "Quit without saving" })
dual("n", "<leader>wqa", ":wqa<CR>", { desc = "Save and quit all" })
dual("n", "<leader>qa", ":qa<CR>", { desc = "Quit all without saving" })
dual("n", "<leader>ww", ":w<CR>", { desc = "Save file" })
dual("n", "<leader>E", ":e", { desc = "Reload page" })
dual("n", "gx", ":!open <c-r><c-a><CR>", { desc = "Open URL under cursor" })
dual("n", ";", ":", { noremap = true, silent = false, desc = "Enter command mode" })
dual("i", "jk", "<ESC>", { desc = "Exit insert mode" })
dual("n", "<leader><leader>", ":Neotree reveal float<CR>", { desc = "Reveal current file in explorer" })
dual("n", "<leader>vf", "va{o0", { desc = "Visual golang function"})

-- Split window management
dual("n", "<leader>sV", "<C-w>v", { desc = "Split window vertically" })
dual("n", "<leader>sH", "<C-w>s", { desc = "Split window horizontally" })
dual("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
dual("n", "<leader>sx", ":close<CR>", { desc = "Close split window" })
dual("n", "<leader>sj", "<C-w>-", { desc = "Make split shorter" })
dual("n", "<leader>sk", "<C-w>+", { desc = "Make split taller" })
dual("n", "<leader>sl", "<C-w>>5", { desc = "Make split wider" })
dual("n", "<leader>sh", "<C-w><5", { desc = "Make split narrower" })

-- Tab management
dual("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
dual("n", "<leader>tx", ":BufferClose<CR>", { desc = "Close buffer" })
dual("n", "<leader>tn", ":BufferNext<CR>", { desc = "Next buffer" })
dual("n", "<leader>tp", ":BufferPrevious<CR>", { desc = "Previous buffer" })
dual("n", "<leader>Tn", ":BufferMoveNext<CR>", { desc = "Move buffer next" })
dual("n", "<leader>Tp", ":BufferMovePrevious<CR>", { desc = "Move buffer previous" })
dual("n", "<leader>tt", ":BufferPick<CR>", { desc = "Pick buffer" })

-- Diff keymaps
dual("n", "<leader>cc", ":diffput<CR>", { desc = "Put diff to other file" })
dual("n", "<leader>cj", ":diffget 1<CR>", { desc = "Get diff from left (local)" })
dual("n", "<leader>ck", ":diffget 3<CR>", { desc = "Get diff from right (remote)" })
dual("n", "<leader>cn", "]c", { desc = "Next diff hunk" })
dual("n", "<leader>cp", "[c", { desc = "Previous diff hunk" })

-- Quickfix keymaps
dual("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
dual("n", "<leader>qf", ":cfirst<CR>", { desc = "First quickfix item" })
dual("n", "<leader>qn", ":cnext<CR>", { desc = "Next quickfix item" })
dual("n", "<leader>qp", ":cprev<CR>", { desc = "Previous quickfix item" })
dual("n", "<leader>ql", ":clast<CR>", { desc = "Last quickfix item" })
dual("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })

-- Neo-tree
dual("n", "<leader>et", ":Neotree toggle float<CR>", { desc = "Toggle file explorer" })

-- Telescope
dual('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find files" })
dual('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Live grep" })
dual('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Find buffers" })
dual('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Help tags" })
dual('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, { desc = "Search in current buffer" })
dual('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, { desc = "Document symbols" })
dual('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, { desc = "LSP incoming calls" })
dual('n', '<leader>fm', function() require('telescope.builtin').treesitter({symbols={'function', 'method'}}) end, { desc = "Find methods" })
dual('n', '<leader>ft', function()
  local success, node = pcall(function() return require('nvim-tree.lib').get_node_at_cursor() end)
  if not success or not node then return end;
  require('telescope.builtin').live_grep({search_dirs = {node.absolute_path}})
end, { desc = "Grep in tree node" })

-- LSP
dual('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "LSP hover" })
dual('n', '<leader>gd', require('telescope.builtin').lsp_definitions, { desc = "Go to definition" })
dual('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "Go to declaration" })
dual('n', '<leader>gi', require('telescope.builtin').lsp_implementations, { desc = "Go to implementation" })
dual('n', '<leader>gt', require('telescope.builtin').lsp_type_definitions, { desc = "Go to type definition" })
dual('n', '<leader>gr', require('telescope.builtin').lsp_references, { desc = "Show references" })
dual('n', '<leader>gc', '<cmd>lua vim.lsp.buf.clear_references()<CR>', { desc = "Clear references" })
dual('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Signature help" })
dual('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "LSP rename" })
dual('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "Format code" })
dual('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "Format selection" })
dual('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "Code actions" })
dual('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Show line diagnostics" })
dual('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = "Previous diagnostic" })
dual('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = "Next diagnostic" })
dual('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', { desc = "Document symbols" })

-- Flash (navigation) — 's' to jump, 'S' for treesitter select (defined in flash.lua)


-- Copy Error's description
dual('n', '<leader>ec', function()
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
dual('n', '<leader>ee', function()
  vim.diagnostic.open_float(nil, { focus = true, border = "rounded" })
end, { noremap = true, silent = true, desc = "Show diagnostics" })

-- Ufo
dual('n', 'zO', require('ufo').openAllFolds, { desc = "Open all folds" })
dual('n', 'zC', require('ufo').closeAllFolds, { desc = "Close all folds" })
dual('n', 'Z', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "Peek fold or hover" })

-- Ollama/Avante
dual("n", "<leader>om", require("custom.ollama_switcher").show_ollama_models, { desc = "Switch Ollama model" })
dual("n", "<leader>on", ":AvanteChatNew<cr>", { desc = "New Avante chat" })
dual("n", "<leader>os", ":AvanteStop<cr>", { desc = "Stop Avante chat" })

-- Go tests
dual("n", "<leader>Tr", ":Neotest run<CR>", { desc = "Run test under cursor" })
dual("n", "<leader>TT", ":Neotest summary<CR>", { desc = "Show test summary" })

-- Copy relative file path
dual("n", "<leader>yp", function()
  local path = vim.fn.expand('%')
  vim.fn.setreg('+', path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy relative file path" })

return { dual = dual }
