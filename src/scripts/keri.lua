local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local damage_p_proc
local Keri00
local Keri01
local Keri02
local Keri03
local Keri04
local Keri04a
local Keri04b
local Keri05
local Keri06
local Keri07
local Keri08
local Keri09
local Keri10
local Keri10a
local Keri11
local Keri12
local Keri13
local Keri14
local Keri15
local Keri16
local Keri17
local Keri18
local Keri19
local Keri20
local Keri21a
local Keri21b
local Keri21c
local Keri21d
local Keri27
local Keri28
local Keri29
local Keri30
local Keri33
local Keri34
local KeriEnd
local KeriCombat
local Jailed
local RecalcDate
local RecalcDateString
local SendAroundHouse

local hostile = 0
local Only_Once = 1
local days = 0
local DayString = "None"
local SetDayNight = 0
local Destination = 0
local LastMove = 0

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

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 36)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
        LastMove = 12127
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    else
                        if fallout.script_action() == 22 then
                            timed_event_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    local v0 = 0
    if hostile then
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if SetDayNight == 0 then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 8)), 1)
        SetDayNight = 1
    end
    v0 = fallout.tile_num(fallout.self_obj())
    if v0 == 12126 then
        if fallout.anim_busy(fallout.self_obj()) == 0 then
            if fallout.has_trait(1, fallout.self_obj(), 10) ~= 0 then
                fallout.anim(fallout.self_obj(), 1000, 0)
            end
        end
    else
        if v0 == 11927 then
            if fallout.anim_busy(fallout.self_obj()) == 0 then
                if fallout.has_trait(1, fallout.self_obj(), 10) ~= 5 then
                    fallout.anim(fallout.self_obj(), 1000, 5)
                end
            end
        else
            if v0 == 12127 then
                if fallout.anim_busy(fallout.self_obj()) == 0 then
                    if fallout.has_trait(1, fallout.self_obj(), 10) ~= 2 then
                        fallout.anim(fallout.self_obj(), 1000, 2)
                    end
                end
            end
        end
    end
end

function pickup_p_proc()
    if fallout.local_var(5) == 0 then
        fallout.dialogue_system_enter()
    else
        Keri10()
    end
end

