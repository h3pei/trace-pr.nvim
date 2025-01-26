local config = require("trace-pr.config")

local M = {}

---@param pr_number string
local function browse_pr(pr_number)
  vim.system({ "gh", "browse", pr_number })
end

---@param commit_hash string
local function browse_commit(commit_hash)
  vim.system({ "gh", "browse", commit_hash })
end

---Open the Pull Request page or commit page by the "gh browse" command
---@param pr_number string
---@param commit_hash string
---@return nil
function M.browse(pr_number, commit_hash)
  if pr_number ~= "" then
    browse_pr(pr_number)
    return
  end

  if config.trace_by_commit_hash_when_pr_not_found then
    browse_commit(commit_hash)
    return
  end

  vim.notify("[trace-pr.nvim] Pull Request not found.", vim.log.levels.WARN)
end

return M
