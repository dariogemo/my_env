th.git = th.git or {}
th.git.unknown_sign = " "
th.git.added_sign = "A"
th.git.modified_sign = "M"
th.git.deleted_sign = "D"
-- th.git.clean_sign = "✔"

th.git.added = ui.Style():fg("red")
th.git.modified = ui.Style():fg("yellow")
th.git.deleted = ui.Style():fg("red"):bold()

require("git"):setup({
	-- Order of status signs showing in the linemode
	order = 1500,
})

require("no-status"):setup()
