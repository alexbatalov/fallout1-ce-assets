local fallout = require("fallout")

local start
local use_p_proc
local spatial_p_proc
local turn_field_off
local turn_field_on
local toggle_field

local initialized = false
local on_tile = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        local self_tile_num = fallout.tile_num(self_obj)
        local self_pid = fallout.obj_pid(self_obj)
        if self_tile_num == 21068 then
            if self_pid == 33554923 then
                if fallout.external_var("field_change") == "off" then
                    fallout.set_map_var(14, 1)
                end
                fallout.set_map_var(8, self_obj)
                use_p_proc()
            end
        elseif self_tile_num == 25088 then
            if self_pid == 33554923 then
                if fallout.external_var("field_change") == "off" then
                    fallout.set_map_var(15, 1)
                end
                fallout.set_map_var(9, self_obj)
                use_p_proc()
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

function spatial_p_proc()
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    if (self_tile_num == 21068 and fallout.map_var(14) == 0)
        or (self_tile_num == 25088 and fallout.map_var(15) == 0) then
        local source_obj = fallout.source_obj()
        if fallout.tile_num(source_obj) == self_tile_num then
            if not on_tile then
                on_tile = true
                fallout.critter_dmg(source_obj, fallout.random(10, 20), 4)
            end
        else
            on_tile = false
        end
    end
end

function turn_field_off()
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    fallout.set_obj_visibility(self_obj, true)
    if self_tile_num == 21068 then
        fallout.set_map_var(14, 1)
    elseif self_tile_num == 25088 then
        fallout.set_map_var(15, 1)
    end
end

function turn_field_on()
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    fallout.set_obj_visibility(self_obj, false)
    if self_tile_num == 21068 then
        fallout.set_map_var(14, 0)
    elseif self_tile_num == 25088 then
        fallout.set_map_var(15, 0)
    end
end

function toggle_field()
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    if (self_tile_num == 21068 and fallout.map_var(14) == 1)
        or (self_tile_num == 25088 and fallout.map_var(15) == 1) then
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
