local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local BobStandardQuestions
local BobBlackmailQuestions
local BBQa
local Bob00
local Bob01
local Bob01a
local Bob02
local Bob03
local Bob04
local Bob05
local Bob06
local Bob07
local Bob08
local Bob09
local Bob09a
local Bob09b
local Bob09c
local Bob09d
local Bob10
local Bob11
local Bob12
local Bob13
local Bob14
local Bob15
local Bob16
local Bob18
local Bob19
local Bob20
local Bob20a
local Bob21
local Bob22
local Bob23
local Bob25
local Bob27
local Bob28
local Bob30
local Bob31
local Bob32
local Bob33
local Bob34
local Bob35
local Bob36
local Bob38
local Bob39
local Bob42
local Bob43
local Bob44
local Bob44a
local Bob44b
local Bob44c
local Bob44d
local Bob44e
local Bob45
local Bob46
local Bob47
local Bob48
local Bob49
local Bob50
local BobEnd
local BobCombat

local hostile = 0
local initialized = false
local ToldRumor1 = 0
local ToldRumor2 = 0
local ToldRumor3 = 0
local ToldRumor4 = 0
local ToldRumor5 = 0

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 19)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
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
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(5) == 0 then
        if fallout.local_var(1) == 1 then
            fallout.start_gdialog(891, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Bob04()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.start_gdialog(891, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Bob05()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    else
        if fallout.local_var(5) == 1 then
            if fallout.local_var(6) <= time.game_time_in_days() then
                if fallout.do_check(fallout.dude_obj(), 0, 0) or fallout.do_check(fallout.dude_obj(), 3, 0) then
                    fallout.start_gdialog(891, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Bob00()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    fallout.start_gdialog(891, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Bob01()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            else
                fallout.start_gdialog(891, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Bob02()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        else
            Bob03()
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(891, 100))
end

function BobStandardQuestions()
    fallout.giq_option(4, 891, 231, Bob11, 50)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 891, 232, Bob18, 50)
    end
    if fallout.global_var(219) == 1 then
        if fallout.global_var(203) ~= 0 then
            fallout.giq_option(4, 891, 233, Bob23, 50)
        else
            fallout.giq_option(4, 891, 233, Bob19, 50)
        end
    end
    if fallout.global_var(305) == 1 then
        fallout.giq_option(4, 891, 234, Bob20, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 891, 235, Bob21, 50)
    end
    fallout.giq_option(4, 891, 237, Bob25, 50)
    fallout.giq_option(4, 891, 240, BobEnd, 50)
    fallout.giq_option(-3, 891, 238, Bob11, 50)
    fallout.giq_option(-3, 891, 241, BobEnd, 50)
end

function BobBlackmailQuestions()
    fallout.giq_option(4, 891, 102, BBQa, 50)
    fallout.giq_option(4, 891, 103, Bob06, 51)
    fallout.giq_option(4, 891, 104, Bob07, 50)
    if fallout.global_var(219) == 1 then
        if fallout.global_var(203) ~= 0 then
            fallout.giq_option(4, 891, 233, Bob23, 50)
        else
            fallout.giq_option(4, 891, 233, Bob08, 50)
        end
    end
    fallout.giq_option(4, 891, 106, Bob10, 50)
    fallout.giq_option(4, 891, 240, BobEnd, 50)
end

function BBQa()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -15)) then
        Bob09()
    else
        Bob13()
    end
end

function Bob00()
    local v0 = 0
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), fallout.local_var(7))
    fallout.set_local_var(6, time.game_time_in_days() + 5)
    fallout.gsay_reply(891, 101)
    BobBlackmailQuestions()
end

function Bob01()
    fallout.gsay_reply(891, 108)
    fallout.giq_option(6, 891, 109, Bob01a, 50)
    fallout.giq_option(4, 891, 110, Bob01a, 50)
    fallout.giq_option(4, 891, 111, Bob14, 50)
    fallout.giq_option(4, 891, 112, Bob15, 50)
    fallout.giq_option(4, 891, 113, Bob16, 50)
    fallout.giq_option(4, 891, 114, BobCombat, 50)
end

function Bob01a()
    if fallout.local_var(7) > 250 then
        Bob13()
    else
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
            Bob12()
        else
            Bob13()
        end
    end
end

function Bob02()
    fallout.gsay_reply(891, 115)
    BobBlackmailQuestions()
end

function Bob03()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(891, 116), 2)
end

function Bob04()
    fallout.gsay_reply(891, 117)
    fallout.giq_option(4, 891, 236, Bob22, 50)
    BobStandardQuestions()
end

function Bob05()
    fallout.gsay_reply(891, 118)
    BobStandardQuestions()
end

function Bob06()
    fallout.gsay_message(891, 119, 51)
    BobCombat()
end

function Bob07()
    fallout.set_local_var(5, 3)
    fallout.gsay_message(891, 120, 50)
end

function Bob08()
    fallout.gsay_reply(891, 121)
    fallout.giq_option(4, 891, 106, Bob10, 50)
    fallout.giq_option(4, 891, 107, Bob11, 50)
end

