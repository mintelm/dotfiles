local utils = require('utils')

return {
    name = 'CMake: Build',
    priority = 20,
    condition = {
        callback = function()
            return utils.is_cmake_project('.')
        end
    },
    builder = function()
        return {
            cmd = { 'cmake' },
            args = { '--build', 'build-cc', '-j' },
        }
    end,
}
