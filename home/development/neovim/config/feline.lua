local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

vim.o.termguicolors = true

local colors = {
    bg = '#282c34',
    fg = '#abb2bf',
    yellow = '#e0af68',
    cyan = '#56b6c2',
    darkblue = '#081633',
    green = '#98c379',
    orange = '#d19a66',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#61afef',
    red = '#e86671'
}

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    VISUAL = colors.magenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.violet,
    ['V-REPLACE'] = colors.violet,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = '🐧'
    elseif os == 'MAC' then
        icon = ''
    else
        icon = '🏠'
    end
    return icon
end

local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

local lsp_get_diag = function(str)
  local count = vim.lsp.diagnostic.get_count(0, str)
  return (count > 0) and ' '..count..' ' or ''
end

local comps = {
    vi_mode = {
        provider = function()
            return ' — ' .. vi_mode_utils.get_vim_mode() .. ' — '
        end,
        hl = function()
            local val = {
                name = vi_mode_utils.get_mode_highlight_name(),
                fg = vi_mode_utils.get_mode_color(),
                -- fg = colors.bg
            }
            return val
        end,
    },
    file = {
        info = {
            provider = {
                name = 'file_info',
                opts = {
                    type = 'relative',
                    file_readonly_icon = '📖',
                    file_modified_icon = '✍️',
                },
            },
            left_sep = ' ',
            hl = {
                fg = colors.blue,
                style = 'bold'
            }
        },
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        type = {
            provider = 'file_type'
        },
        os = {
            provider = file_osinfo,
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        position = {
            provider = 'position',
            left_sep = ' ',
            hl = {
                fg = colors.cyan,
                style = 'bold',
            }
        },
    },
    line_percentage = {
        provider = 'line_percentage',
        left_sep = ' ',
        hl = {
            style = 'bold'
        }
    },
    scroll_bar = {
        provider = 'scroll_bar',
        left_sep = ' ',
        hl = {
            fg = colors.blue,
            style = 'bold'
        }
    },
    diagnos = {
        err = {
            provider = 'diagnostic_errors',
            left_sep = '⛔️',
            enabled = function() return lsp.diagnostics_exist('Error') end,
            hl = {
                fg = colors.red
            }
        },
        warn = {
            provider = 'diagnostic_warnings',
            left_sep = '⚠️',
            enabled = function() return lsp.diagnostics_exist('Warning') end,
            hl = {
                fg = colors.yellow
            }
        },
        info = {
            provider = 'diagnostic_info',
            left_sep = 'ℹ️',
            enabled = function() return lsp.diagnostics_exist('Information') end,
            hl = {
                fg = colors.blue
            }
        },
        hint = {
            provider = 'diagnostic_hints',
            left_sep = '💡',
            enabled = function() return lsp.diagnostics_exist('Hint') end,
            hl = {
                fg = colors.cyan
            }
        },
    },
    lsp = {
        name = {
            provider = 'lsp_client_names',
            icon = '🔍 ',
            left_sep = ' ',
            hl = {
                fg = colors.yellow
            }
        }
    },
    git = {
        branch = {
            provider = 'git_branch',
            left_sep = ' ',
            icon = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            },
        },
        add = {
            provider = 'git_diff_added',
            left_sep = ' ',
            icon = '+',
            hl = {
                fg = colors.green
            }
        },
        change = {
            provider = 'git_diff_changed',
            left_sep = ' ',
            icon = '/',
            hl = {
                fg = colors.orange
            }
        },
        remove = {
            provider = 'git_diff_removed',
            left_sep = ' ',
            icon = '-',
            hl = {
                fg = colors.red
            }
        }
    }
}

local components = {
    active = {
        {
            comps.vi_mode,
            comps.git.branch,
            comps.git.add,
            comps.git.change,
            comps.git.remove,
            comps.file.info,
        },
        {},
        {
            comps.diagnos.err,
            comps.diagnos.warn,
            comps.diagnos.hint,
            comps.diagnos.info,
            comps.lsp.name,
            comps.file.position,
            comps.file.os,
            comps.file.encoding,
            comps.scroll_bar,
        },
    },
    inactive = {
        {
            comps.vi_mode,
            comps.file.info,
        },
        {},
        {},
    },
}

require'feline'.setup {
    colors = { bg = colors.bg, fg = colors.fg },
    components = components,
    vi_mode_colors = vi_mode_colors,
    force_inactive = {
        filetypes = {
            'packer',
            'NvimTree',
            'fugitive',
            'fugitiveblame'
        },
        buftypes = {'terminal'},
        bufnames = {}
    }
}
