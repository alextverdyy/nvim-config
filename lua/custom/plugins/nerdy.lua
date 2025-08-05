-- nerdy_snack.lua
return {
  -- Plugin principal
  {
    '2KAbhishek/nerdy.nvim',
    dependencies = { 'folke/snacks.nvim' },
    config = function()
      local nerdy = require 'nerdy'
      local snacks = require 'snacks'

      -- Función para abrir el picker
      local function open_nerdy_picker()
        local icon_list = require 'nerdy.icons'
        local list_titie = 'Nerdy Icons'
        vim.ui.select(icon_list, {
          prompt = list_titie,
          format_item = function(item)
            local item_str = string.format('%s (%s) : %s', item.name, item.code, item.char)
            return item_str
          end,
        }, function(item, _)
          if item ~= nil then
            vim.fn.setreg('+', item.name)
          end
        end)
      end

      -- Comando para abrirlo fácilmente
      vim.api.nvim_create_user_command('NerdyPicker', open_nerdy_picker, {})
    end,
  },
}
