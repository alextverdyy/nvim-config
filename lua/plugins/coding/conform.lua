-- Autoformat buffer on save using conform.nvim.
-- Uses stylua for Lua and ruff for Python. C/C++ are excluded from autoformat.
-- Press <leader><leader>f to manually format the buffer.
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      python = { 'ruff_fix', 'ruff_format' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      go = { 'gofmt' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      bash = { 'shfmt' },
      fish = { 'fish_indent' },
      zsh = {},
      swift = {},
      lua = {},
      ruby = { 'rubocop' },
    },
  },
}
