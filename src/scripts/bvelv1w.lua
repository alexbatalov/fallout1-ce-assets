local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc
local use_obj_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 6 then
        use_obj_on_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function description_p_proc()
    if fallout.obj_pid(fallout.self_obj()) ~= 33555334 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(786, 104))
    end
end

function use_p_proc()
    fallout.script_overrides()
    if fallout.obj_pid(fallout.self_obj()) == 33555334 then
        fallout.move_to(fallout.dude_obj(), 23118, 1)
    else
        fallout.display_msg(fallout.message_str(786, 104))
    end
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    if fallout.obj_pid(item_obj) == 127 then
        fallout.script_overrides()
        local self_obj = fallout.self_obj()
        if fallout.obj_pid(self_obj) ~= 33555334 then
            fallout.set_local_var(0, 1)
            fallout.rm_obj_from_inven(fallout.dude_obj(), item_obj)
            fallout.create_object_sid(33555334, fallout.tile_num(self_obj), fallout.elevation(self_obj), 200)
            fallout.display_msg(fallout.message_str(786, 105))
            fallout.destroy_object(item_obj)
            fallout.destroy_object(self_obj)
        else
            fallout.display_msg(fallout.message_str(786, 106))
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
