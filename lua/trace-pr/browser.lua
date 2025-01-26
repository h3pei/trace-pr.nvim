local M = {}

---@param pr_number string
---@return nil
function M.browse_pr(pr_number)
  vim.system({ "gh", "browse", pr_number })
end

---@param commit_hash string
---@return nil
function M.browse_commit(commit_hash)
  vim.system({ "gh", "browse", commit_hash })
end

return M
