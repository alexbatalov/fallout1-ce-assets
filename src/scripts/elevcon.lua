local fallout = require("fallout")

local start
local use_p_proc
local map_enter_p_proc
local map_exit_p_proc
local look_at_p_proc

local spot1 = 17140
local field1 = nil

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 16 then
        map_exit_p_proc()
    end
end

function use_p_proc()
    if fallout.local_var(0) ~= 0 then
        fallout.set_obj_visibility(field1, false)
        fallout.set_local_var(0, 0)
    else
        if fallout.has_skill(fallout.dude_obj(), 8) > 50 then
            fallout.set_external_var("signal_mutants", 1)
        end
        fallout.set_obj_visibility(field1, true)
        fallout.set_local_var(0, 1)
    end
end

function map_enter_p_proc()
    field1 = fallout.create_object_sid(33554921, spot1, 0, -1)
    fallout.set_obj_visibility(field1, fallout.local_var(0) == 1)
end

function map_exit_p_proc()
    fallout.destroy_object(field1)
end

function look_at_p_proc()
    fallout.script_overrides()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
