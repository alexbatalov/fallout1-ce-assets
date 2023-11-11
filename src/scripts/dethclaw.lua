local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    if fallout.obj_can_see_obj(fallout.self_obj(), dude_obj) then
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    fallout.set_global_var(44, 1)
    fallout.set_global_var(226, 5)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
