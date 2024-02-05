local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local morphend
local morphcbt
local morph02
local morph02a
local morph02_1
local morph02_2
local morph02_3
local morph03
local morph03_1
local morph03_2
local morph04
local morph04a
local morph05
local morph06
local morph07
local morph07_1
local morph08
local morph09
local morph10
local morph10_1
local morph11
local morph12
local morph13
local morph14
local morph15
local morph16
local morph17
local morph18
local morph18_1
local morph18_2
local morph19
local morph20
local morph21
local morph23
local morph24
local morph26
local morph27
local morph27_1
local morph28
local morph29
local morph30
local morph31
local morph32
local morph33
local morph33_1
local morph34
local morph35
local morph36
local morph37
local morph38
local morph39
local morph39_1
local morph40
local morph41
local morph42
local morph42a
local morph42a_1
local morph42b
local morph42c
local morph45
local morph46
local morph47
local morph48
local morph49
local morph50
local morph51
local morph52
local morph53
local morph54
local morph55
local morph56
local morph57
local morph58
local morph59
local morph60
local morph61
local morph62
local morph63
local morph64
local morph65
local morphx
local morphx2
local morphx4
local morph66
local morph05a
local morph08a
local morph32a
local morph39a
local morph05b

local Signal_wait = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.cur_map_index() == 18 then
            misc.set_team(self_obj, 20)
        else
            misc.set_team(self_obj, 55)
        end
        fallout.critter_add_trait(self_obj, 1, 5, 82)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    end
end

function pickup_p_proc()
    fallout.set_local_var(5, 2)
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(5) ~= 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(766, 172), 2)
        morphcbt()
    else
        if fallout.global_var(241) == 2 then
            fallout.set_global_var(241, 3)
            morph66()
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 23457, 0)
        else
            if Signal_wait then
                Signal_wait = false
                morph04a()
            else
                if fallout.cur_map_index() == 17 then
                    fallout.start_gdialog(53, fallout.self_obj(), 4, 2, 8)
                    fallout.gsay_start()
                    morph28()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    if fallout.global_var(241) == 3 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(766, 171), 2)
                    else
                        fallout.start_gdialog(53, fallout.self_obj(), 4, 2, 8)
                        fallout.gsay_start()
                        morph02()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.global_var(241) == 1 then
        fallout.set_global_var(241, 2)
        fallout.add_timer_event(fallout.external_var("Master_Ptr"), fallout.game_ticks(5), 1)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 2)
        fallout.dialogue_system_enter()
    end
    if fallout.local_var(5) == 2 then
        fallout.set_local_var(5, 1)
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.tile_num(fallout.self_obj()) == 23457 then
        fallout.set_obj_visibility(fallout.self_obj(), 1)
    end
end

function damage_p_proc()
    fallout.set_local_var(5, 1)
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.display_msg(fallout.message_str(53, 500))
    fallout.give_exp_points(1000)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(53, 100))
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.dialogue_system_enter()
        else
            Signal_wait = false
        end
    elseif event == 2 then
        if not fallout.combat_is_initialized() then
            fallout.set_obj_visibility(fallout.self_obj(), true)
        end
    end
end

function morphend()
end

function morphcbt()
    fallout.set_local_var(5, 2)
end

function morph02()
    fallout.gsay_reply(53, 101)
    fallout.giq_option(4, 53, 102, morph02_1, 50)
    fallout.giq_option(5, 53, 103, morph02_3, 50)
    fallout.giq_option(4, 53,
        fallout.message_str(53, 104) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(53, 105), morph27, 50)
    fallout.giq_option(4, 53, 106, morph06, 51)
    fallout.giq_option(-3, 53, 107, morph02a, 50)
end

function morph02a()
    fallout.gsay_message(53, 108, 51)
    morphcbt()
end

function morph02_1()
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        morph02_2()
    else
        morph06()
    end
end

function morph02_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        morph03()
    else
        morph06()
    end
end

function morph02_3()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        morph07()
    else
        morph26()
    end
end

function morph03()
    fallout.gsay_reply(53, 109)
    fallout.giq_option(4, 53, 110, morph03_1, 50)
    fallout.giq_option(5, 53, 111, morph03_2, 50)
    fallout.giq_option(4, 53, 112, morph23, 50)
    fallout.giq_option(4, 53, 113, morph24, 51)
    fallout.giq_option(4, 53, 114, morph06, 50)
end

function morph03_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        morph04()
    else
        morph05()
    end
end

function morph03_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        morph04()
    else
        morph05()
    end
end

function morph04()
    fallout.gsay_message(53, 115, 50)
    morphx()
end

function morph04a()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(53, 116), 7)
    morphcbt()
end

function morph05()
    fallout.gsay_reply(53, 117)
    fallout.giq_option(4, 53, 118, morph05a, 51)
    fallout.giq_option(4, 53, 119, morph05b, 50)
    fallout.giq_option(4, 53, 120, morph06, 51)
