local M = {}

---@param name string
function M.get_plugin(name)
	return require("lazy.core.config").spec.plugins[name]
end

---@param name string
function M.opts(name)
	local plugin = M.get_plugin(name)
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end

---@param name string
function M.is_loaded(name)
	local Config = require("lazy.core.config")
	return Config.plugins[name] and Config.plugins[name]._.loaded
end

---@param fn fun()
function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			fn()
		end,
	})
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
	if M.is_loaded(name) then
		fn(name)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end

function M.dedup(list)
	local ret = {}
	local seen = {}
	for _, v in ipairs(list) do
		if not seen[v] then
			table.insert(ret, v)
			seen[v] = true
		end
	end
	return ret
end

function M.safe_keymap_set(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	local modes = type(mode) == "string" and { mode } or mode

	for _, m in ipairs(modes) do
		local lhs_mapped = keys.resolve({ lhs, mode = m }).lhs
		if lhs_mapped then
			vim.keymap.set(m, lhs, rhs, opts)
		end
	end
end

-- LSP utilities
M.lsp = {}

function M.lsp.get_config(server)
	local configs = require("lspconfig.configs")
	return rawget(configs, server)
end

function M.lsp.disable(server, cond)
	local util = require("lspconfig.util")
	local def = M.lsp.get_config(server)
	def.document_config.on_new_config = util.add_hook_before(
		def.document_config.on_new_config,
		function(config, root_dir)
			if cond(root_dir, config) then
				config.enabled = false
			end
		end
	)
end

function M.lsp.on_attach(on_attach, name)
	return vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if name and client.name ~= name then
				return
			end
			return on_attach(client, buffer)
		end,
	})
end

function M.lsp.formatter(opts)
	opts = opts or {}
	local filter = opts.filter or {}
	filter = type(filter) == "string" and { name = filter } or filter
	local ret = {
		name = "LSP",
		primary = true,
		priority = 1,
		format = function(buf)
			M.lsp.format(vim.tbl_deep_extend("force", {
				bufnr = buf,
				filter = function(client)
					if filter.name and client.name ~= filter.name then
						return false
					end
					if filter.method and not client.supports_method(filter.method) then
						return false
					end
					return true
				end,
			}, opts))
		end,
		sources = function(buf)
			local clients = M.lsp.get_clients({ bufnr = buf })
			local ret = vim.tbl_filter(function(client)
				if filter.name and client.name ~= filter.name then
					return false
				end
				if filter.method and not client.supports_method(filter.method) then
					return false
				end
				return true
			end, clients)
			return vim.tbl_map(function(client)
				return client.name
			end, ret)
		end,
	}
	return ret
end

function M.lsp.format(opts)
	opts = vim.tbl_deep_extend("force", {
		timeout_ms = nil,
		format_options = nil,
	}, opts or {})
	local buf = opts.bufnr or vim.api.nvim_get_current_buf()
	local clients = M.lsp.get_clients(vim.tbl_extend("force", opts, { bufnr = buf }))

	if #clients == 0 then
		return
	end

	return vim.lsp.buf.format(vim.tbl_deep_extend("force", {
		bufnr = buf,
		filter = function(client)
			return vim.tbl_contains(
				vim.tbl_map(function(c)
					return c.id
				end, clients),
				client.id
			)
		end,
	}, opts))
end

function M.lsp.get_clients(opts)
	local ret = {}
	if vim.lsp.get_clients then
		ret = vim.lsp.get_clients(opts)
	else
		ret = vim.lsp.get_active_clients(opts)
		if opts and opts.method then
			ret = vim.tbl_filter(function(client)
				return client.supports_method(opts.method, { bufnr = opts.bufnr })
			end, ret)
		end
	end
	return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

-- Format utilities
M.format = {}

M.format.formatters = {}

function M.format.register(formatter)
	M.format.formatters[#M.format.formatters + 1] = formatter
	table.sort(M.format.formatters, function(a, b)
		return a.priority > b.priority
	end)
end

function M.format.resolve(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	local have_primary = false
	for _, formatter in ipairs(M.format.formatters) do
		if formatter.active and formatter.active(buf) then
			if formatter.primary then
				have_primary = true
			end
		end
	end

	local resolve = {}
	for _, formatter in ipairs(M.format.formatters) do
		if formatter.active and formatter.active(buf) then
			if not have_primary or not formatter.primary then
				resolve[#resolve + 1] = formatter
			end
		end
	end
	return resolve
end

function M.format.info(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	local gaf = vim.g.autoformat == nil or vim.g.autoformat
	local baf = vim.b[buf].autoformat
	local enabled = M.format.enabled(buf)
	local lines = {
		"# Status",
		("- [%s] global **%s**"):format(gaf and "x" or " ", gaf and "enabled" or "disabled"),
		("- [%s] buffer **%s**"):format(
			enabled and "x" or " ",
			baf == nil and "inherit" or baf and "enabled" or "disabled"
		),
	}
	local have = false
	for _, formatter in ipairs(M.format.resolve(buf)) do
		if #formatter.sources(buf) > 0 then
			have = true
		end
	end
	if not have then
		lines[#lines + 1] = "\n**No formatters available for this buffer.**"
	else
		lines[#lines + 1] = "\n# Formatters"
		for _, formatter in ipairs(M.format.resolve(buf)) do
			local sources = formatter.sources(buf)
			if #sources > 0 then
				lines[#lines + 1] = "\n## " .. formatter.name
				for _, source in ipairs(sources) do
					lines[#lines + 1] = ("- **%s**"):format(source)
				end
			end
		end
	end

	Snacks.win({
		buf = vim.api.nvim_create_buf(false, true),
		file = "markdown",
		title = "Format Info",
		size = { width = 0.6, height = 0.6 },
		wo = { wrap = false },
	}, function(win)
		vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, lines)
	end)
end

function M.format.enabled(buf)
	buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
	local gaf = vim.g.autoformat
	local baf = vim.b[buf].autoformat

	if baf ~= nil then
		return baf
	end
	return gaf == nil or gaf
end

function M.format.toggle(buf)
	if buf then
		vim.b.autoformat = not M.format.enabled()
	else
		vim.g.autoformat = not M.format.enabled()
		vim.b.autoformat = nil
	end
end

function M.format.format(opts)
	opts = opts or {}
	local buf = opts.buf or vim.api.nvim_get_current_buf()
	if not ((opts and opts.force) or M.format.enabled(buf)) then
		return
	end

	local done = false
	for _, formatter in ipairs(M.format.resolve(buf)) do
		if formatter.active(buf) then
			done = true
			Util.try(function()
				return formatter.format(buf)
			end, { msg = "Formatter `" .. formatter.name .. "` failed" })
		end
	end

	if not done and opts and opts.force then
		Util.warn("No formatter available", { title = "Format" })
	end
end

-- Toggle utilities
M.toggle = {}

function M.toggle.option(option, silent, values)
	if values then
		if vim.opt_local[option]:get() == values[1] then
			vim.opt_local[option] = values[2]
		else
			vim.opt_local[option] = values[1]
		end
		return Snacks.notify.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
	end
	vim.opt_local[option] = not vim.opt_local[option]:get()
	if not silent then
		if vim.opt_local[option]:get() then
			Snacks.notify.info("Enabled " .. option, { title = "Option" })
		else
			Snacks.notify.warn("Disabled " .. option, { title = "Option" })
		end
	end
end

return M
