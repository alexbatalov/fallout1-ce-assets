local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local do_dialogue
local zark00
local zark00a
local zark00b
local zark00c
local zark01
local zark01a
local zark02
local zark02a
local zark03
local zark03a
local zark04
local zark04a
local zark04b
local zark05
local zark05a
local zark06
local zark06a
local zark06b
local zark07
local zark07a
local zark08
local zark08a
local zark09
local zark10
local zark11
local zark12
local zark13
local zark14
local zark14a
local zark15
local zark15a
local zark15c
local zark16
local zark17
local zark18
local zark19
local zark19a
local zark20
local zark21
local zark22
local zark23
local zark24
local zark25
local zark26
local zark27
local zark28
local zark28a
local zark28b
local zark29
local zark30
local zark31
local zark31a
local zark31b
local zark32
local zark33
local zark34
local zark35
local zark36
local zark37
local zark38
local zark38a
local zark38b
local zark38c
local zark39
local zark39a
local zark39b
local zark40
local zark40a
local zark41
local zark41a
local zark41b
local zark41c
local zark42
local zark43
local zark44
local zark44a
local zark44b
local zark45
local zark46
local zark47
local zark47a
local zark48
local zark49
local zarkdone
local zarkend
local zarkcombat
local weapon_check

local hostile = 0
local armed = 0
local GENDER = 0
local LASHERKNOWN = 0
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        initialized = true
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(392, 100))
        else
            if fallout.script_action() == 4 then
                hostile = 1
            else
                if fallout.script_action() == 18 then
                    reputation.inc_evil_critter()
                else
                    if fallout.script_action() == 12 then
                        if hostile then
                            hostile = 0
                            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    weapon_check()
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.local_var(4) == 0 then
            if armed == 1 then
                zark14()
            else
                zark01()
            end
        else
            fallout.set_local_var(4, 1)
            zark13()
        end
    else
        fallout.set_local_var(4, 1)
        if fallout.global_var(195) == 1 then
            zark00()
        else
            if armed == 1 then
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) or (fallout.global_var(155) > 50) then
                    zark02()
                else
                    if (fallout.global_var(158) > 2) or (((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1))) or (fallout.global_var(155) < -50) then
                        zark45()
                    else
                        zark03()
                    end
                end
            else
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) or (fallout.global_var(155) > 50) then
                    zark02()
                else
                    if (fallout.global_var(158) > 2) or (((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1))) or (fallout.global_var(155) < -50) then
                        zark45()
                    else
                        zark04()
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function zark00()
    if GENDER == 0 then
        fallout.gsay_reply(392, 101)
    else
        fallout.gsay_reply(392, 102)
    end
    fallout.giq_option(4, 392, 103, zark00a, 50)
    fallout.giq_option(4, 392, 104, zark00b, 50)
    fallout.giq_option(4, 392, 105, zark11, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 106, zark00c, 50)
    end
    fallout.giq_option(-3, 392, 107, zark11, 50)
end

function zark00a()
    if fallout.get_critter_stat(fallout.dude_obj(), 0) > 7 then
        zark10()
    else
        zark11()
    end
end

function zark00b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark10()
    else
        zark11()
    end
end

function zark00c()
    if fallout.get_critter_stat(fallout.dude_obj(), 0) > 7 then
        zark12()
    else
        zark11()
    end
end

function zark01()
    fallout.gsay_reply(392, 108)
    fallout.giq_option(7, 392, 109, zark01a, 50)
    fallout.giq_option(7, 392, 110, zark39, 50)
    fallout.giq_option(4, 392, 111, zark46, 50)
    fallout.giq_option(4, 392, 112, zark08, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 113, zark12, 50)
    end
    fallout.giq_option(3, 392, 114, zark18, 50)
end

function zark01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark38()
    else
        zark26()
    end
end

function zark02()
    fallout.gsay_reply(392, 115)
    fallout.giq_option(7, 392, 116, zark02a, 50)
    fallout.giq_option(4, 392, 117, zark25, 50)
    fallout.giq_option(4, 392, 118, zark31, 50)
    fallout.giq_option(4, 392, 119, zark46, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 392, 120, zark30, 50)
    end
    fallout.giq_option(3, 392, 121, zark35, 50)
