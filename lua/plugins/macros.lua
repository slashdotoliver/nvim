return {
	{ -- https://github.com/chrisgrieser/nvim-recorder
		"chrisgrieser/nvim-recorder",
		dependencies = { "rcarriga/nvim-notify" },
		opts = {
			mapping = {
				startStopRecording = "<leader>qq",
				playMacro = "Q",
				switchSlot = "<leader>qs",
				editMacro = "<leader>qe",
				deleteAllMacros = "<leader>qd",
				yankMacro = "<leader>qy",
				-- ⚠️ this should be a string you don't use in insert mode during a macro
				addBreakPoint = "<leader>q#",
			},
		},
	},
}
