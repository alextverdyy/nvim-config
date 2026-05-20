return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
    'folke/lazydev.nvim',
    'mikavilpas/blink-ripgrep.nvim',
  },
  config = function(_, opts)
    require('blink.cmp').setup(opts)
    pcall(require, 'config.blink-colors')
  end,
  opts = {
    enabled = function()
      return vim.fn.reg_recording() == '' and vim.fn.reg_executing() == ''
    end,
    keymap = { preset = 'enter' },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = { border = 'solid' },
      },
      ghost_text = { enabled = false },
      list = { selection = { preselect = true, auto_insert = true } },
      menu = {
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1, 'kind' },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' '
              end,
            },
            kind = {
              text = function(ctx)
                return '(' .. ctx.kind .. ')'
              end,
              highlight = function(_)
                return 'BlinkCmpCustomType'
              end,
            },
          },
        },
      },
    },
    sources = {
      default = { 'snippets', 'lsp', 'path', 'buffer', 'ripgrep' },
      per_filetype = {
        codecompanion = { 'codecompanion' },
      },
      providers = {
        ripgrep = {
          module = 'blink-ripgrep',
          name = 'Ripgrep',
          score_offset = -2,
          opts = {},
        },
        snippets = { score_offset = 100 },
        lsp = { score_offset = 99, timeout_ms = 500 },
        buffer = {
          transform_items = function(ctx, items)
            local keyword = ctx.get_keyword()
            if not (keyword:match '^%l' or keyword:match '^%u') then
              return items
            end
            local pattern, case_func
            if keyword:match '^%l' then
              pattern = '^%u%l+$'
              case_func = string.lower
            else
              pattern = '^%l+$'
              case_func = string.upper
            end
            local seen, out = {}, {}
            for _, item in ipairs(items) do
              if not item.insertText then goto continue end
              if item.insertText:match(pattern) then
                local text = case_func(item.insertText:sub(1, 1)) .. item.insertText:sub(2)
                item.insertText = text
                item.label = text
              end
              if seen[item.insertText] then goto continue end
              seen[item.insertText] = true
              table.insert(out, item)
              ::continue::
            end
            return out
          end,
        },
      },
    },
    snippets = { preset = 'luasnip' },
    signature = { enabled = true },
  },
}
