local M = {}

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

--- check if the remote origin is github
---@return boolean
local function is_remote_origin_github()
  local result = vim.system({ "git", "remote", "get-url", "origin" }):wait()
  return result.stdout:find("github.com") ~= nil
end

--- check if all requirements are satisfied
---@return boolean
function M.check_requirements()
  if not is_git_installed() then
    vim.notify("[trace-pr.nvim] git is not installed.", vim.log.levels.ERROR)
    return false
  end

  if not is_gh_installed() then
    vim.notify("[trace-pr.nvim] gh is not installed.", vim.log.levels.ERROR)
    return false
  end

  if not is_inside_git_work_tree() then
    vim.notify("[trace-pr.nvim] Not inside a git work tree.", vim.log.levels.ERROR)
    return false
  end

  if not is_remote_origin_github() then
    vim.notify("[trace-pr.nvim] Remote origin is not GitHub.", vim.log.levels.ERROR)
    return false
  end

  return true
end

return M
