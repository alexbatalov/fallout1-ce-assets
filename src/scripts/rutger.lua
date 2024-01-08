local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local Rutger00
local Rutger00a
local Rutger00b
local Rutger01
local Rutger02
local Rutger03
local Rutger04
local Rutger05
local Rutger06
local Rutger07
local Rutger08
local Rutger09
local Rutger10
local Rutger11
local Rutger11a
local Rutger12
local Rutger13
local Rutger14
local Rutger15
local Rutger16
local Rutger17
local Rutger17a
local Rutger18
local Rutger19
local Rutger20
local Rutger21
local Rutger22
local Rutger22a
local Rutger23
local Rutger24
local Rutger25
local Rutger26
local Rutger27
local Rutger28
local Rutger29
local Rutger29a
local Rutger29b
local Rutger30
local Rutger31
local Rutger32
local Rutger33
local Rutger34
local Rutger35
local Rutger36
local Rutger37
local Rutger38
local Rutger39
local Rutger39a
local Rutger40
local Rutger40a
local Rutger40b
local Rutger41
local Rutger42
local Rutger43
local Rutger44
local Rutger45
local Rutger46
local Rutger47
local Rutger48
local Rutger49
local Rutger50
local Rutger51
local Rutger52
local Rutger53
local Rutger54
local Rutger55
local Rutger55a
local Rutger56
local Rutger56a
local Rutger57
local Rutger58
local Rutger59
local Rutger60
local Rutger61
local Rutger62
local Rutger63
local Rutger64
local Rutger65
local Rutger67
local Rutger68
local Rutger69
local Rutger70
local Rutger71
local Rutger72
local Rutger73
local Rutger74
local Rutger75
local Rutger76
local RutgerEnd
local RutgerEndBad

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 36)
        fallout.critter_add_trait(self_obj, 1, 5, 17)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function combat()
    hostile = true
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
        fallout.float_msg(fallout.dude_obj(), fallout.message_str(401, 314), 3)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(401, 315), 2)
    elseif fallout.global_var(18) == 1 and fallout.global_var(17) ~= 1 and fallout.local_var(8) == 0 then
        fallout.set_local_var(8, 1)
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rutger55()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.global_var(18) ~= 1 and fallout.global_var(17) == 1 and fallout.local_var(8) == 0 then
        fallout.set_local_var(8, 1)
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rutger58()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.map_var(40) == 1 or fallout.map_var(35) == 1 then
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rutger74()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rutger00()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.map_var(34) == 0 then
        if fallout.local_var(1) >= 2 then
            fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Rutger73()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Rutger74()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    elseif fallout.map_var(34) == 1 and fallout.map_var(41) == 0 then
        Rutger21()
    elseif fallout.map_var(41) == 3 then
        fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rutger54()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.map_var(41) == 4 then
        fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rutger56()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(6) == 0 then
        if fallout.map_var(41) == 2 then
            fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Rutger17()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            if fallout.map_var(41) == 1 then
                fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Rutger25()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                if fallout.map_var(41) == 0 then
                    Rutger21()
                end
            end
        end
    elseif fallout.local_var(6) == 1 and fallout.map_var(41) == 1 then
        fallout.start_gdialog(401, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rutger22()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(401, 100))
end

function Rutger00()
    fallout.gsay_reply(401, 101)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 401, 102, Rutger03, 50)
    end
    if fallout.map_var(43) == 1 then
        fallout.giq_option(4, 401, 103, Rutger00a, 50)
    else
        fallout.giq_option(4, 401, 104, Rutger00a, 50)
    end
    fallout.giq_option(4, 401, 105, Rutger07, 50)
    fallout.giq_option(4, 401, 106, RutgerEnd, 50)
    fallout.giq_option(-3, 401, 107, Rutger00b, 50)
end

function Rutger00a()
    if reputation.has_rep_berserker() then
        Rutger10()
    elseif fallout.global_var(158) > 2 then
        Rutger11()
    elseif reputation.has_rep_champion() then
        Rutger15()
    elseif fallout.map_var(35) == 1 or fallout.map_var(40) == 1 then
        Rutger75()
    else
        Rutger16()
    end
end

function Rutger00b()
    if fallout.get_critter_stat(fallout.dude_obj(), 0) <= 6 then
        Rutger01()
    else
        Rutger02()
    end
end

function Rutger01()
    fallout.gsay_message(401, 108, 51)
end

function Rutger02()
    fallout.gsay_message(401, 109, 50)
end

