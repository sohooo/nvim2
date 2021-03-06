require("trouble").setup {
  -- settings without a patched font or icons
  fold_open = "v", -- icon used for open folds
  fold_closed = ">", -- icon used for closed folds
  indent_lines = false, -- add an indent guide below the fold icons
  icons = false, -- requires nvim-web-devicons
  signs = {
      -- icons / text used for a diagnostic
      error = "error",
      warning = "warn",
      hint = "hint",
      information = "info"
  },
  use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

