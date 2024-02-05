local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Kane00
local Kane01
local Kane02
local Kane03
local Kane04
local Kane05
local Kane06
local Kane07
local Kane08
local Kane09
local Kane10
local Kane11
local Kane12
local Kane13
local Kane14
local Kane15
local Kane16
local Kane17
local Kane18
local Kane19
local Kane29
local Kane30
local Kane31
local Kane32
local Kane33
local Kane34
local Kane35
local Kane36
local Kane36a
local Kane37
local Kane38
local Kane39
local Kane40
local Kane41
local Kane41a
local Kane42
local Kane43
local Kane44
local Kane45
local Kane46
local Kane47
local Kane47a
local Kane48
local Kane49
local Kane50
local Kane51
local Kane52
local Kane53
local Kane54
local Kane55
local Kane56
local Kane57
local Kane58
local Kane59
local Kane60
local Kane61
local Kane62
local Kane63
local Kane71
local Kane72
local Kane73
local Kane74
local Kane75
local Kane75a
local Kane76
local Kane77
local Kane78
local Kane79
local Kane80
local Kane81
local Kane82
local Kane83
local Kane84
local Kane85
local Kane86
local Kane87
local Kane88
local Kane89
local Kane90
local Kane91
local Kane92
local Kane93
local Kane93a
local Kane94
local Kane95
local Kane96
local Kane97
local Kane98
local Kane99
local Kane100
local Kane101
local Kane102
local Kane103
local Kane104
local Kane105
local Kane106
local Kane131
local Kane132
local Kane133
local Kane134
local Kane135
local Kane136
local Kane137
local Kane138
local Kane139
local Kane140
local Kane146
local Kane147
local Kane148
local Kane149
local Kane150
local Kane151
local Kane152
local Kane153
local Kane154
local Kane155
local KaneEnd
local KaneEndHostile
local KaneEndNotAcceptedOrDeclined
local KaneEndDeclined
local KaneEndAnnoyed
local KaneEndTakeHike
local KaneEndRefuses
local KaneTravel
local GoToDecker

