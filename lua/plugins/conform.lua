return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Disable notify_on_error
      opts.notify_on_error = false

      -- Your formatters by filetype
      opts.formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        go = { "gofmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        bash = { "shfmt" },
        fish = { "fish_indent" },
        zsh = {},
        swift = { "swiftformat" },
        lua = {},
        ruby = { "rubocop" },
      }

      return opts
    end,
  },
}
