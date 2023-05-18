require("code_runner").setup({
	mode = "tab",
	filetype = {
		java = {
			"cd '$dir' && javac $fileName && java $fileNameWithoutExt",
		},
		python = "python3 -u",
		typescript = "ts-node $fileName",
		rust = {
			"cd '$dir' && rustc $fileName && '$dir/$fileNameWithoutExt'",
		},
		cpp = {
			"cd '$dir' && g++ $fileName && '$dir/a.out'",
		},
	},
})
