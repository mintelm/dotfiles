local utils = require('utils')

return {
    name = 'CMake: Configure fresh',
    priority = 23,
    condition = {
        callback = function()
            return utils.is_cmake_project('.')
        end
    },
    builder = function()
        local args = { '--fresh' }
        local chosen_preset = ''

        for name in vim.fs.dir('.') do
            if name == 'CMakePresets.json' then
                local presets = {}
                for preset in vim.system({ 'cmake', '--list-presets' }):wait().stdout:gmatch('"(.-)"') do
                    table.insert(presets, preset)
                end

                chosen_preset = utils.pick_one_sync(presets, 'Select a preset', function(item) return item end)
                if chosen_preset ~= nil then
                    table.insert(args, '--preset')
                    table.insert(args, chosen_preset)
                end

                break
            end
        end


        return { cmd = { 'cmake' }, args = args }
    end,
}
