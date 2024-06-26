local M = {}

local config = require("arrow.config")

function M.join_two_keys_tables(tableA, tableB)
	local newTable = {}

	for k, v in pairs(tableA) do
		newTable[k] = v
	end

	for k, v in pairs(tableB) do
		newTable[k] = v
	end

	return newTable
end

function M.join_two_arrays(tableA, tableB)
	local newTable = {}

	for _, v in ipairs(tableA) do
		table.insert(newTable, v)
	end

	for _, v in ipairs(tableB) do
		table.insert(newTable, v)
	end

	return newTable
end

function M.get_current_buffer_path()
    return M.get_buffer_path(vim.api.nvim_get_current_buf())
end

function M.get_buffer_path(bufnr)
    local bufname = vim.fn.bufname(bufnr)
    local absolute_buffer_path = vim.fn.fnamemodify(bufname, ":p")

    local save_key = config.getState("save_key_cached")
    local escaped_save_key = save_key:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")

    if absolute_buffer_path:find("^" .. escaped_save_key .. "/") then
        local relative_path = absolute_buffer_path:gsub("^" .. escaped_save_key .. "/", "")
        return relative_path
    else
        return absolute_buffer_path
    end
end

function M.string_contains_whitespace(str)
	return string.match(str, "%s") ~= nil
end

return M
