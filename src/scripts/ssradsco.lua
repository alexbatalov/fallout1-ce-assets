local fallout = require("fallout")
local misc = require("lib.misc")

local start
local critter_p_proc
local combat_p_proc
local destroy_p_proc
local timed_event_p_proc

local rndx = 0
local rndy = 0
local critter_tile = 0
local hostile = false
local initialized = false
local start_moving = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 5, 14)
        misc.set_team(self_obj, 5)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    end
end

function critter_p_proc()
    if fallout.random(1, 10) == 1 and not start_moving then
        start_moving = true
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        hostile = true
    end
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 2 then
        if not fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, -1)) then
            local dmg = fallout.random(1, 6)
            fallout.poison(fallout.target_obj(), dmg)
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(2, fallout.global_var(2) - 1)
    if fallout.global_var(2) <= 0 then
        fallout.set_global_var(2, 0)
        fallout.set_global_var(28, 2)
        fallout.set_global_var(43, 2)
        fallout.give_exp_points(500)
        fallout.display_msg(fallout.message_str(517, 100))
        fallout.set_global_var(155, fallout.global_var(155) + 6)
    end
end

function timed_event_p_proc()
    if start_moving then
        local self_obj = fallout.self_obj()
        local tile = fallout.tile_num_in_direction(fallout.tile_num(self_obj), fallout.random(0, 5), 3)
        start_moving = false
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, tile, -1)
        fallout.reg_anim_func(3, 0)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.combat_p_proc = combat_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