function talk_p_proc()
    local v0 = 0
    get_reaction()
    if fallout.local_var(13) == 1 then
        if fallout.local_var(11) < (fallout.game_time() // (10 * 60 * 60 * 24 * 365)) then
            fallout.set_local_var(13, 0)
        else
            if (fallout.local_var(10) < fallout.get_month()) or (fallout.local_var(10) == 12) and (fallout.get_month() == 1) and ((fallout.local_var(10) ~= 1) or (fallout.get_month() ~= 12)) then
                fallout.set_local_var(13, 0)
            else
                if (fallout.local_var(9) < fallout.get_day()) and ((fallout.local_var(10) ~= 1) or (fallout.get_month() ~= 12)) then
                    fallout.set_local_var(13, 0)
                end
            end
        end
    end
    RecalcDate()
    v0 = fallout.local_var(9)
    if (fallout.map_var(24) == 1) and (fallout.map_var(28) == 0) then
        Keri13()
    else
        if fallout.local_var(5) == 1 then
            Keri14()
        else
            if fallout.map_var(25) == 1 then
                Keri15()
            else
                if fallout.map_var(204) == 3 then
                    fallout.start_gdialog(595, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Keri19()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    if fallout.map_var(26) == 0 then
                        Keri00()
                    else
                        if fallout.global_var(204) == 4 then
                            fallout.start_gdialog(595, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            Keri27()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        else
                            if (fallout.map_var(26) == 1) and (fallout.local_var(13) == 0) then
                                fallout.start_gdialog(595, fallout.self_obj(), 4, -1, -1)
                                fallout.gsay_start()
                                if fallout.local_var(12) == 0 then
                                    Keri01()
                                else
                                    Keri03()
                                end
                                fallout.gsay_end()
                                fallout.end_dialogue()
                            else
                                if (fallout.local_var(13) == 1) and (v0 == fallout.get_day()) then
                                    fallout.start_gdialog(595, fallout.self_obj(), 4, -1, -1)
                                    fallout.gsay_start()
                                    Keri28()
                                    fallout.gsay_end()
                                    fallout.end_dialogue()
                                else
                                    if (fallout.local_var(13) == 1) and (v0 ~= fallout.get_day()) then
                                        fallout.start_gdialog(595, fallout.self_obj(), 4, -1, -1)
                                        fallout.gsay_start()
                                        Keri29()
                                        fallout.gsay_end()
                                        fallout.end_dialogue()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
    fallout.set_map_var(28, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(595, 100))
end

function timed_event_p_proc()
    SendAroundHouse()
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function Keri00()
    if fallout.local_var(7) == 0 then
        fallout.set_local_var(7, 1)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(595, 101), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(595, 102), 2)
    end
end

function Keri01()
    if fallout.global_var(71) == 0 then
        fallout.set_global_var(71, 1)
    end
    if fallout.global_var(74) == 0 then
        fallout.set_global_var(74, 1)
    end
    if fallout.global_var(72) == 0 then
        fallout.set_global_var(72, 1)
    end
    if fallout.global_var(75) == 0 then
        fallout.set_global_var(75, 1)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        fallout.gsay_reply(595, 103)
    else
        fallout.gsay_reply(595, 104)
    end
    fallout.giq_option(4, 595, 105, Keri02, 50)
    fallout.giq_option(-3, 595, 106, Keri02, 50)
end

function Keri02()
    local v0 = 0
    RecalcDateString()
    v0 = fallout.local_var(9)
    if v0 == fallout.get_day() then
        fallout.gsay_reply(595, fallout.message_str(595, 107) + fallout.message_str(595, 108))
    else
        fallout.gsay_reply(595, fallout.message_str(595, 107) + fallout.message_str(595, 109) + DayString + fallout.message_str(595, 112))
    end
    Keri04()
end

function Keri03()
    local v0 = 0
    if fallout.local_var(1) ~= 1 then
        RecalcDateString()
        v0 = fallout.local_var(9)
        if v0 == fallout.get_day() then
            fallout.gsay_reply(595, fallout.message_str(595, 113))
        else
            fallout.gsay_reply(595, fallout.message_str(595, 114) + DayString + fallout.message_str(595, 117))
        end
        Keri04()
    else
        fallout.gsay_reply(595, 118)
        Keri04()
    end
end

function Keri04()
    fallout.giq_option(4, 595, 119, Keri04a, 50)
    fallout.giq_option(4, 595, 120, Keri05, 50)
    if (fallout.get_critter_stat(fallout.dude_obj(), 34) == 0) and (fallout.local_var(14) == 0) then
        fallout.giq_option(4, 595, 121, Keri04b, 50)
    end
    fallout.giq_option(4, 595, 122, Keri06, 50)
    fallout.giq_option(-3, 595, 123, Keri07, 50)
end

function Keri04a()
    local v0 = 0
    fallout.set_local_var(13, 1)
    RecalcDate()
    v0 = fallout.local_var(9)
    if v0 == fallout.get_day() then
        Keri17()
    else
        Keri18()
    end
end

function Keri04b()
    local v0 = 0
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        Keri08()
    else
        v0 = fallout.get_critter_stat(fallout.dude_obj(), 3)
        if v0 <= 6 then
            Keri16()
        else
            if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
                Keri09()
            else
                Keri16()
            end
        end
    end
end

function Keri05()
    fallout.set_local_var(13, 0)
    fallout.gsay_message(595, 124, 50)
end

function Keri06()
    fallout.set_local_var(13, 0)
    fallout.gsay_message(595, 126, 50)
end

function Keri07()
    fallout.gsay_message(595, 127, 50)
end

function Keri08()
    local v0 = 0
    fallout.set_local_var(14, 1)
    fallout.gsay_message(595, 130, 50)
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 2))
    fallout.gfade_in(600)
    v0 = fallout.create_object_sid(53, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(87, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(110, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.display_msg(fallout.message_str(595, 229))
    fallout.gsay_message(595, 131, 50)
    fallout.gsay_message(595, 132, 50)
end

function Keri09()
    local v0 = 0
    fallout.set_local_var(14, 1)
    fallout.gsay_message(595, 133, 50)
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 2))
    fallout.gfade_in(600)
    v0 = fallout.create_object_sid(53, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(87, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(110, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.display_msg(fallout.message_str(595, 229))
    fallout.gsay_message(595, 131, 50)
    fallout.gsay_message(595, 132, 50)
end

function Keri10()
    if fallout.local_var(5) == 0 then
        fallout.set_local_var(5, 1)
        fallout.set_map_var(25, 1)
        fallout.gsay_reply(595, 136)
        fallout.giq_option(4, 595, 137, Keri10a, 50)
        fallout.giq_option(4, 595, 138, KeriCombat, 51)
        fallout.giq_option(4, 595, 139, KeriCombat, 51)
        fallout.giq_option(-3, 595, 141, KeriCombat, 51)
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(595, 143), 2)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(595, 142), 2)
        end
        KeriCombat()
    end
end

function Keri10a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        Keri11()
    else
        Keri12()
    end
end

function Keri11()
    fallout.gsay_message(595, 144, 50)
end

function Keri12()
    fallout.gsay_reply(595, 145)
    KeriCombat()
end

function Keri13()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(595, 148), 2)
    KeriCombat()
end

function Keri14()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(595, fallout.random(149, 150)), 2)
    KeriCombat()
