local fallout = require("fallout")
local misc = require("lib.misc")
local time = require("lib.time")

local start
local goto0
local goto1
local goto2
local goto3
local goto3a
local goto4
local goto5
local goto10
local goto11
local goto11a
local goto12
local goto13
local goto13a
local goto13b
local goto14
local goto15
local goto16
local goto16a
local goto16b
local goto17
local goto18
local goto19
local goto20
local goto21
local goto22
local goto23
local goto24
local goto26
local goto27
local goto28
local goto29
local goto30
local goto38
local goto39
local goto40
local goto41
local goto42
local goto43
local goto44a
local goto44b
local goto44c
local goto44d
local goto44e
local goto44f
local goto44g
local goto44h
local goto44i
local goto47
local goto47a
local goto48
local goto49
local goto50
local goto51
local goto52
local goto52a
local goto53
local goto54
local goto55
local goto56
local goto57
local goto58
local goto59
local goto60
local goto61
local goto144
local goto145
local goto146
local goto147
local goto148
local goto149
local goto150
local Do_Dialogue
local CheckFlag
local combat
local gotoend
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc

local hostile = 0
local initialized = false
local Open_Door = 0
local Herebefore = 0
local item = 0
local Hear_28 = 0
local Hear_29 = 0
local Hear_50 = 0
local temp = 0
local temp2 = 0

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
    if not initialized then
        misc.set_team(fallout.self_obj(), 44)
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

function goto0()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(320, 103), 0)
end

function goto1()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(320, 104), 0)
end

function goto2()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(320, 105), 0)
end

function goto3()
    fallout.gsay_reply(0, fallout.message_str(320, 106))
    fallout.giq_option(5, 320, fallout.message_str(320, 107), goto3a, 49)
    fallout.giq_option(4, 320, fallout.message_str(320, 108), goto11, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 109), goto10, 50)
    fallout.giq_option(-3, 320, fallout.message_str(320, 110), goto4, 50)
end

function goto3a()
    UpReact()
    goto11()
end

function goto4()
    fallout.gsay_reply(0, fallout.message_str(320, 111))
    fallout.giq_option(-3, 320, fallout.message_str(320, 112), goto5, 50)
    fallout.giq_option(-3, 320, fallout.message_str(320, 113), goto5, 50)
end

function goto5()
    fallout.gsay_message(0, fallout.message_str(320, 114), 50)
end

function goto10()
    fallout.gsay_message(0, fallout.message_str(320, 115), 50)
end

function goto11()
    fallout.gsay_reply(0, fallout.message_str(320, 116))
    fallout.giq_option(5, 320, fallout.message_str(320, 117), goto11a, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 118), goto26, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 119), gotoend, 50)
end

function goto11a()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
        goto13()
    else
        goto12()
    end
end

function goto12()
    fallout.gsay_message(0, fallout.message_str(320, 120), 50)
end

function goto13()
    fallout.gsay_message(0, fallout.message_str(320, 121), 50)
    fallout.giq_option(5, 320, fallout.message_str(320, 122), goto13a, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 123), goto13b, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 124), goto22, 50)
end

function goto13a()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            goto16()
        else
            goto18()
        end
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            goto14()
        else
            goto17()
        end
    end
end

function goto13b()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
        goto22()
    else
        goto15()
    end
end

function goto14()
    fallout.gsay_message(0, fallout.message_str(320, 125), 50)
    DownReact()
end

function goto15()
    fallout.gsay_message(0, fallout.message_str(320, 126), 50)
    DownReact()
end

function goto16()
    fallout.gsay_reply(0, fallout.message_str(320, 127))
    fallout.giq_option(4, 320, fallout.message_str(320, 128), goto16a, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 129), goto16b, 50)
end

function goto16a()
    BigUpReact()
    goto19()
end

function goto16b()
    DownReact()
    goto20()
end

function goto17()
    fallout.gsay_message(0, fallout.message_str(320, 130), 50)
    DownReact()
end

function goto18()
    fallout.gsay_reply(0, fallout.message_str(320, 131))
    fallout.giq_option(4, 320, fallout.message_str(320, 132), goto16a, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 133), goto16b, 50)
end

function goto19()
    fallout.gsay_message(0, fallout.message_str(320, 134), 50)
    TopReact()
    item = fallout.create_object_sid(27, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    item = fallout.create_object_sid(27, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    item = fallout.create_object_sid(27, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
end

function goto20()
    fallout.gsay_message(0, fallout.message_str(320, 135), 50)
end

function goto21()
    fallout.gsay_message(0, fallout.message_str(320, 136), 50)
end

function goto22()
    fallout.gsay_reply(0, fallout.message_str(320, 137))
    fallout.giq_option(6, 320, fallout.message_str(320, 138), goto23, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 139), goto24, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 140), gotoend, 50)
end

function goto23()
    fallout.gsay_message(0, fallout.message_str(320, 141), 50)
    TopReact()
    item = fallout.create_object_sid(50, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    item = fallout.create_object_sid(50, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
end

function goto24()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(0, fallout.message_str(320, 142), 50)
    else
        fallout.gsay_message(0, fallout.message_str(320, 143), 50)
    end
end

function goto26()
    fallout.gsay_reply(0, fallout.message_str(320, 144))
    fallout.giq_option(4, 320, fallout.message_str(320, 145), goto27, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 146), goto48, 50)
    end
    fallout.giq_option(4, 320, fallout.message_str(320, 147), goto27, 50)
end

function goto27()
    fallout.gsay_reply(0, fallout.message_str(320, 148))
    fallout.giq_option(4, 320, fallout.message_str(320, 149), goto28, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 150), goto29, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 151), gotoend, 50)
