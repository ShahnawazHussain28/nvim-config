return {
	"ray-x/lsp_signature.nvim",
	opts = {
		bind = true,
		floating_window = false,
		hint_enable = true,
		handler_opts = {
			border = "rounded",
		},
		hint_prefix = {
			above = "↙ ", -- when the hint is on the line above the current line
			current = "← ", -- when the hint is on the same line
			below = "↖ ", -- when the hint is on the line below the current line
		},
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)
		require("lsp_signature").toggle_float_win()
	end,
}
