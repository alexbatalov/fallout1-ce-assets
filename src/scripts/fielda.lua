local fallout = require("fallout")

local start
local use_p_proc
local turn_field_on
local turn_field_off
local toggle_field

local initialized = false

function start()
    if not initialized then
        if fallout.elevation(fallout.self_obj()) == 0 then
            if fallout.tile_num(fallout.self_obj()) == 17106 then
                fallout.set_map_var(0, fallout.self_obj())
            else
                if fallout.tile_num(fallout.self_obj()) == 17082 then
                    fallout.set_map_var(1, fallout.self_obj())
                else
                    if fallout.tile_num(fallout.self_obj()) == 26710 then
                        fallout.set_map_var(2, fallout.self_obj())
                    end
                end
            end
        else
            if fallout.tile_num(fallout.self_obj()) == 15520 then
                fallout.set_map_var(3, fallout.self_obj())
            end
        end
        fallout.set_local_var(1, fallout.tile_num(fallout.self_obj()))
        use_p_proc()
        initialized = true
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        end
    end
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