function Rutger03()
    fallout.gsay_reply(401, 110)
    if fallout.global_var(71) > 0 then
        fallout.giq_option(4, 401, 111, Rutger04, 50)
    else
        fallout.giq_option(4, 401, 112, Rutger04, 50)
    end
    fallout.giq_option(4, 401, 113, RutgerEnd, 50)
end

function Rutger04()
    fallout.gsay_reply(401, 114)
    fallout.giq_option(4, 401, 115, Rutger05, 50)
    if fallout.map_var(43) == 1 then
        fallout.giq_option(4, 401, 116, Rutger00a, 50)
    else
        fallout.giq_option(4, 401, 117, Rutger00a, 50)
    end
    fallout.giq_option(4, 401, 118, RutgerEnd, 50)
end

function Rutger05()
    fallout.gsay_reply(401, 119)
    fallout.giq_option(4, 401, 120, Rutger06, 50)
    fallout.giq_option(4, 401, 121, RutgerEnd, 50)
end

function Rutger06()
    fallout.gsay_reply(401, 122)
    fallout.giq_option(4, 401, 123, Rutger07, 50)
    fallout.giq_option(4, 401, 124, RutgerEnd, 50)
end

function Rutger07()
    if fallout.local_var(5) == 0 then
        fallout.set_local_var(5, 1)
        fallout.gsay_reply(401, 125)
    else
        fallout.gsay_reply(401, 126)
    end
    fallout.giq_option(4, 401, 127, Rutger08, 50)
    fallout.giq_option(4, 401, 128, RutgerEnd, 50)
    if fallout.map_var(43) == 1 then
        fallout.giq_option(4, 401, 129, Rutger00a, 50)
    else
        fallout.giq_option(4, 401, 130, Rutger00a, 50)
    end
end

function Rutger08()
    fallout.gsay_reply(401, 131)
    fallout.giq_option(4, 401, 132, Rutger09, 50)
    fallout.giq_option(4, 401, 133, RutgerEnd, 50)
end

function Rutger09()
    fallout.gsay_reply(401, 134)
    fallout.giq_option(4, 401, 135, RutgerEndBad, 50)
    fallout.giq_option(4, 401, 136, RutgerEnd, 50)
    if fallout.map_var(43) == 1 then
        fallout.giq_option(4, 401, 129, Rutger00a, 50)
    else
        fallout.giq_option(4, 401, 130, Rutger00a, 50)
    end
end

function Rutger10()
    fallout.set_map_var(34, 1)
    fallout.gsay_message(401, 139, 50)
end

function Rutger11()
    fallout.gsay_reply(401, 140)
    fallout.giq_option(4, 401, 141, Rutger11a, 50)
    fallout.giq_option(4, 401, 142, Rutger14, 50)
end

function Rutger11a()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -1)) then
        Rutger12()
    else
        Rutger13()
    end
end

function Rutger12()
    fallout.set_map_var(34, 1)
    fallout.gsay_message(401, 143, 50)
end

function Rutger13()
    fallout.set_map_var(34, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(401, 144, 51)
    else
        fallout.gsay_message(401, 145, 51)
    end
end

function Rutger14()
    fallout.set_map_var(34, 1)
    fallout.gsay_message(401, 146, 50)
end

function Rutger15()
    fallout.set_map_var(34, 1)
    fallout.gsay_message(401, 147, 50)
end

function Rutger16()
    fallout.set_map_var(34, 1)
    fallout.gsay_message(401, 148, 50)
end

function Rutger17()
    fallout.gsay_reply(401, 149)
    fallout.giq_option(4, 401, 150, RutgerEndBad, 50)
    fallout.giq_option(4, 401, 151, Rutger17a, 50)
    fallout.giq_option(4, 401, 152, RutgerEnd, 50)
    fallout.giq_option(-3, 401, 153, Rutger18, 50)
end

function Rutger17a()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 1)) then
        Rutger19()
    else
        Rutger20()
    end
end

function Rutger18()
    fallout.gsay_message(401, 154, 51)
end

function Rutger19()
    fallout.set_map_var(41, 1)
    fallout.set_global_var(106, 1)
    fallout.set_map_var(10, 1)
    fallout.set_map_var(56, 1)
    fallout.gsay_message(401, 155, 50)
    Rutger25()
end

function Rutger20()
    fallout.set_map_var(35, 1)
    fallout.set_map_var(40, 1)
    fallout.set_map_var(10, 0)
    reaction.BottomReact()
    fallout.gsay_message(401, 156, 51)
end

function Rutger21()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(401, 157), 2)
end

