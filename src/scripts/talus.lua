local fallout = require("fallout")

local start
local do_dialogue
local weapon_check
local set_requisition
local Talus00
local Talus01
local Talus02
local Talus05
local Talus06
local Talus07
local Talus08
local Talus09
local Talus10
local Talus11
local Talus12
local Talus13
local Talus14
local Talus14a
local Talus15
local Talus16
local Talus17
local Talus18
local Talus19
local Talus20
local Talus21
local Talus22
local Talus23
local Talus24
local Talus25
local Talus26
local Talus27
local Talus28
local Talus29
local Talus30
local Talus31
local Talus31a
local Talus32
local Talus33
local Talus34
local Talus35
local Talus37
local Talus38
local Talus39
local Talus40
local Talus41
local Talus42
local Talus43
local Talus44
local Talus45
local Talus46
local Talus47
local Talus49
local Talus50
local Talus51
local Talus51a
local Talus51b
local Talus51c
local Talus51d
local Talus53
local Talus54
local Talus55
local TalusBackground
local TalusAmmo
local TalusEnd
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc

local armed = 0
local temp = 0
local flag1 = 0
local flag5 = 0
local who_vree = 0
local who_rhombus = 0
local who_maxson = 0
local line16flag = 0
local Only_Once = 1
local Hostile = 0
local drugs = 0
local awardex = 0

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

local Talus36

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 2)
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
                if fallout.script_action() == 22 then
                    if fallout.global_var(250) == 0 then
                        TalusBackground()
                    end
                else
                    if fallout.script_action() == 12 then
                        critter_p_proc()
                    else
                        if fallout.script_action() == 18 then
                            destroy_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    weapon_check()
    if armed then
        if fallout.local_var(6) == 0 then
            Talus11()
        else
            if fallout.local_var(6) == 1 then
                Talus12()
            else
                Talus13()
            end
        end
    else
        if (fallout.global_var(109) == 2) and (fallout.local_var(8) == 0) then
            if fallout.local_var(7) == 0 then
                Talus49()
            else
                Talus47()
            end
        else
            if fallout.local_var(7) == 0 then
                Talus00()
            else
                if fallout.local_var(1) == 1 then
                    Talus22()
                else
                    Talus14()
                end
            end
        end
    end
    fallout.set_local_var(7, 1)
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        armed = 1
    else
        armed = 0
    end
end

function set_requisition()
    fallout.set_local_var(5, 1)
    fallout.set_map_var(17, 1)
    fallout.set_map_var(9, 4)
    fallout.set_map_var(14, 1)
    fallout.set_map_var(10, 3)
end

function Talus00()
    fallout.gsay_reply(318, 101)
    fallout.giq_option(8, 318, 102, Talus01, 50)
    fallout.giq_option(4, 318, 103, Talus02, 50)
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 318, 104, Talus07, 50)
    end
    fallout.giq_option(4, 318, 401, Talus28, 50)
    fallout.giq_option(4, 318, 402, Talus28, 50)
    fallout.giq_option(-3, 318, 105, TalusEnd, 50)
end

function Talus01()
    fallout.gsay_reply(318, 106)
    fallout.giq_option(4, 318, 107, Talus05, 50)
    Goodbyes()
    fallout.giq_option(4, 0, exit_line, TalusEnd, 50)
end

function Talus02()
    fallout.gsay_reply(318, 108)
    fallout.giq_option(4, 318, 107, Talus05, 50)
    Goodbyes()
    fallout.giq_option(4, 0, exit_line, TalusEnd, 50)
end

function Talus05()
    fallout.gsay_reply(318, 110)
    fallout.giq_option(7, 318, 111, Talus06, 50)
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 318, 112, Talus07, 50)
    end
    fallout.giq_option(4, 318, 401, Talus28, 50)
    fallout.giq_option(4, 318, 402, Talus28, 50)
    Goodbyes()
    fallout.giq_option(4, 0, exit_line, TalusEnd, 50)
end

function Talus06()
    fallout.gsay_reply(318, 113)
    fallout.giq_option(4, 318, 115, TalusEnd, 50)
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 318, 112, Talus07, 50)
    end