end

function goto28()
    Hear_28 = 1
    fallout.gsay_reply(0, fallout.message_str(320, 152))
    if Hear_29 == 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 153), goto29, 50)
    end
    fallout.giq_option(4, 320, fallout.message_str(320, 154), gotoend, 50)
end

function goto29()
    Hear_29 = 1
    fallout.gsay_reply(0, fallout.message_str(320, 155))
    if Hear_28 == 0 then
        fallout.giq_option(8, 320, fallout.message_str(320, 156), goto30, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 157), goto28, 50)
    end
    fallout.giq_option(4, 320, fallout.message_str(320, 158), gotoend, 50)
end

function goto30()
    fallout.gsay_reply(0, fallout.message_str(320, 159))
    fallout.giq_option(8, 320, fallout.message_str(320, 160), UpReact, 50)
end

function goto38()
    fallout.gsay_reply(0, fallout.message_str(320, 167))
    temp2 = fallout.map_var(11) + 1
    fallout.set_map_var(11, temp2)
    item = fallout.create_object_sid(temp, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    fallout.giq_option(4, 320, fallout.message_str(320, 168), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 169), goto43, 50)
    end
end

function goto39()
    fallout.gsay_reply(0, fallout.message_str(320, 170))
    fallout.giq_option(4, 320, fallout.message_str(320, 171), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 172), goto43, 50)
    end
end

function goto40()
    fallout.gsay_reply(0, fallout.message_str(320, 173))
    fallout.giq_option(4, 320, fallout.message_str(320, 174), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 175), goto43, 50)
    end
end

function goto41()
    fallout.gsay_reply(0, fallout.message_str(320, 176))
    fallout.giq_option(4, 320, fallout.message_str(320, 177), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 178), goto43, 50)
    end
end

function goto42()
    fallout.gsay_reply(0, fallout.message_str(320, 179))
    fallout.giq_option(4, 320, fallout.message_str(320, 180), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 181), goto43, 50)
    end
end

function goto43()
    fallout.gsay_message(0, fallout.message_str(320, 182), 50)
    goto49()
end

function goto44a()
    temp = 29
    goto38()
end

function goto44b()
    temp = 30
    goto38()
end

function goto44c()
    temp = 31
    goto38()
end

function goto44d()
    temp = 111
    goto38()
end

function goto44e()
    temp = 33
    goto38()
end

function goto44f()
    temp = 34
    goto38()
end

function goto44g()
    temp = 35
    goto38()
end

function goto44h()
    temp = 36
    goto38()
end

function goto44i()
    temp = 95
    goto38()
end

function goto47()
    fallout.gsay_reply(0, fallout.message_str(320, 183))
    if Hear_50 == 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 184), goto50, 50)
    end
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 185), goto48, 50)
    end
    fallout.giq_option(4, 320, fallout.message_str(320, 186), gotoend, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 187), goto47a, 50)
end

function goto47a()
    BigDownReact()
    gotoend()
end

function goto48()
    fallout.gsay_message(0, fallout.message_str(320, 188), 50)
    goto49()
end

function goto49()
    fallout.gsay_message(0, fallout.message_str(320, 189), 50)
    if fallout.map_var(10) > fallout.map_var(11) then
        goto144()
    else
        if fallout.map_var(12) > 0 then
            goto146()
        else
            if fallout.map_var(13) > 0 then
                goto147()
            else
                if fallout.map_var(14) > 0 then
                    goto148()
                else
                    if fallout.map_var(15) > 0 then
                        goto149()
                    else
                        if fallout.map_var(16) > 0 then
                            goto150()
                        end
                    end
                end
            end
        end
    end
    temp = 0
    temp = temp + fallout.map_var(10) - fallout.map_var(11)
    temp = temp + fallout.map_var(12)
    temp = temp + fallout.map_var(13)
    temp = temp + fallout.map_var(14)
    temp = temp + fallout.map_var(15)
    temp = temp + fallout.map_var(16)
    if temp == 0 then
        fallout.set_map_var(9, 0)
    end
end

function goto50()
    Hear_50 = 1
    fallout.gsay_reply(0, fallout.message_str(320, 190))
    fallout.giq_option(4, 320, fallout.message_str(320, 191), goto51, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 192), gotoend, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 193), goto47a, 51)
