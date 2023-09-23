vim.g.loaded_netrw=1
vim.g.loaded_netrwPlugin=1
vim.g.loaded_python3_provider=0
vim.g.mapleader=" " 
--vim.g.python3_host_prog='/usr/bin/python'
vim.opt.signcolumn='yes'
vim.opt.encoding='utf-8'
vim.opt.fileformat='unix'
vim.opt.termguicolors=true
vim.opt.backup=false
vim.opt.writebackup=false
vim.opt.swapfile=false
vim.opt.updatetime=300
vim.opt.timeoutlen=5000
vim.opt.scrolloff=7
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.autoindent=true
vim.opt.smartindent=true
vim.opt.cursorline=true
vim.opt.number=true
vim.opt.ruler=true
vim.opt.showcmd=true
vim.opt.cmdheight=1

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug('neoclide/coc.nvim', {branch='release'})
Plug 'jacquesg/p5-Neovim-Ext'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug('nvim-treesitter/nvim-treesitter', {run=':TSUpdate'})
Plug('nvim-telescope/telescope.nvim', {branch='0.1.x'})
Plug 'nvim-lua/plenary.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'm-demare/hlargs.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sainnhe/everforest'
Plug 'nvim-tree/nvim-web-devicons'
vim.call('plug#end')

require("nvim-autopairs").setup()
require('hlargs').setup {
		paint_arg_declarations = true,
}

local keyset = vim.keymap.set
keyset("n", "<leader>0", ":w <bar> :exec '!python' shellescape(@%, 1)<cr>", {buffer = true, noremap = true})
keyset("n", "<leader>e", ":NERDTreeMirrorToggle<CR>", {silent = true})

keyset("n", "<s-q>", ":qall!<CR>", {silent = true})
keyset("n", "<s-c>", ":close!<CR>", {silent = true})
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#next(1) : "<TAB>"]], opts)
keyset("i", "<s-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "<s-TAB>"]], opts)
keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gb", "<C-o>", {silent = true, noremap = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

function get_buffer_id()
    local buffer_id = vim.api.nvim_win_get_buf(0)
    print('winId:', buffer_id)
end
keyset("n", "w<right>", "<CMD>lua get_buffer_id()<CR>", {noremap = true})

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

function _G.check_back_space()
   local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

vim.opt.background = 'dark'
vim.g.everforest_background = 'hard'
vim.g.everforest_better_performance = 1
vim.g.everforest_enable_italic = 1
vim.g.everforest_diagnostic_line_highlight = 1
vim.g.everforest_cursor = 'orange'

vim.g.airline_theme='everforest'
vim.cmd [[
  colorscheme everforest

]]
