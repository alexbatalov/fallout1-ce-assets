local fallout = require("fallout")

local start
local do_dialogue
local social_skills
local slummer00
local slummer01
local slummer02
local slummer03
local slummer03a
local slummer04
local slummer04a
local slummer05
local slummer06
local slummer07
local slummer07a
local slummer08
local slummer09
local slummer10
local slummer10a
local slummer11
local slummer12
local slummer13
local slummer13a
local slummer13b
local slummer13c
local slummer14
local slummer15
local slummer16
local slummer17
local slummer17a
local slummer18
local slummer19
local slummer19a
local slummer20
local slummer21
local slummer21a
local slummer22
local slummer23
local slummer24
local slummer25
local slummer25a
local slummer26
local slummer26a
local slummer27
local slummer28
local slummer29
local slummer30
local slummer31
local slummer32
local slummer33
local slummer34
local slummer35
local slummer36
local slummer36a
local slummer36b
local slummer37
local slummer38a
local slummer38
local slummer39
local slummer40
local slummer41
local slummer42
local slummer43
local slummer44
local slummer45
local slummer46
local slummer47
local slummer48
local slummer49
local slummer50
local slummer51
local slummer51a
local slummer52
local slummer52a
local slummer53
local slummer54
local slummer54a
local slummer55
local slummer56
local slummer57
local slummer58
local slummer59
local slummer60
local slummer61
local slummer62
local slummer63
local slummer64
local slummer65
local slummer65a
local slummer66
local slummer67
local slummerdone
local slummerend
local slummercombat
local weapon_check

local hostile = 0
local armed = 0
local LASHERKNOWN = 0
local Only_Once = 1

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
    if Only_Once then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        Only_Once = 0
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(391, 100))
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
                    fallout.set_global_var(160, fallout.global_var(160) + 1)
                    if (fallout.global_var(160) % 6) == 0 then
                        fallout.set_global_var(155, fallout.global_var(155) + 1)
                    end
                end
            else
                if fallout.script_action() == 4 then
                    hostile = 1
                else
                    if fallout.script_action() == 12 then
                        if hostile then
                            hostile = 0
                            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    get_reaction()
    weapon_check()
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.local_var(4) == 0 then
            if armed == 1 then
                slummer02()
            else
                slummer03()
            end
        else
            fallout.set_local_var(4, 1)
            slummer01()
        end
    else
        fallout.set_local_var(4, 1)
        if fallout.global_var(195) == 1 then
            slummer00()
        else
            if armed == 1 then
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                    slummer04()
                else
                    if (fallout.global_var(158) > 2) or (((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1))) then
                        slummer06()
                    else
                        slummer05()
                    end
                end
            else
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                    slummer07()
                else
                    if (fallout.global_var(158) > 2) or (((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1))) then
                        slummer09()
                    else
                        slummer08()
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function social_skills()
    fallout.script_overrides()
    get_reaction()
    do_dialogue()
end

function slummer00()
    fallout.gsay_message(391, 101, 50)
end

function slummer01()
    fallout.gsay_message(391, 102, 50)
end

function slummer02()
    fallout.gsay_reply(391, 103)
    fallout.giq_option(7, 391, 104, slummer10, 50)
    fallout.giq_option(7, 391, 105, slummer11, 50)
    fallout.giq_option(4, 391, 106, slummer13, 50)
    fallout.giq_option(4, 391, 107, slummer15, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 108, slummer16, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 109, slummer18, 50)
    end
    fallout.giq_option(-3, 391, 110, slummer14, 50)
end

function slummer03()
    fallout.gsay_reply(391, 111)
    fallout.giq_option(7, 391, 112, slummer03a, 50)
    fallout.giq_option(7, 391, 113, slummer20, 50)
    fallout.giq_option(4, 391, 114, slummer21, 50)
    fallout.giq_option(4, 391, 115, slummer22, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 116, slummer16, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 117, slummer17, 50)
    end
    fallout.giq_option(-3, 391, 118, slummer23, 50)
end

function slummer03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer19()
    else
        slummer49()
    end
end

