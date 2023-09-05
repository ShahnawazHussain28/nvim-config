return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"vim-scripts/ReplaceWithRegister", -- replace with register contents using motion (gr + motion,
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	-- better color comments (e.g. TODO, FIXME, etc...)
	{ "folke/todo-comments.nvim", dependencies = {
		{ "nvim-lua/plenary.nvim" },
	} },
	"github/copilot.vim", -- github copilot for smart code completions
	"simrat39/rust-tools.nvim", -- rust tools for rust-analyzer
	"jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports,
}