end

function zark02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark19()
    else
        zark26()
    end
end

function zark03()
    fallout.gsay_reply(392, 122)
    fallout.giq_option(7, 392, 123, zark03a, 50)
    fallout.giq_option(4, 392, 124, zark18, 50)
    fallout.giq_option(4, 392, 125, zark26, 50)
    fallout.giq_option(4, 392, 126, zark17, 50)
    fallout.giq_option(-3, 392, 127, zark18, 50)
end

function zark03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark06()
    else
        zark11()
    end
end

function zark04()
    fallout.gsay_reply(392, 128)
    fallout.giq_option(7, 392, 129, zark04a, 50)
    fallout.giq_option(4, 392, 130, zark26, 50)
    fallout.giq_option(4, 392, 131, zark04b, 50)
    fallout.giq_option(-3, 392, 132, zark18, 50)
end

function zark04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark05()
    else
        zark11()
    end
end

function zark04b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark31()
    else
        zark26()
    end
end

function zark05()
    fallout.set_global_var(196, 1)
    LASHERKNOWN = 1
    fallout.gsay_reply(392, 133)
    fallout.giq_option(7, 392, 134, zark05a, 50)
    fallout.giq_option(4, 392, 135, zark31, 50)
    fallout.giq_option(4, 392, 136, zark07, 50)
end

function zark05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark23()
    else
        zark26()
    end
end

function zark06()
    fallout.gsay_reply(392, 137)
    fallout.giq_option(7, 392, 138, zark06a, 50)
    fallout.giq_option(4, 392, 139, zark06b, 50)
    fallout.giq_option(4, 392, 140, zark20, 50)
    fallout.giq_option(4, 392, 141, zark46, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 142, zark11, 50)
    end
end

function zark06a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark19()
    else
        zark26()
    end
end

function zark06b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark19()
    else
        zark11()
    end
end

function zark07()
    LASHERKNOWN = 1
    fallout.gsay_reply(392, 143)
    if fallout.global_var(196) == 1 then
        fallout.giq_option(7, 392, 144, zark07a, 50)
    end
    fallout.giq_option(4, 392, 145, zark33, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 146, zark36, 50)
    end
end

function zark07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark26()
    else
        zark26()
    end
end

function zark08()
    fallout.set_global_var(196, 1)
    fallout.gsay_reply(392, 147)
    fallout.giq_option(7, 392, 148, zark08a, 50)
    fallout.giq_option(4, 392, 149, zark49, 50)
    fallout.giq_option(4, 392, 150, zark31, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 151, zark18, 50)
    end
end

function zark08a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark09()
    else
        zark18()
    end
end

function zark09()
    fallout.gsay_reply(392, 152)
    fallout.giq_option(7, 392, 153, zark31, 50)
    fallout.giq_option(4, 392, 154, zark47, 50)
    fallout.giq_option(4, 392, 155, zark29, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 156, zark12, 50)
    end
end

function zark10()
    fallout.gsay_message(392, 157, 50)
end

function zark11()
    fallout.gsay_message(392, 158, 50)
    zarkcombat()
end

function zark12()
    if GENDER == 0 then
        fallout.gsay_reply(392, 159)
    else
        fallout.gsay_reply(392, 160)
    end
    fallout.giq_option(4, 392, 161, zark21, 50)
    fallout.giq_option(4, 392, 162, zark11, 50)
end

function zark13()
    fallout.gsay_message(392, 163, 50)
end

function zark14()
    fallout.gsay_reply(392, 164)
    fallout.giq_option(7, 392, 165, zark14a, 50)
    fallout.giq_option(4, 392, 166, zark18, 50)
    fallout.giq_option(4, 392, 167, zark16, 50)
    fallout.giq_option(4, 392, 168, zark17, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 169, zark16, 50)
    end
    fallout.giq_option(-3, 392, 170, zark18, 50)
end

function zark14a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark15()
    else
        zark16()
    end
end

