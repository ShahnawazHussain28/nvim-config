return {
	"saecki/crates.nvim",
	dependencies = { "hrsh7th/nvim-cmp", "nvim-lua/plenary.nvim" },
	ft = { "rust", "toml" },
	config = function()
		local crates = require("crates")
		local opts = { silent = true }
		crates.setup({
			smart_insert = true,
			insert_closing_quote = true,
			autoload = true,
			autoupdate = true,
			autoupdate_throttle = 250,
			loading_indicator = true,
			date_format = "%Y-%m-%d",
			thousands_separator = ".",
			notification_title = "Crates",
			curl_args = { "-sL", "--retry", "1" },
			max_parallel_requests = 80,
			expand_crate_moves_cursor = true,
			open_programs = { "xdg-open", "open" },
			disable_invalid_feature_diagnostic = false,
			enable_update_available_warning = true,
			text = {
				loading = "   Loading",
				version = "   %s",
				prerelease = "   %s",
				yanked = "   %s",
				nomatch = "   No match",
				upgrade = "   %s",
				error = "   Error fetching crate",
			},
			highlight = {
				loading = "CratesNvimLoading",
				version = "CratesNvimVersion",
				prerelease = "CratesNvimPreRelease",
				yanked = "CratesNvimYanked",
				nomatch = "CratesNvimNoMatch",
				upgrade = "CratesNvimUpgrade",
				error = "CratesNvimError",
			},
			popup = {
				autofocus = true,
				hide_on_select = false,
				copy_register = '"',
				style = "minimal",
				border = "none",
				show_version_date = true,
				show_dependency_version = true,
				max_height = 30,
				min_width = 20,
				padding = 2,
				text = {
					title = " %s",
					pill_left = "",
					pill_right = "",
					description = "%s",
					created_label = " created        ",
					created = "%s",
					updated_label = " updated        ",
					updated = "%s",
					downloads_label = " downloads      ",
					downloads = "%s",
					homepage_label = " homepage       ",
					homepage = "%s",
					repository_label = " repository     ",
					repository = "%s",
					documentation_label = " documentation  ",
					documentation = "%s",
					crates_io_label = " crates.io      ",
					crates_io = "%s",
					categories_label = " categories     ",
					keywords_label = " keywords       ",
					version = " %s",
					prerelease = " %s",
					yanked = " %s",
					version_date = " %s",
					feature = "  %s",
					enabled = " %s",
					transitive = " %s",
					normal_dependencies_title = " Dependencies",
					build_dependencies_title = " Build dependencies",
					dev_dependencies_title = " Dev dependencies",
					dependency = " %s",
					optional = " %s",
					dependency_version = "  %s",
					loading = "  ",
				},
				highlight = {
					title = "CratesNvimPopupTitle",
					pill_text = "CratesNvimPopupPillText",
					pill_border = "CratesNvimPopupPillBorder",
					description = "CratesNvimPopupDescription",
					created_label = "CratesNvimPopupLabel",
					created = "CratesNvimPopupValue",
					updated_label = "CratesNvimPopupLabel",
					updated = "CratesNvimPopupValue",
					downloads_label = "CratesNvimPopupLabel",
					downloads = "CratesNvimPopupValue",
					homepage_label = "CratesNvimPopupLabel",
					homepage = "CratesNvimPopupUrl",
					repository_label = "CratesNvimPopupLabel",
					repository = "CratesNvimPopupUrl",
					documentation_label = "CratesNvimPopupLabel",
					documentation = "CratesNvimPopupUrl",
					crates_io_label = "CratesNvimPopupLabel",
					crates_io = "CratesNvimPopupUrl",
					categories_label = "CratesNvimPopupLabel",
					keywords_label = "CratesNvimPopupLabel",
					version = "CratesNvimPopupVersion",
					prerelease = "CratesNvimPopupPreRelease",
					yanked = "CratesNvimPopupYanked",
					version_date = "CratesNvimPopupVersionDate",
					feature = "CratesNvimPopupFeature",
					enabled = "CratesNvimPopupEnabled",
					transitive = "CratesNvimPopupTransitive",
					normal_dependencies_title = "CratesNvimPopupNormalDependenciesTitle",
					build_dependencies_title = "CratesNvimPopupBuildDependenciesTitle",
					dev_dependencies_title = "CratesNvimPopupDevDependenciesTitle",
					dependency = "CratesNvimPopupDependency",
					optional = "CratesNvimPopupOptional",
					dependency_version = "CratesNvimPopupDependencyVersion",
					loading = "CratesNvimPopupLoading",
				},
				keys = {
					hide = { "q", "<esc>" },
					open_url = { "<cr>" },
					select = { "<cr>" },
					select_alt = { "s" },
					toggle_feature = { "<cr>" },
					copy_value = { "yy" },
					goto_item = { "gd", "K", "<C-LeftMouse>" },
					jump_forward = { "<c-i>" },
					jump_back = { "<c-o>", "<C-RightMouse>" },
				},
			},
			completion = {
				insert_closing_quote = true,
				text = {
					prerelease = "  pre-release ",
					yanked = "  yanked ",
				},
				coq = {
					enabled = false,
					name = "Crates",
				},
				cmp = {
					enabled = true,
				},
			},
			on_attach = function(bufnr) end,
		})

		vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
		vim.keymap.set("n", "<leader>cr", crates.reload, opts)

		vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
		vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
		vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)

		vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)

		vim.keymap.set("n", "<leader>ce", crates.expand_plain_crate_to_inline_table, opts)
		vim.keymap.set("n", "<leader>cE", crates.extract_crate_into_table, opts)

		local function show_documentation()
			local filetype = vim.bo.filetype
			if vim.tbl_contains({ "vim", "help" }, filetype) then
				vim.cmd("h " .. vim.fn.expand("<cword>"))
			elseif vim.tbl_contains({ "man" }, filetype) then
				vim.cmd("Man " .. vim.fn.expand("<cword>"))
			elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
				require("crates").show_popup()
			else
				vim.lsp.buf.hover()
			end
		end

		vim.keymap.set("n", "K", show_documentation, { silent = true })
	end,
}
