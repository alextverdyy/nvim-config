-- Xcode helper: version resolver and BSP autoconfig (macOS only)
if vim.fn.has 'mac' == 0 then
  return
end

-- Resolve active Xcode developer path
local function resolve_xcode_path()
  local handle = io.popen 'xcode-select -p 2>/dev/null'
  if handle then
    local path = handle:read '*l'
    handle:close()
    if path and path ~= '' then
      vim.env.DEVELOPER_DIR = path
    end
  end
end
resolve_xcode_path()

-- BSP autoconfig: detect project root for Swift/ObjC files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('xcode-bsp', { clear = true }),
  pattern = { '*.swift', '*.m', '*.mm', '*.h' },
  callback = function(args)
    local root = vim.fs.root(args.buf, { 'Package.swift', '.git', '*.xcodeproj', '*.xcworkspace' })
    if root then
      vim.b[args.buf].project_root = root
    end
  end,
})
