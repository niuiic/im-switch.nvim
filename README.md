# im-switch.nvim

Neovim plugin to automatically switch input method without delay.

[More neovim plugins](https://github.com/niuiic/awesome-neovim-plugins)

## Config

Default configuration here.

```lua
require("im-switch").setup({
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
})
```
