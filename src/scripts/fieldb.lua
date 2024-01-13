local fallout = require("fallout")

local start
local use_p_proc
local turn_field_off
local turn_field_on
local toggle_field

local initialized = false

function start()
    if not initialized then
        local cur_map_index = fallout.cur_map_index()
        local self_obj = fallout.self_obj()
        local self_tile_num = fallout.tile_num(self_obj)
        if cur_map_index == 31 then
            if self_tile_num == 15520 then
                fallout.set_map_var(4, self_obj)
            elseif self_tile_num == 19524 then
                fallout.set_map_var(5, self_obj)
            elseif self_tile_num == 25100 then
                fallout.set_map_var(6, self_obj)
            elseif self_tile_num == 26680 then
                fallout.set_map_var(7, self_obj)
            end
        elseif cur_map_index == 32 then
            fallout.set_map_var(5, self_obj)
        end
        fallout.set_local_var(1, self_tile_num)
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

function turn_field_off()
    fallout.set_obj_visibility(fallout.self_obj(), true)
    fallout.set_local_var(0, 1)
end

function turn_field_on()
    fallout.set_obj_visibility(fallout.self_obj(), false)
    fallout.set_local_var(0, 0)
end

function toggle_field()
    if fallout.local_var(0) == 1 then
        turn_field_on()
    else
        turn_field_off()
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
