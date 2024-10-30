return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			-- "nvim-treesitter/nvim-treesitter-context", -- context aware commentstring
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },
				-- ensure these language parsers are installed
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"markdown",
					"bash",
					"lua",
					"rust",
					"python",
					"scss",
				},
				-- auto install above language parsers
				auto_install = true,
			})

			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})

			-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
			require("ts_context_commentstring").setup({})
		end,
	},
}