end

function goto51()
    fallout.gsay_message(0, fallout.message_str(320, 194), 50)
    fallout.set_local_var(5, time.game_time_in_hours())
    fallout.set_map_var(6, 1)
    item = fallout.create_object_sid(27, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    item = fallout.create_object_sid(27, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    item = fallout.create_object_sid(27, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
end

function goto52()
    fallout.gsay_reply(0, fallout.message_str(320, 195))
    fallout.giq_option(4, 320, fallout.message_str(320, 196), goto53, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 197), goto57, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 198), gotoend, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 199), goto52a, 50)
end

function goto52a()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        goto54()
    else
        goto55()
    end
end

function goto53()
    fallout.gsay_message(0, fallout.message_str(320, 200), 50)
end

function goto54()
    fallout.gsay_message(0, fallout.message_str(320, 201), 50)
end

function goto55()
    fallout.gsay_message(0, fallout.message_str(320, 202), 50)
end

function goto56()
    fallout.gsay_message(0, fallout.message_str(320, 203), 50)
end

function goto57()
    fallout.gsay_message(0, fallout.message_str(320, 204), 50)
end

function goto58()
    fallout.gsay_message(0, fallout.message_str(320, 205), 50)
end

function goto59()
    fallout.gsay_message(0, fallout.message_str(320, 206), 50)
end

function goto60()
    fallout.gsay_reply(0, fallout.message_str(320, 207))
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 208), goto61, 50)
    end
    fallout.giq_option(4, 320, fallout.message_str(320, 209), gotoend, 50)
end

function goto61()
    fallout.gsay_message(0, fallout.message_str(320, 210), 50)
    goto49()
end

function goto144()
    fallout.gsay_reply(0, fallout.message_str(320, 211))
    fallout.giq_option(4, 320, fallout.message_str(320, 212), goto145, 50)
    if fallout.map_var(10) > fallout.map_var(11) then
        fallout.giq_option(4, 320, fallout.message_str(320, 213), goto44a, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 214), goto44b, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 215), goto44c, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 216), goto44d, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 217), goto44e, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 218), goto44f, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 219), goto44g, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 220), goto44h, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 221), goto44i, 50)
    end
    fallout.display_msg("sadg")
end

function goto145()
    fallout.gsay_message(0, fallout.message_str(320, 222), 50)
end

function goto146()
    fallout.gsay_reply(0, fallout.message_str(320, 223))
    temp2 = fallout.map_var(12) - 1
    fallout.set_map_var(12, temp2)
    item = fallout.create_object_sid(9, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    fallout.giq_option(4, 320, fallout.message_str(320, 224), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 225), goto43, 50)
    end
end

function goto147()
    fallout.gsay_reply(0, fallout.message_str(320, 226))
    temp2 = fallout.map_var(13) - 1
    fallout.set_map_var(13, temp2)
    item = fallout.create_object_sid(22, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    fallout.giq_option(4, 320, fallout.message_str(320, 227), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 228), goto43, 50)
    end
end

function goto148()
    fallout.gsay_reply(0, fallout.message_str(320, 229))
    temp2 = fallout.map_var(14) - 1
    fallout.set_map_var(14, temp2)
    item = fallout.create_object_sid(17, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    fallout.giq_option(4, 320, fallout.message_str(320, 230), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 231), goto43, 50)
    end
end

function goto149()
    fallout.gsay_reply(0, fallout.message_str(320, 232))
    temp2 = fallout.map_var(15) - 1
    fallout.set_map_var(15, temp2)
    item = fallout.create_object_sid(3, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    fallout.giq_option(4, 320, fallout.message_str(320, 233), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 234), goto43, 50)
    end
end

function goto150()
    fallout.gsay_reply(0, fallout.message_str(320, 235))
    temp2 = fallout.map_var(16) - 1
    fallout.set_map_var(16, temp2)
    item = fallout.create_object_sid(52, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    fallout.giq_option(4, 320, fallout.message_str(320, 236), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 237), goto43, 50)
    end
end

function Do_Dialogue()
    if fallout.map_var(8) ~= 0 then
        fallout.set_map_var(8, 2)
        goto59()
    else
        if fallout.map_var(7) ~= 0 then
            goto56()
        else
            if fallout.map_var(6) and ((time.game_time_in_hours() - fallout.local_var(5)) < 48) then
                goto52()
            else
                if fallout.map_var(6) and ((time.game_time_in_hours() - fallout.local_var(5)) >= 48) then
                    goto58()
                else
                    if Herebefore then
                        if fallout.local_var(1) < 2 then
                            goto60()
                        else
                            goto47()
                        end
                    else
                        goto3()
                    end
                end
            end
        end
    end
end

function CheckFlag()
end

function combat()
    hostile = 1
end

function gotoend()
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
    get_reaction()
    fallout.start_gdialog(320, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Do_Dialogue()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(159, fallout.global_var(159) + 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(320, 100))
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
        if (fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if (fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1) then
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
return exports