function Rutger22()
    fallout.gsay_reply(401, 159)
    if fallout.global_var(78) == 2 or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 196) >= 1 then
        fallout.giq_option(4, 401, 312, Rutger76, 50)
    else
        fallout.giq_option(4, 401, 160, Rutger23, 50)
    end
    fallout.giq_option(4, 401, 161, Rutger26, 50)
    if fallout.map_var(35) == 0 then
        fallout.giq_option(4, 401, 162, Rutger22a, 50)
    end
    fallout.giq_option(4, 401, 163, RutgerEnd, 50)
    fallout.giq_option(-3, 401, 164, Rutger24, 50)
end

function Rutger22a()
    if fallout.map_var(41) ~= 3 and fallout.map_var(41) ~= 4 then
        Rutger63()
    else
        if fallout.map_var(36) == 1 then
            Rutger71()
        end
    end
end

function Rutger23()
    fallout.gsay_message(401, 165, 50)
end

function Rutger24()
    fallout.gsay_message(401, 166, 51)
end

function Rutger25()
    fallout.set_local_var(6, 1)
    fallout.set_global_var(226, 1)
    fallout.set_map_var(33, 1)
    fallout.gsay_reply(401, 167)
    Rutger29()
end

function Rutger26()
    fallout.gsay_message(401, 168, 50)
    Rutger25()
end

function Rutger27()
    fallout.gsay_reply(401, 169)
    fallout.giq_option(4, 401, 170, Rutger28, 50)
    fallout.giq_option(4, 401, 171, Rutger30, 50)
end

function Rutger28()
    fallout.gsay_reply(401, 172)
    Rutger29()
end

function Rutger29()
    if fallout.global_var(108) ~= 2 then
        fallout.giq_option(4, 401, 173, Rutger29a, 50)
    else
        fallout.giq_option(4, 401, 174, Rutger29b, 50)
    end
    if fallout.map_var(8) == 1 then
        fallout.giq_option(4, 401, 175, Rutger38, 50)
    end
    fallout.giq_option(4, 401, 176, Rutger37, 50)
    fallout.giq_option(4, 401, 177, RutgerEnd, 50)
end

function Rutger29a()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 3 then
        Rutger27()
    else
        Rutger31()
    end
end

function Rutger29b()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 3 then
        Rutger32()
    else
        Rutger33()
    end
end

function Rutger30()
    fallout.gsay_reply(401, 178)
    Rutger29()
end

function Rutger31()
    fallout.gsay_reply(401, 179)
    Rutger29()
end

function Rutger32()
    fallout.gsay_reply(401, 180)
    Rutger29()
end

function Rutger33()
    fallout.gsay_reply(401, 181)
    fallout.giq_option(4, 401, 182, Rutger34, 50)
    fallout.giq_option(4, 401, 183, Rutger35, 50)
    fallout.giq_option(4, 401, 184, Rutger36, 50)
end

function Rutger34()
    fallout.gsay_reply(401, 185)
    Rutger29()
end

function Rutger35()
    fallout.gsay_reply(401, 186)
    Rutger29()
end

function Rutger36()
    fallout.gsay_reply(401, 187)
    Rutger29()
end

function Rutger37()
    fallout.set_map_var(10, 1)
    fallout.gsay_reply(401, 188)
    Rutger29()
end

function Rutger38()
    fallout.gsay_reply(401, 189)
    Rutger29()
end

function Rutger39()
    fallout.gsay_reply(401, 190)
    fallout.giq_option(4, 401, 191, Rutger39a, 50)
    fallout.giq_option(4, 401, 192, RutgerEnd, 50)
    fallout.giq_option(-3, 401, 193, Rutger24, 50)
    fallout.giq_option(-3, 401, 194, Rutger24, 50)
end

function Rutger39a()
    if fallout.map_var(42) == 16777267 then
        Rutger49()
    elseif fallout.map_var(42) == 1 then
        Rutger50()
    elseif fallout.map_var(42) == 2 then
        Rutger51()
    else
        Rutger40()
    end
end

function Rutger40()
    fallout.gsay_reply(401, 195)
    fallout.giq_option(4, 401, 196, Rutger40a, 50)
    fallout.giq_option(4, 401, 197, Rutger47, 50)
    fallout.giq_option(4, 401, 198, Rutger40b, 50)
    fallout.giq_option(4, 401, 199, Rutger41, 50)
end

function Rutger40a()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 1)) then
        Rutger42()
    else
        Rutger44()
    end
end

function Rutger40b()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -2)) then
        Rutger45()
    else
        Rutger46()
    end
end

function Rutger41()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(401, 200, 51)
    else
        fallout.gsay_message(401, 201, 51)
    end
end

