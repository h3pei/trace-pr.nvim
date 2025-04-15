local M = {}
local notifier = require("trace-pr.notifier")

--- check if git is installed
---@return boolean
local function is_git_installed()
  return vim.fn.executable("git") == 1
end

--- check if gh is installed
---@return boolean
local function is_gh_installed()
  return vim.fn.executable("gh") == 1
end

--- check if the current directory is inside git work tree
---@return boolean
local function is_inside_git_work_tree()
  local result = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }):wait()
  return result.stdout:gsub("[\r\n]", "") == "true"
end

--- check if all requirements are satisfied
---@return boolean
function M.check_requirements()
  if not is_git_installed() then
    notifier.error("git is not installed.")
    return false
  end

  if not is_gh_installed() then
    notifier.error("gh is not installed.")
    return false
  end

  if not is_inside_git_work_tree() then
    notifier.error("Not inside a git work tree.")
    return false
  end

  return true
end

return M