end

function morph06()
    fallout.gsay_message(53, 121, 51)
    morphcbt()
end

function morph07()
    fallout.gsay_reply(53, 122)
    fallout.giq_option(4, 53, 123, morph08, 50)
    fallout.giq_option(4, 53, 124, morph16, 50)
    fallout.giq_option(6, 53, 125, morph07_1, 50)
end

function morph07_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        morph20()
    else
        morph21()
    end
end

function morph08()
    fallout.gsay_reply(53, 126)
    fallout.giq_option(5, 53, 127, morph08a, 50)
    fallout.giq_option(4, 53, 128, morph12, 50)
    fallout.giq_option(5, 53, 129, morph14, 50)
end

function morph09()
    fallout.gsay_reply(53, 130)
    fallout.giq_option(5, 53, 131, morph10, 50)
    fallout.giq_option(5, 53, 132, morph10, 50)
    fallout.giq_option(4, 53, 133, morph06, 51)
    fallout.giq_option(4, 53, 134, morph11, 51)
end

function morph10()
    fallout.gsay_reply(53, 135)
    fallout.giq_option(4, 53, 136, morph11, 51)
    fallout.giq_option(4, 53, 137, morph12, 50)
    fallout.giq_option(4, 53, 138, morph10_1, 50)
end

function morph10_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        fallout.set_local_var(1, 2)
        morph13()
    else
        morph11()
    end
end

function morph11()
    fallout.gsay_message(53, 139, 51)
    morphcbt()
end

function morph12()
    fallout.gsay_reply(53, 140)
    fallout.giq_option(4, 53, 141, morphx2, 50)
    fallout.giq_option(4, 53, 142, morphcbt, 51)
end

function morph13()
    fallout.gsay_message(53, 143, 50)
    morphx2()
end

function morph14()
    fallout.gsay_reply(53, 144)
    fallout.giq_option(4, 53, 145, morph12, 50)
    fallout.giq_option(4, 53, 146, morph11, 51)
    fallout.giq_option(4, 53, 147, morph15, 51)
end

function morph15()
    fallout.gsay_message(53, 148, 51)
    morphcbt()
end

function morph16()
    fallout.gsay_reply(53, 149)
    fallout.giq_option(4, 53, 150, morph17, 50)
    fallout.giq_option(4, 53, 151, morph17, 50)
end

function morph17()
    fallout.gsay_reply(53, 152)
    fallout.giq_option(4, 53, 153, morph18, 50)
    fallout.giq_option(4, 53, 154, morph18, 50)
end

function morph18()
    fallout.gsay_reply(53, 155)
    fallout.giq_option(4, 53, 156, morph18_1, 50)
    fallout.giq_option(4, 53, 157, morph18_2, 50)
end

function morph18_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -5)) then
        morph19()
    else
        morph15()
    end
end

function morph18_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -15)) then
        morph12()
    else
        morph15()
    end
end

function morph19()
    fallout.gsay_reply(53, 158)
    fallout.giq_option(4, 53, 159, morphcbt, 51)
    fallout.giq_option(4, 53, 160, morphx2, 50)
end

function morph20()
    fallout.gsay_message(53, 161, 51)
    morphcbt()
end

function morph21()
    fallout.gsay_reply(53, 162)
    fallout.giq_option(4, 53, 163, morph08, 50)
    fallout.giq_option(4, 53, 164, morph16, 50)
end

function morph23()
    fallout.gsay_reply(53, 165)
    fallout.giq_option(4, 53, 166, morph12, 50)
    fallout.giq_option(4, 53, 167, morph16, 50)
    fallout.giq_option(4, 53, 168, morph11, 51)
    fallout.giq_option(4, 53, 169, morph15, 51)
end

function morph24()
    fallout.gsay_reply(53, 170)
    fallout.giq_option(4, 53, 171, morphcbt, 51)
    fallout.giq_option(7, 53, 172, morphcbt, 51)
    fallout.giq_option(4, 53, 173, morphcbt, 51)
end

function morph26()
    fallout.gsay_reply(53, 174)
    fallout.giq_option(4, 53, 175, morph12, 50)
    fallout.giq_option(5, 53, 176, morph16, 50)
    fallout.giq_option(4, 53, 177, morph11, 51)
    fallout.giq_option(4, 53, 178, morph15, 51)
end

function morph27()
    fallout.gsay_reply(53, 179)
    fallout.giq_option(4, 53, 180, morph02_1, 50)
    fallout.giq_option(4, 53, 181, morph27_1, 50)
end

function morph27_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        morph07()
    else
        morph06()
    end
end

function morph28()
    fallout.gsay_reply(53, 182)
    fallout.giq_option(5, 53, 183, morph29, 50)
    fallout.giq_option(4, 53, 184, morphend, 50)
    fallout.giq_option(-3, 53, 185, morph42c, 50)
end