end

function Talus07()
    fallout.gsay_reply(318, 116)
    set_requisition()
    fallout.giq_option(4, 318, 118, Talus08, 50)
    fallout.giq_option(4, 318, 119, Talus42, 51)
    fallout.giq_option(4, 318, 159, TalusEnd, 50)
end

function Talus08()
    fallout.gsay_reply(318, 406)
    if fallout.global_var(109) ~= 2 then
        fallout.giq_option(4, 318, 109, Talus32, 50)
    end
    fallout.giq_option(4, 318, 121, Talus09, 51)
    fallout.giq_option(4, 318, 193, TalusEnd, 50)
end

function Talus09()
    fallout.set_local_var(11, 1)
    DownReact()
    fallout.gsay_message(318, 122, 51)
end

function Talus10()
    fallout.gsay_message(318, 123, 50)
    fallout.gsay_message(318, 124, 50)
    fallout.gsay_reply(318, 125)
    fallout.giq_option(4, 318, 126, TalusEnd, 50)
end

function Talus11()
    fallout.gsay_message(318, 127, 50)
    fallout.set_local_var(6, fallout.local_var(6) + 1)
end

function Talus12()
    fallout.gsay_message(318, 128, 50)
    fallout.set_local_var(6, fallout.local_var(6) + 1)
end

function Talus13()
    fallout.gsay_message(318, 129, 51)
end

function Talus14()
    fallout.gsay_reply(318, fallout.message_str(318, 130) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(318, 131))
    if not(line16flag) then
        fallout.giq_option(5, 318, 132, Talus16, 50)
    else
        fallout.giq_option(5, 318, 133, Talus17, 50)
    end
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 318, 134, Talus15, 50)
    else
        fallout.giq_option(4, 318, 135, TalusAmmo, 50)
    end
    if fallout.local_var(11) == 1 then
        fallout.giq_option(4, 318, 403, Talus44, 51)
    end
    fallout.giq_option(4, 318, 404, Talus29, 50)
    fallout.giq_option(4, 318, 136, TalusEnd, 50)
    fallout.giq_option(-3, 318, 105, TalusEnd, 50)
end

function Talus14a()
    Talus34()
end

function Talus15()
    fallout.gsay_message(318, 137, 50)
    fallout.gsay_reply(318, 138)
    set_requisition()
    fallout.giq_option(4, 318, 118, Talus08, 50)
end

function Talus16()
    line16flag = 1
    fallout.gsay_message(318, 141, 50)
    Talus18()
end

function Talus17()
    fallout.gsay_message(318, 142, 50)
    Talus18()
end

function Talus18()
    fallout.gsay_reply(318, 143)
    fallout.giq_option(4, 318, 144, Talus19, 50)
    fallout.giq_option(4, 318, 145, Talus20, 50)
    fallout.giq_option(4, 318, 146, Talus21, 50)
end

function Talus19()
    who_rhombus = 1
    fallout.gsay_message(318, 147, 50)
    fallout.gsay_reply(318, 148)
    if who_vree == 0 then
        fallout.giq_option(4, 318, 145, Talus20, 50)
    end
    if who_maxson == 0 then
        fallout.giq_option(4, 318, 146, Talus21, 50)
    end
    fallout.giq_option(4, 318, 151, TalusEnd, 50)
end

function Talus20()
    who_vree = 1
    fallout.gsay_message(318, 152, 50)
    fallout.gsay_reply(318, 153)
    if who_rhombus == 0 then
        fallout.giq_option(4, 318, 144, Talus19, 50)
    end
    if who_maxson == 0 then
        fallout.giq_option(4, 318, 146, Talus21, 50)
    end
    fallout.giq_option(4, 318, 156, TalusEnd, 50)
end

function Talus21()
    who_maxson = 1
    fallout.gsay_reply(318, 157)
    if who_rhombus == 0 then
        fallout.giq_option(4, 318, 144, Talus19, 50)
    end
    if who_vree == 0 then
        fallout.giq_option(4, 318, 145, Talus20, 50)
    end
    fallout.giq_option(4, 318, 160, TalusEnd, 50)
