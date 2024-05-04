-- :help dap.txt
-- You'll need to install and configure a debug adapter per language.
-- A debug adapter is a facilitator between nvim-dap (the client), and a
-- language-specific debugger:
--
--
--    DAP-Client ----- Debug Adapter ------- Debugger ------ Debugee
--    (nvim-dap)  |   (per language)  |   (per language)    (your app)
--                |                   |
--                |        Implementation specific communication
--                |        Debug adapter and debugger could be the same process
--                |
--         Communication via the Debug Adapter Protocol
--
--
--To debug applications, you need to configure two things per language:
--
--- A debug adapter (|dap-adapter|).
--- How to launch your application to debug or how to attach to a running
--  application (|dap-configuration|).

local dapconfigs = {}

function dapconfigs.setup_codelldb(dap)
	local codelldb = require("mason-registry").get_package("codelldb")
	local externsion_path = codelldb:get_install_path() .. "/extension/"
	local codelldb_path = externsion_path .. "adapter/codelldb"
	--local liblldb_path = externsion_path .. "lldb/lib/liblldb.so"

	-- start codelldb automatically
	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			-- CHANGE THIS to your path!
			command = codelldb_path,
			args = { "--port", "${port}" },
			-- detached = false,
		},
	}

	-- languages configuration
	dap.configurations.c = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			preLaunchTask = function() -- function(config)
				local ft = vim.bo.filetype -- vim.fn:fnamemodify(config.program, ":e")
				local message = "Help compilation message not configured yet."
				if ft == "c" then
					message = "Compile C program using: gcc -g <file.c>* -o <executable>"
				elseif ft == "cpp" then
					message = "Compile C++ program using: g++ -g <file.cpp>* -o <executable>"
				end
				local answer = vim.fn.input(message .. "\nContinue debugging? (Y/n): ", "")
				if answer == "n" or answer == "N" then
					error("Debugging process aborted.\nIgnore stack traceback.", 0) -- dont report error position
					return nil
				end
			end,
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			args = function()
				local args_input = vim.fn.input("Program arguments: ")
				if args_input ~= "" and args_input ~= "\n" then
					return vim.split(args_input, " ")
				else
					return nil
				end
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}
	dap.configurations.cpp = dap.configurations.c
	dap.configurations.rust = dap.configurations.c
	-- codelldb tambien permite: Ada, Fortran, Kotlin Native, Nim, Objective-C, Pascal, Swift and Zig.
end

function dapconfigs.setup_godot(dap)
	dap.adapters.godot = {
		type = "server",
		host = "127.0.0.1",
		port = 6006,
	}

	dap.configurations.gdscript = {
		{
			type = "godot",
			request = "launch",
			name = "Launch Scene",
			project = "${workspaceFolder}",
			launch_scene = true,
		},
	}
end

return {
	{ -- https://github.com/mfussenegger/nvim-dap
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>db", "<cmd>DapToggleBreakpoint <CR>", mode = "n", desc = "Debugging: Toggle Breakpoint" },
			{ "<leader>dc", "<cmd>DapContinue <CR>", mode = "n", desc = "Debugging: Continue Execution" },
			{ "<F9>", "<cmd>DapContinue <CR>", mode = "n", desc = "Debugging: Resume" },
			{ "<F8>", "<cmd>DapStepOver <CR>", mode = "n", desc = "Debugging: Step Over" },
			{ "<F20>", "<cmd>DapStepOut <CR>", mode = "n", desc = "Debugging: Step Out" },
			{ "<F7>", "<cmd>DapStepInto <CR>", mode = "n", desc = "Debugging: Step Into" },
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
			"folke/neodev.nvim",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})

			dapui.setup()

			-- codelldb config
			dapconfigs.setup_codelldb(dap)
			-- godot config
			dapconfigs.setup_godot(dap)
		end,
	},
	-- ~~~~~~~ language-specific ~~~~~~~
	{ -- python debugging | https://github.com/mfussenegger/nvim-dap-python
		"mfussenegger/nvim-dap-python",
		-- Supported test frameworks are unittest, pytest and django.
		-- By default it tries to detect the runner by probing for pytest.ini and manage.py,
		-- if neither are present it defaults to unittest.
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap", -- https://youtu.be/4BnVeOUeZxc?t=902
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			-- installed by Mason -> debugpy
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
		keys = {
			{
				"<leader>dpr",
				function()
					require("dap-python").test_method()
				end,
				mode = "n",
				desc = "Debugging Python: Run Test",
			},
		},
	},
}
