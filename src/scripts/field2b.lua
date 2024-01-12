local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    fallout.set_external_var("Field2b_Ptr", self_obj)
    if fallout.global_var(146) == 1 then
        fallout.set_obj_visibility(self_obj, false)
        fallout.set_global_var(262, 1)
        fallout.set_map_var(23, 1)
    end
    if fallout.global_var(262) == 0 or fallout.map_var(23) == 0 then
        fallout.set_obj_visibility(self_obj, true)
    end
end

function map_update_p_proc()
    local self_obj = fallout.self_obj()
    fallout.set_external_var("Field2b_Ptr", self_obj)
    if fallout.global_var(262) == 0 then
        if fallout.map_var(23) == 0 and fallout.global_var(146) == 1 then
            fallout.set_map_var(23, 1)
            fallout.set_obj_visibility(self_obj, true)
        else
            fallout.set_obj_visibility(self_obj, true)
        end
    elseif fallout.global_var(262) == 1 then
        fallout.set_map_var(23, 1)
        fallout.set_obj_visibility(self_obj, false)
    elseif fallout.global_var(146) == 1 then
        fallout.set_obj_visibility(self_obj, false)
        fallout.set_global_var(262, 1)
        fallout.set_map_var(23, 1)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
