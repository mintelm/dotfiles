local fmt = string.format

---Global namespace
---store all callbacks in one global table so they are able to survive re-requiring this file
_G.__mm_global_callbacks = __mm_global_callbacks or { }

_G.mm = {
    _store = __mm_global_callbacks,
}

---Inspect contents of any object
---@vararg any
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
end

---Set tabstop and shiftwdith
---@param tab_width number
function _G.set_tab_width(tab_width)
    mm.opt('b', 'tabstop', tab_width)
    mm.opt('b', 'shiftwidth', tab_width)
end

---Add callback to global store
---@param f function
function mm._create(f)
    table.insert(mm._store, f)
    return #mm._store
end

---Execute callback with id
---@param id number
---@param args any
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

---Find an item in a list
---@generic T
---@param haystack T[]
---@param matcher fun(arg: T):boolean
---@return T
function mm.find(haystack, matcher)
    local found

    for _, needle in ipairs(haystack) do
        if matcher(needle) then
            found = needle
            break
        end
    end

    return found
end

---Determine if a value of any type is empty
---@param item any
---@return boolean
function mm.empty(item)
    if not item then
        return true
    end

    local item_type = type(item)

    if item_type == 'string' then
        return item == ''
    elseif item_type == 'table' then
        return vim.tbl_isempty(item)
    end
end

---Set vim option
---@param scope string
---@param key string
---@param value any
function mm.opt(scope, key, value)
    local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
    scopes[scope][key] = value

    if scope ~= 'o' then
        scopes['o'][key] = value
    end
end

---Set global vim keymap
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table
function mm.map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---Set buffer vim keymap
---@param bufnr number
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table
function mm.bmap(bufnr, mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end
