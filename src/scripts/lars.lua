local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0
local g3 = 0
local g4 = 0
local g5 = 0
local g6 = 0
local g7 = 0

local start
local combat_p_proc
local critter_p_proc
local description_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local Lars00
local Lars01
local Lars02
local Lars03
local Lars04
local Lars05
local Lars06
local Lars07
local Lars08
local Lars09
local Lars10
local Lars11
local Lars12
local Lars13
local Lars14
local Lars15
local Lars16
local Lars17
local Lars18
local Lars19
local Lars20
local Lars21
local Lars22
local Lars23
local Lars24
local Lars25
local Lars26
local Lars27
local LarsEnd
local LarsKillNeal

-- ?import? variable hostile
-- ?import? variable initialized
-- ?import? variable round_counter
-- ?import? variable Lars_bust_Skulz
-- ?import? variable Lars_kill_Neal
-- ?import? variable nail_Gizmo
-- ?import? variable wait_for_Lars
-- ?import? variable removal_ptr

local get_reaction
local ReactToLevel
local LevelToReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

-- ?import? variable exit_line

local timed_event_p_proc

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 3 then
            description_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 15 then
                        map_enter_p_proc()
                    else
                        if fallout.script_action() == 4 then
                            pickup_p_proc()
                        else
                            if fallout.script_action() == 11 then
                                talk_p_proc()
                            end
                        end
                    end
                end
            end
        end
    end
end

function combat_p_proc()
    if fallout.cur_map_index() ~= 11 then
        if fallout.fixed_param() == 4 then
            g2 = g2 + 1
        end
        if g2 > 3 then
            if fallout.global_var(247) == 0 then
                fallout.set_global_var(247, 1)
                fallout.set_global_var(155, fallout.global_var(155) - 5)
            end
        end
    end
end

function critter_p_proc()
    if g0 then
        g0 = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.map_var(0) == 1 then
            fallout.item_caps_adjust(fallout.dude_obj(), 500)
            fallout.float_msg(fallout.self_obj(), fallout.message_str(518, 162), 3)
            fallout.set_map_var(0, 2)
        end
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function description_p_proc()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0))) then
        fallout.display_msg(fallout.message_str(518, 103))
    else
        fallout.display_msg(fallout.message_str(518, 102))
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
    end
    if fallout.cur_map_index() == 11 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(518, 168))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) ~= 0 then
        fallout.display_msg(fallout.message_str(518, 101))
    else
        fallout.display_msg(fallout.message_str(518, 100))
    end
end

function map_enter_p_proc()
    if fallout.cur_map_index() == 11 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
    else
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 12)
    end
    if (fallout.global_var(38) == 1) and (fallout.cur_map_index() == 11) then
        fallout.destroy_object(fallout.self_obj())
    end
end

function pickup_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(518, 104), 0)
    g0 = 1
end

