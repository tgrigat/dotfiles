-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- { dir = "/home/yang/Documents/git/astrocommunity" },
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.just" },
  { import = "astrocommunity.pack.yaml" },
  -- { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.recipes.neovide" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.recipes.vscode" },
  { import = "astrocommunity.debugging.telescope-dap-nvim" },
  { import = "astrocommunity.completion.cmp-cmdline" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.terminal-integration.toggleterm-manager-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.terminal-integration.flatten-nvim" },
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  { import = "astrocommunity.recipes.heirline-clock-statusline" },
  { import = "astrocommunity.workflow.hardtime-nvim" },
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  { import = "astrocommunity.syntax.vim-easy-align" },
  -- { import = "astrocommunity.note-taking.obsidian-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.code-runner.overseer-nvim"}
  -- { import = "astrocommunity.workflow.precognition-nvim" },

  -- import/override with your plugins folder
}
