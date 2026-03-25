return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      -- Авто-открытие UI при старте дебага и закрытие при завершении
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Go интеграция (даёт удобные команды Debug test / Debug nearest и т.п.)
      require("dap-go").setup()

      -- (Опционально) если хочешь явную настройку адаптера delve:
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      -- Базовые конфиги для Go (можно оставить, если используешь dap-go, но полезно иметь)
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug file",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug package (cwd)",
          request = "launch",
          program = "${workspaceFolder}",
        },
      }

      -- Keymaps (можешь поменять под себя)
      local map = vim.keymap.set
      map("n", "<leader>dc",  function() dap.continue() end, { desc = "DAP continue" })
      map("n", "<leader>dso", function() dap.step_over() end, { desc = "DAP step over" })
      map("n", "<leader>dsi", function() dap.step_into() end, { desc = "DAP step into" })
      map("n", "<leader>dsout", function() dap.step_out() end, { desc = "DAP step out" })
      map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP toggle breakpoint" })
      map("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP conditional breakpoint" })
      map("n", "<leader>dr", function() dap.repl.open() end, { desc = "DAP REPL" })
      map("n", "<leader>du", function() dapui.toggle() end, { desc = "DAP UI toggle" })

      -- Go-specific shortcuts
      map("n", "<leader>dt", function() require("dap-go").debug_test() end, { desc = "Debug Go test (current)" })
      map("n", "<leader>dT", function() require("dap-go").debug_test({ verbose = true }) end, { desc = "Debug Go test (verbose)" })
      map("n", "<leader>dn", function() require("dap-go").debug_test() end, { desc = "Debug nearest Go test" })
      -- В некоторых версиях есть debug_test/ debug_test_file / debug_last:
      map("n", "<leader>dl", function() require("dap-go").debug_last() end, { desc = "Debug last Go test" })
    end,
  },
}

