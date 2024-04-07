vim.cmd([[
    set expandtab
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4

    set number
    set relativenumber
    set cursorline
]])

local function save()
	-- save the current buffer
	local status, err = pcall(function()
		vim.cmd(":w")
	end)
end

vim.keymap.set("n", "<C-s>", save, {})
