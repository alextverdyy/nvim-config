-- QMK keyboard configuration
-- This plugin provides tools for working with QMK firmware in Neovim
-- Disabled by default, enable it if you work with QMK keyboards
-- and want to use Neovim for editing QMK firmware files.
-- You can customize the setup as needed.
-- For more information, refer to the plugin's documentation:
-- --
return {
  'codethread/qmk.nvim',
  config = function()
    require('qmk').setup {
      -- Nombre del layout definido en tu keymap.c
      name = 'LAYOUT',

      -- Tipo de firmware: 'qmk' (por defecto) o 'zmk'
      variant = 'qmk',

      -- Definición visual del layout (filas con alineación)
      layout = {
        '_ x x x x x _ x x x x x _', -- fila superior: qwertyuiop
        '_ x x x x x _ x x x x x _', -- fila media: asdfghjkl;
        'x x x x x x _ x x x x x x', -- fila inferior: qzxcvb nm,./p
        '_ _ _ x x x _ x x x _ _ _', -- fila de espacio: CTRL LOWER SPC | ENT RAISE BSPC
      },

      -- Opciones de previsualización del comentario
      comment_preview = {
        position = 'top', -- 'top', 'bottom', 'inside', 'none'

        -- Reemplazos para claves largas o poco claras
        keymap_overrides = {
          ['LOWER'] = '▽ Lower',
          ['RAISE'] = '△ Raise',
          ['KC_SPC'] = '␣ Space',
          ['KC_BSPC'] = '⌫ Bksp',
          ['KC_DEL'] = '⌦ Del',
          ['KC_SCLN'] = ';',
          ['KC_COMM'] = ',',
          ['KC_DOT'] = '.',
          ['KC_SLSH'] = '/',
          ['KC_LBRC'] = '[',
          ['KC_RBRC'] = ']',
          ['KC_GRV'] = '`',
          ['KC_EQL'] = '=',
        },

        -- Personalización de bordes (opcional)
        symbols = {
          tl = '┌',
          tr = '┐', -- top-left, top-right
          bl = '└',
          br = '┘', -- bottom-left, bottom-right
          vert = '│',
          horz = '─', -- vertical, horizontal
          tm = '┬',
          bm = '┴', -- top, bottom (intersecciones)
          ml = '├',
          mr = '┤', -- left, right (intersecciones)
          mm = '┼', -- middle
        },
      },

      -- Activar auto-formateo al guardar (solo en archivos keymap.c)
      auto_format_pattern = '*.c', -- o "*keymap.c" si quieres ser más específico

      -- Tiempo de notificación en ms (opcional)
      timeout = 3000,
    }
  end,
}
