local fallout = require("fallout")

local start
local look_at_p_proc
local description_p_proc
local damage_p_proc

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        look_at_p_proc()
    else
        if fallout.script_action() == 14 then
            damage_p_proc()
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(465, 100))
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, -1)) then
        fallout.display_msg(fallout.message_str(465, 101))
    else
        fallout.display_msg(fallout.message_str(465, 100))
    end
end

function damage_p_proc()
    local v0 = 0
    local v1 = 0
    if fallout.map_var(0) == 0 then
        fallout.set_map_var(0, 1)
        fallout.gfade_out(600)
        v0 = fallout.create_object_sid(33554839, 0, 0, -1)
        fallout.move_to(v0, 21744, 0)
        fallout.create_object_sid(33554499, 22349, 0, -1)
        fallout.create_object_sid(33554499, 21544, 0, -1)
        fallout.create_object_sid(33554499, 21744, 0, -1)
        fallout.create_object_sid(33554499, 21944, 0, -1)
        fallout.create_object_sid(33554499, 22144, 0, -1)
        fallout.create_object_sid(33554499, 22344, 0, -1)
        fallout.create_object_sid(33554499, 22544, 0, -1)
        fallout.create_object_sid(33554499, 22744, 0, -1)
        fallout.create_object_sid(33554499, 22944, 0, -1)
        fallout.create_object_sid(33554499, 21139, 0, -1)
        fallout.create_object_sid(33554499, 21339, 0, -1)
        fallout.create_object_sid(33554499, 21539, 0, -1)
        fallout.create_object_sid(33554499, 21739, 0, -1)
        fallout.create_object_sid(33554499, 21939, 0, -1)
        fallout.create_object_sid(33554499, 22139, 0, -1)
        fallout.create_object_sid(33554499, 22339, 0, -1)
        fallout.create_object_sid(33554499, 22539, 0, -1)
        fallout.create_object_sid(33554499, 22739, 0, -1)
        fallout.create_object_sid(33554499, 22939, 0, -1)
        fallout.create_object_sid(33554499, 22940, 0, -1)
        fallout.create_object_sid(33554499, 22941, 0, -1)
        fallout.create_object_sid(33554499, 22942, 0, -1)
        fallout.create_object_sid(33554499, 22943, 0, -1)
        fallout.set_global_var(155, fallout.global_var(155) + 3)
        v1 = (fallout.global_var(2) * 75) + 75
        if v1 < 300 then
            v1 = 300
        end
        if fallout.global_var(2) > 0 then
            v1 = v1 + 500
        end
        fallout.set_global_var(28, 2)
        fallout.set_global_var(43, 2)
        fallout.display_msg(fallout.message_str(766, 188) .. " " .. fallout.message_str(766, 103) .. " " .. v1 .. " " .. fallout.message_str(766, 104))
        fallout.give_exp_points(v1)
        fallout.gfade_in(600)
        if not(fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), 21155) < 15) then
            fallout.metarule(13, 0)
        end
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.damage_p_proc = damage_p_proc
return exports