function Rutger42()
    fallout.gsay_reply(401, 202)
    fallout.giq_option(4, 401, 203, Rutger43, 50)
    fallout.giq_option(4, 401, 204, Rutger47, 50)
    fallout.giq_option(4, 401, 205, RutgerEnd, 50)
end

function Rutger43()
    fallout.gsay_message(401, 206, 50)
end

function Rutger44()
    fallout.gsay_message(401, 207, 51)
end

function Rutger45()
    fallout.gsay_reply(401, 208)
    fallout.giq_option(4, 401, 209, Rutger47, 50)
    fallout.giq_option(4, 401, 210, Rutger44, 50)
end

function Rutger46()
    fallout.gsay_message(401, 211, 51)
end

function Rutger47()
    fallout.gsay_reply(401, 212)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 196) >= 1 then
        if fallout.global_var(100) == 2 then
            fallout.giq_option(4, 401, 213, Rutger48, 50)
        else
            fallout.giq_option(4, 401, 214, Rutger48, 50)
        end
    else
        fallout.giq_option(4, 401, 215, RutgerEnd, 50)
    end
    fallout.giq_option(4, 401, 216, RutgerEnd, 50)
    fallout.giq_option(4, 401, 217, RutgerEnd, 50)
end

function Rutger48()
    reaction.TopReact()
    fallout.item_caps_adjust(fallout.dude_obj(), 800)
    fallout.set_map_var(42, 2)
    fallout.set_map_var(36, 1)
    fallout.set_map_var(35, 0)
    fallout.set_map_var(40, 0)
    fallout.set_map_var(10, 1)
    fallout.set_map_var(41, 4)
    fallout.give_exp_points(1000)
    fallout.display_msg(fallout.message_str(766, 103) .. 1000 .. fallout.message_str(766, 104))
    fallout.set_global_var(155, fallout.global_var(155) + 5)
    fallout.gsay_message(401, 218, 49)
end

function Rutger49()
    fallout.gsay_reply(401, 219)
    fallout.giq_option(4, 401, 220, Rutger40a, 50)
    fallout.giq_option(4, 401, 221, Rutger47, 50)
    fallout.giq_option(4, 401, 222, Rutger40b, 50)
    fallout.giq_option(4, 401, 223, Rutger41, 50)
end

function Rutger50()
    fallout.gsay_reply(401, 224)
    fallout.giq_option(4, 401, 225, Rutger40a, 50)
    fallout.giq_option(4, 401, 226, Rutger47, 50)
    fallout.giq_option(4, 401, 227, Rutger40b, 50)
    fallout.giq_option(4, 401, 228, Rutger41, 50)
end

function Rutger51()
    fallout.gsay_reply(401, 229)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 196) >= 1 then
        if fallout.global_var(100) == 2 then
            fallout.giq_option(4, 401, 230, Rutger48, 50)
        else
            fallout.giq_option(4, 401, 231, Rutger48, 50)
        end
    else
        fallout.giq_option(4, 401, 232, RutgerEnd, 50)
    end
    fallout.giq_option(4, 401, 233, RutgerEnd, 50)
end

function Rutger52()
    fallout.gsay_reply(401, 234)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 196) >= 1 then
        fallout.giq_option(4, 401, 235, Rutger48, 50)
    else
        if fallout.global_var(100) == 2 then
            fallout.giq_option(4, 401, 236, Rutger53, 50)
        end
    end
    fallout.giq_option(4, 401, 237, RutgerEnd, 50)
    fallout.giq_option(-3, 401, 238, Rutger24, 50)
end

function Rutger53()
    fallout.gsay_message(401, 239, 50)
end

function Rutger54()
    fallout.gsay_reply(401, 240)
    fallout.giq_option(4, 401, 241, Rutger39a, 50)
    fallout.giq_option(4, 401, 242, RutgerEnd, 50)
end

function Rutger55()
    fallout.gsay_reply(401, 243)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 401, 244, Rutger59, 50)
    elseif reputation.has_rep_champion() then
        fallout.giq_option(4, 401, 245, Rutger59, 50)
    else
        fallout.giq_option(4, 401, 246, Rutger59, 50)
    end
    fallout.giq_option(4, 401, 247, Rutger55a, 50)
    fallout.giq_option(4, 401, 248, RutgerEnd, 50)
    fallout.giq_option(-3, 401, 249, RutgerEnd, 50)
end

function Rutger55a()
    if fallout.map_var(40) == 1 or fallout.map_var(35) == 1 then
        Rutger67()
    else
        if fallout.map_var(36) == 1 then
            Rutger71()
        else
            Rutger62()
        end
    end
end

