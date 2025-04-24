local config = {
	is_active = function(resolve)
		vim.system({ "fcitx5-remote" }, nil, function(res)
			resolve(string.find(res.stdout, "1") == nil)
		end)
	end,
	active_input = function()
		vim.system({ "fcitx5-remote", "-o" })
	end,
	inactive_input = function()
		vim.system({ "fcitx5-remote", "-c" })
	end,
}

local function setup(new_config)
	config = vim.tbl_deep_extend("force", config, new_config or {})
end

local is_active_previously = false

vim.api.nvim_create_autocmd({ "ModeChanged" }, {
	pattern = { "*" },
	callback = function(args)
		if string.match(args.match, "[^i]:i") and is_active_previously then
			config.active_input_method()
		elseif string.match(args.match, "i:[^i]") then
			config.is_active(function(is_active)
				is_active_previously = is_active
			end)
			config.inactive_input_method()
		end
	end,
})

return { setup = setup }
