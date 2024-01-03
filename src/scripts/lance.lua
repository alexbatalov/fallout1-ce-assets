local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local Lance00
local Lance00a
local Lance01
local Lance02
local Lance03
local Lance04
local Lance04a
local Lance05
local Lance06
local Lance07
local Lance08
local Lance09
local Lance10
local Lance11
local Lance12
local Lance13
local Lance14
local Lance15
local Lance16
local Lance17
local Lance18
local Lance19
local Lance19a
local Lance20
local Lance21
local Lance22
local Lance23
local Lance24
local Lance25
local Lance26
local Lance27
local Lance28
local Lance29
local Lance30
local Lance31
local Lance31a
local Lance32
local Lance33
local Lance34
local Lance35
local Lance36
local Lance37
local Lance38
local Lance39
local Lance40
local Lance41
local Lance42
local Lance43
local Lance44
local Lance45
local Lance46
local Lance47
local Lance48
local Lance49
local Lance50
local Lance51
local Lance52
local LanceCombat
local LanceEnd
local LanceLoot

local hostile = 0
local initialized = false
local known = 0
local go_to_Shady = 0
local go_to_Raiders = 0

local exit_line = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 4)
        hostile = fallout.global_var(334)
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
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

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if known and (fallout.tile_num(fallout.self_obj()) < 20000) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.self_obj(), 0, 3), 0)
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    fallout.set_global_var(332, 1)
end

function pickup_p_proc()
    hostile = 1
    fallout.set_global_var(334, 1)
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.global_var(12) ~= 0 then
        if known then
            Lance52()
        else
            fallout.start_gdialog(699, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Lance49()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    else
        if known then
            if fallout.local_var(1) == 1 then
                Lance02()
            else
                fallout.start_gdialog(699, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Lance03()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        else
            if fallout.global_var(246) or (fallout.global_var(155) < -30) or (reputation.has_rep_berserker()) or (fallout.global_var(158) > 2) then
                if (fallout.global_var(103) == 2) and (fallout.global_var(43) == 2) then
                    fallout.start_gdialog(699, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Lance00()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    Lance01()
                end
            else
                if fallout.global_var(68) < 2 then
                    if fallout.local_var(1) >= 2 then
                        fallout.start_gdialog(699, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Lance04()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    else
                        Lance05()
                    end
                else
                    fallout.start_gdialog(699, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    if fallout.local_var(1) >= 2 then
                        Lance07()
                    else
                        Lance06()
                    end
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            end
        end
    end
    if go_to_Shady then
        fallout.gfade_out(600)
        fallout.game_time_advance(fallout.game_ticks(86400))
        fallout.load_map(26, 0)
    end
    if go_to_Raiders then
        fallout.gfade_out(600)
        fallout.game_time_advance(fallout.game_ticks(86400))
        fallout.load_map(24, 0)
    end
end

function Lance00()
    reaction.BottomReact()
    known = 1
    fallout.gsay_reply(699, 102)
    fallout.giq_option(4, 699, 103, Lance00a, 51)
    fallout.giq_option(4, 699, 104, Lance10, 50)
    fallout.giq_option(4, 699, 105, Lance11, 50)
    fallout.giq_option(4, 699, 106, Lance12, 50)
    fallout.giq_option(-3, 699, 107, Lance13, 50)
end

function Lance00a()
    if (fallout.get_critter_stat(fallout.dude_obj(), 0) > 7) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 15) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 118) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 13) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 12) then
        Lance08()
    else
        Lance09()
    end
end

function Lance01()
    reaction.BottomReact()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(699, 108), 0)
    hostile = 1
    fallout.set_global_var(334, 1)
end

function Lance02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(699, 109), 0)
end

function Lance03()
    fallout.gsay_reply(699, 110)
    if (fallout.global_var(101) == 1) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 699, 111, Lance14, 50)
    end
    if (fallout.global_var(26) == 1) and (fallout.global_var(103) == 1) then
        fallout.giq_option(4, 699, 112, Lance15, 50)
    end
    if fallout.global_var(103) == 2 then
        fallout.giq_option(4, 699, 113, Lance16, 50)
    end
    fallout.giq_option(4, 699, 114, Lance17, 50)
    fallout.giq_option(-3, 699, 115, Lance18, 50)
end

function Lance04()
    known = 1
    fallout.gsay_reply(699, 116)
    if (fallout.global_var(101) == 1) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 699, 111, Lance14, 50)
    end
    fallout.giq_option(4, 699, 118, Lance04a, 50)
    fallout.giq_option(4, 699, 119, Lance22, 50)
    fallout.giq_option(4, 699, 120, Lance23, 50)
    fallout.giq_option(-3, 699, 121, Lance24, 50)
end

