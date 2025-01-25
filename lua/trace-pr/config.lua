local config = {}

local default_config = {
  -- Whether to trace on commit if Pull Request is not found, e.g. if it is committed directly.
  trace_by_commit_hash_when_pr_not_found = true,
}

local Config = {}

function Config.setup(user_config)
  config = vim.tbl_deep_extend("force", default_config, user_config)
end

setmetatable(Config, {
  __index = function(_, key)
    return config[key]
  end,
})

return Config
