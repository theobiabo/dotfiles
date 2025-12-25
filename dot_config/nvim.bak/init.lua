--- ~/.config/nvim/init.lua
-- VSCode-like Neovim with lazy.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Options (VSCode-ish)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.updatetime = 200
vim.opt.cursorline = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.g.mapleader = " "

require("lazy").setup({
  -- UI theme similar to VSCode
  { "Mofiqul/vscode.nvim", priority = 1000, config = function()
      require("vscode").load()
    end },

  -- Statusline
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("lualine").setup({ options = { theme = "vscode" } }) end },

  -- File explorer (like VSCode Explorer)
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({})
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Explorer" })
    end },

  -- Fuzzy finder
  { "nvim-telescope/telescope.nvim", branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local t = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", t.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", t.live_grep,  { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", t.buffers,    { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", t.help_tags,  { desc = "Help" })
    end },

  -- Syntax & code nav
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "json", "javascript", "typescript", "tsx", "python", "rust", "go" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end },

  -- LSP like VSCode
  { "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",:
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "tsserver", "html", "cssls", "jsonls", "lua_ls", "pyright" },
      })
      local lsp = require("lspconfig")
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "K",  vim.lsp.buf.hover,      "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        map("n", "<leader>fd", function() vim.lsp.buf.format({ async = true }) end, "Format")
      end
      -- Lua
      lsp.lua_ls.setup({
        on_attach = on_attach,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })
      -- Generic servers
      for _, server in ipairs({ "tsserver", "html", "cssls", "jsonls", "pyright" }) do
        lsp[server].setup({ on_attach = on_attach })
      end
    end },

  -- Completion & snippets
  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" }, { name = "path" }, { name = "buffer" }, { name = "luasnip" },
        },
      })
    end },

  -- Formatter (Prettier-esque)
  { "stevearc/conform.nvim", config = function()
      require("conform").setup({
        formatters_by_ft = { javascript = { "prettier" }, typescript = { "prettier" }, json = { "prettier" } },
      })
      vim.keymap.set("n", "<leader>fp", function() require("conform").format() end, { desc = "Format file" })
    end },

  -- Integrated terminal toggling
  { "akinsho/toggleterm.nvim", version = "*",
    config = function()
      require("toggleterm").setup({ open_mapping = [[<c-\>]] })
    end },

  -- Debugging (DAP)
  { "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI" })
    end },
})

-- Quality-of-life keymaps (VSCode vibes)
vim.keymap.set("n", "<leader>qq", ":qa<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>ss", ":w<CR>",  { desc = "Save" })
