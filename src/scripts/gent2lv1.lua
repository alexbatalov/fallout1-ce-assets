local fallout = require("fallout")

local start
local use_p_proc
local use_obj_on_p_proc

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    else
        if fallout.script_action() == 7 then
            use_obj_on_p_proc()
        end
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
    local v0 = 0
    if fallout.obj_pid(fallout.obj_being_used_with()) == 127 then
        fallout.script_overrides()
        fallout.set_map_var(0, 1)
        fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
        fallout.destroy_object(fallout.obj_being_used_with())
        v0 = fallout.create_object_sid(33555000, fallout.tile_num(fallout.self_obj()), fallout.elevation(fallout.self_obj()), 511)
        fallout.display_msg(fallout.message_str(786, 103))
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
