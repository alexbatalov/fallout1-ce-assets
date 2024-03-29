local fallout = require("fallout")

--- @param fn function
local function create_use_scr(fn)
    local scr = {}
    scr.start = function()
        if fallout.script_action() == 6 then
            fn()
        end
    end
    return scr
end

--- @param fn function
local function create_one_off_spatial_scr(fn)
    local scr = {}
    scr.start = function()
        if fallout.script_action() == 2 then
            if fallout.source_obj() == fallout.dude_obj() then
                if fallout.local_var(0) == 0 then
                    fn()
                    fallout.set_local_var(0, 1)
                end
            end
        end
    end
    return scr
end

--- @param map string | integer
--- @param param integer
local function create_load_map_spatial_scr(map, param)
    local scr = {}
    scr.start = function()
        if fallout.script_action() == 2 then
            if fallout.source_obj() == fallout.dude_obj() then
                fallout.load_map(map, param)
            end
        end
    end
    return scr
end

--- @param map string | integer
--- @param param integer
local function create_load_map_use_scr(map, param)
    local scr = {}
    scr.start = function()
        if fallout.script_action() == 6 then
            fallout.script_overrides()
            fallout.load_map(map, param)
        end
    end
    return scr
end

--- @param elevator integer
local function create_elevator_spatial_scr(elevator)
    local scr = {}
    scr.start = function()
        if fallout.script_action() == 2 then
            if fallout.source_obj() == fallout.dude_obj() then
                fallout.metarule(15, elevator)
            end
        end
    end
    return scr
end

--- @param tile integer
--- @param elevation integer
local function create_elevator_use_scr(tile, elevation)
    local scr = {}
    scr.start = function()
        local script_action = fallout.script_action()
        if script_action == 6 then
            fallout.script_overrides()
            fallout.add_timer_event(fallout.self_obj(), 8, 1)
        elseif script_action == 22 then
            fallout.move_to(fallout.dude_obj(), tile, elevation)
        end
    end
    return scr
end

local exports = {}
exports.create_use_scr = create_use_scr
exports.create_one_off_spatial_scr = create_one_off_spatial_scr
exports.create_load_map_spatial_scr = create_load_map_spatial_scr
exports.create_load_map_use_scr = create_load_map_use_scr
exports.create_elevator_spatial_scr = create_elevator_spatial_scr
exports.create_elevator_use_scr = create_elevator_use_scr
return exports