function Bob09()
    fallout.gsay_reply(891, 122)
    fallout.giq_option(4, 891, fallout.message_str(891, 123) .. (fallout.local_var(7) + 25) .. fallout.message_str(891, 124), Bob09a, 50)
    fallout.giq_option(4, 891, fallout.message_str(891, 123) .. (fallout.local_var(7) + 50) .. fallout.message_str(891, 124), Bob09b, 50)
    fallout.giq_option(4, 891, fallout.message_str(891, 123) .. (fallout.local_var(7) + 75) .. fallout.message_str(891, 124), Bob09c, 50)
    fallout.giq_option(4, 891, fallout.message_str(891, 123) .. (fallout.local_var(7) + 100) .. fallout.message_str(891, 124), Bob09d, 50)
end

function Bob09a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
        fallout.set_local_var(7, fallout.local_var(7) + 25)
        Bob46()
    else
        Bob47()
    end
end

function Bob09b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -15)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -1)) then
        fallout.set_local_var(7, fallout.local_var(7) + 50)
        Bob46()
    else
        Bob47()
    end
end

function Bob09c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -3)) then
        fallout.set_local_var(7, fallout.local_var(7) + 75)
        Bob46()
    else
        Bob47()
    end
end

function Bob09d()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -45)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -4)) then
        fallout.set_local_var(7, fallout.local_var(7) + 100)
        Bob46()
    else
        Bob47()
    end
end

function Bob10()
    fallout.gsay_message(891, 125, 50)
end

function Bob11()
    fallout.gsay_reply(891, 142)
    fallout.giq_option(4, 891, 129, Bob27, 50)
    fallout.giq_option(4, 891, 131, Bob28, 50)
    fallout.giq_option(4, 891, 130, Bob30, 50)
    fallout.giq_option(-3, 891, 203, Bob27, 50)
    fallout.giq_option(-3, 891, 204, Bob28, 50)
    fallout.giq_option(-3, 891, 133, Bob30, 50)
end

function Bob12()
    local v0 = 0
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), fallout.local_var(7))
    fallout.set_local_var(6, time.game_time_in_days() + 5)
    fallout.gsay_message(891, 134, 51)
end

function Bob13()
    fallout.set_local_var(5, 2)
    fallout.gsay_message(891, 135, 51)
end

function Bob14()
    fallout.set_local_var(5, 2)
    fallout.gsay_message(891, 136, 51)
end

function Bob15()
    fallout.set_local_var(5, 2)
    fallout.gsay_message(891, 137, 51)
end

function Bob16()
    fallout.set_local_var(5, 2)
    fallout.gsay_message(891, 138, 51)
end

function Bob18()
    fallout.gsay_reply(891, 148)
    fallout.giq_option(4, 891, 149, Bob32, 50)
    BobStandardQuestions()
end

function Bob19()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(891, 150)
    fallout.giq_option(4, 891, 152, Bob33, 50)
    BobStandardQuestions()
end

function Bob20()
    fallout.gsay_reply(891, 153)
    fallout.giq_option(4, 891, 154, Bob20a, 50)
    fallout.giq_option(4, 891, 155, Bob34, 50)
    fallout.giq_option(4, 891, 156, Bob35, 50)
    fallout.giq_option(4, 891, 157, Bob36, 50)
end

function Bob20a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) then
        Bob36()
    else
        Bob34()
    end
end

function Bob21()
    fallout.gsay_reply(891, 239)
    BobStandardQuestions()
end

function Bob22()
    fallout.gsay_reply(891, 158)
    BobStandardQuestions()
end

function Bob23()
    fallout.gsay_reply(891, 159)
    BobStandardQuestions()
end

function Bob25()
    if (fallout.global_var(203) ~= 0) and (ToldRumor1 == 0) then
        ToldRumor1 = 1
        fallout.set_global_var(219, 1)
        fallout.gsay_message(891, 160, 50)
    else
        if (fallout.global_var(221) == 1) and (ToldRumor2 == 0) then
            ToldRumor2 = 1
            fallout.gsay_message(891, 161, 50)
        else
            if (fallout.global_var(111) == 2) and (ToldRumor3 == 0) then
                ToldRumor3 = 1
                fallout.gsay_message(891, 162, 50)
            else
                if (fallout.global_var(107) == 2) and (ToldRumor4 == 0) then
                    ToldRumor4 = 1
                    fallout.gsay_message(891, 163, 50)
                else
                    if (fallout.global_var(112) == 2) and (ToldRumor5 == 0) then
                        ToldRumor5 = 1
                        fallout.gsay_message(891, 164, 50)
                    else
                        fallout.gsay_message(891, 165, 50)
                    end
                end
            end
        end
    end
    fallout.gsay_message(891, 166, 50)
    BobStandardQuestions()
end

