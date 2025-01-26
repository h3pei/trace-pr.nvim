local M = {}

---Build the git blame command
---@param path string
---@param line_num number
---@return table
local function build_git_blame_command(path, line_num)
  return {
    cmd = {
      "git",
      "blame",
      "-s", -- Suppress the author name and timestamp from the output
      "-L",
      line_num .. "," .. line_num,
      "--",
      path,
    },
  }
end

---Get the commit hash of the line
---@param path string
---@param line_num number
---@return string|nil # The commit hash of the line. If failed, return nil.
function M.get(path, line_num)
  local git_blame_command = build_git_blame_command(path, line_num)
  local git_blame_result = vim.system(git_blame_command.cmd, { text = true }):wait()

  if git_blame_result.code ~= 0 then
    require("trace-pr.notifier").error("[" .. git_blame_result.code .. "] " .. git_blame_result.stderr)
    return nil
  end

  -- Remove the leading caret (^) and return the commit hash
  -- Commit called "boundary commit" is prefixed with a caret mark(^).
  return vim.split(git_blame_result.stdout, " ")[1]:gsub("^%^", "")
end

return M
