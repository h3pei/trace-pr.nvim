local M = {}

---Build the gh pr command
---@param commit_hash string
---@return table
local function build_gh_pr_command(commit_hash)
  return {
    cmd = {
      "gh",
      "pr",
      "list",
      "-s",
      "merged",
      "-S",
      commit_hash,
      "--limit",
      "1",
      "--json",
      "number",
      "--jq",
      ".[0].number",
    },
    env = {
      NO_COLOR = "1",
      GH_NO_UPDATE_NOTIFIER = "1",
    },
  }
end

---Get the PR number of the commit hash
---@param commit_hash string
---@return string
function M.get(commit_hash)
  local gh_pr_command = build_gh_pr_command(commit_hash)
  local gh_pr_result = vim.system(gh_pr_command.cmd, { env = gh_pr_command.env }):wait()

  -- Remove the trailing newline code by gsub to get the pr number
  return gh_pr_result.stdout:gsub("[\r\n]", "")
end

return M