function morph29()
    fallout.gsay_reply(53, 186)
    fallout.giq_option(4, 53, 187, morph30, 50)
    fallout.giq_option(4, 53, 188, morphend, 50)
end

function morph30()
    fallout.gsay_reply(0, 0)
    fallout.giq_option(4, 53, 189, morph31, 50)
    fallout.giq_option(4, 53, 190, morphend, 50)
    fallout.giq_option(4, 53, 191, morph42a, 50)
end

function morph31()
    fallout.gsay_reply(53, 192)
    fallout.giq_option(4, 53, 193, morph32, 50)
    fallout.giq_option(4, 53, 194, morph39, 50)
end

function morph32()
    fallout.gsay_reply(53, 195)
    fallout.giq_option(4, 53, 196, morph32a, 51)
    fallout.giq_option(4, 53, 197, morph38, 50)
end

function morph33()
    fallout.gsay_reply(53, 198)
    fallout.giq_option(4, 53, 199, morph34, 50)
    fallout.giq_option(4, 53, 200, morph33_1, 50)
end

function morph33_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -5)) then
        morph35()
    else
        morph37()
    end
end

function morph34()
    fallout.gsay_message(53, 201, 50)
    morphx4()
end

function morph35()
    fallout.gsay_reply(53, 202)
    fallout.giq_option(4, 53, 203, morph36, 50)
    fallout.giq_option(4, 53, 204, morphend, 50)
end

function morph36()
    fallout.gsay_message(53, 205, 50)
    morph30()
end

function morph37()
    fallout.gsay_message(53, 206, 49)
    morphx4()
end

function morph38()
    fallout.gsay_reply(53, 207)
    fallout.giq_option(4, 53, 208, morph36, 50)
    fallout.giq_option(4, 53, 209, morphend, 50)
end

function morph39()
    fallout.gsay_reply(53, 210)
    fallout.giq_option(4, 53, 211, morph39a, 51)
    fallout.giq_option(4, 53, 212, morph39_1, 50)
end

function morph39_1()
end

function morph40()
    fallout.gsay_message(53, 213, 50)
    morph30()
end

function morph41()
    fallout.gsay_reply(53, 214)
    fallout.giq_option(4, 53, 215, morph30, 50)
    fallout.giq_option(4, 53, 216, morphend, 50)
end

function morph42()
    fallout.gsay_reply(53, 217)
    fallout.giq_option(4, 53, 218, morph36, 50)
    fallout.giq_option(4, 53, 219, morphend, 50)
end

function morph42a()
    fallout.gsay_reply(53, 220)
    fallout.giq_option(4, 53, 221, morph42a_1, 50)
end

function morph42a_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        morph42b()
    else
        morph42c()
    end
end

function morph42b()
    fallout.gsay_message(53, 222, 50)
    morphx2()
end

function morph42c()
    fallout.gsay_message(53, 223, 50)
    morphx4()
end

function morph45()
    fallout.gsay_message(53, 224, 50)
end

function morph46()
    fallout.gsay_message(53, 225, 50)
end

function morph47()
    fallout.gsay_message(53, 226, 50)
end

function morph48()
    fallout.gsay_message(53, 227, 50)
end

function morph49()
    fallout.gsay_message(53, 228, 50)
end

function morph50()
    fallout.gsay_message(53, 229, 50)
end

function morph51()
    fallout.gsay_message(53, 230, 50)
end

function morph52()
    fallout.gsay_message(53, 231, 50)
end

function morph53()
    fallout.gsay_message(53, 232, 50)
end

function morph54()
    fallout.gsay_message(53, 233, 50)
end

function morph55()
    fallout.gsay_message(53, 234, 50)
end

function morph56()
    fallout.gsay_message(53, 235, 50)
end

function morph57()
    fallout.gsay_message(53, 236, 50)
end

function morph58()
    fallout.gsay_message(53, 237, 50)
end

function morph59()
    fallout.gsay_message(53, 238, 50)
end

function morph60()
    fallout.gsay_message(53, 239, 50)
end

function morph61()
    fallout.gsay_message(53, 240, 50)
end

function morph62()
    fallout.gsay_message(53, 241, 50)
end

function morph63()
    fallout.gsay_message(53, 242, 50)
end

function morph64()
    fallout.gsay_message(53, 243, 50)
end

function morph65()
    fallout.gsay_message(53, 244, 50)
end

function morphx()
    Signal_wait = true
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 1)
end

function morphx2()
    fallout.set_global_var(241, 1)
    fallout.load_map("mstrlr34.map", 12)
end

function morphx4()
end

function morph66()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(53, 245), 2)
end

function morph05a()
    reaction.DownReact()
    morph06()
end

function morph08a()
    reaction.DownReact()
    morph09()
end

function morph32a()
    reaction.DownReact()
    morph33()
end

function morph39a()
    reaction.DownReact()
    morph33()
end

function morph05b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        morph07()
    else
        morph26()
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
