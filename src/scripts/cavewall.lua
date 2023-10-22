local fallout = require("fallout")

local start
local look_at_p_proc
local description_p_proc
local damage_p_proc

local HEXES <const> = {
    22349,
    21544,
    21744,
    21944,
    22144,
    22344,
    22544,
    22744,
    22944,
    21139,
    21339,
    21539,
    21739,
    21939,
    22139,
    22339,
    22539,
    22739,
    22939,
    22940,
    22941,
    22942,
    22943,
}

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(465, 100))
end

function description_p_proc()
    fallout.script_overrides()
    local dude_obj = fallout.dude_obj()
    if fallout.is_success(fallout.do_check(dude_obj, 1, 0)) or fallout.is_success(fallout.do_check(dude_obj, 6, -1)) then
        fallout.display_msg(fallout.message_str(465, 101))
    else
        fallout.display_msg(fallout.message_str(465, 100))
    end
end

function damage_p_proc()
    if fallout.map_var(0) == 0 then
        fallout.set_map_var(0, 1)
        fallout.gfade_out(600)
        local scenery_obj = fallout.create_object_sid(33554839, 0, 0, -1)
        fallout.move_to(scenery_obj, 21744, 0)
        for index = 1, #HEXES do
            fallout.create_object_sid(33554499, HEXES[index], 0, -1)
        end
        fallout.set_global_var(155, fallout.global_var(155) + 3)
        local xp = fallout.global_var(2) * 75 + 75
        if xp < 300 then
            xp = 300
        end
        if fallout.global_var(2) > 0 then
            xp = xp + 500
        end
        fallout.set_global_var(28, 2)
        fallout.set_global_var(43, 2)
        fallout.display_msg(fallout.message_str(766, 188) .. " " .. fallout.message_str(766, 103) .. " " .. xp .. " " .. fallout.message_str(766, 104))
        fallout.give_exp_points(xp)
        fallout.gfade_in(600)
        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), 21155) >= 15 then
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
