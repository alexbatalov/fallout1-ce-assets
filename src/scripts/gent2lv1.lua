local fallout = require("fallout")

local start
local use_p_proc
local use_obj_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function use_p_proc()
    if fallout.map_var(0) == 1 then
        fallout.load_map("Glow1.map", 1)
    else
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(786, 102))
    end
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    if fallout.obj_pid(item_obj) == 127 then
        fallout.script_overrides()
        fallout.set_map_var(0, 1)
        fallout.rm_obj_from_inven(fallout.dude_obj(), item_obj)
        fallout.destroy_object(item_obj)
        local self_obj = fallout.self_obj()
        fallout.create_object_sid(33555000, fallout.tile_num(self_obj), fallout.elevation(self_obj), 511)
        fallout.display_msg(fallout.message_str(786, 103))
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