local hostile = false
local initialized = false
local travel = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.set_external_var("Kane_Ptr", self_obj)
        if fallout.map_var(49) == 1 then
            fallout.set_obj_visibility(self_obj, true)
        end
        misc.set_team(self_obj, 38)
        misc.set_ai(self_obj, 88)
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
    if fallout.map_var(51) == 1 then
        fallout.dialogue_system_enter()
    end
    if travel then
        travel = false
        GoToDecker()
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.map_var(51) == 1 then
        fallout.set_map_var(51, 0)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(594, 300), 2)
    else
        if misc.is_armed(fallout.dude_obj()) then
            if fallout.local_var(6) == 0 then
                fallout.set_local_var(6, 1)
                Kane61()
            elseif fallout.local_var(6) == 1 then
                fallout.set_local_var(6, 2)
                Kane62()
            else
                Kane63()
            end
        else
            if fallout.local_var(4) == 0 then
                fallout.set_local_var(4, 1)
                if fallout.global_var(37) == 0 and fallout.global_var(38) == 0 then
                    if reputation.has_rep_berserker() then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane11()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif reputation.has_rep_champion() then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane15()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    else
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane60()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    end
                elseif fallout.global_var(37) == 1 and fallout.global_var(38) ~= 1 then
                    fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Kane12()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                elseif fallout.global_var(38) == 1 and fallout.global_var(37) ~= 1 then
                    fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Kane13()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                elseif fallout.global_var(37) == 1 and fallout.global_var(38) == 1 then
                    fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Kane14()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Kane60()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            elseif (fallout.map_var(44) == 1) or (fallout.map_var(11) == 1) then
                Kane10()
            elseif fallout.map_var(45) == 2 then
                fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Kane93()
                fallout.gsay_end()
                fallout.end_dialogue()
            elseif fallout.map_var(45) == 5 then
                fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Kane100()
                fallout.gsay_end()
                fallout.end_dialogue()
            elseif fallout.map_var(45) == 4 then
                fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Kane106()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                if fallout.global_var(111) ~= 2 and fallout.local_var(7) == 0 then
                    if fallout.map_var(46) == 0 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane60()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(46) == 1 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane10()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(46) == 2 then
                        if fallout.global_var(111) == 5 then
                            fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            Kane153()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        else
                            fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            Kane86()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        end
                    elseif fallout.map_var(46) == 4 then
                        if fallout.global_var(111) == 5 then
                            fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            Kane153()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        else
                            fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            Kane135()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        end
                    end
                elseif fallout.global_var(111) == 2 and fallout.local_var(7) == 0 then
                    if fallout.map_var(46) == 0 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane71()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(46) == 1 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane79()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(46) == 2 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane89()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(46) == 4 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane87()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    end
                elseif fallout.global_var(112) ~= 2 and fallout.local_var(7) == 112 then
                    if fallout.map_var(47) == 0 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane134()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(47) == 2 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane10()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(47) == 3 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane91()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(47) == 5 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane135()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    end
                elseif fallout.global_var(112) == 2 and fallout.local_var(7) == 112 then
                    if fallout.map_var(47) == 0 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane80()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(47) == 2 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane79()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(47) == 3 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane90()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(47) == 5 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane92()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    elseif fallout.map_var(47) == 6 then
                        fallout.start_gdialog(594, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Kane134()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    end
                end
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_map_var(49, 1)
    if fallout.map_var(49) == 1 and fallout.map_var(50) == 1 then
        fallout.set_global_var(202, 1)
        fallout.set_map_var(11, 1)
        fallout.set_map_var(44, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(594, 100))
end

function Kane00()
    fallout.giq_option(4, 594, 101, Kane02, 50)
    fallout.giq_option(4, 594, 102, Kane04, 51)
    fallout.giq_option(4, 594, 104, Kane07, 50)
    fallout.giq_option(4, 594, 105, KaneEndDeclined, 50)
    fallout.giq_option(-3, 594, 106, Kane01, 50)
end

function Kane01()
    fallout.gsay_message(594, 107, 50)
    KaneEndRefuses()
end

function Kane02()
    fallout.gsay_reply(594, 108)
    fallout.giq_option(4, 594, 109, Kane03, 50)
    fallout.giq_option(4, 594, 110, Kane06, 50)
    fallout.giq_option(6, 594, 111, Kane09, 50)
    fallout.giq_option(4, 594, 112, Kane08, 50)
end

function Kane03()
    fallout.gsay_message(594, 113, 50)
    KaneTravel()
end

function Kane04()
    fallout.gsay_reply(594, 114)
    fallout.giq_option(4, 594, 115, Kane02, 50)
    fallout.giq_option(4, 594, 116, Kane05, 51)
end

function Kane05()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(594, 117)
    else
        fallout.gsay_reply(594, 118)
    end
    fallout.giq_option(4, 594, 119, KaneEndHostile, 51)
    fallout.giq_option(4, 594, 120, Kane02, 50)
    fallout.giq_option(4, 594, 121, KaneEndNotAcceptedOrDeclined, 50)
end

function Kane06()
    fallout.gsay_message(594, 123, 50)
    KaneEndNotAcceptedOrDeclined()
end

function Kane07()
    fallout.gsay_message(594, 124, 50)
    KaneEndNotAcceptedOrDeclined()
end

function Kane08()
    fallout.gsay_reply(594, 125)
    fallout.giq_option(4, 594, 126, Kane03, 50)
    fallout.giq_option(4, 594, 127, KaneEndDeclined, 50)
    fallout.giq_option(4, 594, 128, Kane06, 50)
end

function Kane09()
    fallout.gsay_reply(594, 129)
    fallout.giq_option(4, 594, 130, KaneTravel, 50)
    fallout.giq_option(4, 594, 131, KaneEndDeclined, 50)
    fallout.giq_option(4, 594, 132, Kane06, 50)
end

function Kane10()
    if fallout.local_var(5) < 3 then
        fallout.set_local_var(5, fallout.local_var(5) + 1)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(594, fallout.random(133, 136)), 2)
    else
        fallout.set_map_var(11, 1)
        fallout.set_map_var(45, 4)
        fallout.set_map_var(44, 1)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(594, 137), 2)
        combat()
    end