function Lance04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Lance19()
    else
        Lance20()
    end
end

function Lance05()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(699, 122), 0)
end

function Lance06()
    fallout.gsay_reply(699, fallout.message_str(699, 123) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(699, 124))
    fallout.giq_option(4, 699, 125, Lance25, 50)
    fallout.giq_option(4, 699, 113, Lance16, 50)
    fallout.giq_option(4, 699, 127, Lance26, 50)
    fallout.giq_option(4, 699, 128, Lance28, 50)
    fallout.giq_option(4, 699, 121, Lance18, 51)
end

function Lance07()
    known = 1
    fallout.gsay_reply(699, fallout.message_str(699, 123) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(699, 130))
    fallout.giq_option(4, 699, 131, Lance29, 50)
    fallout.giq_option(4, 699, 113, Lance16, 50)
    if (fallout.global_var(101) == 1) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 699, 111, Lance14, 50)
    end
    fallout.giq_option(4, 699, 132, Lance00a, 51)
    fallout.giq_option(4, 699, 133, Lance30, 50)
    fallout.giq_option(-3, 699, 121, Lance18, 50)
end

function Lance08()
    fallout.gsay_reply(699, 134)
    fallout.giq_option(0, 634, 106, LanceLoot, 51)
end

function Lance09()
    fallout.gsay_message(699, 135, 51)
    hostile = 1
    fallout.set_global_var(334, 1)
end

function Lance10()
    fallout.gsay_reply(699, 126)
    fallout.giq_option(4, 699, 136, Lance00a, 51)
    fallout.giq_option(4, 699, 137, Lance31, 50)
    fallout.giq_option(4, 699, 105, Lance11, 50)
    fallout.giq_option(4, 699, 106, Lance12, 50)
    fallout.giq_option(4, 699, 138, LanceCombat, 51)
end

function Lance11()
    reaction.BottomReact()
    fallout.gsay_message(699, 139, 51)
end

function Lance12()
    fallout.gsay_message(699, 140, 51)
end

function Lance13()
    fallout.gsay_message(699, 141, 50)
end

function Lance14()
    fallout.gsay_reply(699, 142)
    fallout.giq_option(4, 699, 143, Lance14, 50)
    if (fallout.global_var(103) == 1) and (fallout.global_var(26) == 1) then
        fallout.giq_option(4, 699, 112, Lance15, 50)
    end
    if fallout.global_var(103) == 2 then
        fallout.giq_option(4, 699, 113, Lance16, 50)
    end
    fallout.giq_option(4, 699, 114, Lance17, 50)
    if fallout.global_var(43) == 2 then
        fallout.giq_option(4, 699, 144, Lance32, 50)
    end
end

function Lance15()
    fallout.gsay_reply(699, 145)
    fallout.giq_option(4, 699, 146, Lance33, 50)
    fallout.giq_option(4, 699, 147, Lance34, 50)
    fallout.giq_option(4, 699, 148, Lance35, 50)
    fallout.giq_option(4, 699, 149, Lance36, 50)
end

function Lance16()
    fallout.gsay_reply(699, 150)
    fallout.giq_option(4, 699, 151, Lance37, 50)
    fallout.giq_option(4, 699, 152, Lance38, 50)
    fallout.giq_option(4, 699, 144, Lance32, 50)
    fallout.giq_option(4, 699, 153, Lance39, 50)
end

function Lance17()
    fallout.gsay_reply(699, 154)
    if (fallout.global_var(101) == 1) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 699, 111, Lance14, 50)
    end
    if (fallout.global_var(103) == 1) and (fallout.global_var(26) == 1) then
        fallout.giq_option(4, 699, 112, Lance15, 50)
    end
    if fallout.global_var(103) == 2 then
        fallout.giq_option(4, 699, 113, Lance16, 50)
    end
    fallout.giq_option(4, 699, 155, Lance17, 50)
    fallout.giq_option(4, 699, 156, Lance36, 50)
end

function Lance18()
    fallout.gsay_message(699, 157, 51)
end

function Lance19()
    fallout.gsay_reply(699, 158)
    fallout.giq_option(4, 699, 159, Lance19a, 50)
    fallout.giq_option(4, 699, 160, Lance42, 50)
    if (fallout.global_var(101) == 1) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 699, 161, Lance43, 50)
    end
    fallout.giq_option(4, 699, 162, Lance48, 50)
end

function Lance19a()
    if fallout.get_critter_stat(fallout.dude_obj(), 3) > 6 then
        Lance40()
    else
        Lance41()
    end
end

function Lance20()
    reaction.BottomReact()
    fallout.gsay_message(699, 163, 51)
end

function Lance21()
    reaction.BottomReact()
    fallout.gsay_message(699, 164, 51)
end