function talk_p_proc()
    get_reaction()
    fallout.start_gdialog(518, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.global_var(158) > 2 then
        Lars01()
    else
        if fallout.global_var(247) == 1 then
            Lars27()
        else
            if (fallout.global_var(38) == 1) and (fallout.global_var(104) ~= 2) then
                Lars26()
            else
                if fallout.global_var(104) == 1 then
                    fallout.set_local_var(4, 1)
                    Lars21()
                else
                    if fallout.local_var(4) == 0 then
                        Lars00()
                    else
                        if fallout.global_var(555) == 2 then
                            Lars19()
                        else
                            Lars12()
                        end
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if g5 then
        g5 = 0
        fallout.load_map(11, 4)
    else
        if (fallout.global_var(555) == 2) and (fallout.local_var(5) == 0) then
            fallout.set_local_var(5, 1)
            fallout.gfade_out(600)
            fallout.give_exp_points(500)
            fallout.set_global_var(155, fallout.global_var(155) + 3)
            fallout.display_msg(fallout.message_str(518, 174))
            fallout.game_time_advance(fallout.game_ticks(7200))
            fallout.gfade_in(600)
        else
            if g6 then
                fallout.gfade_out(600)
                fallout.game_time_advance(fallout.game_ticks(3000))
                fallout.set_global_var(104, 2)
                fallout.gfade_in(600)
                g6 = 0
            else
                if g4 then
                    g4 = 0
                    fallout.load_map(11, 7)
                else
                    if g3 then
                        g3 = 0
                        fallout.gfade_out(600)
                        fallout.set_global_var(555, 2)
                        fallout.set_global_var(283, 0)
                        fallout.display_msg(fallout.message_str(518, 167))
                        fallout.gfade_in(600)
                    end
                end
            end
        end
    end
end

function Lars00()
    fallout.gsay_reply(518, 105)
    fallout.giq_option(4, 518, 106, Lars02, 50)
    fallout.giq_option(4, 518, 107, Lars05, 50)
    fallout.giq_option(4, 518, 108, Lars10, 50)
    fallout.giq_option(-3, 518, 109, Lars20, 50)
    if fallout.global_var(555) == 1 then
        fallout.giq_option(6, 518, 110, Lars13, 50)
    end
    if fallout.global_var(104) == 1 then
        fallout.giq_option(4, 518, 161, Lars22, 49)
    end
    if fallout.global_var(283) > time.game_time_in_days() then
        fallout.giq_option(4, 518, 166, Lars24, 49)
    end
end

function Lars01()
    fallout.gsay_message(518, 111, 51)
    g0 = 1
end

function Lars02()
    fallout.gsay_reply(518, 112)
    fallout.giq_option(4, 518, 113, Lars03, 50)
    Goodbyes()
    fallout.giq_option(4, 518, g7, LarsEnd, 50)
end

function Lars03()
    fallout.gsay_reply(518, 114)
    fallout.giq_option(4, 518, 115, Lars04, 50)
    Goodbyes()
    fallout.giq_option(4, 518, g7, LarsEnd, 50)
end

function Lars04()
    DownReact()
    fallout.gsay_message(518, 116, 51)
end

function Lars05()
    fallout.gsay_reply(518, 117)
    fallout.giq_option(4, 518, 118, Lars04, 50)
    fallout.giq_option(4, 518, 119, Lars06, 50)
    fallout.giq_option(6, 518, 120, Lars07, 50)
end

function Lars06()
    fallout.gsay_message(518, 121, 50)
end

function Lars07()
    fallout.gsay_reply(518, 122)
    fallout.giq_option(4, 518, 123, Lars08, 50)
    fallout.giq_option(4, 518, 124, Lars09, 50)
end

function Lars08()
    fallout.set_global_var(555, 1)
    fallout.gsay_message(518, 125, 50)
end

function Lars09()
    fallout.gsay_message(518, 126, 50)
end

function Lars10()
    local v0 = 0
    fallout.set_local_var(4, 1)
    v0 = fallout.message_str(518, 128) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(518, 129)
    fallout.gsay_reply(518, 127)
    fallout.giq_option(4, 518, v0, Lars11, 50)
    fallout.giq_option(4, 518, 130, Lars04, 50)
    if fallout.global_var(104) == 1 then
        fallout.giq_option(4, 518, 160, Lars22, 49)
    end
end

function Lars11()
    local v0 = 0
    v0 = fallout.message_str(518, 131) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(518, 132)
    fallout.gsay_reply(518, v0)
    fallout.giq_option(4, 518, 133, Lars05, 50)
    fallout.giq_option(4, 518, 134, Lars02, 50)
    Goodbyes()
    fallout.giq_option(4, 518, g7, LarsEnd, 50)
end

function Lars12()
    if fallout.local_var(1) > 1 then
        fallout.gsay_reply(518, 135)
    else
        if fallout.global_var(104) == 2 then
            fallout.gsay_reply(518, 171)
        else
            fallout.gsay_reply(518, 136)
        end
    end
    if not(fallout.global_var(555)) then
        fallout.giq_option(4, 518, 137, Lars18, 50)
    end
    fallout.giq_option(4, 518, 138, LarsEnd, 50)
    if fallout.global_var(257) and (fallout.global_var(555) == 1) then
        fallout.giq_option(4, 518, 139, Lars14, 50)
    end
    if fallout.global_var(283) > time.game_time_in_days() then
        fallout.giq_option(4, 518, 166, Lars24, 49)
    end
end

function Lars13()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(518, 140)
    fallout.giq_option(4, 518, 141, Lars17, 50)
    if fallout.global_var(257) ~= 0 then
        fallout.giq_option(4, 518, 142, Lars16, 50)
    end
end

function Lars14()
    fallout.gsay_reply(518, 143)
    fallout.giq_option(4, 518, 144, Lars15, 50)
    if fallout.global_var(257) ~= 0 then
        fallout.giq_option(4, 518, 145, Lars16, 50)
    end
end

function Lars15()
    fallout.gsay_reply(518, 146)
    fallout.giq_option(4, 518, 147, LarsEnd, 50)
    if fallout.global_var(257) ~= 0 then
        fallout.giq_option(4, 518, 148, Lars16, 50)
    end
end

function Lars16()
    fallout.set_global_var(555, 2)
    fallout.gsay_message(518, 149, 49)
end

function Lars17()
    DownReact()
    fallout.gsay_message(518, 150, 51)
end

function Lars18()
    fallout.set_global_var(555, 1)
    fallout.gsay_reply(518, 151)
    Goodbyes()
    fallout.giq_option(4, 518, g7, LarsEnd, 50)
end

function Lars19()
    fallout.gsay_message(518, 152, 50)
end

function Lars20()
    fallout.gsay_message(518, 153, 50)
end

function Lars21()
    fallout.gsay_reply(518, 155)
    fallout.giq_option(4, 518, 156, Lars22, 49)
    fallout.giq_option(4, 518, 157, Lars23, 50)
    fallout.giq_option(-3, 518, 172, Lars22, 50)
    fallout.giq_option(-3, 518, 173, Lars23, 50)
end

function Lars22()
    fallout.gsay_message(518, 158, 49)
    g5 = 1
end

function Lars23()
    fallout.gsay_message(518, 159, 50)
    g6 = 1
end

function Lars24()
    fallout.set_global_var(287, 1)
    fallout.gsay_reply(518, 163)
    fallout.giq_option(4, 518, 164, Lars25, 50)
    fallout.giq_option(4, 518, 165, LarsKillNeal, 49)
    fallout.set_local_var(4, 1)
end

function Lars25()
    g3 = 1
    fallout.set_local_var(5, 1)
end

function Lars26()
    fallout.gsay_message(518, 169, 51)
end

function Lars27()
    fallout.gsay_message(518, 170, 51)
    fallout.rm_timer_event(fallout.self_obj())
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 1)
end

