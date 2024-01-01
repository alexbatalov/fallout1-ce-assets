local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.tile_distance(fallout.tile_num(self_obj), 26281) > 3 then
        fallout.animate_move_obj_to_tile(self_obj, 26281, 0)
    else
        if fallout.obj_on_screen(self_obj) then
            fallout.float_msg(self_obj, fallout.message_str(510, 103), 2)
            fallout.attack(fallout.external_var("Killian_ptr"), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_map_var(2, 1)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    if fallout.map_var(2) == 1 then
        fallout.set_global_var(155, fallout.global_var(155) + 2)
        fallout.display_msg(fallout.message_str(510, 104))
        fallout.give_exp_points(400)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(510, 102))
end

function talk_p_proc()
    fallout.display_msg(fallout.message_str(510, fallout.random(100, 101)))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