function slummer04()
    fallout.gsay_reply(391, 119)
    fallout.giq_option(7, 391, 120, slummer04a, 50)
    fallout.giq_option(7, 391, 121, slummer20, 50)
    fallout.giq_option(4, 391, 122, slummer26, 50)
    fallout.giq_option(4, 391, 123, slummer27, 50)
    fallout.giq_option(4, 391, 124, slummer15, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 125, slummer16, 50)
    end
    fallout.giq_option(-3, 391, 126, slummer28, 50)
end

function slummer04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) then
        slummer25()
    else
        slummer49()
    end
end

function slummer05()
    fallout.gsay_reply(391, 127)
    fallout.giq_option(7, 391, 128, slummer29, 50)
    fallout.giq_option(4, 391, 129, slummer30, 50)
    fallout.giq_option(4, 391, 130, slummer31, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 131, slummer16, 50)
    end
    fallout.giq_option(-3, 391, 132, slummer28, 50)
end

function slummer06()
    fallout.gsay_reply(391, 133)
    fallout.giq_option(7, 391, 134, slummer29, 50)
    fallout.giq_option(4, 391, 135, slummer32, 50)
    fallout.giq_option(4, 391, 136, slummer31, 50)
    fallout.giq_option(4, 391, 137, slummer34, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 138, slummer34, 50)
    end
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 139, slummer16, 50)
    end
    fallout.giq_option(-3, 391, 140, slummer28, 50)
end

function slummer07()
    fallout.gsay_reply(391, 141)
    fallout.giq_option(7, 391, 142, slummer07a, 50)
    fallout.giq_option(7, 391, 143, slummer20, 50)
    fallout.giq_option(4, 391, 144, slummer33, 50)
    fallout.giq_option(4, 391, 145, slummer16, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 146, slummer16, 50)
    end
    fallout.giq_option(-3, 391, 147, slummer35, 50)
end

function slummer07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer29()
    else
        slummer49()
    end
end

function slummer08()
    fallout.gsay_reply(391, 148)
    fallout.giq_option(7, 391, 149, slummer07a, 50)
    fallout.giq_option(7, 391, 150, slummer20, 50)
    fallout.giq_option(4, 391, 151, slummer36, 50)
    fallout.giq_option(4, 391, 152, slummer37, 50)
    fallout.giq_option(4, 391, 153, slummer15, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 154, slummer16, 50)
    end
    fallout.giq_option(-3, 391, 155, slummer35, 50)
end

function slummer09()
    fallout.gsay_message(391, 156, 50)
end

function slummer10()
    fallout.gsay_reply(391, 157)
    fallout.giq_option(7, 391, 158, slummer10a, 50)
    fallout.giq_option(7, 391, 159, slummer20, 50)
    fallout.giq_option(4, 391, 160, slummer36, 50)
    fallout.giq_option(4, 391, 161, slummer37, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 162, slummer16, 50)
    end
end

function slummer10a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer38()
    else
        slummer61()
    end
end

function slummer11()
    LASHERKNOWN = 1
    fallout.gsay_message(391, 163, 50)
end

function slummer12()
end

function slummer13()
    fallout.gsay_reply(391, 165)
    fallout.giq_option(7, 391, 166, slummer13a, 50)
    fallout.giq_option(7, 391, 167, slummer13b, 50)
    fallout.giq_option(4, 391, 168, slummer13c, 50)
    fallout.giq_option(4, 391, 169, slummer43, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 170, slummercombat, 50)
    end
end

function slummer13a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        slummer42()
    else
        slummer43()
    end
end

function slummer13b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        slummer39()
    else
        slummer43()
    end
end

function slummer13c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer14()
    else
        slummer43()
    end
end

function slummer14()
    fallout.gsay_message(391, 171, 50)
end

function slummer15()
    fallout.gsay_message(391, 172, 50)
end

function slummer16()
    fallout.gsay_reply(391, 173)
    fallout.giq_option(7, 391, 174, slummer44, 50)
    fallout.giq_option(4, 391, 175, slummer45, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 176, slummercombat, 50)
    end
