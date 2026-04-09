local M = {}

local HASH = "abc1234567890abcdef1234567890abcdef123456"
local OTHER = "deadbeef1234567890abcdef1234567890deadbeef"

M.HASH = HASH
M.OTHER = OTHER

--- Build a mock for vim.system that returns canned stdout.
---@param stdout string
---@return function
function M.stub_vim_system(stdout)
  return function()
    return {
      wait = function()
        return { stdout = stdout, code = 0 }
      end,
    }
  end
end

--- Fixture: squash merge (blamed commit IS the merge commit).
function M.fixture_squash()
  return string.format([=[[{"number": 1, "mergeCommit": {"oid": "%s"}, "commits": [{"oid": "%s"}]}]]=], HASH, HASH)
end

--- Fixture: rebase merge (blamed commit is one of .commits[], NOT the mergeCommit).
function M.fixture_rebase()
  return string.format(
    [=[[{"number": 2, "mergeCommit": {"oid": "%s"}, "commits": [{"oid": "%s"}, {"oid": "%s"}]}]]=],
    OTHER,
    "1111111111111111111111111111111111111111",
    HASH
  )
end

--- Fixture: merge commit --no-ff (blamed commit lives inside .commits[]).
function M.fixture_merge_commit()
  return string.format([=[[{"number": 3, "mergeCommit": {"oid": "%s"}, "commits": [{"oid": "%s"}]}]]=], OTHER, HASH)
end

--- Fixture: hash mentioned only in PR body (false positive guard).
function M.fixture_body_only()
  return string.format([=[[{"number": 4, "mergeCommit": {"oid": "%s"}, "commits": [{"oid": "%s"}]}]]=], OTHER, OTHER)
end

--- Fixture: empty search result.
function M.fixture_empty()
  return "[]"
end

--- Run jq filter against JSON fixture via io.popen.
---@param filter string jq filter expression
---@param json string JSON input
---@return string trimmed stdout
function M.run_jq(filter, json)
  local tmp = os.tmpname()
  local f = assert(io.open(tmp, "w"))
  f:write(json)
  f:close()
  local handle = assert(io.popen("jq -r '" .. filter .. "' " .. tmp .. " 2>&1"))
  local out = handle:read("*a")
  handle:close()
  os.remove(tmp)
  return (out:gsub("%s+$", ""))
end

return M