end

function Kane11()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(594, 138)
    else
        fallout.gsay_reply(594, 139)
    end
    Kane00()
end

function Kane12()
    fallout.gsay_reply(594, 140)
    Kane00()
end

function Kane13()
    fallout.gsay_reply(594, 141)
    Kane00()
end

function Kane14()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(594, 143)
    else
        fallout.gsay_reply(594, 142)
    end
    Kane00()
end

function Kane15()
    fallout.gsay_reply(594, 144)
    Kane16()
end

function Kane16()
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 594, 145, Kane17, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 594, 146, Kane36, 50)
    else
        fallout.giq_option(4, 594, 147, Kane32, 50)
    end
    fallout.giq_option(4, 594, 151, Kane29, 50)
    fallout.giq_option(4, 594, 152, KaneEndNotAcceptedOrDeclined, 50)
    fallout.giq_option(-3, 594, 154, Kane01, 50)
    fallout.giq_option(-3, 594, 155, Kane01, 50)
end

function Kane17()
    fallout.gsay_reply(594, 156)
    fallout.giq_option(6, 594, 157, Kane18, 50)
    fallout.giq_option(4, 594, 158, Kane19, 50)
    fallout.giq_option(4, 594, 159, Kane16, 50)
    fallout.giq_option(4, 594, 160, KaneEndNotAcceptedOrDeclined, 50)
end

function Kane18()
    fallout.gsay_reply(594, 161)
    Kane16()
end

function Kane19()
    fallout.gsay_reply(594, 162)
    Kane16()
end

function Kane29()
    fallout.gsay_reply(594, 200)
    fallout.giq_option(4, 594, 201, Kane59, 50)
    fallout.giq_option(4, 594, 202, Kane31, 50)
    fallout.giq_option(4, 594, 203, Kane30, 50)
end

function Kane30()
    fallout.gsay_reply(594, 204)
    Kane16()
end

function Kane31()
    fallout.gsay_message(594, 205, 51)
    KaneEndRefuses()
end

function Kane32()
    fallout.gsay_reply(594, 206)
    fallout.giq_option(4, 594, 207, Kane33, 51)
    fallout.giq_option(4, 594, 208, Kane35, 50)
end

function Kane33()
    fallout.gsay_reply(594, 209)
    fallout.giq_option(4, 594, 210, Kane34, 51)
    fallout.giq_option(4, 594, 211, Kane35, 50)
end

function Kane34()
    fallout.gsay_message(594, 212, 51)
    KaneEndHostile()
end

function Kane35()
    fallout.gsay_reply(594, 213)
    Kane16()
end

function Kane36()
    fallout.gsay_reply(594, 214)
    fallout.giq_option(4, 594, 215, Kane41, 50)
    fallout.giq_option(4, 594, 216, Kane39, 50)
    fallout.giq_option(4, 594, 217, Kane36a, 50)
end

function Kane36a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -15)) then
        Kane37()
    else
        Kane38()
    end
end

function Kane37()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(594, 218, 50)
    else
        fallout.gsay_message(594, 219, 50)
    end
    KaneTravel()
end

function Kane38()
    fallout.gsay_message(594, 220, 51)
    KaneEndTakeHike()
end

function Kane39()
    fallout.gsay_reply(594, 221)
    fallout.giq_option(4, 594, 222, Kane41, 50)
    fallout.giq_option(4, 594, 223, Kane40, 50)
end

function Kane40()
    fallout.gsay_message(594, 224, 50)
    KaneEndAnnoyed()