end

function slummer17()
    fallout.gsay_reply(391, 177)
    fallout.giq_option(7, 391, 178, slummer17a, 50)
    fallout.giq_option(4, 391, 179, slummerend, 50)
    fallout.giq_option(4, 391, 180, slummercombat, 50)
end

function slummer17a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        slummer46()
    else
        slummer49()
    end
end

function slummer18()
    fallout.gsay_message(391, 181, 50)
end

function slummer19()
    fallout.gsay_reply(391, 182)
    fallout.giq_option(7, 391, 183, slummer19a, 50)
    fallout.giq_option(7, 391, 184, slummer47, 50)
    fallout.giq_option(4, 391, 185, slummer44, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 186, slummer44, 50)
    end
end

function slummer19a()
    slummer49()
end

function slummer20()
    fallout.set_global_var(196, 1)
    fallout.gsay_reply(391, 187)
    fallout.giq_option(7, 391, 188, slummer47, 50)
    fallout.giq_option(4, 391, 189, slummer44, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 190, slummer44, 50)
    end
end

function slummer21()
    fallout.gsay_reply(391, 191)
    fallout.giq_option(7, 391, 192, slummer21a, 50)
    fallout.giq_option(7, 391, 193, slummer11, 50)
    fallout.giq_option(4, 391, 194, slummer20, 50)
    fallout.giq_option(4, 391, 195, slummer15, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 196, slummer16, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 197, slummercombat, 50)
    end
end

function slummer21a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer25()
    else
        slummer49()
    end
end

function slummer22()
    LASHERKNOWN = 1
    fallout.gsay_reply(391, 198)
    fallout.giq_option(7, 391, 199, slummer50, 50)
    fallout.giq_option(7, 391, 200, slummer49, 50)
    fallout.giq_option(4, 391, 201, slummer33, 50)
    fallout.giq_option(4, 391, 202, slummer20, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 203, slummer16, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 204, slummer44, 50)
    end
end

function slummer23()
    fallout.gsay_message(391, 205, 50)
end

function slummer24()
    fallout.set_global_var(196, 1)
    fallout.gsay_message(391, 206, 50)
end

function slummer25()
    fallout.gsay_reply(391, 207)
    fallout.giq_option(7, 391, 208, slummer25a, 50)
    fallout.giq_option(7, 391, 209, slummer52, 50)
    fallout.giq_option(4, 391, 210, slummer33, 50)
    fallout.giq_option(4, 391, 211, slummer54, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 212, slummer16, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 213, slummer24, 50)
    end
end

function slummer25a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer51()
    else
        slummer49()
    end
end

function slummer26()
    fallout.gsay_reply(391, 214)
    fallout.giq_option(7, 391, 215, slummer26a, 50)
    fallout.giq_option(7, 391, 216, slummer33, 50)
    fallout.giq_option(4, 391, 217, slummer55, 50)
    fallout.giq_option(4, 391, 218, slummer54, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 219, slummer24, 50)
    end
end

function slummer26a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer51()
    else
        slummer49()
    end
end

function slummer27()
    fallout.gsay_reply(391, 220)
    fallout.giq_option(7, 391, 221, slummer56, 50)
    fallout.giq_option(4, 391, 222, slummer44, 50)
    fallout.giq_option(4, 391, 223, slummer57, 50)
    fallout.giq_option(4, 391, 224, slummer54, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 225, slummer16, 50)
    end
end

function slummer28()
    fallout.gsay_reply(391, 226)
    fallout.giq_option(-3, 391, 227, slummer44, 50)
    fallout.giq_option(-3, 391, 228, slummer49, 50)
end

function slummer29()
    fallout.gsay_reply(391, 229)
    fallout.giq_option(7, 391, 230, slummer58, 50)
    fallout.giq_option(7, 391, 231, slummer59, 50)
    fallout.giq_option(4, 391, 232, slummer01, 50)
    fallout.giq_option(4, 391, 233, slummer44, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 234, slummercombat, 50)
    end
end

function slummer30()
    fallout.gsay_message(391, 235, 50)
end

