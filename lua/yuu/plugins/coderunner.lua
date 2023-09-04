return {
	"CRAG666/code_runner.nvim",
	lazy = true,
	keys = { "<leader>rr", ":RunCode<CR>" },
	config = function()
		require("code_runner").setup({
			filetype = {
				java = {
					"cd '$dir' && javac $fileName && java $fileNameWithoutExt",
				},
				python = "python3 -u $fileName",
				typescript = "ts-node $fileName",
				javascript = "node $fileName",
				rust = {
					"cd '$dir' && rustc $fileName && '$dir/$fileNameWithoutExt'",
				},
				cpp = {
					"cd '$dir' && g++ $fileName && '$dir/a.out'",
				},
			},
		})
	end,
}
