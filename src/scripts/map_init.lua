local fallout = require("fallout")

local start
local map_enter_p_proc

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    end
end

function map_enter_p_proc()
    local dude_obj = fallout.dude_obj()
    local item_obj
    item_obj = fallout.create_object_sid(4, 0, 0, -1)
    fallout.add_obj_to_inven(dude_obj, item_obj)
    item_obj = fallout.create_object_sid(18, 0, 0, -1)
    fallout.add_obj_to_inven(dude_obj, item_obj)
    item_obj = fallout.create_object_sid(31, 0, 0, -1)
    fallout.add_obj_to_inven(dude_obj, item_obj)
    item_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(dude_obj, item_obj)
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
return exports
