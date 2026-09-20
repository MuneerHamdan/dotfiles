-- ~/.config/nvim/init.lua

-----------------------------------------------------------
-- Options
-----------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.whichwrap = "h,l"
vim.opt.cursorline = true
-- vim.opt.mouse = "n"
vim.opt.hlsearch = true
vim.opt.wrap = true
vim.opt.linebreak = true

-----------------------------------------------------------
-- Appearance
-----------------------------------------------------------

vim.cmd("highlight Visual cterm=reverse")
vim.cmd("highlight Comment guifg=#FFFFFF")

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------

local map = vim.keymap.set

map("n", "`", "<cmd>NERDTreeToggle<CR>")
map("n", "<leader>w", "<cmd>w<CR>", { silent = true })
map("n", "<Tab>", "<cmd>Outline<CR>", { silent = true })
map("n", "<leader>n", "<cmd>noh<CR>", { silent = true })

map("n", "<leader>tn", "<cmd>tabnew<CR>")
map("n", "<leader>tq", "<cmd>tabclose<CR>", { silent = true })

map("n", "<leader>an", "<cmd>ALENextWrap<CR>", { silent = true })

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------

local plugins = {
  ---------------------------------------------------------
  -- Debugging
  ---------------------------------------------------------

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -------------------------------------------------------
      -- DAP UI
      -------------------------------------------------------

      dapui.setup()

      -------------------------------------------------------
      -- Keymaps
      -------------------------------------------------------

      map("n", "<leader>dt", dap.toggle_breakpoint, {
        desc = "Toggle Breakpoint",
      })

      map("n", "<leader>dc", dap.continue, {
        desc = "Continue",
      })

      map("n", "<leader>dr", dap.repl.open, {
        desc = "Inspect",
      })

      map("n", "<leader>dk", dap.terminate, {
        desc = "Kill",
      })

      map("n", "<leader>dso", dap.step_over, {
        desc = "Step Over",
      })

      map("n", "<leader>dsi", dap.step_into, {
        desc = "Step In",
      })

      map("n", "<leader>dsu", dap.step_out, {
        desc = "Step Out",
      })

      map("n", "<leader>dl", dap.run_last, {
        desc = "Run Last",
      })

      map("n", "<leader>duu", dapui.open, {
        desc = "Open DAP UI",
      })

      map("n", "<leader>duc", dapui.close, {
        desc = "Close DAP UI",
      })

      -------------------------------------------------------
      -- GDB Adapter
      -------------------------------------------------------

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = {
          "--interpreter=dap",
          "--eval-command",
          "set print pretty on",
        },
      }

      -------------------------------------------------------
      -- C Debug Configurations
      -------------------------------------------------------

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",

          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/",
              "file"
            )
          end,

          args = {},
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },

        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",

          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/",
              "file"
            )
          end,

          pid = function()
            local name = vim.fn.input("Executable name (filter): ")

            return require("dap.utils").pick_process({
              filter = name,
            })
          end,

          cwd = "${workspaceFolder}",
        },

        {
          name = "Attach to gdbserver :1234",
          type = "gdb",
          request = "attach",

          target = "localhost:1234",

          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/",
              "file"
            )
          end,

          cwd = "${workspaceFolder}",
        },
      }

      -------------------------------------------------------
      -- Use the same C configurations for C++
      -------------------------------------------------------

      dap.configurations.cpp = dap.configurations.c
    end,
  },

  -----------------------------------------------------------
  -- DAP UI
  -----------------------------------------------------------

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },

  -----------------------------------------------------------
  -- Linting
  -----------------------------------------------------------

  {
    "dense-analysis/ale",
  },

  -----------------------------------------------------------
  -- Outline
  -----------------------------------------------------------

  {
    "hedyhli/outline.nvim",

    config = function()
      require("outline").setup()
    end,
  },

  -----------------------------------------------------------
  -- Colorscheme
  -----------------------------------------------------------

  {
    "fcpg/vim-fahrenheit",

    config = function()
      vim.cmd("colorscheme fahrenheit")
    end,
  },

  -----------------------------------------------------------
  -- Markdown Preview
  -----------------------------------------------------------

  {
    "iamcco/markdown-preview.nvim",

    build = function()
      vim.fn["mkdp#util#install"]()
    end,

    ft = {
      "markdown",
      "vim-plug",
    },
  },

  -----------------------------------------------------------
  -- Bullets
  -----------------------------------------------------------

  {
    "bullets-vim/bullets.vim",

    init = function()
      vim.g.bullets_set_mappings = 0

      vim.g.bullets_custom_mappings = {
        { "imap", "<CR>", "<Plug>(bullets-newline)" },
        { "inoremap", "<C-CR>", "<CR>" },

        { "nmap", "o", "<Plug>(bullets-newline)" },

        { "vmap", "gN", "<Plug>(bullets-renumber)" },
        { "nmap", "gN", "<Plug>(bullets-renumber)" },

        { "nmap", "<leader>x", "<Plug>(bullets-toggle-checkbox)" },

        { "imap", "<Tab>", "<Plug>(bullets-demote)" },
        { "nmap", ">>", "<Plug>(bullets-demote)" },
        { "vmap", ">", "<Plug>(bullets-demote)" },

        { "imap", "<Esc><Tab>", "<Plug>(bullets-promote)" },
        { "nmap", "<<", "<Plug>(bullets-promote)" },
        { "vmap", "<", "<Plug>(bullets-promote)" },
      }
    end,
  },

  -----------------------------------------------------------
  -- NERDTree
  -----------------------------------------------------------

  {
    "preservim/nerdtree",

    init = function()
      vim.g.NERDTreeQuitOnOpen = 1
    end,
  },

  -----------------------------------------------------------
  -- LSP
  -----------------------------------------------------------

  {
    "neovim/nvim-lspconfig",
  },

  -----------------------------------------------------------
  -- Completion
  -----------------------------------------------------------

  {
    "hrsh7th/nvim-cmp",
  },

  {
    "hrsh7th/cmp-nvim-lsp",
  },

  {
    "hrsh7th/cmp-buffer",
  },

  {
    "hrsh7th/cmp-path",
  },

  -----------------------------------------------------------
  -- CoC
  -----------------------------------------------------------

  {
    "neoclide/coc.nvim",
    branch = "release",
  },
}

-----------------------------------------------------------
-- lazy.nvim Bootstrap
-----------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins)

