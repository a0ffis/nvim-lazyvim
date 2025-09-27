return {
  -- Mason core
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSP bridge
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = { auto_install = true },
  },

  -- LSP config (ใช้ capabilities จาก blink.cmp)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hoffs/omnisharp-extended-lsp.nvim" },
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- ESLint: fix on save + workspaceFolder
      lspconfig.eslint.setup({
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", { buffer = bufnr, command = "EslintFixAll" })
        end,
        on_new_config = function(config, new_root_dir)
          config.settings = config.settings or {}
          config.settings.workspaceFolder = {
            uri = vim.uri_from_fname(new_root_dir),
            name = vim.fn.fnamemodify(new_root_dir, ":t"),
          }
        end,
      })

      -- Lua
      lspconfig.lua_ls.setup({ capabilities = capabilities })

      lspconfig.vtsls.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentHighlightProvider = false
        end,
      })

      -- ---------- Hybrid Vue (Volar + ts_ls) ----------
      local local_ls = vim.fs.find("node_modules/@vue/language-server", { path = vim.loop.cwd(), upward = true })[1]
      local MASON = vim.fn.expand("$MASON")
      if MASON == "" or MASON == "$MASON" then
        MASON = vim.fn.stdpath("data") .. "/mason"
      end
      local vue_language_server = local_ls
        or (MASON .. "/packages/vue-language-server/node_modules/@vue/language-server")

      local function get_tsdk(root_dir)
        local local_ts = vim.fs.find("node_modules/typescript/lib", { path = root_dir, upward = true })[1]
        if local_ts then
          return local_ts
        end
        return vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"
      end

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = { "vue" },
        init_options = {
          hostInfo = "neovim",
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server,
              languages = { "vue" },
            },
          },
        },
      })

      -- Volar: ดูแล .vue (template/HTML/CSS) และ forward คำสั่ง TS ไป ts_ls
      lspconfig.volar.setup({
        capabilities = capabilities,
        filetypes = { "vue" },
        init_options = {
          typescript = { tsdk = get_tsdk(vim.loop.cwd()) },
        },
        on_init = function(client)
          local retries = 0
          local function typescriptHandler(_, result, context)
            local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })[1]
              or vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })[1]
              or vim.lsp.get_clients({ bufnr = context.bufnr, name = "typescript-tools" })[1]

            if not ts_client then
              if retries <= 10 then
                retries = retries + 1
                vim.defer_fn(function()
                  typescriptHandler(_, result, context)
                end, 100)
              else
                vim.notify(
                  "Could not find `vtsls`/`ts_ls`/`typescript-tools` required by `vue_ls`.",
                  vim.log.levels.ERROR
                )
              end
              return
            end

            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
              title = "vue_request_forward",
              command = "typescript.tsserverRequest",
              arguments = { command, payload },
            }, { bufnr = context.bufnr }, function(_, r)
              local response_data = { { id, r and r.body } }
              client:notify("tsserver/response", response_data)
            end)
          end

          client.handlers["tsserver/request"] = typescriptHandler
        end,
      })
      -- ---------- /Hybrid Vue ----------

      -- HTML
      lspconfig.html.setup({
        filetypes = { "html", "ejs" },
        capabilities = capabilities,
      })

      -- CSS
      lspconfig.cssls.setup({ capabilities = capabilities })

      -- Python
      lspconfig.pyright.setup({ capabilities = capabilities })

      -- XML
      lspconfig.lemminx.setup({ capabilities = capabilities })

      -- Prisma
      lspconfig.prismals.setup({ capabilities = capabilities })
    end,
  },
}