function LarsEnd()
end

function LarsKillNeal()
    g4 = 1
end

function get_reaction()
    if fallout.local_var(2) == 0 then
        fallout.set_local_var(0, 50)
        fallout.set_local_var(1, 2)
        fallout.set_local_var(2, 1)
        fallout.set_local_var(0, fallout.local_var(0) + (5 * fallout.get_critter_stat(fallout.dude_obj(), 3)) - 25)
        fallout.set_local_var(0, fallout.local_var(0) + (10 * fallout.has_trait(0, fallout.dude_obj(), 10)))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            end
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            end
        end
        if fallout.global_var(158) > 2 then
            fallout.set_local_var(0, fallout.local_var(0) - 30)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) - 20)
        end
        ReactToLevel()
    end
end

function ReactToLevel()
    if fallout.local_var(0) <= 25 then
        fallout.set_local_var(1, 1)
    else
        if fallout.local_var(0) <= 75 then
            fallout.set_local_var(1, 2)
        else
            fallout.set_local_var(1, 3)
        end
    end
end

function LevelToReact()
    if fallout.local_var(1) == 1 then
        fallout.set_local_var(0, fallout.random(1, 25))
    else
        if fallout.local_var(1) == 2 then
            fallout.set_local_var(0, fallout.random(26, 75))
        else
            fallout.set_local_var(0, fallout.random(76, 100))
        end
    end
end

function UpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 10)
    ReactToLevel()
end

function DownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 10)
    ReactToLevel()
end

function BottomReact()
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function TopReact()
    fallout.set_local_var(0, 100)
    fallout.set_local_var(1, 3)
end

function BigUpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 25)
    ReactToLevel()
end

function BigDownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 25)
    ReactToLevel()
end

function UpReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(1, 3)
    end
    LevelToReact()
end

function DownReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) - 1)
    if fallout.local_var(1) < 1 then
        fallout.set_local_var(1, 1)
    end
    LevelToReact()
end

function Goodbyes()
    g7 = fallout.message_str(634, fallout.random(100, 105))
end

function timed_event_p_proc()
    g0 = 1
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