end

function Kane41()
    fallout.gsay_reply(594, 225)
    if fallout.map_var(33) == 1 then
        fallout.giq_option(4, 594, 226, Kane42, 50)
    end
    if fallout.map_var(18) == 1 then
        fallout.giq_option(4, 594, 227, Kane41a, 50)
    end
    if fallout.global_var(207) == 1 then
        fallout.giq_option(4, 594, 228, Kane47, 50)
    end
    fallout.giq_option(4, 594, 229, Kane45, 50)
    fallout.giq_option(4, 594, 230, Kane44, 50)
end

function Kane41a()
    if fallout.map_var(21) == 1 then
        Kane57()
    else
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -15)) then
            Kane57()
        else
            Kane58()
        end
    end
end

function Kane42()
    fallout.gsay_reply(594, 231)
    fallout.giq_option(4, 594, 232, Kane43, 50)
    fallout.giq_option(4, 594, 233, Kane46, 50)
end

function Kane43()
    fallout.gsay_message(594, 234, 51)
    KaneEndAnnoyed()
end

function Kane44()
    fallout.gsay_message(594, 235, 51)
    KaneEndAnnoyed()
end

function Kane45()
    fallout.gsay_message(594, 236, 51)
    KaneEndHostile()
end

function Kane46()
    fallout.gsay_message(594, 237, 50)
    KaneEndAnnoyed()
end

function Kane47()
    fallout.gsay_reply(594, 238)
    fallout.giq_option(4, 594, 239, Kane47a, 50)
    fallout.giq_option(4, 594, 240, Kane49, 50)
    fallout.giq_option(4, 594, 241, KaneEndRefuses, 51)
    fallout.giq_option(4, 594, 242, Kane48, 50)
end

function Kane47a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Kane50()
    else
        Kane53()
    end
end

function Kane48()
    fallout.gsay_message(594, 243, 51)
    KaneEndRefuses()
end

function Kane49()
    fallout.gsay_message(594, 244, 50)
    KaneTravel()
end

function Kane50()
    fallout.gsay_reply(594, 245)
    fallout.giq_option(4, 594, 246, Kane51, 50)
    fallout.giq_option(4, 594, 247, Kane52, 50)
end

function Kane51()
    fallout.gsay_message(594, 248, 51)
    KaneEndRefuses()
end

function Kane52()
    fallout.gsay_message(594, 249, 50)
    KaneTravel()
end

function Kane53()
    fallout.gsay_reply(594, 250)
    fallout.giq_option(4, 594, 251, Kane55, 50)
    fallout.giq_option(4, 594, 252, Kane54, 50)
    fallout.giq_option(4, 594, 253, Kane56, 50)
    fallout.giq_option(4, 594, 254, Kane54, 50)
end

function Kane54()
    fallout.gsay_message(594, 255, 50)
    KaneEndAnnoyed()
end

function Kane55()
    fallout.gsay_message(594, 256, 50)
    KaneEndAnnoyed()
end

function Kane56()
    fallout.gsay_message(594, 257, 50)
    KaneTravel()
end

function Kane57()
    fallout.gsay_message(594, 258, 50)
    KaneTravel()
end

function Kane58()
    fallout.gsay_message(594, 259, 51)
    KaneEndRefuses()
end

function Kane59()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(594, 260, 49)
    else
        fallout.gsay_message(594, 261, 49)
    end
    KaneEndNotAcceptedOrDeclined()
end

function Kane60()
    fallout.gsay_reply(594, 262)
    Kane16()
end

function Kane61()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(594, 263), 2)
end

function Kane62()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(594, 264), 2)
end

function Kane63()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(594, 265), 2)
end

function Kane71()
    fallout.set_map_var(46, 6)
    fallout.gsay_reply(594, 278)
    Kane72()
end

function Kane72()
    fallout.giq_option(4, 594, 279, Kane73, 51)
    fallout.giq_option(4, 594, 280, Kane74, 51)
    fallout.giq_option(4, 594, 281, Kane78, 51)