function Lance22()
    if fallout.global_var(71) < 1 then
        fallout.set_global_var(71, 1)
    end
    fallout.gsay_message(699, 165, 50)
end

function Lance23()
    reaction.BottomReact()
    fallout.gsay_message(699, 166, 51)
end

function Lance24()
    fallout.gsay_message(699, 167, 51)
end

function Lance25()
    fallout.gsay_reply(699, 168)
    fallout.giq_option(4, 699, 169, Lance44, 50)
    fallout.giq_option(4, 699, 170, LanceCombat, 51)
    fallout.giq_option(4, 699, 171, Lance28, 50)
    fallout.giq_option(4, 699, 172, Lance31, 50)
end

function Lance26()
    fallout.gsay_reply(699, 173)
    fallout.giq_option(4, 699, 169, Lance44, 50)
    fallout.giq_option(4, 699, 170, Lance45, 51)
    fallout.giq_option(4, 699, 171, Lance28, 50)
    fallout.giq_option(4, 699, 172, Lance31, 50)
end

function Lance27()
    reaction.BottomReact()
    fallout.gsay_reply(699, 174)
    fallout.giq_option(0, 634, 106, LanceLoot, 51)
end

function Lance28()
    fallout.gsay_message(699, 175, 50)
end

function Lance29()
    fallout.gsay_reply(699, 176)
    fallout.giq_option(4, 699, 177, Lance46, 50)
    fallout.giq_option(4, 699, 178, Lance47, 50)
end

function Lance30()
    fallout.gsay_reply(699, 179)
    fallout.giq_option(0, 634, 106, Lance29, 50)
end

function Lance31()
    fallout.gsay_reply(699, 180)
    fallout.giq_option(0, 634, 106, Lance31a, 51)
end

function Lance31a()
    fallout.gsay_message(699, 181, 50)
end

function Lance32()
    fallout.gsay_reply(699, 182)
    if (fallout.global_var(101) == 1) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 699, 161, Lance43, 50)
    end
    if (fallout.global_var(103) == 1) and (fallout.global_var(26) == 1) then
        fallout.giq_option(4, 699, 112, Lance15, 50)
    end
    if fallout.global_var(103) == 2 then
        fallout.giq_option(4, 699, 113, Lance16, 50)
    end
    fallout.giq_option(4, 699, 114, Lance17, 50)
    fallout.giq_option(4, 699, 183, Lance36, 50)
end

function Lance33()
    fallout.gsay_message(699, 184, 50)
    go_to_Shady = 1
end

function Lance34()
    fallout.gsay_message(699, 185, 50)
    go_to_Raiders = 1
end

function Lance35()
    fallout.gsay_message(699, 186, 50)
end

function Lance36()
    fallout.gsay_message(699, 187, 50)
end

function Lance37()
    fallout.gsay_reply(699, 188)
    fallout.giq_option(0, 634, 106, LanceLoot, 50)
end

function Lance38()
    fallout.gsay_message(699, 189, 50)
end

function Lance39()
    fallout.gsay_message(699, 190, 49)
end

function Lance40()
    fallout.gsay_message(699, 191, 50)
    go_to_Shady = 1
end

function Lance41()
    fallout.gsay_message(699, 192, 50)
end

function Lance42()
    fallout.gsay_message(699, 193, 50)
end

function Lance43()
    fallout.gsay_reply(699, 194)
    fallout.giq_option(0, 634, 106, Lance36, 50)
end

function Lance44()
    fallout.gsay_message(699, 195, 50)
end

function Lance45()
    reaction.BottomReact()
    fallout.gsay_message(699, 196, 51)
end

function Lance46()
    fallout.gsay_message(699, 197, 50)
    go_to_Shady = 1
end

function Lance47()
    fallout.gsay_message(699, 198, 50)
end

function Lance48()
    fallout.gsay_message(699, 199, 50)
end

function Lance49()
    known = 1
    fallout.gsay_reply(699, 200)
    fallout.giq_option(4, 699, 201, Lance50, 50)
    fallout.giq_option(4, 699, 202, Lance51, 50)
    fallout.giq_option(4, 699, 203, Lance50, 50)
    fallout.giq_option(4, 699, 204, Lance51, 50)
    fallout.giq_option(-3, 699, 205, Lance51, 50)
end

function Lance50()
    fallout.gsay_message(699, 206, 50)
end

function Lance51()
    fallout.gsay_message(699, 207, 50)
end

function Lance52()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(699, 208), 0)
end

function LanceCombat()
    hostile = 1
    fallout.set_global_var(334, 1)
end

function LanceEnd()
end

function LanceLoot()
    fallout.gdialog_mod_barter(0)
    fallout.giq_option(4, 634, 103, LanceEnd, 50)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
