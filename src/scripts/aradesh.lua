local fallout = require("fallout")

local start
local do_dialogue
local aradeshleave
local aradeshend
local aradeshcbt
local aradesh01
local aradesh01_2
local aradesh01_3
local aradesh02
local aradesh02_2
local aradesh02_4
local aradesh02_5
local aradesh03
local aradesh04
local aradesh05
local aradesh06
local aradesh07
local aradesh08
local aradesh08a
local aradesh08b
local aradesh09
local aradesh09a
local aradesh10
local aradesh11
local aradesh11a
local aradesh11b
local aradesh12
local aradesh13
local aradesh14
local aradesh15
local aradesh16
local aradesh16_2
local aradesh17
local aradesh17_2
local aradesh17_3
local aradesh18
local aradesh19
local aradesh20
local aradesh21
local aradesh22
local aradesh23
local aradesh23_2
local aradesh24
local aradesh24a
local aradesh24b
local aradesh24c
local aradesh25
local aradesh26
local aradesh27
local aradesh28
local aradesh28a
local aradesh28b
local aradesh28c
local aradesh29
local aradesh30
local aradesh30a
local aradesh30b
local aradesh31
local aradesh32
local aradesh33
local aradesh35
local aradesh36
local aradesh37
local aradesh37a
local aradesh38
local aradesh39
local aradesh39a
local aradesh39b
local aradesh39c
local aradesh40
local aradesh40a
local aradesh41
local aradesh42
local aradesh43
local aradesh44
local aradesh45
local aradesh46
local aradesh47
local aradesh48
local aradeshx
local aradeshx1
local aradeshx2
local aradeshx3
local aradeshx5

local TRESPASS = 0
local ILLEGAL = 0
local ILLEGBEFORE = 0
local hostile = 0
local rndx = 0
local rndy = 0
local rndz = 0
local MALE = 0

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

local aradesh49
local aradesh49a
local aradesh50
local aradesh51
local aradesh52
local aradesh53
local aradesh54
local aradesh55
local aradesh56
local aradesh57
local aradesh58
local aradesh59
local aradesh60
local aradesh61
local aradesh62
local aradesh63
local aradesh64
local aradesh65
local aradesh66
local aradesh67
local aradesh68
local aradesh69
local aradesh70
local aradesh71
local aradesh72
local aradesh73

function start()
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
    if fallout.script_action() == 11 then
        if fallout.local_var(9) > 2 then
            fallout.display_msg(fallout.message_str(766, 170))
            hostile = 1
        else
            if fallout.global_var(246) == 1 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(33, 277), 2)
            else
                do_dialogue()
            end
        end
        if fallout.local_var(7) == 1 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 32945, 0)
        end
    else
        if fallout.script_action() == 12 then
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if fallout.global_var(246) == 1 then
                    hostile = 1
                end
            end
            if hostile then
                hostile = 0
                fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
        else
            if fallout.script_action() == 14 then
                if fallout.source_obj() == fallout.dude_obj() then
                    fallout.set_global_var(246, 1)
                end
            else
                if fallout.script_action() == 21 then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(33, 100))
                else
                    if fallout.script_action() == 18 then
                        fallout.set_global_var(604, 1)
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
                    else
                        if fallout.script_action() == 4 then
                            hostile = 1
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    if fallout.global_var(246) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(33, 277), 2)
    else
        if fallout.local_var(9) > 2 then
            fallout.display_msg(fallout.message_str(766, 170))
            hostile = 1
        else
            get_reaction()
            fallout.start_gdialog(33, fallout.self_obj(), 4, 13, 9)
            fallout.gsay_start()
            if fallout.global_var(26) == 1 then
                fallout.set_local_var(4, 1)
                if fallout.global_var(103) == 0 then
                    aradesh39()
                else
                    aradesh37()
                end
            else
                if fallout.local_var(4) == 1 then
                    if fallout.local_var(5) == 1 then
                        aradesh46()
                    else
                        if (fallout.global_var(26) == 2) and (fallout.local_var(8) == 0) then
                            aradesh43()
                        else
                            if (fallout.global_var(43) == 2) and (fallout.local_var(10) == 0) then
                                fallout.set_local_var(10, 1)
                                aradesh31()
                            else
                                if fallout.global_var(26) == 1 then
                                    if fallout.global_var(103) == 0 then
                                        aradesh39()
                                    else
                                        aradesh37()
                                    end
                                else
                                    if (fallout.global_var(26) == 2) and (fallout.global_var(43) ~= 2) then
                                        aradesh30a()
                                    else
                                        if fallout.global_var(26) == 2 then
                                            aradesh35()
                                        else
                                            if fallout.local_var(1) < 3 then
                                                aradesh18()
                                            else
                                                aradesh17()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    fallout.set_local_var(4, 1)
                    aradesh01()
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function aradeshleave()
    fallout.gsay_message(33, 276, 50)
