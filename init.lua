vim.g.loaded_netrw=1
vim.g.loaded_netrwPlugin=1
vim.g.loaded_python3_provider=0
vim.g.mapleader=" " 
vim.opt.signcolumn='yes'
vim.opt.encoding='utf-8'
vim.opt.fileformat='unix'
vim.opt.backup=false
vim.opt.writebackup=false
vim.opt.swapfile=false
vim.opt.updatetime=300
vim.opt.timeoutlen=5000
vim.opt.scrolloff=7
vim.opt.tabstop=8
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.autoindent=true
vim.opt.smartindent=true
vim.opt.cursorline=true
vim.opt.wrap=false
vim.opt.relativenumber=true
vim.opt.ruler=true
vim.opt.termguicolors=true
vim.opt.clipboard:append("unnamedplus")


local Plug = vim.fn['plug#']
vim.call('plug#begin', '$HOME/.config/nvim/plugged')
Plug('neoclide/coc.nvim', {branch='release'})
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug('nvim-telescope/telescope.nvim', {branch='0.1.x'})
Plug 'nvim-lua/plenary.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'windwp/nvim-autopairs'
Plug 'm-demare/hlargs.nvim'
Plug 'sainnhe/everforest'
vim.call('plug#end')

require('lualine').setup {
    options = { theme = 'everforest' },
}

require('colorizer').setup()
require('nvim-autopairs').setup()
require('hlargs').setup {
    paint_arg_declarations = true,
}
if vim.g.neovide then
    vim.opt.guifont = 'Source Code Pro:h9'
    vim.opt.linespace = -2
    vim.g.neovide_transparency = 1.0
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_padding_top = 60.0
    vim.g.neovide_padding_bottom = 55.0
    vim.g.neovide_padding_left = 55.0
    vim.g.neovide_padding_right = 55.0
    vim.g.neovide_theme = 'auto'
    vim.g.neovide_no_idle = true
    vim.g.neovide_confirm_quit = false
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_trail_size = 0.8
    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_vfx_mode = "railgun"
end

local keyset = vim.keymap.set
keyset("n", "<leader>0", ":w <bar> :exec '!python' shellescape(@%, 1)<cr>", {buffer = true, noremap = true})
keyset("n", "<leader>e", ":NERDTreeMirrorToggle<CR>", {silent = true})
keyset("n", "<leader>f", ":NERDTreeFocusToggle<CR>", {silent = true})
keyset("n", "<s-q>", ":qall!<CR>", {silent = true})
keyset("n", "<s-c>", ":close!<CR>", {silent = true})
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#next(1) : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset("i", "<S-CR>", [[coc#pum#visible() ? coc#pum#prev(1) : "<s-CR>"]], opts)
keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#confirm() : "<TAB>"]], opts)
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gb", "<C-o>", {silent = true, noremap = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


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



local glb = vim.g
glb.nerdtree_tabs_open_on_gui_startup = 0
glb.nerdtree_tabs_open_on_console_startup = 0

vim.opt.background = 'dark'
glb.everforest_background = 'hard'
glb.everforest_better_performance = 1
glb.everforest_enable_italic = 1
glb.everforest_diagnostic_line_highlight = 1
glb.airline_theme='everforest'
glb.airline_powerline_fonts = 1
vim.cmd [[
  colorscheme everforest

]]

glb.everforest_cursor = 'blue'
