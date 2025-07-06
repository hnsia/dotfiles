return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = { "lua_ls", "ts_ls" },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    { "neovim/nvim-lspconfig",
      keys={
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Execute a code action" },
      }
    },
  },
}
