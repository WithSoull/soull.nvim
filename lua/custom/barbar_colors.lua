local M = {}

-- Словарь для хранения цветов буферов
M.buffer_colors = {}

-- Палитры акцентных цветов для каждой темы
local palettes = {
  mocha = {
    "#cba6f7", -- Mauve
    "#f38ba8", -- Red
    "#eba0ac", -- Maroon
    "#fab387", -- Peach
    "#f9e2af", -- Yellow
    "#a6e3a1", -- Green
    "#94e2d5", -- Teal
    "#89dceb", -- Sky
    "#74c7ec", -- Sapphire
    "#89b4fa", -- Blue
  },
  latte = {
    "#8839ef", -- Mauve
    "#d20f39", -- Red
    "#e64553", -- Maroon
    "#fe640b", -- Peach
    "#df8e1d", -- Yellow
    "#40a02b", -- Green
    "#179299", -- Teal
    "#04a5e5", -- Sky
    "#209fb5", -- Sapphire
    "#1e66f5", -- Blue
  },
}

-- Фоновые цвета для каждой темы
local theme_bg = {
  mocha = {
    tabline    = "#181926",
    inactive   = "#12111b",
    inactive_fg = "#eff1f5",
    target     = "#ea76cb",
    visible    = "#737994",
  },
  latte = {
    tabline    = "#e6e9ef",
    inactive   = "#dce0e8",
    inactive_fg = "#4c4f69",
    target     = "#ea76cb",
    visible    = "#acb0be",
  },
}

-- Определение текущей темы
local function get_flavor()
  local ok, catppuccin = pcall(require, 'catppuccin')
  if ok and catppuccin.flavour then
    return catppuccin.flavour
  end
  return vim.o.background == "light" and "latte" or "mocha"
end

-- Последний использованный цвет
M.last_used_color = nil

-- Функция для получения случайного цвета из палитры
function M.generate_random_color()
    local palette = palettes[get_flavor()] or palettes.mocha
    local color
    repeat
        color = palette[math.random(1, #palette)]
    until color ~= M.last_used_color -- Убедимся, что цвет не совпадает с предыдущим
    M.last_used_color = color
    return color
end

-- Функция для получения цвета буфера
function M.get_buffer_color(bufnr)
    -- Если буфер уже имеет цвет, возвращаем его
    if M.buffer_colors[bufnr] then
        return M.buffer_colors[bufnr]
    end

    -- Иначе генерируем новый цвет и сохраняем его
    local color = M.generate_random_color()
    M.buffer_colors[bufnr] = color
    return color
end

-- Сброс цветов при смене темы (чтобы пересгенерировались из новой палитры)
function M.reset_colors()
    M.buffer_colors = {}
    M.last_used_color = nil
end

-- Функция для установки стилей буферов
function M.set_buffer_style(group, bg, fg, opts)
    opts = opts or {}
    vim.api.nvim_set_hl(0, group, { bg = bg, fg = fg, bold = opts.bold, italic = opts.italic })
end

-- Функция для обновления цвета буфера в barbar.nvim
function M.update_buffer_color(bufnr)
    local color = M.get_buffer_color(bufnr)
    local bg = theme_bg[get_flavor()] or theme_bg.mocha

    -- Стили для активного буфера
    local active_styles = {
        { group = 'BufferCurrent', bg = color, fg = bg.tabline },
        { group = 'BufferCurrentIcon', bg = color, fg = bg.tabline },
        { group = 'BufferCurrentMod', bg = color, fg = bg.tabline },
        { group = 'BufferCurrentSign', bg = bg.tabline, fg = color },
        { group = 'BufferCurrentSignRight', bg = bg.tabline, fg = color },
        { group = 'BufferCurrentTarget', bg = color, fg = bg.tabline},
    }

    -- Стили для неактивного буфера
    local inactive_styles = {
        { group = 'BufferInactive', bg = bg.inactive, fg = bg.inactive_fg},
        { group = 'BufferInactiveIcon', bg = bg.inactive, fg = bg.inactive_fg},
        { group = 'BufferInactiveSign', bg = bg.tabline, fg = bg.inactive},
        { group = 'BufferInactiveSignRight', bg = bg.tabline, fg = bg.inactive},
        { group = 'BufferInactiveTarget', bg = bg.inactive, fg = bg.target},
    }

    -- Стили для видимого буфера
    local visible_styles = {
        { group = 'BufferVisible', bg = bg.visible, fg = bg.tabline},
        { group = 'BufferVisibleIcon', bg = bg.visible, fg = bg.tabline},
        { group = 'BufferVisibleMod', bg = bg.visible, fg = bg.tabline},
        { group = 'BufferVisibleSign', bg = bg.tabline, fg = bg.visible },
        { group = 'BufferVisibleSignRight', bg = bg.tabline, fg = bg.visible},
        { group = 'BufferVisibleTarget', bg = bg.visible, fg = bg.tabline},
    }

    -- Применяем стили
    for _, style in ipairs(active_styles) do
        M.set_buffer_style(style.group, style.bg, style.fg)
    end

    for _, style in ipairs(inactive_styles) do
        M.set_buffer_style(style.group, style.bg, style.fg)
    end

    for _, style in ipairs(visible_styles) do
        M.set_buffer_style(style.group, style.bg, style.fg)
    end
end

-- Автоматическое обновление цвета при открытии нового буфера
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function(args)
        local bufnr = args.buf
        M.update_buffer_color(bufnr)
    end,
})

-- Пересоздание цветов при смене colorscheme
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        M.reset_colors()
        -- Обновить текущий буфер
        local bufnr = vim.api.nvim_get_current_buf()
        M.update_buffer_color(bufnr)
    end,
})

return M
