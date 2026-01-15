-- Put this file content into
-- :e ~\AppData\Local\nvim\init.lua
-- :e ~/.conig/init.lua

-- Clear configs:
-- ~/.config/nvim
-- ~/.local/share/nvim
-- ~/.local/state/nvim

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

vim.lsp.config.clangd = {
  cmd = { 'clangd', '--background-index' },
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
