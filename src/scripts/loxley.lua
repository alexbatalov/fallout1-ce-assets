local fallout = require("fallout")

local start
local do_dialogue
local loxley00a
local loxley01
local loxley02
local loxley02_1
local loxley03
local loxley04
local loxley05
local loxley06
local loxley06b
local loxley07
local loxley08
local loxley09
local loxley10
local loxley11
local loxley12
local loxley12b
local loxley13
local loxley14
local loxley16
local loxley17
local loxley18
local loxley21
local loxley22
local loxley23
local loxley24
local loxley25
local loxley26
local loxley27
local loxley29
local loxley30
local loxley31
local loxley32
local loxley33
local loxley34
local loxley34_1
local loxley34_2
local loxley35
local loxley35_1
local loxley36
local loxley37
local loxley38
local loxley39
local loxley40
local loxley41
local loxley42
local loxley43
local loxley43a
local loxley44
local loxley47
local loxley48
local loxley51
local loxley53
local loxley54
local loxley55
local loxley56
local loxley57
local loxley58
local loxley59
local loxley60
local loxley61
local loxley62
local loxley90
local loxleyx
local loxleyx1
local loxleyx2
local loxleyx3
local loxleyx4
local loxley00aa
local loxley00ab
local loxley00a1
local loxley01a
local loxley01b
local loxley01c
local loxley03a
local loxley04a
local loxley07a
local loxley18a
local loxley23a
local loxley23b
local loxley23c
local loxley24a
local loxley25a
local loxley27a
local loxley44a
local loxley44b
local loxleyend
local loxley63
local loxley64
local loxley65
local loxley66
local loxley67
local loxley68
local loxley69
local loxley70
local loxley71
local loxley72
local loxley73
local loxley74
local loxley75
local loxley76
local loxley77
local loxley78
local loxley79
local loxley80
local loxley81
local loxley82
local loxley83
local loxley84
local loxley85
local loxley86
local loxley87
local loxley88
local loxley89
local loxley91
local combat

local rndx = 0
local rndy = 0
local rndz = 0
local MALE = 0
local HOSTILE = 0
local DESTROYED = 0
local KILLEDANY = 0
local CAPTURED = 0
local ILLEGBEFORE = 0
local ILLEGAL = 0
local TRESPASS = 0
local CRIME = 0
local floatReward = 0

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

local loxley00

function start()
    local v0 = 0
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(49, 100))
        else
            if fallout.script_action() == 4 then
                combat()
            else
                if fallout.script_action() == 12 then
                    if HOSTILE then
                        HOSTILE = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    end
                else
                    if fallout.script_action() == 18 then
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
                end
            end
        end
    end
end

function do_dialogue()
    get_reaction()
    fallout.set_global_var(207, 1)
    MALE = fallout.get_critter_stat(fallout.dude_obj(), 34) == 0
    if ILLEGAL then
        if ILLEGBEFORE then
            fallout.start_gdialog(49, fallout.self_obj(), 4, 17, 3)
            fallout.gsay_start()
            loxley57()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            if CRIME == TRESPASS then
                fallout.start_gdialog(49, fallout.self_obj(), 4, 17, 3)
                fallout.gsay_start()
                loxley59()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
            if CRIME > TRESPASS then
                fallout.start_gdialog(49, fallout.self_obj(), 4, 17, 3)
                fallout.gsay_start()
                loxley58()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    else
        if fallout.local_var(4) == 1 then
            if fallout.global_var(107) == 1 then
                fallout.start_gdialog(49, fallout.self_obj(), 4, 17, 3)
                fallout.gsay_start()
                loxley27()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                if fallout.global_var(107) == 0 then
                    if fallout.local_var(1) > 1 then
                        fallout.start_gdialog(49, fallout.self_obj(), 4, 17, 3)
                        fallout.gsay_start()
                        loxley01()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    else
                        fallout.start_gdialog(49, fallout.self_obj(), 4, 17, 3)
                        fallout.gsay_start()
                        loxley24()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    end
                else
                    fallout.display_msg(fallout.message_str(49, 267))
                end
            end
        else
            fallout.set_local_var(4, 1)
            if fallout.local_var(1) > 1 then
                fallout.start_gdialog(49, fallout.self_obj(), 4, 17, 3)
                fallout.gsay_start()
                loxley01()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                fallout.start_gdialog(49, fallout.self_obj(), 4, 17, 3)
                fallout.gsay_start()
                loxley24()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
    if floatReward == 1 then
        floatReward = 0
        fallout.float_msg(fallout.self_obj(), fallout.message_str(49, 268), 2)
    end