end

function aradeshend()
end

function aradeshcbt()
    hostile = 1
end

function aradesh01()
    if fallout.local_var(1) >= 2 then
        if fallout.local_var(1) >= 3 then
            fallout.gsay_reply(33, 101)
        else
            fallout.gsay_reply(33, 102)
        end
    else
        fallout.gsay_reply(33, 103)
    end
    fallout.giq_option(5, 33, 104, aradesh02, 50)
    fallout.giq_option(4, 33, 105, aradesh01_2, 51)
    fallout.giq_option(4, 33, 106, aradesh10, 51)
    fallout.giq_option(4, 33, 107, aradesh01_3, 50)
    fallout.giq_option(4, 33, 108, aradesh14, 51)
    fallout.giq_option(5, 33, 109, aradesh07, 51)
    fallout.giq_option(-3, 33, 110, aradesh15, 50)
end

function aradesh01_2()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    DownReact()
    if fallout.local_var(1) >= 2 then
        aradesh05()
    else
        aradesh06()
    end
end

function aradesh01_3()
    if fallout.local_var(1) >= 2 then
        aradesh13()
    else
        aradesh11()
    end
end

function aradesh02()
    fallout.gsay_reply(33, 111)
    fallout.giq_option(4, 33, 112, aradesh02_2, 50)
    fallout.giq_option(4, 33, 113, aradesh01_2, 51)
    fallout.giq_option(5, 33, 114, aradesh02_4, 51)
    fallout.giq_option(5, 33, 115, aradesh02_5, 50)
end

function aradesh02_2()
    if fallout.local_var(1) >= 2 then
        aradesh03()
    else
        aradesh08()
    end
end

function aradesh02_4()
    if fallout.local_var(1) >= 2 then
        aradesh09()
    else
        aradesh06()
    end
end

function aradesh02_5()
    if fallout.local_var(1) >= 2 then
        aradesh04()
    else
        aradesh09()
    end
end

function aradesh03()
    fallout.gsay_reply(33, 116)
    fallout.giq_option(4, 33, 117, aradesh04, 50)
    fallout.giq_option(4, 33, 118, aradesh01_2, 51)
    fallout.giq_option(5, 33, 119, aradesh07, 51)
    fallout.giq_option(4, 33, 120, aradesh07, 51)
end

function aradesh04()
    fallout.gsay_message(33, 121, 50)
    aradeshend()
end

function aradesh05()
    fallout.gsay_reply(33, 122)
    fallout.giq_option(5, 33, 123, aradesh06, 51)
    fallout.giq_option(4, 33, 124, aradesh04, 50)
    fallout.giq_option(4, 33, 125, aradesh07, 51)
end

function aradesh06()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    fallout.gsay_message(33, 126, 51)
    aradeshx1()
end

function aradesh07()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    fallout.gsay_message(33, 127, 51)
    aradeshx2()
end

function aradesh08()
    fallout.gsay_reply(33, 128)
    fallout.giq_option(4, 33, 129, aradesh08a, 49)
    fallout.giq_option(5, 33, 130, aradesh08b, 51)
end

function aradesh08a()
    UpReact()
    aradesh04()
end

function aradesh08b()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    DownReact()
    aradesh06()
end

function aradesh09()
    fallout.gsay_reply(33, 131)
    fallout.giq_option(0, 33, 132, aradesh09a, 50)
end

function aradesh09a()
    fallout.gsay_message(33, 133, 50)
    aradeshx()
end

function aradesh10()
    fallout.gsay_message(33, 134, 50)
    aradeshx()
end

function aradesh11()
    fallout.gsay_reply(33, 135)
    fallout.giq_option(4, 33, 136, aradesh12, 50)
    fallout.giq_option(5, 33, 137, aradesh11a, 50)
    fallout.giq_option(4, 33, 138, aradesh11b, 51)
end

function aradesh11a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        aradesh02()
    else
        aradesh14()
    end
end

function aradesh11b()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    DownReact()
    aradesh14()
