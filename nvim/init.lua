-- Put this file content into
-- :e ~\AppData\Local\nvim\init.lua
-- :e ~/.conig/init.lua

-- Clear configs:
-- rm -rf ~/.local/share/nvim/; rm -rf ~/.local/state/nvim/; rm -rf  ~/.config/nvim/; mkdir ~/.config/nvim/
------------------------------------------------------------------------------------------------
-- Keymap
-- vim.keymap.set('n', '<leader>pv', vim.cmd('Explore'))
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')


vim.keymap.set('x', '<leader>p', '\'_dP')

vim.keymap.set('n', '<leader>y', '\'+y')
vim.keymap.set('v', '<leader>y', '\'+y')
vim.keymap.set('n', '<leader>Y', '\'+Y')

vim.keymap.set('n', '<leader>d', '\'_d')
vim.keymap.set('v', '<leader>d', '\'_d')

-- CTRL-S for saving
vim.keymap.set('i', '<C-s>', '<ESC>:w<ENTER>a')
vim.keymap.set('n', '<C-s>', '<ESC>:w<ENTER>')

-- Shift-Insert paste from Clipboard
vim.keymap.set('i', '<S-Insert>', '<ESC>"+pa')
vim.keymap.set('n', '<S-Insert>', '"+p')

vim.keymap.set('n', 'Q', '<nop>')

-- Settings 
vim.g.mapleader     = ' '

------------------------------------------------------------------------------------------------
vim.opt.number      = true  -- numbered lines
vim.opt.cursorline  = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth  = 2
vim.opt.expandtab   = true
vim.opt.hlsearch    = true
vim.opt.incsearch   = true

vim.opt.signcolumn  = 'yes' -- left-hand column denoting a breakpoint

vim.opt.smartindent = true
vim.opt.colorcolumn = '119' --Расположение цветной колонки

vim.opt.showcmd     = true

vim.opt.swapfile    = false
vim.opt.backup      = false
-- vim.opt.undodir     = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile    = true

-- Set colorscheme
vim.o.termguicolors = true

------------------------------------------------------------------------------------------------
-- http://vimcasts.org/episodes/show-invisibles/
-- Use the same symbols as TextMate for tabstops and EOLs
-- Dot symbols: • · ∙ ␣  ˷
-- eols : § ↲ ¬ ⇰  ⇢
-- tabs : ← → ¤ ▸ \u25b8 \<Char-0x25B8>
-- trail: ☻ \u221 ★  ␠
-- extends:⟩,precedes:⟨
--set invlist
vim.o.list=true
vim.o.showbreak='↪'

--vim.cmd [[set listchars=tab:\¤\ ,trail:\☻,extends:#,nbsp:.]]
vim.opt.listchars={eol = '↲', tab = '←-→', trail =  "☻"}
--
-- Invisible character colors
--vim.cmd [[set t_Co=256]]
vim.api.nvim_set_hl(0,'NonText',   { fg='#404060' }) -- "NonText"    for "eol", "extends" and "precedes"
vim.api.nvim_set_hl(0,'Whitespace',{ ctermfg=155, fg='#405a66' }) -- "Whitespace" for "nbsp", "space", "tab", "multispace", "lead" and "trail"

-- Подсвечивает на доли секунды скопированную часть текста
vim.api.nvim_exec([[
  augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
  augroup end
]], false)

------------------------------------------------------------------------------------------------
-- Native Neovim LSP : https://lugh.ch/switching-to-neovim-native-lsp.html
-- New LSP-related keyboard mappings https://neovim.io/doc/user/news-0.11.html#_defaults
-- :checkhealth vim.lsp

clangd_path = vim.fn.expand('$HOME/.config/Code/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/21.1.0/clangd_21.1.0/bin')

vim.lsp.config.clangd = {
  cmd = {
    clangd_path .. '/clangd', {
        '--background-index',
        '--compile-commands-dir=build',
        '-pretty',
        '-j14',
      }
    },
    root_markers = { 'compile_commands.json', 'compile_flags.txt', 'build/compile_commands.json' },
    filetypes = { 'c', 'cpp' },
}

vim.lsp.enable({'clangd'})

vim.diagnostic.config({
  virtual_lines = true
  -- Alternatively, customize specific options
  -- virtual_lines = {
  --  -- Only show virtual line diagnostics for the current cursor line
  --  current_line = true,
  -- },
})

------------- Enabling builtin autocomplite
--  Hover K, Autocomplete (omnifunc) ctrl+x ctrl+o, Code actions gra
local lsp_au_group = vim.api.nvim_create_augroup('lsp_au_group', {clear = true})
vim.api.nvim_create_autocmd({'LspAttach'}, {
    callback = function()
        local clients = vim.lsp.get_clients()
        for _, client in ipairs(clients) do
            local id = client.id
            vim.lsp.completion.enable(true, id, 0, {autotrigger = true})
        end
    end,
    group = lsp_au_group,
})

--vim.cmd("set completeopt+=noselect")
vim.o.winborder = 'rounded' -- for Hover
-------------
-- use ctrl+space for code completion with omni function
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })

------------------------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." }, }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { 'nvim-mini/mini.icons', version = '*' },
    { "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
    { "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = function()
        return {
          --[[add your custom lualine config here]]
        }
        end,
    },
    { "mfussenegger/nvim-dap",
      lazy = true,
      -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
      -- modified.
      keys = {
        { "<F9>",
          function() require("dap").toggle_breakpoint() end,
          desc = "Toggle Breakpoint"
        },
        { "<leader>db",
          function() require("dap").toggle_breakpoint() end,
          desc = "Toggle Breakpoint"
        },

        { "<F5>",
          function() require("dap").continue() end,
          desc = "Continue"
        },
        { "<leader>dc",
          function() require("dap").continue() end,
          desc = "Continue"
        },

        { "<F10>",
          function() require("dap").step_over() end,
          desc = "Continue"
        },
        { "<F11>",
          function() require("dap").step_into() end,
          desc = "Continue"
        },

        { "<leader>dC",
          function() require("dap").run_to_cursor() end,
          desc = "Run to Cursor"
        },

        { "<leader>dT",
          function() require("dap").terminate() end,
          desc = "Terminate"
        },
      },
    },
    -- :lua require("dapui").open()
    { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
  },
  --install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
})



local dap = require("dap")
dap.adapters.cortexm_gdb = {
  type = "executable",
  command = "arm-none-eabi-gdb-py3",
  args = { "--interpreter=dap",
    "--eval-command", "set print pretty on", 
    "--eval-command", "set confirm off", 
    "--eval-command", "set pagination off",
    "--eval-command", "set set verbose on",
    "--eval-command", "set trace-commands on",
--  "--quiet",
    "-iex", "set debug dap-log-level 2",
    "-iex", "set debug dap-log-file gdb-dap.log",
    "-ex", "set exception-verbose on",
    "-ex", "set exception-debugger on",
    "-ex", "set debug target on",
    --vim.fn.getcwd() .. '/build/firmware.elf',
    --"--eval-command", "target extended-remote :2331",
  },
  options = { initialize_timeout_sec = 8, },
}

dap.configurations.c = {
  {
    name = "Debug (run)",
    type = "cortexm_gdb",
    --request = "launch",
    request = "attach",
    program = function()
        return vim.fn.getcwd() .. '/build/firmware.elf'
      end,
    --executable  = vim.fn.getcwd() .. '/build/firmware.elf',
    cwd = vim.fn.getcwd(),
    target = ":2331",
    stopAtBeginningOfMainSubprogram = false,
  },
}

dap.configurations.cpp = dap.configurations.c

-- use :DapShowLog
-- https://www.johntobin.ie/blog/debugging_in_neovim_with_nvim-dap/
-- :lua require("dapui").open()
-- :Lazy
-- :lua vim.print(require('dap').configurations.c)
-- :lua vim.print(require('dap').configurations[vim.bo.filetype])
require("dapui").setup()
--:DapSetLogLevel TRACE
dap.set_log_level('TRACE')

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapStopped',    { text = '▶️', texthl = '', linehl = '', numhl = ''})
