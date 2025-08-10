local overseer = require 'overseer'

overseer.register_template {
  name = 'Run C file',
  desc = 'Compile current C file and run the output',
  tags = { overseer.TAG.BUILD, overseer.TAG.RUN },
  condition = {
    filetype = { 'c' },
  },
  builder = function()
    local source_file = vim.fn.expand '%:p'
    local output_file = vim.fn.expand '%:t:r' .. '.out'
    local cwd = vim.fn.expand '%:p:h'
    return {
      name = 'gcc build & run',
      cmd = 'bash',
      args = {
        '-c',
        string.format('gcc *.c -o "%s" -lSDL2 -lm -lSDL2_ttf && "./%s"', output_file, output_file),
      },
      cwd = cwd,
      components = { 'default' },
    }
  end,
}

vim.api.nvim_create_user_command('RunC', function()
  overseer.run_template { name = 'Run C file' }
end, {})
