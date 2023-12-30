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
    fallout.set_external_var("Psy_Field_Ptr", self_obj)
    if fallout.map_var(6) == 0 then
        fallout.set_obj_visibility(self_obj, false)
    else
        fallout.set_obj_visibility(self_obj, true)
    end
end

function map_update_p_proc()
    local self_obj = fallout.self_obj()
    fallout.set_external_var("Psy_Field_Ptr", self_obj)
    if fallout.map_var(6) == 0 then
        fallout.set_obj_visibility(self_obj, false)
    else
        fallout.set_obj_visibility(self_obj, true)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
