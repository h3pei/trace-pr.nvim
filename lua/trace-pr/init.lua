local config = require("trace-pr.config")

local M = {}

local function define_commands()
  vim.cmd("command! TracePR lua require('trace-pr').trace_pr()<CR>")
end

function M.trace_pr()
  local is_valid = require('trace-pr.checker').check_requirements()
  if not is_valid then
    return
  end

  local current_buf_path = vim.api.nvim_buf_get_name(0)
  local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
  local commit_hash = require("trace-pr.commit_hash").get(current_buf_path, current_line_num)
  if commit_hash == nil then
    return
  end

  local pr_number = require("trace-pr.pr_number").get(commit_hash)

  require("trace-pr.browser").browse(pr_number, commit_hash)
end

function M.setup(user_config)
  user_config = user_config or {}
  config.setup(user_config)

  define_commands()
end

return M
