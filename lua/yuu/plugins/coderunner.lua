require("code_runner").setup({
	filetype = {
		java = {
			"cd '$dir' && javac $fileName && java $fileNameWithoutExt",
		},
		python = "python3 -u $fileName",
		typescript = "ts-node $fileName",
		rust = {
			"cd '$dir' && rustc $fileName && '$dir/$fileNameWithoutExt'",
		},
		cpp = {
			"cd '$dir' && g++ $fileName && '$dir/a.out'",
		},
	},
})
