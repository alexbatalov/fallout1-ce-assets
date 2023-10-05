local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == map_update_p_proc() then
            map_update_p_proc()
        end
    end
end

function map_enter_p_proc()
    fallout.set_external_var("Field2a_Ptr", fallout.self_obj())
    if fallout.global_var(146) == 1 then
        fallout.set_obj_visibility(fallout.self_obj(), 0)
        fallout.set_global_var(262, 1)
        fallout.set_map_var(17, 1)
    end
    if (fallout.global_var(262) == 0) or (fallout.map_var(17) == 0) then
        fallout.set_obj_visibility(fallout.self_obj(), 1)
    end
end

function map_update_p_proc()
    fallout.set_external_var("Field2a_Ptr", fallout.self_obj())
    if fallout.global_var(262) == 0 then
        if (fallout.map_var(17) == 0) and (fallout.global_var(146) == 1) then
            fallout.set_map_var(17, 1)
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        else
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        end
    else
        if fallout.global_var(262) == 1 then
            fallout.set_map_var(17, 1)
            fallout.set_obj_visibility(fallout.self_obj(), 0)
        else
            if fallout.global_var(146) == 1 then
                fallout.set_obj_visibility(fallout.self_obj(), 0)
                fallout.set_global_var(262, 1)
                fallout.set_map_var(17, 1)
            end
        end
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
