
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
  { key = "s", cb = tree_cb("vsplit") },
  { key = "i", cb = tree_cb("split") },
  { key = "t", cb = tree_cb("tabnew") },
  { key = "?", cb = tree_cb("toggle_help") },
}

