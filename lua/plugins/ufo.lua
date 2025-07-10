return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- Общие UI настройки
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.signcolumn = 'yes'
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldenable = true
    vim.o.foldlevelstart = 99
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.statuscolumn = '%=%l%s%#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? " " : " ") : "  " }%*'

    -- ftMap для выбора провайдеров
    local ftMap = {
      vim = 'indent',
      python = {'treesitter', 'indent' },
      go = {'treesitter', 'indent' },
      git = ''
    }

    -- Кастомный обработчик для fold-текста
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (' 󰁂 %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, {chunkText, hlGroup})
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, {suffix, 'MoreMsg'})
      return newVirtText
    end

    -- Настройка UFO
    require('ufo').setup({
      fold_virt_text_handler = handler,
      open_fold_hl_timeout = 150,

      close_fold_kinds_for_ft = {
        default = {'imports'},
      },

      close_fold_current_line_for_ft = {
        default = true,
      },

      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0,
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']'
        }
      },

      provider_selector = function(bufnr, filetype, buftype)
        return ftMap[filetype] or { 'treesitter', 'indent' }
      end,
    })
  end,
}
