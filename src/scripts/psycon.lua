local fallout = require("fallout")

local start
local use_p_proc
local look_at_p_proc
local map_enter_p_proc
local map_update_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    end
end

function use_p_proc()
    if fallout.local_var(0) ~= 0 then
        fallout.set_obj_visibility(fallout.external_var("Psy_Field_Ptr"), false)
        fallout.set_map_var(6, 0)
        fallout.set_local_var(0, 0)
    else
        fallout.set_obj_visibility(fallout.external_var("Psy_Field_Ptr"), true)
        fallout.set_map_var(6, 1)
        fallout.set_local_var(0, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
end

function map_enter_p_proc()
    fallout.set_external_var("contpan", fallout.self_obj())
end

function map_update_p_proc()
    fallout.set_external_var("contpan", fallout.self_obj())
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
