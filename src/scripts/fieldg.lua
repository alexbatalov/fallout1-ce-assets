local fallout = require("fallout")

local start
local timed_event_p_proc
local use_p_proc
local turn_field_on
local turn_field_off
local toggle_field

local initialized = false

function start()
    if not initialized then
        fallout.set_map_var(1, fallout.self_obj())
        use_p_proc()
        initialized = true
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        else
            if fallout.script_action() == 22 then
                timed_event_p_proc()
            end
        end
    end
end

function timed_event_p_proc()
    use_p_proc()
end

function use_p_proc()
    if fallout.global_var(609) then
        fallout.set_external_var("field_change", "off")
    end
    if fallout.source_obj() ~= fallout.dude_obj() then
        if fallout.external_var("field_change") == "toggle" then
            toggle_field()
        else
            if fallout.external_var("field_change") == "off" then
                turn_field_off()
            else
                if fallout.external_var("field_change") == "on" then
                    turn_field_on()
                end
            end
        end
    end
end

function turn_field_on()
    fallout.set_obj_visibility(fallout.self_obj(), 0)
    fallout.set_local_var(0, 0)
end

function turn_field_off()
    fallout.set_obj_visibility(fallout.self_obj(), 1)
    fallout.set_local_var(0, 1)
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
return exports