end

function loxley00a()
    fallout.gsay_reply(49, 104)
    fallout.giq_option(4, 49, fallout.message_str(49, 105) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(49, 106), loxley02, 50)
    fallout.giq_option(4, 49, 107, loxley00a1, 51)
    fallout.giq_option(4, 49, 108, loxley22, 50)
end

function loxley01()
    if MALE then
        fallout.gsay_reply(49, 109)
    else
        fallout.gsay_reply(49, 110)
    end
    fallout.giq_option(4, 49, fallout.message_str(49, 111) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(49, 112), loxley02, 50)
    fallout.giq_option(4, 49, 113, loxley01a, 51)
    fallout.giq_option(4, 49, 114, loxley22, 50)
    fallout.giq_option(5, 49, 115, loxley01b, 49)
    fallout.giq_option(4, 49, 116, loxley01c, 51)
    fallout.giq_option(-3, 49, 117, loxley90, 50)
end

function loxley02()
    fallout.gsay_reply(49, 118)
    fallout.giq_option(4, 49, 119, loxley03, 49)
    fallout.giq_option(4, 49, 120, loxley02_1, 50)
    fallout.giq_option(4, 49, 121, loxley18, 51)
end

function loxley02_1()
    if fallout.local_var(1) > 2 then
        loxley08()
    else
        loxley09()
    end
end

function loxley03()
    fallout.gsay_reply(49, 122)
    fallout.giq_option(4, 49, 123, loxley04, 50)
    fallout.giq_option(4, 49, 124, loxley03a, 51)
    fallout.giq_option(4, 49, 125, loxley17, 50)
end

function loxley04()
    fallout.gsay_reply(49, 126)
    fallout.giq_option(4, 49, 127, loxley05, 50)
    fallout.giq_option(4, 49, 128, loxley04a, 51)
    fallout.giq_option(4, 49, 129, loxley10, 50)
end

function loxley05()
    fallout.gsay_reply(49, 130)
    fallout.giq_option(4, 49, 131, loxley06, 50)
    fallout.giq_option(4, 49, 132, loxley07, 50)
end

function loxley06()
    if MALE then
        fallout.gsay_message(49, 133, 50)
    else
        fallout.gsay_message(49, 134, 50)
    end
    fallout.give_exp_points(900)
    fallout.display_msg(fallout.message_str(766, 103) .. 900 .. fallout.message_str(766, 104))
    fallout.set_global_var(107, 1)
    loxley06b()
end

function loxley06b()
    fallout.gsay_message(49, 135, 50)
    loxleyx()
end

function loxley07()
    fallout.gsay_reply(49, 136)
    fallout.giq_option(4, 49, 137, loxley02_1, 50)
    fallout.giq_option(4, 49, 138, loxley07a, 51)
    fallout.giq_option(4, 49, 139, loxley03, 50)
end

function loxley08()
    fallout.gsay_message(49, 140, 50)
    loxley34()
end

function loxley09()
    BigDownReact()
    fallout.gsay_message(49, 141, 51)
    loxleyx1()
end

function loxley10()
    fallout.gsay_reply(49, 142)
    fallout.giq_option(4, 49, 143, loxley11, 51)
    fallout.giq_option(4, 49, 144, loxley12, 49)
end

function loxley11()
    BigDownReact()
    fallout.gsay_message(49, 145, 51)
    loxleyx1()
end

