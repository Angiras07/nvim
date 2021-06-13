local gl = require("galaxyline")
local gls = gl.section
local condition = require("galaxyline.condition")

local colors = {
    bg = "#1e2127",
    fg = "#abb2bf",
    green = "#97C378",
    red = "#d47d85",
    lightbg = "#2d3139",
    lightbg2 = "#262a32",
    blue = "#81A1C1",
    yellow = "#e0c080",
    grey = "#6f737b",
    dark_yellow = '#D7BA7D',
    cyan = '#4EC9B0',
    light_green = '#B5CEA8',
    string_orange = '#CE9178',
    orange = '#FF8800',
    purple = '#C586C0',
    magenta = '#D16D9E',
    vivid_blue = '#4FC1FF',
    light_blue = '#9CDCFE',
    error_red = '#F44747',
    info_yellow = '#FFCC66'

}
gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}


local mode_color = {
	n = colors.red,
	i = colors.green,
	v = colors.purple,
	[''] = colors.purple,
	V = colors.purple,
	c = colors.magenta,
	no = colors.blue,
	s = colors.orange,
	S = colors.orange,
	[''] = colors.orange,
	ic = colors.yellow,
	R = colors.blue,
	Rv = colors.blue,
	cv = colors.red,
	ce = colors.red,
	r = colors.cyan,
	rm = colors.cyan,
	['r?'] = colors.cyan,
	['!'] = colors.blue,
	t = colors.blue
}

 table.insert(gls.left, {
	starter = {
		provider = function()
			return ""
		end,
		highlight = {colors.blue, colors.bg}
	}
})

table.insert(gls.left, {
	Icon = {
		provider = function()
			return " "
		end,
		highlight = {colors.bg, colors.blue},
		-- separator = "  ",
		separator = " ",
		separator_highlight = {colors.blue, colors.lightbg}
	}
})

print(vim.fn.getbufvar(0, 'ts'))
vim.fn.getbufvar(0, 'ts')

table.insert(gls.left, {
	FileIcon = {
		provider = "FileIcon",
		condition = condition.buffer_not_empty,
		highlight = {colors.blue, colors.lightbg}
	}
})

table.insert(gls.left, {
	FileName = {
		provider = {"FileName"},
		condition = condition.buffer_not_empty,
		highlight = {colors.blue, colors.lightbg},
		separator = " ",
		separator_highlight = {colors.lightbg, colors.lightbg2}
	}
})

table.insert(gls.left, {
	current_dir = {
		provider = function()
			local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
			return "  " .. dir_name .. " "
		end,
		highlight = {colors.grey, colors.lightbg2},
		-- separator = " ",
		separator = " ",

        separator_highlight = {colors.lightbg2, colors.bg}
    }
})

table.insert(gls.left, {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.green, colors.bg}
    }
})
table.insert(gls.left, {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' 柳',
        highlight = {colors.blue, colors.bg}
    }
})
table.insert(gls.left, {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
})

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 30 then
        return true
    end
    return false
end

table.insert(gls.right, {
    DiagnosticError = {
    	provider = 'DiagnosticError',
    	icon = '  ',
    	highlight = {colors.error_red, colors.bg}
    }
})
table.insert(gls.right, {
	DiagnosticWarn = {
		provider = 'DiagnosticWarn',
		icon = '  ',
		highlight = {colors.orange, colors.bg}
	}
})

table.insert(gls.right, {
    DiagnosticHint = {
    	provider = 'DiagnosticHint',
    	icon = '  ',
    	highlight = {colors.vivid_blue, colors.bg}
    }
})

table.insert(gls.right, {
	DiagnosticInfo = {
		provider = 'DiagnosticInfo',
		icon = '  ',
		highlight = {colors.info_yellow, colors.bg}
	}
})

table.insert(gls.right, {
    TreesitterIcon = {
        provider = function()
            if next(vim.treesitter.highlighter.active) ~= nil then return '侮 ' end
            return ''
        end,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.green, colors.bg}
    }
})

table.insert(gls.right, {
	LspSep = {
		provider = function()
			return ''
		end,
		highlight = {colors.lightbg, colors.bg},
	}
})

table.insert(gls.right, {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {['dashboard'] = true, [' '] = true}
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
		icon = ' ',
        highlight = {colors.grey, colors.lightbg}
    }
})

table.insert(gls.right, {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.bg, colors.cyan},
        separator = " ",
        separator_highlight = {colors.cyan, colors.lightbg}
    }
})

table.insert(gls.right, {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.bg, colors.cyan},
    }
})

table.insert(gls.right, {
	ViMode = {
		provider = function()
			local alias = {
				n = "NORMAL",
				i = "INSERT",
				c = "COMMAND",
				V = "VISUAL",
				[""] = "VISUAL",
				v = "VISUAL",
				R = "REPLACE"
			}
			local current_Mode = alias[vim.fn.mode()]
            vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color[vim.fn.mode()])
			if current_Mode == nil then
				return "  Terminal "
			else
				return " " .. current_Mode .. " "
			end
		end,
		separator = ' ',
		separator_highlight = {colors.cyan, colors.cyan},
		highlight = {colors.bg, colors.lightbg},
	}
})

-- table.insert(gls.right, {
--     LineInfo = {
--         provider = 'LineColumn',
--         separator = '  ',
--         separator_highlight = {'NONE', colors.bg},
--         highlight = {colors.grey, colors.bg}
--     }
-- })
-- 
table.insert(gls.right, {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {colors.light_blue, colors.light_blue},
        highlight = {colors.bg,colors.light_blue}
    }
})

table.insert(gls.right, {
	ender = {
		provider = function()
			return ""
		end,
		highlight = {colors.light_blue, colors.bg}
	}
})

table.insert(gls.short_line_left, {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
})

table.insert(gls.short_line_left, {
    SFileName = {provider = 'SFileName', condition = condition.buffer_not_empty, highlight = {colors.grey, colors.bg}}
})



-- "  "
-- "  "
-- "  ﯨ"
-- "  ﰋ"
-- " 勺"
-- " 﫢"
 


