return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",

		dependencies = {
			"github/copilot.vim",
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},

		build = "make tiktoken",

		config = function()
			vim.opt.splitright = true

			require("CopilotChat").setup({
				model = "claude-sonnet-5",
				temperature = 0.1,
				auto_insert_mode = false,

				window = {
					layout = "vertical",
					width = 0.5,
				},

				headers = {
					user = "👤 You",
					assistant = "🤖 Copilot",
					tool = "🔧 Tool",
				},

				separator = "━━",
				auto_fold = true,

				-- Adjust chat display settings
				highlight_headers = true,
				error_header = "> [!ERROR] Error",
			})

			-- Keymaps for Copilot Chat
			vim.g.copilot_no_tab_map = true

			vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
				desc = "Accept Copilot suggestion",
			})

			vim.keymap.set("n", "<leader>kf", "<cmd>CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
			vim.keymap.set("n", "<leader>kr", "<cmd>CopilotChatReset<CR>", { desc = "Reset Copilot Chat" })
			vim.keymap.set("n", "<leader>km", "<cmd>CopilotChatModels<CR>", { desc = "Copilot Chat Models" })

			vim.keymap.set("v", "<leader>ke", ":CopilotChatExplain<CR>", { desc = "Copilot Explain" })
			vim.keymap.set("v", "<leader>kr", ":CopilotChatReview<CR>", { desc = "Copilot Review" })
			vim.keymap.set("v", "<leader>kf", ":CopilotChatFix<CR>", { desc = "Copilot Fix" })
			vim.keymap.set("v", "<leader>ko", ":CopilotChatOptimize<CR>", { desc = "Copilot Optimize" })
			vim.keymap.set("v", "<leader>kt", ":CopilotChatTests<CR>", { desc = "Copilot Tests" })
			vim.keymap.set("v", "<leader>kd", ":CopilotChatDocs<CR>", { desc = "Copilot Docs" })

			vim.keymap.set("n", "<leader>kq", function()
				vim.ui.input({ prompt = "Quick Chat: " }, function(input)
					if input and input ~= "" then
						vim.schedule(function()
							require("CopilotChat").ask(input, {
								sticky = {
									"#buffer:listed",
								},
							})
						end)
					end
				end)
			end, { desc = "CopilotChat - Quick chat" })
		end,
	},
}