function loxley12()
    fallout.gsay_reply(49, 146)
    fallout.giq_option(4, 49, 147, loxley12b, 50)
    fallout.giq_option(4, 49, 148, loxley13, 51)
end

function loxley12b()
    fallout.gsay_message(49, 149, 50)
    loxley06()
end

function loxley13()
    BigDownReact()
    fallout.gsay_message(49, 150, 50)
    loxleyx1()
end

function loxley14()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(49, 151)
    fallout.giq_option(4, 49, 152, loxley05, 50)
    fallout.giq_option(4, 49, 153, loxley07, 51)
end

function loxley16()
    BigDownReact()
    fallout.gsay_message(49, 154, 50)
    loxleyx1()
end

function loxley17()
    fallout.gsay_reply(49, 155)
    fallout.giq_option(4, 49, 156, loxley06, 50)
    fallout.giq_option(4, 49, 157, loxley05, 50)
    fallout.giq_option(4, 49, 158, loxley02_1, 50)
end

function loxley18()
    fallout.gsay_reply(49, 159)
    fallout.giq_option(4, 49, 160, loxley18a, 51)
    fallout.giq_option(4, 49, 161, loxley12, 50)
end

function loxley21()
    fallout.gsay_reply(49, 162)
    fallout.giq_option(4, 49, fallout.message_str(49, 163) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(49, 164), loxley02, 50)
    fallout.giq_option(4, 49, 165, loxley10, 51)
end

function loxley22()
    fallout.gsay_reply(49, 166)
    fallout.giq_option(4, 49, 167, loxley04, 50)
    fallout.giq_option(4, 49, 168, loxley02_1, 50)
    fallout.giq_option(4, 49, 169, loxley10, 51)
end

function loxley23()
    fallout.gsay_reply(49, 170)
    fallout.giq_option(4, 49, fallout.message_str(49, 171) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(49, 172), loxley02, 50)
    fallout.giq_option(4, 49, 173, loxley23a, 51)
    fallout.giq_option(4, 49, 174, loxley22, 50)
    fallout.giq_option(5, 49, 175, loxley23b, 49)
    fallout.giq_option(4, 49, 176, loxley23c, 51)
end

function loxley24()
    fallout.gsay_reply(49, 177)
    fallout.giq_option(4, 49, 178, loxley25, 51)
    fallout.giq_option(4, 49, 179, loxley26, 50)
    fallout.giq_option(4, 49, 180, loxley24a, 49)
end

function loxley25()
    fallout.gsay_reply(49, 181)
    fallout.giq_option(4, 49, 182, loxley25a, 49)
    fallout.giq_option(4, 49, 183, loxley26, 51)
end

function loxley26()
    BigDownReact()
    fallout.gsay_message(49, 184, 50)
    loxleyx1()
end

function loxley27()
    fallout.gsay_reply(49, 185)
    fallout.giq_option(4, 49, 186, loxley32, 51)
    fallout.giq_option(4, 49, 187, loxley33, 50)
    fallout.giq_option(4, 49, 188, loxley27a, 50)
end

function loxley29()
    local v0 = 0
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 119)
    UpReact()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 119) then
        fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
        fallout.add_obj_to_inven(fallout.self_obj(), v0)
    end
    fallout.give_exp_points(500)
    fallout.display_msg(fallout.message_str(766, 103) .. 500 .. fallout.message_str(766, 104))
    fallout.set_global_var(107, 2)
    fallout.gsay_message(49, 189, 49)
    loxleyx3()
end

function loxley30()
    fallout.gsay_message(49, 190, 50)
end

function loxley31()
    fallout.gsay_message(49, 191, 51)
    loxleyx1()
end

function loxley32()
    fallout.gsay_message(49, 192, 50)
    fallout.set_global_var(107, 2)
    loxleyx1()
end

function loxley33()
    fallout.gsay_message(49, 193, 51)
    loxleyx4()
end

