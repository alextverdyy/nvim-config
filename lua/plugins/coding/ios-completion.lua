-- iOS-specific completions and snippets
if vim.uv.os_uname().sysname == 'Darwin' then
  return {}
end
return {
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local ls = require 'luasnip'
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node

      -- Load existing snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Custom Swift/iOS snippets
      ls.add_snippets('swift', {
        s('viewcontroller', {
          t { 'import UIKit', '', 'class ' },
          i(1, 'ViewController'),
          t { 'ViewController: UIViewController {', '    ', '    override func viewDidLoad() {', '        super.viewDidLoad()', '        ' },
          i(2, '// Setup UI'),
          t { '', '    }', '}' },
        }),

        s('swiftui_view', {
          t { 'import SwiftUI', '', 'struct ' },
          i(1, 'ContentView'),
          t { ': View {', '    var body: some View {', '        ' },
          i(2, 'Text("Hello, World!")'),
          t { '', '    }', '}', '', 'struct ' },
          f(function(args)
            return args[1][1]
          end, { 1 }),
          t { '_Previews: PreviewProvider {', '    static var previews: some View {', '        ' },
          f(function(args)
            return args[1][1]
          end, { 1 }),
          t { '()', '    }', '}' },
        }),

        s('outlet', {
          t '@IBOutlet weak var ',
          i(1, 'myOutlet'),
          t ': ',
          i(2, 'UILabel'),
          t '!',
        }),

        s('action', {
          t '@IBAction func ',
          i(1, 'myAction'),
          t '(_ sender: ',
          i(2, 'UIButton'),
          t { ') {', '    ' },
          i(3, '// Action code'),
          t { '', '}' },
        }),

        s('tableview_cell', {
          t {
            'func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {',
            '    let cell = tableView.dequeueReusableCell(withIdentifier: "',
          },
          i(1, 'cellIdentifier'),
          t { '", for: indexPath)', '    ' },
          i(2, '// Configure cell'),
          t { '', '    return cell', '}' },
        }),

        s('delegate', {
          t '// MARK: - ',
          i(1, 'ProtocolName'),
          t { ' Delegate', '', 'extension ' },
          i(2, 'ClassName'),
          t ': ',
          f(function(args)
            return args[1][1]
          end, { 1 }),
          t { ' {', '    ' },
          i(3, '// Delegate methods'),
          t { '', '}' },
        }),
      })

      -- Configure LuaSnip
      ls.config.set_config {
        history = true,
        updateevents = 'TextChanged,TextChangedI',
        enable_autosnippets = true,
      }

      -- LuaSnip keymaps
      vim.keymap.set({ 'i', 's' }, '<C-l>', function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { desc = 'Expand or jump snippet' })

      vim.keymap.set({ 'i', 's' }, '<C-h>', function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { desc = 'Jump backwards in snippet' })
    end,
  },
}
