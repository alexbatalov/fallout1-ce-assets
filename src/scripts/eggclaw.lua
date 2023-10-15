local fallout = require("fallout")

local start
local destroy_p_proc

local Initialize = 1

local exit_line = 0

function start()
    if Initialize then
        Initialize = 0
    end
end

function destroy_p_proc()
    fallout.set_map_var(2, fallout.map_var(2) - 1)
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
return exports
