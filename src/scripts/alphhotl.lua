local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc

local PIDS <const> = {
    4,
    18,
    31,
    40,
}

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    end
end

function map_enter_p_proc()
    local dude_obj = fallout.dude_obj()
    for index = 1, #PIDS do
        local item_obj = fallout.create_object_sid(PIDS[index], 0, 0, -1)
        fallout.add_obj_to_inven(dude_obj, item_obj)
    end
end

function map_update_p_proc()
    if fallout.elevation(fallout.dude_obj()) == 0 then
        fallout.set_light_level(1)
    else
        fallout.set_light_level(100)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
