local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local guard00
local guard01
local guard02
local guard03
local guard04
local guard05
local guard06
local guard07
local guard07a
local guard07b
local guard08
local guard09
local guard10
local guard11
local guard12
local guard13
local guard14
local guard15
local guardend
local combat
local weapon_check
local critter_p_proc
local damage_p_proc

local hostile = false
local initialized = false
local Weapons = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 6)
        misc.set_ai(self_obj, 20)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.local_var(5) == 1 then
        fallout.display_msg(fallout.message_str(439, 100))
    elseif fallout.global_var(116) == 1 then
        guard00()
    elseif Weapons and fallout.external_var("killing_women") == 0 and fallout.global_var(611) ~= 1 then
        guard02()
    else
        fallout.set_local_var(3, 1)
        reaction.get_reaction()
        fallout.start_gdialog(439, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.local_var(4) == 0 then
            fallout.set_local_var(4, 1)
            guard04()
        else
            guard15()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_global_var(254, 1)
    fallout.set_global_var(611, 0)
    fallout.set_global_var(115, fallout.global_var(115) - 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(439, 101))
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        if misc.is_armed(fallout.dude_obj()) then
            combat()
        end
    elseif event == 2 then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
            combat()
        end
    elseif event == 3 then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
            combat()
        end
    end
end

function guard00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(439, fallout.random(102, 106)), 8)
end

function guard01()
    local rndx = fallout.random(1, 5)
    if rndx == 1 then
        fallout.gsay_message(439, 107, 50)
    elseif rndx == 2 then
        fallout.gsay_message(439, 108, 50)
    elseif rndx == 3 then
        fallout.gsay_message(439, 109, 50)
    elseif rndx == 4 then
        fallout.gsay_message(439, 110, 50)
    elseif rndx == 5 then
        fallout.gsay_message(439, 111, 50)
    end
end

function guard02()
    local self_obj = fallout.self_obj()
    fallout.float_msg(self_obj, fallout.message_str(439, fallout.random(112, 115)), 8)
    fallout.add_timer_event(self_obj, fallout.game_ticks(9), 1)
end

function guard03()
    local rndx = fallout.random(1, 3)
    if rndx == 1 then
        fallout.gsay_message(439, 116, 50)
    elseif rndx == 2 then
        fallout.gsay_message(439, 117, 50)
    elseif rndx == 3 then
        fallout.gsay_message(439, 118, 50)
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 2)
end

function guard04()
    fallout.gsay_reply(439, 119)
    if fallout.global_var(103) == 1 and fallout.global_var(218) == 1 then
        fallout.giq_option(4, 439, 120, guard07, 50)
    end
    fallout.giq_option(4, 439, 121, guard06, 50)
    fallout.giq_option(-3, 439, 122, guard05, 50)
end

function guard05()
    fallout.gsay_message(439, 123, 50)
end

function guard06()
    fallout.gsay_message(439, 124, 50)
    reaction.DownReact()
end

function guard07()
    fallout.gsay_reply(439, 125)
    fallout.giq_option(4, 439, 126, guard08, 50)
    fallout.giq_option(6, 439, 127, guard07a, 50)
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) then
        fallout.giq_option(4, 439, 128, guard07b, 50)
    end
end

function guard07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        guard09()
    else
        guard11()
    end
end

function guard07b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        guard12()
    else
        guard13()
    end
end

function guard08()
    fallout.gsay_message(439, 129, 50)
end

function guard09()
    fallout.gsay_reply(439, 130)
    fallout.giq_option(6, 439, 131, guard10, 50)
end

function guard10()
    fallout.gsay_message(439, 132, 50)
end

function guard11()
    fallout.gsay_message(439, 133, 50)
end

function guard12()
    fallout.gsay_message(439, 134, 50)
    fallout.set_local_var(5, 1)
end

function guard13()
    fallout.gsay_message(439, 135, 50)
    combat()
end

function guard14()
    fallout.gsay_message(439, 136, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(12), 3)
end

function guard15()
    fallout.gsay_message(439, 137, 50)
end

function guardend()
end

function combat()
    if fallout.global_var(116) == 1 then
        misc.set_team(fallout.self_obj(), 87)
    end
    hostile = true
end

function weapon_check()
    if misc.is_armed(fallout.dude_obj()) then
        Weapons = false
    else
        Weapons = true
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)
    local self_can_see_dude = fallout.obj_can_see_obj(self_obj, dude_obj)
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    else
        if fallout.global_var(116) ~= 0 then
            fallout.set_global_var(254, 0)
            if distance_self_to_dude < 3 then
                local self_tile_num = fallout.tile_num(self_obj)
                local dest = fallout.tile_num_in_direction(self_tile_num, fallout.random(0, 5), 3)
                if fallout.tile_distance(self_tile_num, dest) > 2 then
                    if fallout.random(0, 9) == 0 then
                        fallout.float_msg(self_obj, fallout.message_str(136, fallout.random(102, 106)), 8)
                    end
                    fallout.animate_move_obj_to_tile(self_obj, dest, 0)
                end
            end
        else
            if fallout.global_var(213) ~= 0 then
                fallout.set_global_var(254, 1)
            end
            if self_can_see_dude then
                if fallout.global_var(214) ~= 0 then
                    fallout.set_global_var(254, 1)
                end
            end
            if fallout.map_var(2) == 1 then
                fallout.set_global_var(254, 1)
            end
        end
    end
    if fallout.global_var(254) ~= 0 and self_can_see_dude then
        hostile = true
    end
    if distance_self_to_dude > 12 then
        hostile = false
    end
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if self_can_see_dude and fallout.global_var(611) ~= 1 then
            if misc.is_armed(dude_obj)
                and not Weapons
                and fallout.external_var("killing_women") == 0 then
                Weapons = true
                fallout.dialogue_system_enter()
            end
        end
    end
end

function damage_p_proc()
    if fallout.global_var(116) == 0 then
        fallout.set_global_var(254, 1)
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