end

function Kane73()
    fallout.gsay_message(594, 282, 51)
    KaneEndHostile()
end

function Kane74()
    fallout.gsay_message(594, 283, 51)
    KaneEndHostile()
end

function Kane75()
    fallout.set_map_var(46, 5)
    fallout.give_exp_points(300)
    fallout.display_msg(fallout.message_str(766, 103) .. 300 .. fallout.message_str(766, 104))
    fallout.set_global_var(155, fallout.global_var(155) - 1)
    fallout.item_caps_adjust(fallout.dude_obj(), 1500)
    fallout.gsay_reply(594, 284)
    fallout.giq_option(4, 594, 285, Kane75a, 51)
    fallout.giq_option(4, 594, 286, Kane76, 50)
    fallout.giq_option(4, 594, 287, Kane77, 51)
    fallout.giq_option(-3, 594, 288, Kane78, 51)
end

function Kane75a()
    fallout.set_map_var(47, 6)
    KaneEndRefuses()
end

function Kane76()
    fallout.gsay_message(594, 289, 50)
    KaneTravel()
end

function Kane77()
    fallout.gsay_message(594, 290, 51)
    KaneEndHostile()
end

function Kane78()
    fallout.gsay_message(594, 291, 51)
    KaneEndHostile()
end

function Kane79()
    fallout.set_map_var(46, 6)
    fallout.gsay_message(594, 292, 51)
    KaneEndHostile()
end

function Kane80()
    fallout.give_exp_points(350)
    fallout.display_msg(fallout.message_str(766, 103) .. 350 .. fallout.message_str(766, 104))
    fallout.set_global_var(155, fallout.global_var(155) - 1)
    fallout.item_caps_adjust(fallout.dude_obj(), 1000)
    fallout.set_map_var(47, 7)
    fallout.gsay_reply(594, 293)
    Kane81()
end

function Kane81()
    fallout.giq_option(4, 594, 294, Kane82, 51)
    fallout.giq_option(4, 594, 295, Kane83, 51)
    fallout.giq_option(-3, 594, 296, Kane84, 51)
end

function Kane82()
    fallout.gsay_message(594, 297, 51)
    KaneEndRefuses()
end

function Kane83()
    fallout.gsay_message(594, 298, 51)
    KaneEndRefuses()
end

function Kane84()
    fallout.gsay_message(594, 299, 51)
    KaneEndRefuses()
end

function Kane85()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(594, 300), 2)
end

function Kane86()
    fallout.set_map_var(46, 4)
    fallout.set_global_var(579, 1)
    fallout.item_caps_adjust(fallout.dude_obj(), 500)
    fallout.gsay_message(594, 301, 50)
end

function Kane87()
    fallout.item_caps_adjust(fallout.dude_obj(), 2500)
    fallout.give_exp_points(600)
    fallout.display_msg(fallout.message_str(766, 103) .. 600 .. fallout.message_str(766, 104))
    fallout.set_global_var(155, fallout.global_var(155) - 2)
    fallout.set_map_var(46, 5)
    fallout.set_local_var(7, 112)
    fallout.gsay_message(594, 302, 50)
end

function Kane88()
    fallout.item_caps_adjust(fallout.dude_obj(), 3500)
    fallout.give_exp_points(600)
    fallout.display_msg(fallout.message_str(766, 103) .. 600 .. fallout.message_str(766, 104))
    fallout.set_global_var(155, fallout.global_var(155) - 2)
    fallout.set_map_var(46, 5)
    fallout.set_map_var(47, 5)
    fallout.set_local_var(7, 112)
    fallout.set_global_var(112, 1)
    fallout.gsay_message(594, 303, 50)
end