function Rutger56()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(401, 250)
    elseif fallout.get_critter_stat(fallout.dude_obj(), 3) >= 7 then
        fallout.gsay_reply(401, 252)
    else
        fallout.gsay_reply(401, 253)
    end
    fallout.giq_option(4, 401, 254, Rutger55a, 50)
    fallout.giq_option(4, 401, 255, Rutger56a, 50)
    fallout.giq_option(-3, 401, 256, Rutger24, 50)
end

function Rutger56a()
    if fallout.global_var(18) == 1 or fallout.global_var(17) == 1 then
        Rutger57()
    else
        Rutger61()
    end
end

function Rutger57()
    fallout.gsay_message(401, 257, 49)
end

function Rutger58()
    fallout.gsay_reply(401, 258)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 401, 259, Rutger60, 50)
    elseif reputation.has_rep_champion() then
        fallout.giq_option(4, 401, 260, Rutger60, 50)
        fallout.giq_option(4, 401, 261, Rutger60, 50)
    else
        fallout.giq_option(4, 401, 262, Rutger61, 50)
    end
    fallout.giq_option(4, 401, 263, Rutger55a, 50)
    fallout.giq_option(4, 401, 248, RutgerEnd, 50)
    fallout.giq_option(-3, 401, 264, RutgerEnd, 50)
end

function Rutger59()
    fallout.gsay_message(401, 265, 50)
end

function Rutger60()
    fallout.gsay_message(401, 266, 50)
end

function Rutger61()
    fallout.gsay_message(401, 267, 50)
end

function Rutger62()
    fallout.gsay_reply(401, 268)
    fallout.giq_option(4, 401, 269, Rutger65, 50)
    fallout.giq_option(4, 401, 270, Rutger64, 50)
end

function Rutger63()
    fallout.gsay_reply(401, 271)
    fallout.giq_option(4, 401, 272, Rutger68, 50)
    fallout.giq_option(4, 401, 273, Rutger70, 50)
    fallout.giq_option(4, 401, 274, RutgerEnd, 50)
end

function Rutger64()
    fallout.gsay_message(401, 275, 50)
end

function Rutger65()
    fallout.set_map_var(36, 1)
    fallout.gsay_message(401, 276, 50)
end

function Rutger67()
    if fallout.local_var(7) == 0 then
        fallout.set_local_var(7, 1)
        fallout.gsay_message(401, 279, 50)
    end
    fallout.gsay_message(401, 280, 50)
end

function Rutger68()
    fallout.gsay_reply(401, 281)
    fallout.giq_option(4, 401, 282, Rutger72, 50)
    fallout.giq_option(4, 401, 283, Rutger69, 50)
    fallout.giq_option(4, 401, 284, Rutger70, 50)
end

function Rutger69()
    fallout.gsay_message(401, 285, 50)
end

function Rutger70()
    fallout.set_map_var(36, 1)
    fallout.gsay_message(401, 286, 50)
end

function Rutger71()
    fallout.set_map_var(36, 1)
    fallout.gsay_message(401, 287, 50)
end

function Rutger72()
    fallout.gsay_reply(401, 289)
    fallout.giq_option(4, 401, 290, RutgerEnd, 50)
    fallout.giq_option(4, 401, 291, Rutger70, 50)
end

function Rutger73()
    fallout.gsay_reply(401, 292)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 401, 294, Rutger03, 50)
    end
    if fallout.map_var(43) == 1 then
        fallout.giq_option(4, 401, 295, Rutger00a, 50)
    else
        fallout.giq_option(4, 401, 296, Rutger00a, 50)
    end
    fallout.giq_option(4, 401, 297, Rutger07, 50)
    fallout.giq_option(4, 401, 298, RutgerEnd, 50)
    fallout.giq_option(-3, 401, 299, Rutger00b, 50)
end

function Rutger74()
    fallout.gsay_reply(401, fallout.random(300, 303))
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 401, 305, Rutger03, 50)
    end
    if fallout.map_var(43) == 1 then
        fallout.giq_option(4, 401, 306, Rutger00a, 50)
    else
        fallout.giq_option(4, 401, 307, Rutger00a, 50)
    end
    fallout.giq_option(4, 401, 308, Rutger07, 50)
    fallout.giq_option(4, 401, 309, RutgerEnd, 50)
    fallout.giq_option(-3, 401, 310, Rutger00b, 50)
end

function Rutger75()
    fallout.gsay_message(401, 311, 50)
end

function Rutger76()
    fallout.gsay_message(401, 313, 50)
end

function RutgerEnd()
end

function RutgerEndBad()
    reaction.DownReactLevel()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