function zark15()
    fallout.gsay_reply(392, 171)
    fallout.giq_option(7, 392, 172, zark15a, 50)
    fallout.giq_option(4, 392, 173, zark15a, 50)
    fallout.giq_option(4, 392, 174, zark20, 50)
    fallout.giq_option(4, 392, 175, zark46, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 176, zark15c, 50)
    end
end

function zark15a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark19()
    else
        zark16()
    end
end

function zark15c()
    if fallout.get_critter_stat(fallout.dude_obj(), 0) < 7 then
        zark21()
    else
        zark22()
    end
end

function zark16()
    fallout.gsay_message(392, 177, 50)
end

function zark17()
    fallout.gsay_message(392, 178, 51)
    zarkcombat()
end

function zark18()
    fallout.gsay_message(392, 179, 50)
end

function zark19()
    fallout.gsay_reply(392, 180)
    fallout.giq_option(4, 392, 181, zark19a, 50)
    fallout.giq_option(4, 392, 182, zark24, 50)
    fallout.giq_option(4, 392, 183, zark25, 50)
    fallout.giq_option(4, 392, 184, zark24, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 185, zark18, 50)
    end
end

function zark19a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark23()
    else
        zark26()
    end
end

function zark20()
    fallout.set_global_var(196, 1)
    fallout.gsay_reply(392, 186)
    fallout.giq_option(7, 392, 187, zark26, 50)
    fallout.giq_option(4, 392, 188, zark27, 50)
    fallout.giq_option(4, 392, 189, zark28, 50)
    fallout.giq_option(4, 392, 190, zark29, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 392, 191, zark30, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 192, zark21, 50)
    end
end

function zark21()
    fallout.gsay_reply(392, 193)
end

function zark22()
    fallout.gsay_reply(392, 194)
    fallout.giq_option(4, 392, 195, zark19, 50)
    fallout.giq_option(4, 392, 196, zark20, 50)
    fallout.giq_option(4, 392, 197, zark31, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 198, zark21, 50)
    end
end

function zark23()
    fallout.gsay_message(392, 199, 50)
end

function zark24()
    fallout.gsay_message(392, 200, 50)
end

function zark25()
    fallout.gsay_message(392, 201, 50)
end

function zark26()
    fallout.gsay_message(392, 202, 50)
end

function zark27()
    fallout.gsay_reply(392, 203)
    fallout.giq_option(7, 392, 204, zark32, 50)
    fallout.giq_option(4, 392, 205, zark33, 50)
    fallout.giq_option(4, 392, 206, zark34, 50)
    fallout.giq_option(4, 392, 207, zark35, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 208, zark21, 50)
    end
end

function zark28()
    LASHERKNOWN = 1
    fallout.gsay_reply(392, 209)
    if fallout.global_var(196) == 1 then
        fallout.giq_option(7, 392, 210, zark28a, 50)
    else
        fallout.giq_option(7, 392, 211, zark28a, 50)
    end
    fallout.giq_option(4, 392, 212, zark33, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 213, zark36, 50)
    end
end

function zark28a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark26()
    else
        zark26()
    end
end

function zark28b()
end

function zark29()
    fallout.gsay_message(392, 214, 50)
end

function zark30()
    fallout.gsay_reply(392, 215)
    fallout.giq_option(4, 392, 216, zark37, 50)
    fallout.giq_option(4, 392, 217, zark37, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 218, zark21, 50)
    end
end

function zark31()
    fallout.set_global_var(196, 1)
    fallout.gsay_reply(392, 219)
    fallout.giq_option(7, 392, 220, zark31a, 50)
    fallout.giq_option(4, 392, 221, zark31b, 50)
    fallout.giq_option(4, 392, 222, zark28, 50)
    fallout.giq_option(4, 392, 223, zark29, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 392, 224, zark30, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 225, zark21, 50)
    end
end

function zark31a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark23()
    else
        zark26()
    end
end

function zark31b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark27()
    else
        zark26()
    end
end

function zark32()
    fallout.gsay_message(392, 226, 50)
end

function zark33()
    fallout.gsay_message(392, 227, 50)
end

function zark34()
    fallout.set_global_var(196, 1)
    fallout.gsay_message(392, 228, 50)