function slummer31()
    fallout.gsay_reply(391, 236)
    fallout.giq_option(7, 391, 237, slummer52, 50)
    fallout.giq_option(7, 391, 238, slummer44, 50)
    fallout.giq_option(4, 391, 239, slummer18, 50)
    fallout.giq_option(4, 391, 240, slummer20, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 241, slummer24, 50)
    end
end

function slummer32()
    fallout.set_global_var(196, 1)
    LASHERKNOWN = 1
    fallout.gsay_message(391, 242, 50)
end

function slummer33()
    fallout.set_global_var(196, 1)
    fallout.gsay_reply(391, 243)
    fallout.giq_option(7, 391, 244, slummer47, 50)
    fallout.giq_option(4, 391, 245, slummer44, 50)
    fallout.giq_option(4, 391, 246, slummer45, 50)
end

function slummer34()
    fallout.gsay_reply(391, 247)
    fallout.giq_option(7, 391, 248, slummer43, 50)
    fallout.giq_option(4, 391, 249, slummer60, 50)
    fallout.giq_option(4, 391, 250, slummer43, 50)
    fallout.giq_option(4, 391, 251, slummercombat, 50)
end

function slummer35()
    fallout.gsay_message(391, 252, 50)
end

function slummer36()
    fallout.gsay_reply(391, 253)
    fallout.giq_option(4, 391, 254, slummer18, 50)
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        fallout.giq_option(7, 391, 255, slummer36a, 50)
        fallout.giq_option(4, 391, 256, slummer52, 50)
    else
        fallout.giq_option(7, 391, 257, slummer36b, 50)
        fallout.giq_option(4, 391, 258, slummer20, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 259, slummer24, 50)
    end
end

function slummer36a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer29()
    else
        slummer49()
    end
end

function slummer36b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer26()
    else
        slummer49()
    end
end

function slummer37()
    fallout.gsay_message(391, 260, 50)
end

function slummer38a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer52()
    else
        slummer52()
    end
end

function slummer38()
    fallout.gsay_reply(391, 261)
    fallout.giq_option(7, 391, 262, slummer38a, 50)
    fallout.giq_option(4, 391, 263, slummer01, 50)
    fallout.giq_option(4, 391, 264, slummer44, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 265, slummercombat, 50)
    end
end

function slummer39()
    fallout.gsay_message(391, 266, 50)
end

function slummer40()
    fallout.gsay_message(391, 267, 50)
end

function slummer41()
    fallout.set_global_var(196, 1)
    fallout.gsay_message(391, 268, 50)
end

function slummer42()
    fallout.gsay_reply(391, 269)
    fallout.giq_option(4, 391, 270, slummer44, 50)
    fallout.giq_option(4, 391, 271, slummer50, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 272, slummer49, 50)
    end
    fallout.giq_option(-3, 391, 273, slummer48, 50)
end

function slummer43()
    fallout.gsay_message(391, 274, 51)
    slummercombat()
end

function slummer44()
    fallout.gsay_message(391, 275, 50)
end

function slummer45()
    fallout.gsay_message(391, 276, 50)
end

function slummer46()
    fallout.gsay_reply(391, 277)
    fallout.giq_option(7, 391, 278, slummer61, 50)
    fallout.giq_option(4, 391, 279, slummer41, 50)
    fallout.giq_option(4, 391, 280, slummer44, 50)
    fallout.giq_option(4, 391, 281, slummer44, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 282, slummer44, 50)
    end
end

function slummer47()
    fallout.gsay_message(391, 283, 50)
end

function slummer48()
    fallout.gsay_message(391, 284, 50)
end

function slummer49()
    fallout.gsay_message(391, 285, 50)
end

function slummer50()
    fallout.gsay_message(391, 286, 50)
end

function slummer51()
    fallout.gsay_reply(391, 287)
    fallout.giq_option(7, 391, 288, slummer51a, 50)
    fallout.giq_option(7, 391, 289, slummer63, 50)
    fallout.giq_option(4, 391, 290, slummer64, 50)
    fallout.giq_option(4, 391, 291, slummer54, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 292, slummer24, 50)
    end
