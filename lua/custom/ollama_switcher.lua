local M = {}

function M.get_ollama_models()
  local models = {}
  
  -- Execute the command safely
  local handle, err = io.popen('ollama list 2>&1', 'r')
  if not handle then
    vim.notify("Failed to execute ollama command: " .. err, vim.log.levels.ERROR)
    return models
  end

  -- Read and process output
  local output = handle:read('*a')
  local success, exit_reason, exit_code = handle:close()

  -- Check for command errors
  if not success then
    vim.notify("Ollama command failed: " .. (exit_reason or "unknown error"), vim.log.levels.ERROR)
    return models
  end

  -- Parse models from output
  for line in output:gmatch("[^\r\n]+") do
    -- Skip header line and empty lines
    if not line:match("^NAME") and not line:match("^%s*$") then
      -- Extract model name (first column)
      local model_name = line:match("^%s*([^%s]+)")
      
      -- If we have a model name with colon, keep the full name
      if model_name then
        -- Some models might have tags (qwen:8b) - we want the full identifier
        table.insert(models, model_name)
      end
    end
  end

  -- Remove duplicates and sort
  local unique_models = {}
  for _, model in ipairs(models) do
    unique_models[model] = true
  end
  
  models = {}
  for model in pairs(unique_models) do
    table.insert(models, model)
  end
  table.sort(models)
  
  return models
end

function M.show_ollama_models()
  -- Get models with proper error handling
  local ok, models = pcall(M.get_ollama_models)
  if not ok then
    vim.notify("Failed to get Ollama models: " .. models, vim.log.levels.ERROR)
    return
  end
  
  if #models == 0 then
    vim.notify("No Ollama models found. Install models with `ollama pull <model>`", vim.log.levels.WARN)
    return
  end

  -- Use dressing.nvim for enhanced UI
  vim.ui.select(models, {
    prompt = "Select Ollama Model",
    format_item = function(item)
      local icons = {
        ["deepseek"] = "🔍",
        ["llama"] = "🦙",
        ["qwen"] = "🌊",
        ["mistral"] = "🌬️",
        ["phi"] = "Φ",
        ["gemma"] = "💎",
        ["mixtral"] = "🌀",
        ["dolphin"] = "🐬",
        ["command"] = "⌨️",
        ["dbrx"] = "🧠",
        ["openchat"] = "💬",
      }
      
      local icon = "" -- Default LLM icon
      -- Match based on base model name (before colon if present)
      local base_name = item:match("^([^:]+)") or item
      for pattern, i in pairs(icons) do
        if base_name:lower():match(pattern) then
          icon = i
          break
        end
      end
      
      return string.format("%s %s", icon, item)
    end,
    kind = "ollama",
  }, function(choice)
    if not choice then return end
    
    -- Escape special characters in model name
    local escaped_choice = choice:gsub("([^%w])", "%1")
    
    -- Validate the provider exists before switching
    local cmd = "AvanteSwitchProvider " .. escaped_choice
    local ok, result = pcall(vim.cmd, cmd)
    if ok then
      vim.notify(string.format("Switched to: %s", choice), vim.log.levels.INFO)
    else
      vim.notify(string.format("Failed to switch to: %s\nError: %s", choice, result), vim.log.levels.ERROR)
    end
  end)
end

return M
