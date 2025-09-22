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
  },
}