end

function slummer51a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer62()
    else
        slummer49()
    end
end

function slummer52()
    fallout.gsay_reply(391, 293)
    fallout.giq_option(7, 391, 294, slummer52a, 50)
    fallout.giq_option(7, 391, 295, slummer53, 50)
    fallout.giq_option(4, 391, 296, slummer41, 50)
    fallout.giq_option(4, 391, 297, slummer44, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 298, slummercombat, 50)
    end
end

function slummer52a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer65()
    else
        slummer49()
    end
end

function slummer53()
    fallout.set_global_var(196, 1)
    fallout.gsay_message(391, 299, 50)
end

function slummer54()
    fallout.gsay_reply(391, 300)
    fallout.giq_option(7, 391, 301, slummer54a, 50)
    fallout.giq_option(4, 391, 302, slummer44, 50)
    fallout.giq_option(4, 391, 303, slummer44, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 304, slummer16, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 305, slummercombat, 50)
    end
end

function slummer54a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer51()
    else
        slummer49()
    end
end

function slummer55()
    fallout.gsay_reply(391, 306)
    fallout.giq_option(7, 391, 307, slummer66, 50)
    fallout.giq_option(7, 391, 308, slummer66, 50)
    fallout.giq_option(4, 391, 309, slummer44, 50)
    fallout.giq_option(4, 391, 310, slummer41, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 311, slummer16, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 312, slummercombat, 50)
    end
end

function slummer56()
    fallout.gsay_reply(391, 313)
    fallout.giq_option(7, 391, 314, slummer33, 50)
    fallout.giq_option(7, 391, 315, slummer54, 50)
    fallout.giq_option(4, 391, 316, slummer41, 50)
    fallout.giq_option(4, 391, 317, slummer44, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 318, slummer16, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 319, slummer45, 50)
    end
end

function slummer57()
    fallout.gsay_message(391, 320, 50)
end

function slummer58()
    fallout.gsay_message(391, 321, 50)
end

function slummer59()
    fallout.gsay_message(391, 322, 50)
end

function slummer60()
    fallout.gsay_reply(391, 323)
    fallout.giq_option(4, 391, 324, slummerdone, 50)
    fallout.giq_option(4, 391, 325, slummer40, 50)
    fallout.giq_option(4, 391, 326, slummercombat, 50)
end

function slummer61()
    fallout.gsay_message(391, 327, 50)
end

function slummer62()
    fallout.gsay_reply(391, 328)
    fallout.giq_option(7, 391, 329, slummer58, 50)
    fallout.giq_option(7, 391, 330, slummer59, 50)
    fallout.giq_option(4, 391, 331, slummer01, 50)
    fallout.giq_option(4, 391, 332, slummer44, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 333, slummercombat, 50)
    end
end

function slummer63()
    fallout.gsay_reply(391, 334)
    fallout.giq_option(7, 391, 335, slummer67, 50)
    fallout.giq_option(4, 391, 336, slummer41, 50)
    fallout.giq_option(4, 391, 337, slummer44, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 338, slummer16, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 339, slummer35, 50)
    end
end

function slummer64()
    fallout.gsay_message(391, 340, 50)
end

function slummer65()
    fallout.gsay_reply(391, 341)
    fallout.giq_option(7, 391, 342, slummer65a, 50)
    fallout.giq_option(4, 391, 343, slummer41, 50)
    fallout.giq_option(4, 391, 344, slummer44, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 391, 345, slummer16, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 391, 346, slummer35, 50)
    end
end

function slummer65a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        slummer49()
    else
        slummer49()
    end
end

function slummer66()
    fallout.gsay_message(391, 347, 50)
end

function slummer67()
    fallout.gsay_message(391, 348, 50)
end

function slummerdone()
    fallout.gsay_option(391, 349, slummerend, 50)
end

function slummerend()
end

function slummercombat()
    fallout.set_global_var(195, 1)
    hostile = 1
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        armed = 1
    else
        armed = 0
    end
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

local exports = {}
exports.start = start
return exports
