local config = require("trace-pr.config")

local M = {}

function M.trace_pr()
  local current_buf_path = vim.api.nvim_buf_get_name(0)
  local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
  local commit_hash = require("trace-pr.commit_hash").get(current_buf_path, current_line_num)
  local pr_number = require("trace-pr.pr_number").get(commit_hash)

  require("trace-pr.browser").browse(pr_number, commit_hash)
end

function M.setup(user_config)
  user_config = user_config or {}
  config.setup(user_config)

  vim.cmd("command! TracePR lua require('trace-pr').trace_pr()<CR>")
end

return M
