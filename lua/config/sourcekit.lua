local swift_lsp = vim.api.nvim_create_augroup("swift_lsp", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "swift" },
  callback = function()
    local root_files = { "Package.swift", ".git" }
    local function has_xcode_project(dir)
      local xcodeproj = vim.fn.globpath(dir, "*.xcodeproj")
      local xcworkspace = vim.fn.globpath(dir, "*.xcworkspace")
      return xcodeproj ~= "" or xcworkspace ~= ""
    end

    local dir = vim.fn.expand("%:p:h")
    local root_dir = nil
    while dir ~= "/" do
      for _, file in ipairs(root_files) do
        if vim.fn.filereadable(dir .. "/" .. file) == 1 then
          root_dir = dir
          break
        end
      end
      if root_dir or has_xcode_project(dir) then
        root_dir = dir
        break
      end
      dir = vim.fn.fnamemodify(dir, ":h")
    end

    if not root_dir then
      root_dir = vim.fn.expand("%:p:h")
    end

    -- Inicia sourcekit-lsp
    local sourcekit_client = vim.lsp.start({
      name = "sourcekit-lsp",
      cmd = { "sourcekit-lsp" },
      root_dir = root_dir,
      inlay_hints = { enabled = false },
    })
    if sourcekit_client then
      vim.lsp.buf_attach_client(0, sourcekit_client)
    end

    -- Inicia xcode-build-server (BSP)
    local xcode_bsp_client = vim.lsp.start({
      name = "xcode-build-server",
      cmd = { "xcode-build-server" },
      root_dir = root_dir,
    })
    if xcode_bsp_client then
      vim.lsp.buf_attach_client(0, xcode_bsp_client)
    end

    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(false)
    end
  end,
  group = swift_lsp,
})