end

function zark35()
    fallout.gsay_message(392, 229, 50)
end

function zark36()
    fallout.gsay_message(392, 230, 50)
end

function zark37()
    LASHERKNOWN = 1
    fallout.gsay_message(392, 231, 50)
end

function zark38()
    fallout.gsay_reply(392, 232)
    fallout.giq_option(7, 392, 233, zark38a, 50)
    fallout.giq_option(4, 392, 234, zark38b, 50)
    fallout.giq_option(4, 392, 235, zark20, 50)
    fallout.giq_option(4, 392, 236, zark11, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 392, 237, zark30, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 238, zark38c, 50)
    end
end

function zark38a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark19()
    else
        zark16()
    end
end

function zark38b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark19()
    else
        zark26()
    end
end

function zark38c()
    if fallout.get_critter_stat(fallout.dude_obj(), 0) < 7 then
        zark21()
    else
        zark22()
    end
end

function zark39()
    fallout.gsay_reply(392, 239)
    fallout.giq_option(7, 392, 240, zark39a, 50)
    fallout.giq_option(7, 392, 241, zark39b, 50)
    fallout.giq_option(4, 392, 242, zark40, 50)
    fallout.giq_option(4, 392, 243, zark29, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 244, zark18, 50)
    end
end

function zark39a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark38()
    else
        zark26()
    end
end

function zark39b()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        zark16()
    else
        zark25()
    end
end

function zark40()
    fallout.gsay_reply(392, 245)
    fallout.giq_option(7, 392, 246, zark40a, 50)
    fallout.giq_option(7, 392, 247, zark41, 50)
    fallout.giq_option(4, 392, 248, zark42, 50)
    fallout.giq_option(4, 392, 249, zark43, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 250, zark42, 50)
    end
end

function zark40a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark19()
    else
        zark26()
    end
end

function zark41()
    fallout.gsay_reply(392, 251)
    fallout.giq_option(7, 392, 252, zark25, 50)
    if GENDER ~= 0 then
        fallout.giq_option(7, 392, 253, zark41a, 50)
    else
        fallout.giq_option(7, 392, 254, zark41a, 50)
    end
    fallout.giq_option(4, 392, 255, zark41b, 50)
    fallout.giq_option(4, 392, 256, zark47, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 392, 257, zarkcombat, 50)
    end
end

function zark41a()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        zark42()
    else
        zark45()
    end
end

function zark41b()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        zark42()
    else
        zark45()
    end
end

function zark41c()
    zarkcombat()
end

function zark42()
    fallout.gsay_message(392, 258, 50)
end

function zark43()
    fallout.gsay_message(392, 259, 50)
end

function zark44()
    fallout.gsay_reply(392, 260)
    fallout.giq_option(7, 392, 261, zark44a, 50)
    fallout.giq_option(4, 392, 262, zark44b, 50)
    fallout.giq_option(4, 392, 263, zark31, 50)
    fallout.giq_option(4, 392, 264, zark46, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 392, 265, zark30, 50)
    end
end

function zark44a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark19()
    else
        zark16()
    end
end

function zark44b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark19()
    else
        zark26()
    end
end

function zark45()
    if GENDER == 0 then
        fallout.gsay_message(392, 266, 50)
    else
        fallout.gsay_message(392, 267, 50)
    end
end

function zark46()
    fallout.gsay_message(392, 268, 50)
end

function zark47()
    fallout.gsay_reply(392, 269)
    fallout.giq_option(7, 392, 270, zark47a, 50)
    fallout.giq_option(4, 392, 271, zark48, 50)
    fallout.giq_option(4, 392, 272, zarkend, 50)
    fallout.giq_option(4, 392, 273, zarkcombat, 50)
end

function zark47a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        zark26()
    else
        zark26()
    end
end

function zark48()
    fallout.gsay_message(392, 274, 50)
    zarkcombat()
end

function zark49()
    fallout.gsay_message(392, 275, 50)
end

function zarkdone()
    fallout.gsay_option(392, 276, zarkend, 50)
end

function zarkend()
end

function zarkcombat()
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

local exports = {}
exports.start = start
return exports