end

function aradesh12()
    fallout.gsay_reply(33, 139)
    fallout.giq_option(5, 33, 140, aradesh02, 50)
    fallout.giq_option(4, 33, 141, aradesh13, 50)
    fallout.giq_option(4, 33, 142, aradesh05, 50)
end

function aradesh13()
    fallout.gsay_reply(33, 143)
    fallout.giq_option(4, 33, 160, aradesh19, 50)
    fallout.giq_option(4, 33, 151, aradesh24c, 50)
    fallout.giq_option(-3, 33, 156, aradesh36, 50)
end

function aradesh14()
    fallout.gsay_reply(33, 144)
    fallout.giq_option(5, 33, 145, aradesh06, 51)
    fallout.giq_option(4, 33, 146, aradesh04, 50)
    fallout.giq_option(4, 33, 147, aradesh07, 51)
end

function aradesh15()
    fallout.gsay_message(33, 148, 50)
    aradeshx()
end

function aradesh16()
    fallout.gsay_reply(0, 0)
    fallout.giq_option(8, 33, 149, aradesh25, 50)
    fallout.giq_option(5, 33, 150, aradesh16_2, 50)
    fallout.giq_option(5, 33, 151, aradesh24c, 50)
end

function aradesh16_2()
    if fallout.global_var(43) == 0 then
        aradesh28()
    else
        if fallout.global_var(43) == 1 then
            aradesh30a()
        else
            if (fallout.global_var(43) == 2) and not(fallout.global_var(26) == 2) then
                aradesh31()
            else
                if fallout.global_var(26) == 2 then
                    aradesh35()
                else
                    aradesh26()
                end
            end
        end
    end
end

function aradesh17()
    fallout.gsay_reply(33, 152)
    fallout.giq_option(4, 33, 153, aradesh19, 50)
    fallout.giq_option(4, 33, 154, aradesh17_2, 50)
    fallout.giq_option(5, 33, 155, aradesh17_3, 51)
    fallout.giq_option(-3, 33, 156, aradesh36, 50)
end

function aradesh17_2()
    if fallout.global_var(26) == 2 then
        aradesh44()
    else
        aradesh20()
    end
end

function aradesh17_3()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    DownReact()
    if fallout.global_var(26) == 2 then
        aradesh27()
    else
        if fallout.local_var(1) >= 2 then
            if fallout.local_var(1) >= 3 then
                aradesh27()
            else
                aradesh21()
            end
        else
            aradesh22()
        end
    end
end

function aradesh18()
    if fallout.local_var(1) >= 2 then
        fallout.gsay_reply(33, 157)
    else
        fallout.gsay_reply(33, 158)
    end
    fallout.giq_option(5, 33, 159, aradesh23, 50)
    fallout.giq_option(4, 33, 160, aradesh19, 50)
    fallout.giq_option(4, 33, 161, aradesh17_2, 50)
    fallout.giq_option(-3, 33, 162, aradesh36, 50)
end

function aradesh19()
    if fallout.local_var(1) >= 2 then
        fallout.gsay_reply(33, 163)
    else
        fallout.gsay_reply(33, 164)
    end
    fallout.giq_option(5, 33, 165, aradesh25, 50)
    fallout.giq_option(4, 33, 166, aradesh16_2, 50)
    fallout.giq_option(4, 33, 167, aradesh24c, 50)
end

function aradesh20()
    if fallout.local_var(1) >= 3 then
        fallout.gsay_message(33, 168, 50)
    else
        if fallout.local_var(1) >= 2 then
            fallout.gsay_message(33, 169, 50)
        else
            fallout.gsay_message(33, 170, 50)
        end
    end
    aradeshx()
end

function aradesh21()
    fallout.gsay_message(33, 171, 50)
    aradeshx()
end

function aradesh22()
    fallout.gsay_message(33, 172, 50)
    aradeshx1()
end

function aradesh23()
    if fallout.local_var(1) >= 2 then
        fallout.gsay_reply(33, 173)
    else
        fallout.gsay_reply(33, 174)
    end
    fallout.giq_option(4, 33, 175, aradesh23_2, 50)
    fallout.giq_option(5, 33, 176, aradesh25, 50)
    fallout.giq_option(4, 33, 177, aradesh17_2, 50)
end

function aradesh23_2()
    if fallout.local_var(1) >= 2 then
        aradesh24()
    else
        aradesh24b()
    end
end

