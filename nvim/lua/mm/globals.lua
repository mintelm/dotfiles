local fmt = string.format
-----------------------------------------------------------------------------//
-- Global namespace
-----------------------------------------------------------------------------//
--- Inspired by @tjdevries' astraunauta.nvim/ @TimUntersberger's config
--- store all callbacks in one global table so they are able to survive re-requiring this file
_G.__mm_global_callbacks = __mm_global_callbacks or { }

_G.mm = {
    _store = __mm_global_callbacks,
}

-----------------------------------------------------------------------------//
-- Debugging
-----------------------------------------------------------------------------//
-- inspect the contents of an object very quickly
-- in your code or from the command-line:
-- USAGE:
-- in lua: dump({1, 2, 3})
-- in commandline: :lua dump(vim.loop)
---@vararg any
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
end

-----------------------------------------------------------------------------//
-- Utils
-----------------------------------------------------------------------------//
function mm._create(f)
    table.insert(mm._store, f)
    return #mm._store
end

function mm._execute(id, args)
    mm._store[id](args)
end

---@class Autocommand
---@field events string[] list of autocommand events
---@field targets string[] list of autocommand patterns
---@field modifiers string[] e.g. nested, once
---@field command string | function

---Create an autocommand
---@param name string
---@param commands Autocommand[]
function mm.augroup(name, commands)
    vim.cmd('augroup ' .. name)
    vim.cmd('autocmd!')
    for _, c in ipairs(commands) do
        local command = c.command
        if type(command) == 'function' then
            local fn_id = mm._create(command)
            command = fmt('lua mm._execute(%s)', fn_id)
        end
        vim.cmd(
            string.format(
                'autocmd %s %s %s %s',
                table.concat(c.events, ','),
                table.concat(c.targets or { }, ','),
                table.concat(c.modifiers or { }, ' '),
                command
            )
        )
    end
    vim.cmd('augroup END')
end

function mm.opt(scope, key, value)
    local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
    scopes[scope][key] = value

    if scope ~= 'o' then
        scopes['o'][key] = value
    end
end

function mm.map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function mm.set_tab_width(tab_width)
    mm.opt('b', 'tabstop', tab_width)
    mm.opt('b', 'shiftwidth', tab_width)
end
