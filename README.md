# trace-pr.nvim

**trace-pr.nvim** is a Neovim plugin designed to make it easier for developers to trace the Git history of the current line in their code. With this plugin, you can instantly open the nearest Pull Request (PR) on GitHub associated with the line you're working on. If no Pull Request is found, the plugin will open the commit hash instead, streamlining your workflow and saving you precious time.

## Features

- **Locate the nearest Pull Request**: Quickly find the GitHub Pull Request linked to the current line.
- **Fallback to commit view**: If no PR is found, open the commit hash on GitHub for detailed context.

## Requirements

- `git` must be installed and available in your `PATH`
- `gh` must be installed and available in your `PATH`
- A GitHub repository with remote access set up

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ 'mogulla3/trace-pr.nvim' }
```

## Configuration

`trace-pr.nvim` works out of the box with default settings, but you can customize it to suit your needs. Here is an example configuration:

```lua
require('trace-pr').setup {
  -- Whether to trace on commit if PullRequest is not found, e.g. if it is committed directly.
  -- If false, the tracking is terminated with an error message.
  trace_by_commit_hash_when_pr_not_found = true,
}
```

## Usage

Then, you can use the following commands.

|Command|Description|
|:--|:--|
|`:TracePR`|Traces the most recent PullRequest for the current line and opens it with the `gh browse` command|

## How It Works

1. The plugin checks the Git blame information for the current line to identify the commit hash.
2. It queries the GitHub API (via `gh` CLI if available) to locate the associated Pull Request.
3. If a PR is found, the plugin opens it by `gh browse` command. If not, it opens the commit hash view on GitHub.