function aradesh24()
    fallout.gsay_reply(33, 178)
    fallout.giq_option(0, 33, 179, aradesh24a, 50)
end

function aradesh24a()
    fallout.gsay_reply(33, 180)
    fallout.giq_option(4, 33, 181, aradesh19, 50)
    fallout.giq_option(4, 33, 182, aradesh24c, 50)
end

function aradesh24b()
    fallout.gsay_reply(33, 183)
    fallout.giq_option(4, 33, 184, aradesh19, 50)
end

function aradesh24c()
    if fallout.global_var(26) == 2 then
        aradesh44()
    else
        aradeshx()
    end
end

function aradesh25()
    if fallout.local_var(0) < 2 then
        fallout.gsay_reply(33, 185)
    else
        fallout.gsay_reply(33, 186)
    end
    fallout.giq_option(4, 33, 187, aradesh19, 50)
end

function aradesh26()
    fallout.gsay_reply(33, 188)
    fallout.giq_option(7, 33, 189, aradesh27, 50)
    fallout.giq_option(6, 33, 190, aradesh19, 50)
    fallout.giq_option(6, 33, 191, aradesh24c, 50)
end

function aradesh27()
    fallout.gsay_reply(33, 192)
    fallout.giq_option(8, 33, 193, aradesh25, 50)
    fallout.giq_option(5, 33, 194, aradesh16_2, 50)
    fallout.giq_option(5, 33, 195, aradesh24c, 50)
end

function aradesh28()
    fallout.gsay_reply(33, 196)
    fallout.giq_option(4, 33, 197, aradesh28a, 50)
end

function aradesh28a()
    fallout.gsay_reply(33, 198)
    fallout.giq_option(4, 33, 199, aradesh29, 49)
    fallout.giq_option(4, 33, 200, aradesh28b, 51)
    fallout.giq_option(4, 33, 201, aradesh28c, 51)
end

function aradesh28b()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    DownReact()
    aradesh30()
end

function aradesh28c()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    DownReact()
    aradesh19()
end

function aradesh29()
    fallout.gsay_message(33, 202, 50)
    fallout.set_global_var(43, 1)
    aradeshx()
end

function aradesh30()
    fallout.gsay_reply(33, 203)
    fallout.giq_option(5, 33, 204, aradesh30b, 49)
    fallout.giq_option(4, 33, 205, aradesh19, 50)
end

function aradesh30a()
    fallout.gsay_message(33, 206, 50)
    aradeshx()
end

function aradesh30b()
    UpReact()
    aradesh29()
end

function aradesh31()
    fallout.gsay_reply(33, 207)
    fallout.giq_option(4, 33, 208, aradesh19, 50)
    fallout.giq_option(4, 33, 209, aradesh32, 50)
end

function aradesh32()
    fallout.gsay_reply(33, 210)
    fallout.giq_option(4, 33, 211, aradesh19, 50)
    fallout.giq_option(4, 33, 212, aradesh17_2, 50)
end

function aradesh33()
    fallout.gsay_message(33, 213, 50)
    fallout.set_global_var(103, 1)
    aradeshx()
end

function aradesh35()
    fallout.gsay_reply(33, 214)
    fallout.giq_option(5, 33, 215, aradesh25, 50)
    fallout.giq_option(4, 33, 216, aradesh16_2, 50)
    fallout.giq_option(4, 33, 217, aradesh24c, 50)
end

function aradesh36()
    fallout.gsay_message(33, 218, 50)
    aradeshx()
end

function aradesh37()
    fallout.gsay_reply(33, 219)
    if fallout.global_var(26) == 3 then
        fallout.giq_option(5, 33, 220, aradesh38, 50)
        fallout.giq_option(4, 33, 221, aradesh37a, 50)
        fallout.giq_option(-3, 33, 222, aradesh37a, 50)
    else
        fallout.giq_option(4, 33, 223, aradesh38, 50)
        fallout.giq_option(5, 33, 224, aradesh19, 50)
        fallout.giq_option(-3, 33, 225, aradesh38, 50)
    end
end

function aradesh37a()
    fallout.gsay_message(33, 226, 50)
    aradeshx5()
end

function aradesh38()
    fallout.gsay_message(33, 227, 50)
    aradeshx()
end

function aradesh39()
    fallout.set_global_var(218, 1)
    fallout.gsay_reply(33, 228)
    fallout.giq_option(4, 33, 229, aradesh39a, 50)
    fallout.giq_option(-3, 33, 230, aradesh33, 50)