function loxley34()
    fallout.gsay_reply(0, 0)
    fallout.giq_option(4, 49, 194, loxley34_1, 50)
    fallout.giq_option(4, 49, 195, loxley43, 50)
    fallout.giq_option(4, 49, 196, loxley51, 50)
    fallout.giq_option(4, 49, 197, loxley34_2, 50)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 49, 198, loxley55, 50)
    end
    fallout.giq_option(4, 667, 114, loxleyx1, 50)
end

function loxley34_1()
    if fallout.global_var(51) == 1 then
        if fallout.local_var(1) > 1 then
            loxley35()
        else
            loxley40()
        end
    else
        loxley42()
    end
end

function loxley34_2()
    if fallout.local_var(1) > 2 then
        loxley53()
    else
        loxley54()
    end
end

function loxley35()
    fallout.gsay_reply(49, 199)
    fallout.giq_option(4, 49, 200, loxley36, 50)
    fallout.giq_option(4, 49, 201, loxley35_1, 50)
end

function loxley35_1()
    if fallout.local_var(1) > 2 then
        loxley38()
    else
        loxley39()
    end
end

function loxley36()
    fallout.gsay_reply(49, 202)
    fallout.giq_option(4, 49, 203, loxley37, 50)
    fallout.giq_option(4, 49, 204, loxley35_1, 50)
end

function loxley37()
    fallout.gsay_reply(49, 205)
    fallout.giq_option(4, 49, 206, loxley35_1, 50)
end

function loxley38()
    fallout.set_local_var(6, fallout.local_var(6) + 1)
    if fallout.local_var(6) == 1 then
        fallout.gsay_message(49, 207, 50)
    end
    if fallout.local_var(6) == 2 then
        fallout.gsay_message(49, 208, 50)
    end
    if fallout.local_var(6) > 2 then
        fallout.gsay_message(49, 209, 50)
    end
    loxley34()
end

function loxley39()
    fallout.gsay_message(49, 210, 50)
    loxleyend()
end

function loxley40()
    fallout.gsay_reply(49, 211)
    fallout.giq_option(4, 49, 212, loxley41, 50)
    fallout.giq_option(4, 49, 213, loxley39, 50)
end

function loxley41()
    fallout.gsay_reply(49, 214)
    fallout.giq_option(4, 49, 215, loxley39, 50)
end

function loxley42()
    fallout.set_global_var(219, 1)
    fallout.gsay_message(49, 216, 50)
    loxley34()
end

function loxley43()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(49, 217)
    fallout.giq_option(4, 49, 218, loxley44, 50)
    fallout.giq_option(4, 49, 219, loxley43a, 50)
end

function loxley43a()
    fallout.gsay_message(49, 220, 50)
    loxley34()
end

function loxley44()
    fallout.gsay_reply(49, 221)
    fallout.giq_option(4, 49, 222, loxley44a, 51)
    fallout.giq_option(4, 49, 223, loxley44b, 49)
end

function loxley47()
    fallout.gsay_message(49, 224, 51)
    loxleyx1()
end

function loxley48()
    fallout.gsay_message(49, 225, 50)
    loxley34()
end

function loxley51()
    fallout.gsay_message(49, 226, 50)
    loxley34()
end

function loxley53()
    fallout.gsay_message(49, 227, 50)
    loxley34()
end

function loxley54()
    fallout.gsay_message(49, 228, 50)
    loxley34()
end

function loxley55()
    if fallout.local_var(1) > 1 then
        fallout.gsay_message(49, 229, 50)
    else
        fallout.gsay_message(49, 230, 51)
    end
end

function loxley56()
    fallout.gsay_message(49, 231, 50)
end

function loxley57()
    fallout.gsay_message(49, 232, 50)
end

function loxley58()
    fallout.gsay_message(49, 233, 50)
end

function loxley59()
    fallout.gsay_message(49, 234, 50)
end

function loxley60()
    fallout.gsay_message(49, 235, 50)
end

function loxley61()
    fallout.gsay_message(49, 236, 50)
end

function loxley62()
    fallout.gsay_message(49, 237, 50)
