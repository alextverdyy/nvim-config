-- Disable QMK
if true then
  return {}
end
return {
  'codethread/qmk.nvim',
  lazy = false,
  config = function()
    local conf = {
      name = 'LAYOUT',
      comment_preview = {
        keymap_overrides = {
          CKC_S = 'Magic', -- replace any long key codes
        },
      },
      layout = {
        '_ x x x x x _ x x x x x _',
        '_ x x x x x _ x x x x x _',
        'x x x x x x _ x x x x x x',
        '_ _ _ x x x _ x x x _ _ _',
      },
    }
    require('qmk').setup(conf)
  end,
}