function Bob27()
    local v0 = 0
    local v1 = 0
    if fallout.item_caps_total(fallout.dude_obj()) < 20 then
        fallout.gsay_message(891, 169, 50)
    else
        v1 = fallout.item_caps_adjust(fallout.dude_obj(), -20)
        v0 = fallout.create_object_sid(81, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
        fallout.gsay_message(891, 170, 50)
    end
    BobStandardQuestions()
end

function Bob28()
    local v0 = 0
    local v1 = 0
    if fallout.item_caps_total(fallout.dude_obj()) < 8 then
        fallout.gsay_message(891, 173, 50)
    else
        v1 = fallout.item_caps_adjust(fallout.dude_obj(), -8)
        v0 = fallout.create_object_sid(103, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
        if fallout.local_var(5) > 0 then
            fallout.gsay_message(891, 171, 50)
            fallout.giq_option(4, 891, 172, Bob38, 50)
        else
            fallout.gsay_message(891, 174, 50)
        end
    end
    BobStandardQuestions()
end

function Bob30()
    fallout.gsay_message(891, 175, 50)
end

function Bob31()
    fallout.gsay_reply(891, 176)
    fallout.giq_option(4, 891, 177, Bob42, 50)
    fallout.giq_option(4, 891, 178, Bob43, 50)
    fallout.giq_option(4, 891, 179, Bob44, 50)
end

function Bob32()
    fallout.gsay_reply(891, 180)
    BobStandardQuestions()
end

function Bob33()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(891, 182)
    BobStandardQuestions()
end

function Bob34()
    fallout.set_local_var(5, 2)
    fallout.gsay_message(891, 183, 51)
end

function Bob35()
    fallout.gsay_reply(891, 184)
    fallout.giq_option(4, 891, 185, Bob42, 50)
    fallout.giq_option(4, 891, 186, Bob43, 50)
    fallout.giq_option(4, 891, 187, Bob44, 50)
end

function Bob36()
    fallout.gsay_reply(891, 188)
    fallout.giq_option(4, 891, 189, Bob42, 50)
    fallout.giq_option(4, 891, 190, Bob43, 50)
    fallout.giq_option(4, 891, 191, Bob44, 50)
end

function Bob38()
    fallout.gsay_message(891, 194, 51)
end

function Bob39()
    fallout.gsay_message(891, 195, 50)
end

function Bob42()
    fallout.gsay_message(891, 207, 50)
end

function Bob43()
    fallout.gsay_reply(891, 208)
    fallout.giq_option(4, 891, 209, BobCombat, 50)
    fallout.giq_option(4, 891, 210, Bob45, 50)
    fallout.giq_option(4, 891, 211, Bob44, 50)
end

function Bob44()
    fallout.gsay_reply(891, 212)
    fallout.giq_option(4, 891, fallout.message_str(891, 213) .. fallout.message_str(891, 214) .. fallout.message_str(891, 219), Bob44a, 50)
    fallout.giq_option(4, 891, fallout.message_str(891, 213) .. fallout.message_str(891, 215) .. fallout.message_str(891, 219), Bob44b, 50)
    fallout.giq_option(4, 891, fallout.message_str(891, 213) .. fallout.message_str(891, 216) .. fallout.message_str(891, 219), Bob44c, 50)
    fallout.giq_option(4, 891, fallout.message_str(891, 213) .. fallout.message_str(891, 217) .. fallout.message_str(891, 219), Bob44d, 50)
    fallout.giq_option(4, 891, fallout.message_str(891, 213) .. fallout.message_str(891, 218) .. fallout.message_str(891, 219), Bob44e, 50)
    fallout.giq_option(4, 891, 220, Bob48, 50)
end

function Bob44a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 2)) then
        fallout.set_local_var(7, 50)
        Bob46()
    else
        Bob13()
    end
end

function Bob44b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
        fallout.set_local_var(7, 75)
        Bob46()
    else
        Bob13()
    end
end

function Bob44c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -1)) then
        fallout.set_local_var(7, 100)
        Bob46()
    else
        Bob13()
    end
end

function Bob44d()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -3)) then
        fallout.set_local_var(7, 150)
        Bob46()
    else
        Bob13()
    end
end

function Bob44e()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -60)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -6)) then
        fallout.set_local_var(7, 200)
        Bob46()
    else
        Bob13()
    end
end

function Bob45()
    fallout.gsay_message(891, 221, 51)
end

function Bob46()
    if fallout.local_var(5) ~= 1 then
        fallout.give_exp_points(500)
        fallout.display_msg(fallout.message_str(766, 103) .. 500 .. fallout.message_str(766, 104))
    end
    fallout.set_local_var(5, 1)
    fallout.set_local_var(6, time.game_time_in_days() + 5)
    fallout.set_global_var(155, fallout.global_var(155) - 2)
    fallout.gsay_message(891, fallout.message_str(891, 222) .. fallout.local_var(7) .. fallout.message_str(891, 223), 50)
end

function Bob47()
    fallout.gsay_reply(891, 224)
    fallout.giq_option(4, 891, 225, Bob49, 50)
    fallout.giq_option(4, 891, 226, Bob50, 50)
    fallout.giq_option(4, 891, 227, Bob13, 50)
end

function Bob48()
    fallout.gsay_message(891, 228, 51)
end

function Bob49()
    fallout.gsay_message(891, 229, 51)
end

function Bob50()
    fallout.gsay_message(891, 230, 50)
end

function BobEnd()
end

function BobCombat()
    combat()
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
