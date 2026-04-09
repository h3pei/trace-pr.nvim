local helpers = require("tests.helpers")
local pr_number = require("trace-pr.pr_number")

describe("pr_number", function()
  local original_vim_system

  before_each(function()
    original_vim_system = vim.system
  end)

  after_each(function()
    vim.system = original_vim_system
  end)

  describe("jq filter", function()
    local function get_jq_filter(hash)
      local cmd = pr_number._build_gh_pr_command(hash).cmd
      return cmd[#cmd]
    end

    it("should match squash merge (mergeCommit.oid == blamed hash)", function()
      local filter = get_jq_filter(helpers.HASH)
      local result = helpers.run_jq(filter, helpers.fixture_squash())
      assert.are.equal("1", result)
    end)

    it("should match rebase merge (commits[].oid == blamed hash)", function()
      local filter = get_jq_filter(helpers.HASH)
      local result = helpers.run_jq(filter, helpers.fixture_rebase())
      assert.are.equal("2", result)
    end)

    it("should match merge commit (commits[].oid == blamed hash)", function()
      local filter = get_jq_filter(helpers.HASH)
      local result = helpers.run_jq(filter, helpers.fixture_merge_commit())
      assert.are.equal("3", result)
    end)

    it("should not match when hash is only in PR body (false positive guard)", function()
      local filter = get_jq_filter(helpers.HASH)
      local result = helpers.run_jq(filter, helpers.fixture_body_only())
      assert.are.equal("", result)
    end)

    it("should return empty for no search results", function()
      local filter = get_jq_filter(helpers.HASH)
      local result = helpers.run_jq(filter, helpers.fixture_empty())
      assert.are.equal("", result)
    end)
  end)

  describe("get", function()
    it("should parse a single PR number", function()
      vim.system = helpers.stub_vim_system("42\n")
      assert.are.equal(42, pr_number.get(helpers.HASH))
    end)

    it("should return nil for empty stdout", function()
      vim.system = helpers.stub_vim_system("")
      assert.is_nil(pr_number.get(helpers.HASH))
    end)

    it("should return the first PR number when multiple match", function()
      vim.system = helpers.stub_vim_system("7\n8\n")
      assert.are.equal(7, pr_number.get(helpers.HASH))
    end)
  end)
end)
