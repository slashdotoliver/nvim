--   ##################### COMMANDS #####################
-- :TSInstall <language_name>        ; parser/syntax highlighting
-- :Lazy                             ; open the package manager menu
-- :MonokaiPro <option>              ; change the colorscheme
-- <C-p>                             ; open telescope (fuzzy finder)
-- :Mason                            ; show the Mason/LSPs menu
-- <C-q>                             ; hover information
-- <C-s>                             ; same as :w
-- gx                                ; follow url

vim.g.mapleader = " " -- sets <leader> to the 'spacebar'

-- lazyvim - Package Manager Installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

-- lazyvim - Loading the Package Manager
require("lazy").setup("plugins")

require("vim-config")
