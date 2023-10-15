local fallout = require("fallout")

local start
local destroy_p_proc
local critter_p_proc

local Initialize = 1

local exit_line = 0

function start()
    if Initialize then
        Initialize = 0
    end
end

function destroy_p_proc()
    fallout.set_map_var(0, 1)
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
return exports
