local fallout = require("fallout")

local start
local critter_p_proc

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
return exports
