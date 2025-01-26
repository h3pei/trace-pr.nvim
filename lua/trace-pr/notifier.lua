local M = {}
local prefix = "[trace-pr.nvim]"

local function notify(message, level)
  vim.notify(prefix .. " " .. message:gsub("[\n]", ""), level)
end

function M.warn(message)
  notify(message, vim.log.levels.WARN)
end

function M.error(message)
  notify(message, vim.log.levels.ERROR)
end

return M
