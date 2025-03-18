local M = {}

-- Словарь для хранения цветов буферов
M.buffer_colors = {}

local color_palette = {
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
}

-- Последний использованный цвет
M.last_used_color = nil

-- Функция для получения случайного цвета из палитры
function M.generate_random_color()
    local color
    repeat
        color = color_palette[math.random(1, #color_palette)]
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

-- Функция для установки стилей буферов
function M.set_buffer_style(group, bg, fg, opts)
    opts = opts or {}
    vim.api.nvim_set_hl(0, group, { bg = bg, fg = fg, bold = opts.bold, italic = opts.italic })
end

-- Функция для обновления цвета буфера в barbar.nvim
function M.update_buffer_color(bufnr)
    local color = M.get_buffer_color(bufnr)
    local tabline_background = "#181926"
    local inactive_bg = "#12111b"
    local inactive_fg = "#eff1f5"
    local target = "#ea76cb"
    local visible_bg = "#737994"

    -- Стили для активного буфера
    local active_styles = {
        { group = 'BufferCurrent', bg = color, fg = tabline_background },
        { group = 'BufferCurrentIcon', bg = color, fg = tabline_background },
        { group = 'BufferCurrentMod', bg = color, fg = tabline_background },
        { group = 'BufferCurrentSign', bg = tabline_background, fg = color },
        { group = 'BufferCurrentSignRight', bg = tabline_background, fg = color },
        { group = 'BufferCurrentTarget', bg = color, fg = tabline_background},
    }

    -- Стили для неактивного буфера
    local inactive_styles = {
        { group = 'BufferInactive', bg = inactive_bg, fg = inactive_fg},
        { group = 'BufferInactiveIcon', bg = inactive_bg, fg = inactive_fg},
        { group = 'BufferInactiveSign', bg = tabline_background, fg = inactive_bg},
        { group = 'BufferInactiveSignRight', bg = tabline_background, fg = inactive_bg},
        { group = 'BufferInactiveTarget', bg = inactive_bg, fg = target},
    }

    -- Стили для видимого буфера
    local visible_styles = {
        { group = 'BufferVisible', bg = visible_bg, fg = tabline_background},
        { group = 'BufferVisibleIcon', bg = visible_bg, fg = tabline_background},
        { group = 'BufferVisibleMod', bg = visible_bg, fg = tabline_background},
        { group = 'BufferVisibleSign', bg = tabline_background, fg = visible_bg },
        { group = 'BufferVisibleSignRight', bg = tabline_background, fg = visible_bg},
        { group = 'BufferVisibleTarget', bg = visible_bg, fg = tabline_background},
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

return M
