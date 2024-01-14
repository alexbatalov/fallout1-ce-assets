local fallout = require("fallout")

local start
local use_p_proc
local turn_field_on
local turn_field_off
local toggle_field

local initialized = false

function start()
    if not initialized then
        fallout.set_map_var(11, fallout.self_obj())
        use_p_proc()
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    end
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

function turn_field_on()
    fallout.set_obj_visibility(fallout.self_obj(), false)
    fallout.set_local_var(0, 0)
end

function turn_field_off()
    fallout.set_obj_visibility(fallout.self_obj(), true)
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
exports.use_p_proc = use_p_proc
return exports
