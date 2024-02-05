local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local guard00
local guard01
local guard02
local guard03
local guard04
local guard05
local guard06
local guard07
local guard08
local guard09
local guard10
local guard11
local guard12
local guard13
local guard06a
local guard07a
local guard07_1
local guardend
local set_sleep_tile

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = false
local initialized = false
local round_counter = 0
local Warned_Tile = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 2)
        fallout.critter_add_trait(self_obj, 1, 5, 4)
        if fallout.local_var(10) == 0 then
            fallout.set_local_var(10, fallout.tile_num(self_obj))
        end
        home_tile = fallout.local_var(10)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
    end
    if round_counter > 3 then
        if fallout.global_var(246) == 0 then
            fallout.set_global_var(246, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        if fallout.global_var(246) == 1 then
            hostile = true
        end
    end
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            if misc.is_armed(dude_obj) then
                if fallout.map_var(0) == 1 then
                    guard11()
                end
            end
            if fallout.global_var(246) ~= 0 then
                hostile = true
            end
        end
        if fallout.local_var(7) == 1 then
            if fallout.tile_distance(fallout.tile_num(self_obj), fallout.tile_num(dude_obj)) < fallout.tile_distance(fallout.tile_num(self_obj), Warned_Tile) then
                hostile = true
            end
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(113, 100))
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
    if fallout.source_obj() == fallout.dude_obj() then
        if reputation.has_rep_berserker() then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if reputation.has_rep_champion() then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if fallout.global_var(159) % 5 == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(113, 100))
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if reputation.has_rep_berserker() then
        fallout.set_global_var(156, 1)
        fallout.set_global_var(157, 0)
    end
    reaction.get_reaction()
    if fallout.local_var(9) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    elseif fallout.global_var(246) ~= 0 then
        fallout.set_local_var(4, 1)
        guard00()
    elseif fallout.global_var(26) == 1 then
        fallout.set_local_var(4, 1)
        guard01()
    elseif fallout.global_var(26) == 2 and fallout.local_var(8) == 0 then
        fallout.set_local_var(4, 1)
        guard02()
    elseif fallout.global_var(26) == 3 then
        fallout.set_local_var(4, 1)
        guard03()
    elseif fallout.local_var(4) == 1 then
        if fallout.local_var(1) < 2 then
            guard13()
        else
            guard12()
        end
    else
        fallout.set_local_var(4, 1)
        if fallout.local_var(1) < 2 then
            guard10()
        else
            fallout.start_gdialog(113, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            guard04()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function timed_event_p_proc()
    if misc.is_armed(fallout.dude_obj()) then
        hostile = true
    else
        fallout.set_map_var(0, 0)
    end
end

function guard00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 101), 7)
    Warned_Tile = fallout.tile_num(fallout.dude_obj())
    fallout.set_local_var(7, 1)
end

function guard01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 102), 7)
end

function guard02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 103), 7)
    fallout.set_local_var(8, 1)
    reaction.TopReact()
end

function guard03()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 104), 7)
end

function guard04()
    fallout.gsay_reply(113, 105)
    fallout.giq_option(4, 113, 106, guard05, 50)
    fallout.giq_option(5, 113, 107, guard07, 50)
    fallout.giq_option(-3, 113, 108, guard05, 50)
end

function guard05()
    fallout.gsay_reply(113, 109)
    fallout.giq_option(4, 113, 110, guard06, 50)
    fallout.giq_option(-3, 113, 111, guardend, 50)
end

function guard06()
    fallout.gsay_reply(113, 112)
    fallout.giq_option(4, 113, 113, guardend, 50)
    fallout.giq_option(4, 113, 114, guard06a, 50)
end

function guard07()
    fallout.gsay_reply(113, 115)
    fallout.gsay_option(113, 126, guard07_1, 50)
end

function guard08()
    fallout.gsay_reply(113, 118)
    fallout.giq_option(4, 113, 119, guardend, 50)
    fallout.giq_option(4, 113, 120, reaction.DownReact, 50)
end

function guard09()
    fallout.gsay_reply(113, 121)
    fallout.giq_option(4, 113, reaction.Goodbyes(), guardend, 50)
end

function guard10()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 122), 7)
end

function guard11()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 123), 7)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
    fallout.set_map_var(0, 1)
end

function guard12()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 124), 7)
end

function guard13()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 125), 7)
end

function guard06a()
    hostile = true
    reaction.BottomReact()
end

function guard07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        guard09()
    else
        guard08()
    end
end

function guard07_1()
    fallout.gsay_reply(113, 116)
    fallout.giq_option(5, 113, 117, guard07a, 50)
end

function guardend()
end

function set_sleep_tile()
    if home_tile == 15283 then
        sleep_tile = 14685
    elseif home_tile == 15886 then
        sleep_tile = 14479
    elseif home_tile == 15881 then
        sleep_tile = 15479
    end
    wake_time = fallout.random(610, 650)
    sleep_time = fallout.random(2110, 2150)
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
