return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) [git commits]
				vim.keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) [git file commits]
				vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) [git branch]
				vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview [git status]

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk)
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>hu", gs.undo_stage_hunk)
				map("n", "<leader>hr", gs.reset_hunk)
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>hR", gs.reset_buffer)
				map("n", "<leader>hp", gs.preview_hunk)
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<leader>tb", gs.toggle_current_line_blame)
				map("n", "<leader>hd", gs.diffthis)
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end)
				map("n", "<leader>td", gs.toggle_deleted)

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		})

		-- Setting colors for gitsigns highlight groups for "Colour Vision Deficiency"

		-- Unstaged Highlight Colors
		vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#FFFFFF" }) -- White for unstaged added lines
		vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#0000FF" }) -- Blue for unstaged changed lines
		vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#FF0000" }) -- Red for unstaged deleted lines

		-- Staged Highlight Colors (darker shades of unstaged colors)
		vim.api.nvim_set_hl(0, "GitSignsStagedAdd", { fg = "#454545" }) -- Darker gray for staged added lines
		vim.api.nvim_set_hl(0, "GitSignsStagedChange", { fg = "#000045" }) -- Darker blue for staged changed lines
		vim.api.nvim_set_hl(0, "GitSignsStagedDelete", { fg = "#450000" }) -- Dark red for staged deleted lines
	end,
}