end

function Keri15()
    if fallout.local_var(6) ~= 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(595, 151 + fallout.local_var(6)), 2)
        fallout.set_local_var(6, fallout.local_var(6) + 1)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(595, 154), 2)
    end
end

function Keri16()
    fallout.gsay_message(595, 155, 50)
end

function Keri17()
    fallout.gsay_reply(595, 156)
    Keri33()
    Keri20()
end

function Keri18()
    RecalcDateString()
    fallout.gsay_reply(595, fallout.message_str(595, 157) + DayString + fallout.message_str(595, 158))
    fallout.giq_option(4, 595, 159, Keri30, 50)
    fallout.giq_option(4, 595, 160, Keri34, 50)
end

function Keri19()
    fallout.set_map_var(25, 1)
    fallout.set_global_var(204, 0)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(595, 161), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(595, 162), 2)
    end
end

function Keri20()
    fallout.giq_option(4, 595, 163, Keri21a, 50)
    fallout.giq_option(4, 595, 164, Keri21b, 50)
    fallout.giq_option(4, 595, 165, Keri21c, 50)
    fallout.giq_option(4, 595, 166, Keri21d, 50)
    fallout.giq_option(4, 595, 167, Keri34, 50)
end

function Keri21a()
    local v0 = 0
    fallout.set_global_var(199, 1)
    v0 = fallout.random(1, 8)
    if v0 == 1 then
        fallout.gsay_message(595, 168, 50)
    else
        if v0 == 2 then
            fallout.gsay_message(595, 169, 50)
        else
            if v0 == 3 then
                fallout.gsay_message(595, 170, 50)
            else
                if v0 == 4 then
                    fallout.gsay_message(595, 171, 50)
                else
                    if v0 == 5 then
                        fallout.gsay_message(595, 172, 50)
                    else
                        if v0 == 6 then
                            fallout.gsay_message(595, 173, 50)
                        else
                            if v0 == 7 then
                                fallout.gsay_message(595, 174, 50)
                            else
                                if v0 == 8 then
                                    fallout.gsay_message(595, 175, 50)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.load_map(59, 3)
end

function Keri21b()
    local v0 = 0
    fallout.set_global_var(199, 1)
    v0 = fallout.random(1, 7)
    if v0 == 1 then
        fallout.gsay_message(595, 168, 50)
    else
        if v0 == 2 then
            fallout.gsay_message(595, 169, 50)
        else
            if v0 == 3 then
                fallout.gsay_message(595, 170, 50)
            else
                if v0 == 4 then
                    fallout.gsay_message(595, 171, 50)
                else
                    if v0 == 5 then
                        fallout.gsay_message(595, 176, 50)
                    else
                        if v0 == 6 then
                            fallout.gsay_message(595, 177, 50)
                        else
                            if v0 == 7 then
                                fallout.gsay_message(595, 178, 50)
                            end
                        end
                    end
                end
            end
        end
    end
    v0 = fallout.random(1, 4)
    fallout.load_map(58, 3)
end

function Keri21c()
    local v0 = 0
    fallout.set_global_var(199, 1)
    v0 = fallout.random(1, 7)
    if v0 == 1 then
        fallout.gsay_message(595, 168, 50)
    else
        if v0 == 2 then
            fallout.gsay_message(595, 169, 50)
        else
            if v0 == 3 then
                fallout.gsay_message(595, 170, 50)
            else
                if v0 == 4 then
                    fallout.gsay_message(595, 171, 50)
                else
                    if v0 == 5 then
                        fallout.gsay_message(595, 179, 50)
                    else
                        if v0 == 6 then
                            fallout.gsay_message(595, 180, 50)
                        else
                            if v0 == 7 then
                                fallout.gsay_message(595, 181, 50)
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.load_map(57, 3)
end

function Keri21d()
    local v0 = 0
    fallout.set_global_var(199, 1)
    v0 = fallout.random(1, 7)
    if v0 == 1 then
        fallout.gsay_message(595, 168, 50)
    else
        if v0 == 2 then
            fallout.gsay_message(595, 169, 50)
        else
            if v0 == 3 then
                fallout.gsay_message(595, 170, 50)
            else
                if v0 == 4 then
                    fallout.gsay_message(595, 171, 50)
                else
                    if v0 == 5 then
                        fallout.gsay_message(595, 182, 50)
                    else
                        if v0 == 6 then
                            fallout.gsay_message(595, 183, 50)
                        else
                            if v0 == 7 then
                                fallout.gsay_message(595, 184, 50)
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.load_map(56, 3)
end

