return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local ignore_ft = { c = true, cpp = true }
      if ignore_ft[vim.bo[bufnr].filetype] then
        return nil
      end

      -- Hunk-aware format: only reformat changed git hunks when possible
      local ok, gs = pcall(require, 'gitsigns')
      if ok then
        local hunks = gs.get_hunks(bufnr)
        if hunks and #hunks > 0 then
          for i = #hunks, 1, -1 do
            local h = hunks[i]
            if h.added and h.added.count > 0 then
              require('conform').format {
                bufnr = bufnr,
                range = {
                  start = { h.added.start, 0 },
                  ['end'] = { h.added.start + h.added.count - 1, vim.v.maxcol },
                },
                timeout_ms = 500,
                lsp_format = 'fallback',
              }
            end
          end
          return
        end
      end

      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    formatters_by_ft = {
      lua = {},
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
      swift = {},
      ruby = { 'rubocop' },
    },
  },
}
