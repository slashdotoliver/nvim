vim.cmd([[
    set expandtab
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set smarttab

    set number
    set cursorline

    set colorcolumn=80
    set laststatus=3
    set list
    "set listchars=space:⋅,tab:»—
    set listchars=tab:»⋅,trail:·
    highlight! link WinSeparator Comment

    "set guicursor=n-v:block,i-c-ci-ve:ver25,r-cr-o:hor20
]])

-- space:⋅,tab:»-  »   ܁ ܁,  ⋅,
-- ,tab:»—
--  set relativenumber

-- other keymaps in commander.lua
--vim.keymap.set("n", "<C-s>", save, { desc = "Save Current Buffer" })
