local fallout = require("fallout")

local start
local timed_event_p_proc
local use_p_proc
local map_update_p_proc
local map_enter_p_proc
local turn_field_off
local turn_field_on
local toggle_field

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.set_external_var("fieldH_Ptr", self_obj)
        fallout.set_local_var(1, fallout.tile_num(self_obj))
        use_p_proc()
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    end
end

function timed_event_p_proc()
    use_p_proc()
end

function use_p_proc()
    if fallout.global_var(609) ~= 0 then
        fallout.set_external_var("field_change", "off")
    end
    if fallout.source_obj() ~= fallout.dude_obj() then
        local change = fallout.external_var("field_change")
        if change == "toggle" then
            toggle_field()
        elseif change == "off" then
            turn_field_off()
        elseif change == "on" then
            turn_field_on()
        end
    end
end

function map_update_p_proc()
    fallout.set_external_var("fieldH_Ptr", fallout.self_obj())
end

function map_enter_p_proc()
    fallout.set_external_var("fieldH_Ptr", fallout.self_obj())
end

function turn_field_off()
    fallout.set_obj_visibility(fallout.self_obj(), true)
    fallout.set_local_var(0, 1)
end

function turn_field_on()
    fallout.set_obj_visibility(fallout.self_obj(), false)
    fallout.set_local_var(0, 0)
end

function toggle_field()
    if fallout.local_var(0) ~= 0 then
        turn_field_on()
    else
        turn_field_off()
    end
end

local exports = {}
exports.start = start
exports.timed_event_p_proc = timed_event_p_proc
exports.use_p_proc = use_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_enter_p_proc = map_enter_p_proc
return exports