end

function loxley90()
    fallout.gsay_message(49, 265, 50)
    loxleyx1()
end

function loxleyx()
end

function loxleyx1()
end

function loxleyx2()
end

function loxleyx3()
    fallout.set_map_var(3, 1)
    floatReward = 1
end

function loxleyx4()
end

function loxley00aa()
    UpReact()
    loxley00a()
end

function loxley00ab()
    BigDownReact()
    loxley10()
end

function loxley00a1()
    DownReact()
    loxley21()
end

function loxley01a()
    DownReact()
    loxley21()
end

function loxley01b()
    UpReact()
    loxley00()
end

function loxley01c()
    BigDownReact()
    loxley00()
end

function loxley03a()
    DownReact()
    loxley16()
end

function loxley04a()
    DownReact()
    loxley14()
end

function loxley07a()
    DownReact()
    loxley10()
end

function loxley18a()
    DownReact()
    loxley10()
end

function loxley23a()
    DownReact()
    loxley21()
end

function loxley23b()
    UpReact()
    loxley00()
end

function loxley23c()
    BigDownReact()
    loxley00()
end

function loxley24a()
    UpReact()
    loxley23()
end

function loxley25a()
    UpReact()
    loxley23()
end

function loxley27a()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 119) then
        loxley29()
    else
        fallout.set_local_var(5, fallout.local_var(5) + 1)
        if fallout.local_var(5) == 1 then
            loxley30()
        else
            loxley31()
        end
    end
end

function loxley44a()
    DownReact()
    loxley47()
end

function loxley44b()
    UpReact()
    loxley48()
end

function loxleyend()
end

function loxley63()
    fallout.gsay_message(49, 238, 50)
end

function loxley64()
    fallout.gsay_message(49, 239, 50)
end

function loxley65()
    fallout.gsay_message(49, 240, 50)
end

function loxley66()
    fallout.gsay_message(49, 241, 50)
end

function loxley67()
    fallout.gsay_message(49, 242, 50)
end

function loxley68()
    fallout.gsay_message(49, 243, 50)
end

function loxley69()
    fallout.gsay_message(49, 244, 50)
end

function loxley70()
    fallout.gsay_message(49, 245, 50)
end

function loxley71()
    fallout.gsay_message(49, 246, 50)
end

function loxley72()
    fallout.gsay_message(49, 247, 50)
end

function loxley73()
    fallout.gsay_message(49, 248, 50)
end

function loxley74()
    fallout.gsay_message(49, 249, 50)
end

function loxley75()
    fallout.gsay_message(49, 250, 50)
end

function loxley76()
    fallout.gsay_message(49, 251, 50)
end

function loxley77()
    fallout.gsay_message(49, 252, 50)
end

function loxley78()
    fallout.gsay_message(49, 253, 50)
end

function loxley79()
    fallout.gsay_message(49, 254, 50)
end

function loxley80()
    fallout.gsay_message(49, 255, 50)
end

function loxley81()
    fallout.gsay_message(49, 256, 50)
end

function loxley82()
    fallout.gsay_message(49, 257, 50)
end

function loxley83()
    fallout.gsay_message(49, 258, 50)
end

function loxley84()
    fallout.gsay_message(49, 259, 50)
end

function loxley85()
    fallout.gsay_message(49, 260, 50)
end

function loxley86()
    fallout.gsay_message(49, 261, 50)
end

function loxley87()
    fallout.gsay_message(49, 262, 50)
end

function loxley88()
    fallout.gsay_message(49, 263, 50)
end

function loxley89()
    fallout.gsay_message(49, 264, 50)
end

function loxley91()
    fallout.gsay_message(49, 266, 50)
end

function combat()
    HOSTILE = 1
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

function loxley00()
    fallout.gsay_reply(49, 101)
    fallout.giq_option(4, 49, 102, loxley00aa, 49)
    fallout.giq_option(4, 49, 103, loxley00ab, 51)
end

local exports = {}
exports.start = start
return exports
