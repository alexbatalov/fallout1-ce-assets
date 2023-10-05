local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        end
    end
end

function map_enter_p_proc()
    if fallout.map_var(7) == 0 then
        fallout.set_obj_visibility(fallout.self_obj(), 0)
    else
        fallout.set_obj_visibility(fallout.self_obj(), 1)
    end
end

function map_update_p_proc()
    if fallout.map_var(7) == 0 then
        fallout.set_obj_visibility(fallout.self_obj(), 0)
    else
        fallout.set_map_var(2, 1)
        fallout.set_obj_visibility(fallout.self_obj(), 1)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
