return {
    name = 'CMake: Configure preset fresh',
    priority = 24,
    condition = {
        callback = function()
            for name in vim.fs.dir('.') do
                if name == 'CMakePresets.json' then return true end
            end
            return false
        end,
    },
    params = function()
        local stdout = vim.system({ 'cmake', '--list-presets' }):wait().stdout
        local presets = {}
        for k, _ in stdout:gmatch('"(.-)"') do
            table.insert(presets, k)
        end

        return {
            preset = {
                type = 'enum',
                name = 'Presets',
                choices = presets,
                optional = false,
            }
        }
    end,
    builder = function(params)
        return {
            cmd = { 'cmake' },
            args = { '-S', '.', '-B', 'build-cc', '--preset', params.preset, '--fresh' },
        }
    end,
}
