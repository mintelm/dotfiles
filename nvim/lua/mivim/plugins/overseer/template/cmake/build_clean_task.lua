return {
    name = 'CMake: Build clean',
    priority = 21,
    condition = {
        callback = function()
            return mivim.utils.is_cmake_project('.')
        end
    },
    builder = function()
        return {
            cmd = { 'cmake' },
            args = { '--build', 'build-cc', '-j', '--clean-first' },
        }
    end,
}
