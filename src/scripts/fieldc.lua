local fallout = require("fallout")

local start
local use_p_proc
local spatial_p_proc
local turn_field_off
local turn_field_on
local toggle_field

local initialized = false
local on_tile = 0

function start()
    if not initialized then
        if fallout.tile_num(fallout.self_obj()) == 21068 then
            if fallout.obj_pid(fallout.self_obj()) == 33554923 then
                if fallout.external_var("field_change") == "off" then
                    fallout.set_map_var(14, 1)
                end
                fallout.set_map_var(8, fallout.self_obj())
                use_p_proc()
            end
        else
            if fallout.tile_num(fallout.self_obj()) == 25088 then
                if fallout.obj_pid(fallout.self_obj()) == 33554923 then
                    if fallout.external_var("field_change") == "off" then
                        fallout.set_map_var(15, 1)
                    end
                    fallout.set_map_var(9, fallout.self_obj())
                    use_p_proc()
                end
            end
        end
        initialized = true
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        else
            if fallout.script_action() == 2 then
                spatial_p_proc()
            end
        end
    end
end

function use_p_proc()
    if fallout.global_var(609) ~= 0 then
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

function spatial_p_proc()
    if (fallout.tile_num(fallout.self_obj()) == 21068) and (fallout.map_var(14) == 0) or ((fallout.tile_num(fallout.self_obj()) == 25088) and (fallout.map_var(15) == 0)) then
        if fallout.tile_num(fallout.source_obj()) == fallout.tile_num(fallout.self_obj()) then
            if not(on_tile) then
                on_tile = 1
                fallout.critter_dmg(fallout.source_obj(), fallout.random(10, 20), 4)
            end
        else
            on_tile = 0
        end
    end
end

function turn_field_off()
    fallout.set_obj_visibility(fallout.self_obj(), 1)
    if fallout.tile_num(fallout.self_obj()) == 21068 then
        fallout.set_map_var(14, 1)
    else
        if fallout.tile_num(fallout.self_obj()) == 25088 then
            fallout.set_map_var(15, 1)
        end
    end
end

function turn_field_on()
    fallout.set_obj_visibility(fallout.self_obj(), 0)
    if fallout.tile_num(fallout.self_obj()) == 21068 then
        fallout.set_map_var(14, 0)
    else
        if fallout.tile_num(fallout.self_obj()) == 25088 then
            fallout.set_map_var(15, 0)
        end
    end
end

function toggle_field()
    if (fallout.tile_num(fallout.self_obj()) == 21068) and (fallout.map_var(14) == 1) or ((fallout.tile_num(fallout.self_obj()) == 25088) and (fallout.map_var(15) == 1)) then
        turn_field_on()
    else
        turn_field_off()
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.spatial_p_proc = spatial_p_proc
return exports
