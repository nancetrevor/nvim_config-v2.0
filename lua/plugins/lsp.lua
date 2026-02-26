return {
  { "williamboman/mason.nvim", cmd = "Mason", opts = {} },

  { "williamboman/mason-lspconfig.nvim", dependencies = { "mason.nvim" }, opts = {} },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "html", "cssls", "ts_ls" },
        automatic_installation = true,
      })

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true })
        end
        map("n", "gd", vim.lsp.buf.definition)
        map("n", "gr", "<cmd>Telescope lsp_references<cr>")
        map("n", "K",  vim.lsp.buf.hover)
        map("n", "<leader>rn", vim.lsp.buf.rename)
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      vim.diagnostic.config({
        float = { border = "rounded" },
      })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
      )

      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      vim.lsp.config("pyright", { on_attach = on_attach, capabilities = capabilities })
      vim.lsp.config("html",    { on_attach = on_attach, capabilities = capabilities })
      vim.lsp.config("cssls",   { on_attach = on_attach, capabilities = capabilities })
      vim.lsp.config("ts_ls",   { on_attach = on_attach, capabilities = capabilities }) -- JS/TS

      vim.lsp.enable({ "lua_ls", "pyright", "html", "cssls", "ts_ls" })
    end,
  },
}
