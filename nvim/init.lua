-- Put this file content into
-- :e ~\AppData\Local\nvim\init.lua

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  
  use { 'jedrzejboczar/nvim-dap-cortex-debug', requires = 'mfussenegger/nvim-dap' }
  use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'} }

  use 'navarasu/onedark.nvim' -- Theme inspired by Atom

  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
end)

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
vim.cmd [[colorscheme onedark]]

-- Подсвечивает на доли секунды скопированную часть текста
vim.api.nvim_exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup end
]], false)


-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}


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
