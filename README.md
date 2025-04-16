# trace-pr.nvim

https://github.com/user-attachments/assets/74fadf13-fcbd-40de-b549-6c2a630f732e

**trace-pr.nvim** is a Neovim plugin designed to make it easier for developers to trace the Git history of the current line in their code. With this plugin, you can instantly open the nearest Pull Request (PR) on GitHub associated with the line you're working on. If no Pull Request is found, the plugin will open the commit hash instead, streamlining your workflow and saving you precious time.

## Features

- **Locate the nearest Pull Request**: Quickly find the GitHub Pull Request linked to the current line, regardless of whether it was merged using the `Create a merge commit` method or the `Squash and merge` method.
- **Fallback to commit view**: If no PR is found, open the commit hash on GitHub for detailed context. This behavior is configurable.

## Requirements

- `git` must be installed and available in your `PATH`
- [`gh`](https://github.com/cli/cli#installation) must be installed and available in your `PATH`
- A GitHub repository with remote access set up

## Installation

Install the plugin with your package manager:

[lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ "h3pei/trace-pr.nvim", config = true }
```

## Usage

Then, you can use the following commands.

|Command|Description|
|:--|:--|
|`:TracePR`|Traces the most recent Pull Request for the current line and opens it with the [`gh browse`](https://cli.github.com/manual/gh_browse) command|

## Configuration

`trace-pr.nvim` works out of the box with default settings, but you can customize it to suit your needs. Here is an example configuration:

```lua
require('trace-pr').setup({
  -- Whether to trace on commit if Pull Request is not found, e.g. if it is committed directly.
  -- If false, the tracking is terminated with an warning message.
  -- Default: false
  trace_by_commit_hash_when_pr_not_found = true,
})
```

## How It Works

1. The plugin checks the Git blame information for the current line to identify the commit hash.
2. It queries the GitHub API (via `gh` CLI if available) to locate the associated Pull Request.
3. If a PR is found, the plugin opens it by `gh browse` command. If not, it opens the commit hash view on GitHub.