end

function Talus22()
    fallout.gsay_reply(318, 161)
    fallout.giq_option(4, 318, 162, DownReact, 51)
    fallout.giq_option(4, 318, 163, TalusEnd, 50)
    if fallout.local_var(5) == 1 then
        fallout.giq_option(4, 318, 135, TalusAmmo, 50)
    end
    fallout.giq_option(-3, 318, 164, Talus24, 51)
    fallout.giq_option(-3, 318, 165, TalusEnd, 50)
end

function Talus23()
    fallout.gsay_message(318, 166, 51)
    DownReact()
end

function Talus24()
    fallout.gsay_message(318, 167, 51)
    DownReact()
end

function Talus25()
    fallout.gsay_message(318, 168, 50)
    fallout.set_map_var(17, 1)
    temp = fallout.map_var(9) + 3
    fallout.set_map_var(9, temp)
    temp = fallout.map_var(10) + 3
    fallout.set_map_var(10, temp)
end

function Talus26()
    fallout.gsay_message(318, 169, 50)
end

function Talus27()
    fallout.gsay_message(318, 170, 50)
end

function Talus28()
    fallout.gsay_reply(318, 149)
    fallout.giq_option(4, 318, 102, Talus02, 50)
    fallout.giq_option(4, 318, 103, Talus07, 50)
    fallout.giq_option(4, 318, 150, TalusEnd, 50)
end

function Talus29()
    if fallout.local_var(10) == 0 then
        fallout.set_local_var(10, 1)
        fallout.gsay_message(318, 154, 50)
    else
        fallout.gsay_message(318, 155, 50)
    end
end

function Talus30()
    BottomReact()
    fallout.gsay_reply(318, 171)
    fallout.giq_option(4, 318, 172, Talus37, 51)
    fallout.giq_option(4, 318, 173, Talus38, 50)
    fallout.giq_option(4, 318, 174, TalusEnd, 51)
end

function Talus31()
    fallout.gsay_reply(318, 175)
    fallout.giq_option(4, 318, 176, Talus35, 50)
    fallout.giq_option(4, 318, 177, BigDownReact, 51)
    fallout.giq_option(4, 318, 178, Talus31a, 50)
end

function Talus31a()
    if fallout.local_var(9) == 0 then
        Talus39()
    else
        TalusEnd()
    end
end

function Talus32()
    fallout.gsay_reply(318, 158)
    fallout.giq_option(4, 318, 176, Talus35, 50)
    fallout.giq_option(4, 318, 177, BigDownReact, 51)
    fallout.giq_option(4, 318, 178, Talus31a, 49)
end

function Talus33()
    fallout.gsay_reply(318, 179)
    fallout.giq_option(4, 318, 176, Talus35, 50)
    fallout.giq_option(4, 318, 177, BigDownReact, 51)
    fallout.giq_option(4, 318, 178, Talus31a, 49)
end

function Talus34()
    fallout.gsay_message(318, 180, 51)
end

function Talus35()
    fallout.set_global_var(109, 1)
    fallout.gsay_reply(318, 181)
    fallout.giq_option(4, 318, 182, Talus31a, 49)
    fallout.giq_option(4, 318, 183, Talus46, 50)
end

function Talus37()
    fallout.gsay_message(318, 185, 51)
end

function Talus38()
    fallout.gsay_message(318, 186, 51)
end

function Talus39()
    fallout.gsay_message(318, 187, 49)
end

function Talus40()
    fallout.gsay_reply(318, 191)
    fallout.giq_option(4, 318, 193, TalusEnd, 50)
end

function Talus41()
    fallout.gsay_message(318, 194, 50)
end

function Talus42()
    DownReact()
    fallout.gsay_message(318, 195, 51)
end

function Talus43()
    fallout.gsay_reply(318, 196)
    fallout.giq_option(4, 318, 192, Talus41, 50)
    fallout.giq_option(4, 318, 193, TalusEnd, 50)
end

function Talus44()
    DownReact()
    fallout.gsay_message(318, 198, 51)
