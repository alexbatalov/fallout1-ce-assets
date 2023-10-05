local fallout = require("fallout")

local start
local damage_p_proc

function start()
    if fallout.script_action() == 14 then
        damage_p_proc()
    end
end

function damage_p_proc()
    fallout.set_obj_visibility(fallout.self_obj(), 1)
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
return exports
