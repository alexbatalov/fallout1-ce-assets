local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

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
local goto52a
local goto53
local goto54
local goto55
local goto60
local goto61
local goto72
local goto73
local goto73a
local goto73b
local goto73c
local goto74
local goto75
local goto75a
local goto75b
local goto75c
local goto76
local goto76a
local goto77
local goto78
local goto79
local goto79a
local goto80
local goto144
local goto145
local goto146a
local goto146b
local goto147
local goto148
local goto149
local goto150
local do_dialogue
local combat
local gotoend
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc

local hostile = false
local initialized = false
local conmod = 0
local femmod = 0
local Hear_28 = false
local Hear_29 = false
local temp = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 64)
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
    if fallout.local_var(6) == 0 then
        fallout.giq_option(5, 320, fallout.message_str(320, 107), goto3a, 49)
        fallout.giq_option(4, 320, fallout.message_str(320, 108), goto11, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 109), goto10, 50)
    end
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 146), goto48, 50)
    end
    fallout.giq_option(-3, 320, fallout.message_str(320, 110), goto4, 50)
end

function goto3a()
    reaction.UpReact()
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
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(0, fallout.message_str(320, 116))
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
    fallout.gsay_message(0, fallout.message_str(320, 125), 51)
    reaction.DownReact()
end

function goto15()
    fallout.gsay_message(0, fallout.message_str(320, 126), 51)
    reaction.DownReact()
end

function goto16()
    fallout.gsay_reply(0, fallout.message_str(320, 127))
    fallout.giq_option(4, 320, fallout.message_str(320, 128), goto16a, 49)
    fallout.giq_option(4, 320, fallout.message_str(320, 129), goto16b, 51)
end

function goto16a()
    reaction.BigUpReact()
    goto19()
end

function goto16b()
    reaction.DownReact()
    goto20()
end

function goto17()
    fallout.gsay_message(0, fallout.message_str(320, 130), 51)
    reaction.DownReact()
end

function goto18()
    fallout.gsay_reply(0, fallout.message_str(320, 131))
    fallout.giq_option(4, 320, fallout.message_str(320, 132), goto16a, 49)
    fallout.giq_option(4, 320, fallout.message_str(320, 133), goto16b, 51)
end

function goto19()
    local item_obj
    fallout.gsay_message(0, fallout.message_str(320, 134), 49)
    reaction.TopReact()
    item_obj = fallout.create_object_sid(27, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    item_obj = fallout.create_object_sid(27, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    item_obj = fallout.create_object_sid(27, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
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
    local item_obj
    fallout.gsay_message(0, fallout.message_str(320, 141), 50)
    reaction.TopReact()
    item_obj = fallout.create_object_sid(110, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    item_obj = fallout.create_object_sid(110, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
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
    Hear_28 = true
    fallout.gsay_reply(0, fallout.message_str(320, 152))
    if not Hear_29 then
        fallout.giq_option(4, 320, fallout.message_str(320, 153), goto29, 50)
    end
    fallout.giq_option(4, 320, fallout.message_str(320, 154), gotoend, 50)
end

function goto29()
    Hear_29 = true
    fallout.gsay_reply(0, fallout.message_str(320, 155))
    if not Hear_28 then
        fallout.giq_option(8, 320, fallout.message_str(320, 156), goto30, 50)
        fallout.giq_option(4, 320, fallout.message_str(320, 157), goto28, 50)
    end
    fallout.giq_option(4, 320, fallout.message_str(320, 158), gotoend, 50)
end

function goto30()
    fallout.gsay_reply(0, fallout.message_str(320, 159))
    fallout.giq_option(8, 320, fallout.message_str(320, 160), reaction.UpReact, 50)
end

function goto38()
    fallout.gsay_reply(0, fallout.message_str(320, 167))
    fallout.set_map_var(11, fallout.map_var(11) + 1)
    fallout.set_map_var(9, fallout.map_var(9) - 1)
    local item_obj = fallout.create_object_sid(temp, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
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
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 185), goto48, 50)
    end
    fallout.giq_option(4, 320, fallout.message_str(320, 186), gotoend, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 187), goto47a, 51)
    if fallout.global_var(304) == 1 and fallout.local_var(8) == 0 then
        fallout.set_local_var(8, 1)
        fallout.giq_option(4, 320, fallout.message_str(320, 240), goto72, 50)
    end
    fallout.giq_option(-3, 320, fallout.message_str(320, 110), goto4, 50)
end

function goto47a()
    reaction.BigDownReact()
    gotoend()
end

function goto48()
    fallout.gsay_message(0, fallout.message_str(320, 188), 50)
    goto49()
end

function goto49()
    fallout.gsay_message(0, fallout.message_str(320, 189), 50)
    if fallout.map_var(20) > 0 then
        goto146a()
    end
    if fallout.map_var(12) > 0 then
        goto146b()
    elseif fallout.map_var(13) > 0 then
        goto147()
    elseif fallout.map_var(14) > 0 then
        goto148()
    elseif fallout.map_var(15) > 0 then
        goto149()
    elseif fallout.map_var(16) > 0 then
        goto150()
    elseif fallout.map_var(10) > fallout.map_var(11) then
        goto144()
    end
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

function goto72()
    femmod = (fallout.get_critter_stat(fallout.dude_obj(), 3) - 5) * 10
    fallout.gsay_reply(0, fallout.message_str(320, 241))
    fallout.giq_option(4, 320, fallout.message_str(320, 242), goto73, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 243), goto76, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 244), goto77, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 245), goto79, 50)
end

