local M = {}

function M.on_attach(client, buffer)
	local self = M.new(client, buffer)

	self:map("gd", "Lsp.definition", "Go to Definition")
	self:map("gr", "Lsp.references", "References")
	self:map("gD", "Lsp.declaration", "Go to Declaration")
	self:map("gI", "Lsp.implementation", "Go to Implementation")
	self:map("gy", "Lsp.type_definition", "Go to T[y]pe Definition")
	self:map("K", vim.lsp.buf.hover, "Hover")
	self:map("gK", vim.lsp.buf.signature_help, "Signature Help")
	self:map("<c-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
	self:map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })

	local format = require("utils").format.format
	self:map("<leader>cf", format, "Format Document", { "n", "v" })
	self:map("<leader>cf", function()
		format({ force = true })
	end, "Format Document", { "n", "v" })

	if vim.fn.has("nvim-0.10") == 1 then
		self:map("grn", vim.lsp.buf.rename, "Rename")
		self:map("<leader>cr", vim.lsp.buf.rename, "Rename")
		self:map("gra", vim.lsp.buf.code_action, "Code Action")
	else
		self:map("<leader>cr", vim.lsp.buf.rename, "Rename")
	end

	-- Diagnostics
	self:map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
	self:map("]d", M.diagnostic_goto(true), "Next Diagnostic")
	self:map("[d", M.diagnostic_goto(false), "Prev Diagnostic")
	self:map("]e", M.diagnostic_goto(true, "ERROR"), "Next Error")
	self:map("[e", M.diagnostic_goto(false, "ERROR"), "Prev Error")
	self:map("]w", M.diagnostic_goto(true, "WARN"), "Next Warning")
	self:map("[w", M.diagnostic_goto(false, "WARN"), "Prev Warning")

	local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

	if inlay_hint then
		require("inlay-hints").on_attach(client, buffer)
	end
end

function M.new(client, buffer)
	return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(method)
	method = method:find("/") and method or "textDocument/" .. method
	local clients = require("utils").lsp.get_clients({ bufnr = self.buffer })
	for _, client in ipairs(clients) do
		if client.supports_method(method) then
			return true
		end
	end
	return false
end

function M:map(lhs, rhs, desc, mode)
	mode = mode or "n"
	local opts = { buffer = self.buffer, desc = desc }
	vim.keymap.set(mode, lhs, rhs, opts)
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
