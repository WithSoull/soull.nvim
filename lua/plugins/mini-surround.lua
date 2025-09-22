-- Add, Change, Delete Surrounding Chars (["''"])
return {
  'nvim-mini/mini.surround',
  version = false, -- для main ветки
  config = function()
    require('mini.surround').setup()
  end
}