function goto73()
    fallout.gsay_reply(0, fallout.message_str(320, 246))
    fallout.giq_option(4, 320, fallout.message_str(320, 247), goto73a, 50)
    fallout.giq_option(6, 320, fallout.message_str(320, 248), goto73b, 50)
    fallout.giq_option(7, 320, fallout.message_str(320, 249), gotoend, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 250), goto73c, 50)
end

function goto73a()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        conmod = -30
    else
        conmod = femmod
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, conmod)) then
        goto74()
    else
        goto80()
    end
end

function goto73b()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        conmod = -20
    else
        conmod = femmod
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, conmod)) then
        goto74()
    else
        goto80()
    end
end

function goto73c()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        conmod = -10
    else
        conmod = femmod
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, conmod)) then
        goto74()
    else
        goto75()
    end
end

function goto74()
    local item_obj = fallout.create_object_sid(229, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.gsay_reply(0, fallout.message_str(320, 251))
    fallout.giq_option(4, 320, fallout.message_str(320, 252), gotoend, 50)
end

function goto75()
    fallout.gsay_reply(0, fallout.message_str(320, 253))
    fallout.giq_option(6, 320, fallout.message_str(320, 254), goto75a, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 255), goto75b, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 256), goto75c, 50)
end

function goto75a()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        conmod = 0
    else
        conmod = femmod
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, conmod)) then
        goto74()
    else
        goto80()
    end
end

function goto75b()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        conmod = -100
    else
        conmod = femmod
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, conmod)) then
        goto74()
    else
        goto80()
    end
end

function goto75c()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        conmod = -20
    else
        conmod = femmod
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, conmod)) then
        goto74()
    else
        goto80()
    end
end

function goto76()
    fallout.gsay_reply(0, fallout.message_str(320, 257))
    fallout.giq_option(4, 320, fallout.message_str(320, 258), goto76a, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 259), gotoend, 50)
end

function goto76a()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        conmod = -20
    else
        conmod = femmod
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, conmod)) then
        goto74()
    else
        goto75()
    end
end

function goto77()
    fallout.gsay_reply(0, fallout.message_str(320, 260))
    fallout.giq_option(4, 320, fallout.message_str(320, 261), goto78, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 262), goto73, 50)
end

function goto78()
    fallout.gsay_message(0, fallout.message_str(320, 263), 50)
end

function goto79()
    fallout.gsay_reply(0, fallout.message_str(320, 264))
    fallout.giq_option(4, 320, fallout.message_str(320, 265), gotoend, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 266), goto79a, 50)
    fallout.giq_option(4, 320, fallout.message_str(320, 267), goto76, 50)
end

function goto79a()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        conmod = -20
    else
        conmod = femmod
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        goto73()
    else
        goto77()
    end
end

function goto80()
    fallout.gsay_message(0, fallout.message_str(320, 268), 50)
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
end

function goto145()
    fallout.gsay_message(0, fallout.message_str(320, 222), 50)
end

function goto146a()
    fallout.gsay_reply(0, fallout.message_str(320, 235))
    fallout.set_map_var(20, fallout.map_var(20) - 1)
    fallout.set_map_var(9, fallout.map_var(9) - 1)
    local item_obj = fallout.create_object_sid(115, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.giq_option(4, 320, fallout.message_str(320, 224), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 225), goto43, 50)
    end
end

function goto146b()
    fallout.gsay_reply(0, fallout.message_str(320, 223))
    fallout.set_map_var(12, fallout.map_var(12) - 1)
    fallout.set_map_var(9, fallout.map_var(9) - 1)
    local item_obj = fallout.create_object_sid(13, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.giq_option(4, 320, fallout.message_str(320, 224), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 225), goto43, 50)
    end
end

function goto147()
    fallout.gsay_reply(0, fallout.message_str(320, 226))
    fallout.set_map_var(13, fallout.map_var(13) - 1)
    fallout.set_map_var(9, fallout.map_var(9) - 1)
    local item_obj = fallout.create_object_sid(16, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.giq_option(4, 320, fallout.message_str(320, 227), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 228), goto43, 50)
    end
end

function goto148()
    fallout.gsay_reply(0, fallout.message_str(320, 229))
    fallout.set_map_var(14, fallout.map_var(14) - 1)
    fallout.set_map_var(9, fallout.map_var(9) - 1)
    local item_obj = fallout.create_object_sid(239, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.giq_option(4, 320, fallout.message_str(320, 230), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 231), goto43, 50)
    end
end

function goto149()
    fallout.gsay_reply(0, fallout.message_str(320, 232))
    fallout.set_map_var(15, fallout.map_var(15) - 1)
    fallout.set_map_var(9, fallout.map_var(9) - 1)
    local item_obj = fallout.create_object_sid(3, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.giq_option(4, 320, fallout.message_str(320, 233), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 234), goto43, 50)
    end
end

function goto150()
    fallout.gsay_reply(0, fallout.message_str(320, 235))
    fallout.set_map_var(16, fallout.map_var(16) - 1)
    fallout.set_map_var(9, fallout.map_var(9) - 1)
    local item_obj = fallout.create_object_sid(52, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.giq_option(4, 320, fallout.message_str(320, 236), gotoend, 50)
    if fallout.map_var(9) > 0 then
        fallout.giq_option(4, 320, fallout.message_str(320, 237), goto43, 50)
    end
end

function do_dialogue()
    if fallout.local_var(7) ~= 0 then
        if fallout.local_var(1) < 2 then
            goto60()
        else
            goto47()
        end
    else
        fallout.set_local_var(7, 1)
        goto3()
    end
end

function combat()
    hostile = true
end

function gotoend()
end

function critter_p_proc()
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
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
    fallout.start_gdialog(320, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    do_dialogue()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(320, 100))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
