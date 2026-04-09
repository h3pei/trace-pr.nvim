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
      "--json",
      "number,mergeCommit,commits",
      "--jq",
      ".[] | select(.mergeCommit.oid == \""
        .. commit_hash
        .. "\" or any(.commits[]; .oid == \""
        .. commit_hash
        .. "\")) | .number",
    },
    env = {
      NO_COLOR = "1",
      GH_NO_UPDATE_NOTIFIER = "1",
    },
  }
end

---Get the PR number of the commit hash
---@param commit_hash string
---@return number? # The PR number of the commit hash. If PR not found, return nil.
function M.get(commit_hash)
  local gh_pr_command = build_gh_pr_command(commit_hash)
  local gh_pr_result = vim.system(gh_pr_command.cmd, { env = gh_pr_command.env, text = true }):wait()

  -- Take the first line only (multiple PRs may match in rare cases) and strip newline
  local pr_number = gh_pr_result.stdout:match("[^\n]+") or ""

  return tonumber(pr_number)
end

return M