function Kane89()
    fallout.item_caps_adjust(fallout.dude_obj(), 3000)
    fallout.give_exp_points(600)
    fallout.display_msg(fallout.message_str(766, 103) .. 600 .. fallout.message_str(766, 104))
    fallout.set_global_var(155, fallout.global_var(155) - 2)
    fallout.set_map_var(46, 5)
    fallout.set_local_var(7, 112)
    fallout.gsay_message(594, 304, 50)
end

function Kane90()
    fallout.item_caps_adjust(fallout.dude_obj(), 5000)
    fallout.give_exp_points(700)
    fallout.display_msg(fallout.message_str(766, 103) .. 700 .. fallout.message_str(766, 104))
    fallout.set_global_var(155, fallout.global_var(155) - 2)
    fallout.set_map_var(47, 6)
    fallout.gsay_message(594, 305, 50)
    fallout.gsay_message(594, 306, 50)
end

function Kane91()
    local v0 = 0
    fallout.set_global_var(581, 1)
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), 1000)
    fallout.set_map_var(47, 5)
    fallout.gsay_message(594, 308, 50)
end

function Kane92()
    fallout.item_caps_adjust(fallout.dude_obj(), 4000)
    fallout.give_exp_points(700)
    fallout.display_msg(fallout.message_str(766, 103) .. 700 .. fallout.message_str(766, 104))
    fallout.set_global_var(155, fallout.global_var(155) - 2)
    fallout.set_map_var(47, 6)
    fallout.gsay_message(594, 309, 50)
end

function Kane93()
    fallout.gsay_reply(594, 310)
    fallout.giq_option(4, 594, 311, Kane95, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 594, 312, Kane148, 51)
    end
    fallout.giq_option(4, 594, 313, Kane93a, 50)
    fallout.giq_option(4, 594, 314, Kane149, 51)
    fallout.giq_option(-3, 594, 315, Kane94, 50)
    fallout.giq_option(-3, 594, 316, Kane94, 50)
end

function Kane93a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Kane151()
    else
        Kane152()
    end
end

function Kane94()
    fallout.gsay_message(594, 317, 50)
    KaneEndRefuses()
end

function Kane95()
    fallout.gsay_reply(594, 318)
    fallout.giq_option(4, 594, 319, Kane98, 51)
    fallout.giq_option(4, 594, 320, Kane99, 51)
    fallout.giq_option(4, 594, 321, Kane97, 51)
    fallout.giq_option(4, 594, 322, Kane98, 51)
    if fallout.map_var(48) == 1 then
        fallout.giq_option(4, 594, 323, Kane96, 51)
    end
end

function Kane96()
    fallout.gsay_message(594, 324, 51)
    KaneEndHostile()
end

function Kane97()
    fallout.gsay_message(594, 325, 51)
    KaneEndRefuses()
end

function Kane98()
    fallout.gsay_message(594, 326, 51)
    KaneEndRefuses()
end

function Kane99()
    fallout.gsay_message(594, 327, 51)
    KaneEndHostile()
end

function Kane100()
    fallout.gsay_reply(594, 328)
    fallout.giq_option(4, 594, 330, Kane103, 51)
    fallout.giq_option(4, 594, 331, Kane102, 50)
    fallout.giq_option(4, 594, 332, Kane104, 51)
    fallout.giq_option(4, 594, 333, Kane105, 50)
    fallout.giq_option(4, 594, 334, Kane101, 50)
end

function Kane101()
    fallout.gsay_message(594, 335, 50)
    KaneEnd()
end

function Kane102()
    fallout.gsay_message(594, 336, 50)
    KaneTravel()
end

function Kane103()
    fallout.gsay_message(594, 337, 51)
    KaneEndHostile()
end

function Kane104()
    fallout.gsay_message(594, 338, 51)
    KaneEndHostile()
end

function Kane105()
    fallout.gsay_message(594, 339, 51)
    KaneEndHostile()
end

function Kane106()
    fallout.gsay_reply(594, 340)
    if fallout.map_var(21) == 1 then
        fallout.giq_option(4, 594, 341, Kane57, 50)
    else
        fallout.giq_option(4, 594, 343, Kane132, 50)
    end
    fallout.giq_option(4, 594, 344, KaneEnd, 50)
    fallout.giq_option(-3, 594, 345, Kane101, 50)