end

function Talus45()
    BigDownReact()
    fallout.gsay_message(318, 199, 51)
end

function Talus46()
    fallout.gsay_message(318, 200, 50)
end

function Talus47()
    fallout.gsay_reply(318, fallout.message_str(318, 201) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(318, 202))
    fallout.giq_option(4, 318, 205, Talus51, 50)
    fallout.giq_option(-3, 318, 206, Talus50, 50)
end

function Talus49()
    fallout.gsay_reply(318, 207)
    fallout.giq_option(4, 318, 205, Talus51, 50)
    fallout.giq_option(-3, 318, 206, Talus50, 50)
end

function Talus50()
    fallout.gsay_message(318, 209, 50)
end

function Talus51()
    fallout.gsay_reply(318, 210)
    fallout.giq_option(4, 318, 212, Talus51a, 50)
    fallout.giq_option(4, 318, 213, Talus51b, 50)
    fallout.giq_option(4, 318, 214, Talus51c, 50)
    if fallout.global_var(155) > 15 then
        fallout.giq_option(4, 318, 407, Talus51d, 50)
    end
    fallout.giq_option(4, 318, 215, TalusEnd, 50)
end

function Talus51a()
    fallout.set_map_var(9, fallout.map_var(9) + 1)
    fallout.set_map_var(12, 1)
    Talus53()
end

function Talus51b()
    fallout.set_map_var(9, fallout.map_var(9) + 1)
    fallout.set_map_var(13, 1)
    Talus53()
end

function Talus51c()
    fallout.set_map_var(9, fallout.map_var(9) + 1)
    fallout.set_map_var(20, 1)
    Talus53()
end

function Talus51d()
    fallout.set_map_var(9, fallout.map_var(9) + 1)
    fallout.set_map_var(15, 1)
    Talus53()
end

function Talus53()
    fallout.set_local_var(8, 1)
    awardex = 1
    fallout.gsay_message(318, 216, 50)
end

function Talus54()
    fallout.set_local_var(9, 1)
    fallout.set_map_var(9, fallout.map_var(9) + 1)
    fallout.set_map_var(15, 1)
    fallout.gsay_message(318, fallout.message_str(318, 201) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(318, 217), 50)
end

function Talus55()
    fallout.set_local_var(9, 1)
    fallout.gsay_message(318, 218, 50)
end

function TalusBackground()
    local v0 = 0
    v0 = fallout.random(1, 5)
    if v0 == 1 then
        v0 = fallout.message_str(318, 219)
    else
        if v0 == 2 then
            v0 = fallout.message_str(318, 220)
        else
            if v0 == 3 then
                v0 = fallout.message_str(318, 221)
            else
                if v0 == 4 then
                    v0 = fallout.message_str(318, 222)
                else
                    if v0 == 5 then
                        v0 = fallout.message_str(318, 223)
                    end
                end
            end
        end
    end
    fallout.float_msg(fallout.self_obj(), v0, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(180), 2)
end

function TalusAmmo()
    if fallout.map_var(17) > 0 then
        Talus27()
    else
        Talus25()
    end
end

function TalusEnd()
end

function critter_p_proc()
    if fallout.global_var(250) then
        Hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        Hostile = 0
    end
    if Hostile then
        fallout.set_global_var(250, 1)
        Hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        Hostile = 1
    end
end

function talk_p_proc()
    get_reaction()
    if fallout.local_var(7) == 0 then
        if fallout.local_var(1) == 1 then
            fallout.set_local_var(1, 2)
            LevelToReact()
        end
    end
    fallout.start_gdialog(318, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    do_dialogue()
    fallout.gsay_end()
    fallout.end_dialogue()
    if awardex then
        awardex = 0
        temp = 1500
        fallout.display_msg(fallout.message_str(318, 408) + temp + fallout.message_str(318, 409))
        fallout.set_global_var(155, fallout.global_var(155) + 1)
        fallout.give_exp_points(temp)
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
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
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(318, 100))
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

function Talus36()
    fallout.gsay_message(318, 184, 51)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