end

function aradesh39a()
    fallout.gsay_reply(33, 231)
    fallout.giq_option(4, 33, 232, aradesh39b, 50)
    fallout.giq_option(4, 33, 233, aradesh41, 50)
    fallout.giq_option(4, 33, 234, aradesh39c, 50)
end

function aradesh39b()
    UpReact()
    fallout.set_global_var(103, 1)
    aradesh40()
end

function aradesh39c()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    DownReact()
    aradesh42()
end

function aradesh40()
    local v0 = 0
    fallout.gsay_reply(33, 235)
    fallout.set_global_var(103, 1)
    v0 = fallout.create_object_sid(7, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.giq_option(4, 33, 236, aradesh40a, 50)
end

function aradesh40a()
    fallout.gsay_message(33, 237, 50)
    aradeshx()
end

function aradesh41()
    fallout.gsay_reply(33, 238)
    fallout.giq_option(4, 33, 239, aradesh40, 50)
    fallout.giq_option(4, 33, 240, aradesh42, 50)
end

function aradesh42()
    fallout.gsay_message(33, 241, 50)
    aradeshx3()
end

function aradesh43()
    local v0 = 0
    if fallout.local_var(8) == 0 then
        fallout.set_local_var(8, 1)
        v0 = fallout.create_object_sid(41, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), v0, 500)
    end
    TopReact()
    fallout.set_global_var(103, 2)
    fallout.gsay_reply(33, 242)
    fallout.giq_option(4, 33, 243, aradesh19, 50)
    fallout.giq_option(4, 33, 244, aradesh44, 50)
end

function aradesh44()
    fallout.gsay_message(33, 245, 50)
    aradeshx()
end

function aradesh45()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    BigDownReact()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(33, 246), 7)
    aradeshx()
end

function aradesh46()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    BigDownReact()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(33, 247), 7)
    aradeshx()
end

function aradesh47()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    DownReact()
    fallout.gsay_message(33, 248, 50)
    aradeshx()
end

function aradesh48()
    fallout.set_local_var(9, fallout.local_var(9) + 1)
    DownReact()
    fallout.gsay_message(33, 249, 50)
end

function aradeshx()
end

function aradeshx1()
    fallout.world_map()
end

function aradeshx2()
    fallout.world_map()
end

function aradeshx3()
end

function aradeshx5()
    fallout.set_local_var(7, 1)
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

function aradesh49()
    fallout.gsay_message(33, 250, 50)
end

function aradesh49a()
    fallout.gsay_message(33, 251, 50)
end

function aradesh50()
    fallout.gsay_message(33, 252, 50)
end

function aradesh51()
    fallout.gsay_message(33, 253, 50)
end

function aradesh52()
    fallout.gsay_message(33, 254, 50)
end

function aradesh53()
    fallout.gsay_message(33, 255, 50)
end

function aradesh54()
    fallout.gsay_message(33, 256, 50)
end

function aradesh55()
    fallout.gsay_message(33, 257, 50)
end

function aradesh56()
    fallout.gsay_message(33, 258, 50)
end

function aradesh57()
    fallout.gsay_message(33, 259, 50)
end

function aradesh58()
    fallout.gsay_message(33, 260, 50)
end

function aradesh59()
    fallout.gsay_message(33, 261, 50)
end

function aradesh60()
    fallout.gsay_message(33, 262, 50)
end

function aradesh61()
    fallout.gsay_message(33, 263, 50)
end

function aradesh62()
    fallout.gsay_message(33, 264, 50)
end

function aradesh63()
    fallout.gsay_message(33, 265, 50)
end

function aradesh64()
    fallout.gsay_message(33, 266, 50)
end

function aradesh65()
    fallout.gsay_message(33, 267, 50)
end

function aradesh66()
    fallout.gsay_message(33, 268, 50)
end

function aradesh67()
    fallout.gsay_message(33, 269, 50)
end

function aradesh68()
    fallout.gsay_message(33, 270, 50)
end

function aradesh69()
    fallout.gsay_message(33, 271, 50)
end

function aradesh70()
    fallout.gsay_message(33, 272, 50)
end

function aradesh71()
    fallout.gsay_message(33, 273, 50)
end

function aradesh72()
    fallout.gsay_message(33, 274, 50)
end

function aradesh73()
    fallout.gsay_message(33, 275, 50)
end

local exports = {}
exports.start = start
return exports
