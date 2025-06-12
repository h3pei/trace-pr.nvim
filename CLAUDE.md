# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

trace-pr.nvim is a Neovim plugin that traces Git history for the current line and opens the associated GitHub Pull Request or commit. The plugin is written in Lua and follows a modular architecture.

## Code Architecture

The plugin consists of several modules under `lua/trace-pr/`:

- `init.lua` - Main entry point with `trace_pr()` function and plugin setup
- `config.lua` - Configuration management with default and user settings
- `checker.lua` - Validates requirements (git, gh CLI, git work tree)
- `commit_hash.lua` - Extracts commit hash from git blame for a specific line
- `pr_number.lua` - Queries GitHub API via gh CLI to find PR number for a commit
- `browser.lua` - Opens URLs using gh browse command
- `notifier.lua` - Handles user notifications through vim.notify

## Core Workflow

1. Check requirements (git, gh CLI, inside git repo)
2. Get current file path and line number
3. Run git blame to find commit hash for that line
4. Query gh CLI to find associated merged PR
5. Open PR in browser, or fallback to commit view if configured

## Development Commands

- **Linting**: `stylua .` (configured in stylua.toml with 2-space indentation)
- **Testing**: No test framework detected in codebase

## Dependencies

- git CLI must be installed and in PATH
- gh CLI must be installed and in PATH
- Must be run inside a git repository with GitHub remote

## Configuration

Single configuration option:
- `trace_by_commit_hash_when_pr_not_found` (default: true) - Whether to open commit view when PR not found
