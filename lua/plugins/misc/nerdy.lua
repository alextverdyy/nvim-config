-- Nerdy icons picker
return {
  '2KAbhishek/nerdy.nvim',
  config = function()
    local nerdy = require 'nerdy'


    local function open_nerdy_picker()
      local icon_list = require 'nerdy.icons'
      local list_title = 'Nerdy Icons'
      vim.ui.select(icon_list, {
        prompt = list_title,
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

    vim.api.nvim_create_user_command('NerdyPicker', open_nerdy_picker, {})
  end,
}