function Keri27()
    fallout.gsay_reply(595, 198)
    fallout.giq_option(4, 595, 199, Keri04a, 50)
    fallout.giq_option(4, 595, 200, Keri05, 50)
    fallout.giq_option(4, 595, 201, Keri06, 50)
    fallout.giq_option(-3, 595, 202, Keri07, 50)
    fallout.giq_option(-3, 595, 203, Keri07, 50)
end

function Keri28()
    fallout.gsay_reply(595, 204)
    fallout.giq_option(4, 595, 205, Keri17, 50)
    fallout.giq_option(4, 595, 206, KeriEnd, 50)
    fallout.giq_option(-3, 595, 207, Keri07, 50)
end

function Keri29()
    local v0 = 0
    RecalcDateString()
    v0 = fallout.local_var(9)
    fallout.gsay_message(595, fallout.message_str(595, 209) + DayString + fallout.message_str(595, 212), 50)
end

function Keri30()
    fallout.set_local_var(13, 1)
end

function Keri33()
    local v0 = 0
    fallout.set_local_var(13, 0)
    fallout.set_global_var(204, 1)
    v0 = fallout.local_var(12)
    fallout.set_local_var(12, v0 + 1)
end

function Keri34()
    fallout.set_local_var(13, 0)
end

function KeriEnd()
end

function KeriCombat()
    fallout.set_map_var(24, 1)
    fallout.set_map_var(25, 1)
    combat()
end

function Jailed()
    fallout.set_map_var(25, 1)
    fallout.gfade_out(600)
    fallout.move_to(fallout.dude_obj(), 21867, 0)
    fallout.gfade_in(600)
end

function RecalcDate()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.get_day()
    if v0 <= 3 then
        v0 = 3
        v1 = fallout.get_month()
        v2 = fallout.game_time() // (10 * 60 * 60 * 24 * 365)
    else
        if (v0 > 3) and (v0 <= 17) then
            v0 = 17
            v1 = fallout.get_month()
            v2 = fallout.game_time() // (10 * 60 * 60 * 24 * 365)
        else
            if v0 > 17 then
                v0 = 3
                v1 = fallout.get_month()
                if v1 == 12 then
                    v1 = 1
                    v2 = (fallout.game_time() // (10 * 60 * 60 * 24 * 365)) + 1
                else
                    v1 = v1 + 1
                    v2 = fallout.game_time() // (10 * 60 * 60 * 24 * 365)
                end
            end
        end
    end
    fallout.set_local_var(9, v0)
    fallout.set_local_var(10, v1)
    fallout.set_local_var(11, v2)
end

function RecalcDateString()
    local v0 = 0
    local v1 = 0
    RecalcDate()
    v0 = fallout.local_var(10)
    v1 = fallout.local_var(9)
    if v0 == 1 then
        DayString = fallout.message_str(595, 217)
    else
        if v0 == 2 then
            DayString = fallout.message_str(595, 218)
        else
            if v0 == 3 then
                DayString = fallout.message_str(595, 219)
            else
                if v0 == 4 then
                    DayString = fallout.message_str(595, 220)
                else
                    if v0 == 5 then
                        DayString = fallout.message_str(595, 221)
                    else
                        if v0 == 6 then
                            DayString = fallout.message_str(595, 222)
                        else
                            if v0 == 7 then
                                DayString = fallout.message_str(595, 223)
                            else
                                if v0 == 8 then
                                    DayString = fallout.message_str(595, 224)
                                else
                                    if v0 == 9 then
                                        DayString = fallout.message_str(595, 225)
                                    else
                                        if v0 == 10 then
                                            DayString = fallout.message_str(595, 226)
                                        else
                                            if v0 == 11 then
                                                DayString = fallout.message_str(595, 227)
                                            else
                                                if v0 == 12 then
                                                    DayString = fallout.message_str(595, 228)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if v1 == 3 then
        DayString = DayString + fallout.message_str(595, 210)
    else
        if v1 == 17 then
            DayString = DayString + fallout.message_str(595, 211)
        end
    end
end

function SendAroundHouse()
    local v0 = 0
    Destination = 0
    v0 = fallout.random(10, 20)
    while Destination == 0 do
        Destination = fallout.random(1, 3)
        if Destination == 1 then
            Destination = 12127
        else
            if Destination == 2 then
                Destination = 12126
            else
                if Destination == 3 then
                    Destination = 11927
                end
            end
        end
        if Destination == LastMove then
            Destination = 0
        end
    end
    LastMove = Destination
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), Destination, -1)
    fallout.reg_anim_func(3, 0)
    fallout.rm_timer_event(fallout.self_obj())
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(v0), 1)
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
    exit_line = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.damage_p_proc = damage_p_proc
return exports
