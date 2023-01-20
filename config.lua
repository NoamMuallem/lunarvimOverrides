--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "onedark_dark"
lvim.builtin.nvimtree.setup.auto_reload_on_write = true;
vim.opt.relativenumber = true;
vim.opt.number = true;
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.insert_mode["jj"] = "<Esc>"

lvim.keys.normal_mode["<"] = "<C-i>"
lvim.keys.normal_mode[">"] = "<C-o>"
--yank visualy selected to clipboard
lvim.keys.visual_mode["<Leader>y"] = '"*y'
lvim.keys.normal_mode["<Leader>p"] = '"0p'
lvim.keys.visual_mode["<Leader>P"] = '"0P'
--insert new line without going into insert mode
lvim.keys.normal_mode["<leader>k"] = ":<c-u>put!=repeat([''],v:count)<bar>']+1<cr>"
lvim.keys.normal_mode["<leader>j"] = ":<c-u>put =repeat([''],v:count)<bar>'[-1<cr>"

-- open telescope file fuzzy finder on leader leader
lvim.keys.normal_mode["<leader><leader>"] = ":Telescope find_files<cr>"

-- map m anf M to ; and ,
lvim.keys.normal_mode["m"] = ";"
lvim.keys.normal_mode["M"] = ","
lvim.keys.visual_mode["m"] = ";"
lvim.keys.visual_mode["M"] = ","

--diff view
lvim.keys.normal_mode["<leader>d"] = ":DiffviewOpen<cr>";

-- leap
lvim.keys.normal_mode["<leader>n"] = "<Plug>(leap-forward-to)"
lvim.keys.normal_mode["<leader>N"] = "<Plug>(leap-backward-to)"
local Terminal                     = require('toggleterm.terminal').Terminal
local tmux                         = Terminal:new({ cmd = "tmux attach || tmux", hidden = false, direction = "float" })
function _tmux_toggle()
  tmux:toggle()
end

lvim.keys.normal_mode["<leader>\\"] = "<cmd>lua _tmux_toggle()<CR>"

--undo tree
lvim.keys.normal_mode["<leader>uu"] = ":UndotreeToggle<CR>"


-- remap m to z to set marks with
lvim.keys.normal_mode["z"] = "m"

-- Clear search with <esc>
lvim.keys.normal_mode["<esc>"] = ":noh<cr>"

-- prevent nvimtree to close lunarvim  on close if only the nvimtree buffer is open
vim.o.confirm = true
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
        and layout[3] == nil then vim.cmd("quit") end
  end
})
vim.opt.clipboard = nil
vim.opt.cmdheight = 0;

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettierd",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

local actions = require "lvim.lsp.null-ls.code_actions"
actions.setup {
  actions.eslint_d,
  actions.cspell,
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python", "typescript", "javascriptreact", "typescriptreact" },
  },
}

-- cspell
local null_ls = require("null-ls")
null_ls.register({
  null_ls.builtins.diagnostics.cspell.with({
    diagnostics_postprocess = function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.INFO
    end,
  }),
})

lvim.lsp.diagnostics.update_in_insert = true
lvim.lsp.diagnostics.underline = true
lvim.lsp.diagnostics.severity_sort = true

lvim.lsp.diagnostics.virtual_text = {
  source = "always",
  prefix = '🐛',
}

lvim.lsp.diagnostics.virtual_text = {
  severity = { min = vim.diagnostic.severity.WARN }
}

lvim.lsp.diagnostics.underline = {
  severity = { max = vim.diagnostic.severity.INFO }
}

-- Additional Plugins
lvim.plugins = {
  {
    "ggandor/leap.nvim",
    config = function()
      require('leap').setup({})
    end
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("diffview").setup({})
    end,
  },
  {
    "TimUntersberger/neogit",
    module = "neogit",
    cmd = "Neogit",
    config = function()
      require("neogit").setup({
        kind = "tab",
        signs = {
          -- { CLOSED, OPENED }
          section = { "", "" },
          item = { "", "" },
          hunk = { "", "" },
        },
        integrations = { diffview = true },
      })
    end,
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPre",
    config = function()
      require("scrollbar").setup({
        handle = {
          color = "#33373E",
        },
        marks = {
          Search = { color = "#d19a66" },
          Error = { color = "#e06c75" },
          Warn = { color = "#e5c07b" },
          Info = { color = "#56b6c2" },
          Misc = { color = "#c678dd" },
        }
      })
    end
  },
  {
    'mbbill/undotree',
    cmd = "UndotreeToggle",
    config = function()
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
      vim.opt.undofile = true
    end
  },
  {
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npm run compile",
    config = function()
      require("plugin.dap.lua")
    end
  },
  {
    "olimorris/onedarkpro.nvim"
  },
}


-- dap.configurations.typescriptreact = {
--   {
--     command = "npm run dev",
--     name = "run npm run dev",
--     request = "launch",
--     type = "node-terminal",
--     cwd = "${workspaceFolder}/src/frontend"
--   },
--   {
--     name = "Attach by process id",
--     processId = "${command:PickProcess}",
--     request = "attach",
--     type = "node"
--   }
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