end

function Kane131()
    fallout.gsay_message(594, fallout.random(403, 407), 50)
    KaneTravel()
end

function Kane132()
    fallout.gsay_message(594, 408, 50)
    KaneEndTakeHike()
end

function Kane133()
    fallout.giq_option(4, 594, 409, Kane131, 50)
    fallout.giq_option(4, 594, 411, KaneEnd, 50)
    fallout.giq_option(-3, 594, 412, Kane101, 50)
end

function Kane134()
    fallout.gsay_reply(594, 413)
    Kane133()
end

function Kane135()
    fallout.gsay_message(594, 415, 51)
end

function Kane136()
    fallout.gsay_message(594, 417, 51)
end

function Kane137()
    fallout.gsay_message(594, 418, 51)
end

function Kane138()
    fallout.gsay_reply(594, 420)
    fallout.giq_option(4, 594, 423, Kane139, 50)
    fallout.giq_option(4, 594, 424, KaneEnd, 50)
    fallout.giq_option(-3, 594, 425, KaneEnd, 50)
end

function Kane139()
    fallout.gsay_reply(594, 426)
    fallout.giq_option(4, 594, 427, Kane140, 50)
    fallout.giq_option(4, 594, 428, KaneEndHostile, 50)
end

function Kane140()
    fallout.gsay_message(594, 429, 50)
end

function Kane146()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(594, 449), 2)
end

function Kane147()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(594, 451), 2)
end

function Kane148()
    fallout.gsay_message(594, 453, 51)
    KaneEndHostile()
end

function Kane149()
    fallout.gsay_message(594, 454, 51)
    KaneEndHostile()
end

function Kane150()
    fallout.display_msg(fallout.message_str(594, 455))
end

function Kane151()
    fallout.gsay_message(594, 456, 50)
    KaneTravel()
end

function Kane152()
    fallout.gsay_message(594, 457, 50)
    KaneEndRefuses()
end

function Kane153()
    fallout.gsay_reply(594, 458)
    fallout.giq_option(4, 594, 459, Kane154, 50)
    fallout.giq_option(-3, 594, 460, Kane154, 50)
end

function Kane154()
    fallout.gsay_reply(594, 461)
    fallout.giq_option(4, 594, 462, Kane155, 50)
    fallout.giq_option(-3, 594, 463, Kane155, 50)
end

function Kane155()
    fallout.gsay_message(594, 464, 51)
    KaneEndHostile()
end

function KaneEnd()
end

function KaneEndHostile()
    fallout.set_map_var(11, 1)
    fallout.set_map_var(44, 1)
    fallout.set_map_var(45, 4)
end

function KaneEndNotAcceptedOrDeclined()
    fallout.set_map_var(45, 3)
end

function KaneEndDeclined()
    fallout.set_map_var(45, 2)
end

function KaneEndAnnoyed()
    fallout.set_map_var(45, 6)
end

function KaneEndTakeHike()
    fallout.set_map_var(45, 5)
end

function KaneEndRefuses()
    fallout.set_map_var(45, 4)
    fallout.set_map_var(11, 1)
end

function KaneTravel()
    travel = true
end

function GoToDecker()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local decker_obj = fallout.external_var("Decker_Ptr")
    fallout.set_map_var(45, 1)
    fallout.gfade_out(1000)
    fallout.move_to(self_obj, 22526, 1)
    fallout.anim(self_obj, 1000, fallout.rotation_to_tile(fallout.tile_num(self_obj), fallout.tile_num(decker_obj)))
    fallout.move_to(dude_obj, 23722, 1)
    fallout.anim(dude_obj, 1000, fallout.rotation_to_tile(fallout.tile_num(dude_obj), fallout.tile_num(decker_obj)))
    fallout.gfade_in(1000)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
