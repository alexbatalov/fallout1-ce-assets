local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local viola00
local viola01
local viola02
local viola03
local viola04
local viola05
local viola05a
local viola06
local viola06a
local viola07
local viola07a
local viola08
local viola08a
local viola09
local viola10
local viola11
local viola12
local viola13
local viola14
local viola15
local viola16
local viola17
local viola18
local viola19
local viola20
local viola21
local viola22
local viola23
local viola24
local viola25
local viola26
local viola27
local viola28
local viola29
local viola30
local viola31
local viola32
local viola33
local viola34
local viola35
local viola36
local viola37
local viola38
local viola39
local viola40
local viola41
local viola42
local viola43
local viola44
local viola45
local viola46
local viola47
local viola48
local viola49
local viola50
local viola51
local viola52
local viola53
local viola53a
local viola54
local viola55
local viola56
local viola57
local viola58
local viola59
local viola60
local viola61
local viola62
local viola63
local viola64
local viola65
local viola66
local viola67
local viola68
local viola69
local viola70
local viola71
local viola72
local viola73
local viola74
local viola75
local viola76
local violadone
local violaend
local violacombat
local weapon_check

local hostile = false
local armed = false
local initialized = false
local TALKEDTOLAURA = false
local LAURAWARNING = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 20)
        fallout.critter_add_trait(self_obj, 1, 5, 69)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    weapon_check()
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 1 and fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
        fallout.gsay_message(496, 143, 51)
    else
        if fallout.global_var(195) == 1 and fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) ~= 113 then
            viola00()
        else
            if TALKEDTOLAURA then
                if not LAURAWARNING then
                    viola01()
                else
                    viola02()
                end
            else
                if armed then
                    viola03()
                elseif fallout.local_var(4) == 1 and not LAURAWARNING then
                    viola04()
                elseif not armed then
                    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
                        viola05()
                    elseif reputation.has_rep_champion() then
                        viola06()
                    elseif fallout.global_var(158) > 2 and reputation.has_rep_berserker() then
                        viola07()
                    else
                        viola08()
                    end
                end
            end
        end
    end
    fallout.set_local_var(4, 1)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(496, 100))
end

function viola00()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(496, 101)
    else
        fallout.gsay_reply(496, 102)
    end
    fallout.giq_option(7, 496, 103, viola09, 50)
    fallout.giq_option(7, 496, 104, viola10, 50)
    fallout.giq_option(4, 496, 105, viola11, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 496, 106, viola12, 50)
    end
    fallout.giq_option(4, 496, 107, violacombat, 50)
    fallout.giq_option(-3, 496, 299, violaend, 50)
    fallout.giq_option(-3, 496, 108, violacombat, 50)
end

function viola01()
    LAURAWARNING = true
    fallout.gsay_reply(496, 109)
    fallout.giq_option(7, 496, 110, viola13, 50)
    fallout.giq_option(4, 496, 111, viola14, 50)
    fallout.giq_option(4, 496, 112, viola15, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 113, violacombat, 50)
    end
    fallout.giq_option(-3, 496, 114, violaend, 50)
end

function viola02()
    fallout.gsay_message(496, 115, 50)
end

function viola03()
    fallout.gsay_message(496, 116, 50)
end

function viola04()
    fallout.gsay_reply(496, 117)
    fallout.giq_option(7, 496, 118, viola15, 50)
    fallout.giq_option(4, 496, 119, viola16, 50)
    fallout.giq_option(4, 496, 120, viola17, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 496, 121, viola18, 50)
    end
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 122, viola19, 50)
    end
    fallout.giq_option(-3, 496, 299, violaend, 50)
end

function viola05()
    fallout.gsay_reply(496, 123)
    fallout.giq_option(7, 496, 124, viola05a, 50)
    fallout.giq_option(4, 496, 125, viola46, 50)
    fallout.giq_option(4, 496, 126, viola47, 50)
    fallout.giq_option(4, 496, 127, viola48, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 128, viola49, 50)
    end
end

function viola05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        viola44()
    else
        viola45()
    end
end

function viola06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(496, 129)
    else
        fallout.gsay_reply(496, 130)
    end
    fallout.giq_option(7, 496, 131, viola06a, 50)
    fallout.giq_option(4, 496, 132, viola52, 50)
    fallout.giq_option(4, 496, 133, viola47, 50)
    fallout.giq_option(4, 496, 134, viola48, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 135, viola49, 50)
    end
end

function viola06a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        viola50()
    else
        viola51()
    end
end

function viola07()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(496, 136)
    else
        fallout.gsay_reply(496, 137)
    end
    fallout.giq_option(7, 496, 138, viola07a, 50)
    fallout.giq_option(4, 496, 139, viola52, 50)
    fallout.giq_option(4, 496, 140, viola47, 50)
    fallout.giq_option(4, 496, 141, viola48, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 142, viola49, 50)
    end
end

function viola07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        viola50()
    else
        viola51()
    end
end

function viola08()
    fallout.gsay_reply(496, 143)
    fallout.giq_option(7, 496, 144, viola08a, 50)
    fallout.giq_option(4, 496, 145, viola55, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 146, viola40, 50)
    end
    fallout.giq_option(-3, 496, 299, violaend, 50)
end

function viola08a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        viola53()
    else
        viola54()
    end
end

function viola09()
    fallout.gsay_message(496, 147, 50)
end

function viola10()
    fallout.gsay_message(496, 148, 50)
end

function viola11()
    fallout.gsay_message(496, 149, 50)
end

function viola12()
    fallout.gsay_message(496, 150, 50)
end

function viola13()
    fallout.gsay_reply(496, 151)
    fallout.giq_option(7, 496, 152, viola20, 50)
    fallout.giq_option(4, 496, 153, viola21, 50)
    fallout.giq_option(4, 496, 154, viola22, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 155, viola23, 50)
    end
end

function viola14()
    fallout.gsay_reply(496, 156)
    fallout.giq_option(7, 496, 157, viola16, 50)
    fallout.giq_option(4, 496, 158, viola21, 50)
    fallout.giq_option(4, 496, 159, viola22, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 160, viola23, 50)
    end
end

function viola15()
    fallout.gsay_message(496, 161, 50)
end

function viola16()
    fallout.gsay_message(496, 162, 50)
end

function viola17()
    fallout.gsay_message(496, 163, 50)
end

function viola18()
    fallout.gsay_message(496, 164, 50)
end

function viola19()
    fallout.gsay_message(496, 165, 50)
end

function viola20()
    fallout.gsay_reply(496, 166)
    fallout.giq_option(7, 496, 167, viola24, 50)
    fallout.giq_option(4, 496, 168, viola24, 50)
    fallout.giq_option(4, 496, 169, viola25, 50)
    fallout.giq_option(4, 496, 170, viola26, 50)
    fallout.giq_option(4, 496, 171, viola27, 50)
end

function viola21()
    fallout.gsay_message(496, 172, 50)
end

function viola22()
    fallout.gsay_reply(496, 173)
    fallout.giq_option(7, 496, 174, viola41, 50)
    fallout.giq_option(4, 496, 175, viola21, 50)
    fallout.giq_option(4, 496, 176, viola42, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 177, viola43, 50)
    end
end

function viola23()
    fallout.gsay_message(496, 178, 50)
end

function viola24()
    fallout.gsay_reply(496, 179)
    fallout.giq_option(7, 496, 180, viola28, 50)
    fallout.giq_option(7, 496, 181, viola29, 50)
    fallout.giq_option(4, 496, 182, viola30, 50)
    fallout.giq_option(4, 496, 183, viola31, 50)
end

function viola25()
    fallout.gsay_reply(496, 184)
    fallout.giq_option(7, 496, 185, viola31, 50)
    fallout.giq_option(4, 496, 186, viola32, 50)
    fallout.giq_option(4, 496, 187, viola33, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 188, viola34, 50)
    end
end

function viola26()
    fallout.gsay_reply(496, 189)
    fallout.giq_option(7, 496, 190, viola35, 50)
    fallout.giq_option(4, 496, 191, viola32, 50)
    fallout.giq_option(4, 496, 192, viola36, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 193, viola37, 50)
    end
end

function viola27()
    fallout.gsay_reply(496, 194)
    fallout.giq_option(7, 496, 195, viola29, 50)
    fallout.giq_option(4, 496, 196, viola38, 50)
    fallout.giq_option(4, 496, 197, viola39, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 198, viola40, 50)
    end
end

function viola28()
    fallout.gsay_message(496, 199, 50)
end

function viola29()
    fallout.gsay_message(496, 200, 50)
end

function viola30()
    fallout.gsay_message(496, 201, 50)
end

function viola31()
    fallout.gsay_message(496, 202, 50)
end

function viola32()
    fallout.gsay_message(496, 203, 50)
end

function viola33()
    fallout.gsay_message(496, 204, 50)
end

function viola34()
    fallout.gsay_message(496, 205, 50)
end

function viola35()
    fallout.gsay_message(496, 206, 50)
end

function viola36()
    fallout.gsay_message(496, 207, 50)
end

function viola37()
    fallout.gsay_message(496, 208, 50)
end

function viola38()
    fallout.gsay_message(496, 209, 50)
end

function viola39()
    fallout.gsay_message(496, 210, 50)
end

function viola40()
    fallout.gsay_message(496, 211, 50)
end

function viola41()
    fallout.gsay_reply(496, 212)
    fallout.giq_option(7, 496, 213, viola28, 50)
    fallout.giq_option(7, 496, 214, viola29, 50)
    fallout.giq_option(4, 496, 215, viola32, 50)
    fallout.giq_option(4, 496, 216, viola30, 50)
    fallout.giq_option(4, 496, 217, viola31, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 218, viola43, 50)
    end
end

function viola42()
    fallout.gsay_reply(496, 219)
    fallout.giq_option(7, 496, 220, viola28, 50)
    fallout.giq_option(7, 496, 221, viola29, 50)
    fallout.giq_option(4, 496, 222, viola32, 50)
    fallout.giq_option(4, 496, 223, viola30, 50)
    fallout.giq_option(4, 496, 224, viola31, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 225, viola43, 50)
    end
end

function viola43()
    fallout.gsay_message(496, 226, 50)
end

function viola44()
    fallout.gsay_reply(496, 227)
    fallout.giq_option(7, 496, 228, viola56, 50)
    fallout.giq_option(4, 496, 229, viola16, 50)
    fallout.giq_option(4, 496, 230, viola57, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 231, viola49, 50)
    end
end

function viola45()
    fallout.gsay_message(496, 232, 50)
end

function viola46()
    fallout.gsay_message(496, 233, 50)
end

function viola47()
    fallout.gsay_reply(496, 234)
    fallout.giq_option(7, 496, 235, viola58, 50)
    fallout.giq_option(7, 496, 236, viola59, 50)
    fallout.giq_option(4, 496, 237, viola60, 50)
    fallout.giq_option(4, 496, 238, viola61, 50)
    fallout.giq_option(4, 496, 239, viola62, 50)
end

function viola48()
    fallout.gsay_reply(496, 240)
    fallout.giq_option(7, 496, 241, viola63, 50)
    fallout.giq_option(7, 496, 242, viola64, 50)
    fallout.giq_option(4, 496, 243, viola65, 50)
    fallout.giq_option(4, 496, 244, viola66, 50)
    fallout.giq_option(4, 496, 245, viola67, 50)
end

function viola49()
    fallout.gsay_message(496, 246, 50)
end

function viola50()
    fallout.gsay_reply(496, 247)
    fallout.giq_option(7, 496, 248, viola68, 50)
    fallout.giq_option(7, 496, 249, viola69, 50)
    fallout.giq_option(7, 496, 250, viola70, 50)
    fallout.giq_option(7, 496, 251, viola49, 50)
    fallout.giq_option(7, 496, 252, viola16, 50)
end

function viola51()
    fallout.gsay_message(496, 253, 50)
end

function viola52()
    fallout.gsay_reply(496, 254)
    fallout.giq_option(7, 496, 255, viola71, 50)
    fallout.giq_option(7, 496, 256, viola72, 50)
    fallout.giq_option(4, 496, 257, viola73, 50)
    fallout.giq_option(4, 496, 258, viola74, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 496, 259, viola75, 50)
    end
end

function viola53()
    fallout.gsay_reply(496, 260)
    fallout.giq_option(7, 496, 261, viola53a, 50)
    fallout.giq_option(4, 496, 262, viola52, 50)
    fallout.giq_option(4, 496, 263, viola47, 50)
    fallout.giq_option(4, 496, 264, viola48, 50)
    fallout.giq_option(4, 496, 265, viola49, 50)
end

function viola53a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        viola50()
    else
        viola51()
    end
end

function viola54()
    fallout.gsay_message(496, 266, 50)
end

function viola55()
    fallout.gsay_message(496, 267, 50)
end

function viola56()
    fallout.gsay_message(496, 268, 50)
end

function viola57()
    fallout.gsay_message(496, 269, 50)
end

function viola58()
    fallout.gsay_message(496, 270, 50)
end

function viola59()
    fallout.gsay_message(496, 271, 50)
end

function viola60()
    fallout.gsay_message(496, 272, 50)
end

function viola61()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(496, 273, 50)
    else
        fallout.gsay_message(496, 274, 50)
    end
end

function viola62()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(496, 275, 50)
    else
        fallout.gsay_message(496, 276, 50)
    end
end

function viola63()
    fallout.gsay_message(496, 277, 50)
end

function viola64()
    fallout.gsay_reply(496, 278)
    fallout.giq_option(7, 496, 279, viola63, 50)
    fallout.giq_option(7, 496, 280, viola76, 50)
    fallout.giq_option(4, 496, 281, viola65, 50)
    fallout.giq_option(4, 496, 282, viola66, 50)
    fallout.giq_option(4, 496, 283, viola67, 50)
end

function viola65()
    fallout.gsay_message(496, 284, 50)
end

function viola66()
    fallout.gsay_message(496, 285, 50)
end

function viola67()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(496, 286, 50)
    else
        fallout.gsay_message(496, 287, 50)
    end
end

function viola68()
    fallout.gsay_message(496, 288, 50)
end

function viola69()
    fallout.gsay_message(496, 289, 50)
end

function viola70()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(496, 302, 50)
    else
        fallout.gsay_message(496, 303, 50)
    end
end

function viola71()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(496, 304, 50)
    else
        fallout.gsay_message(496, 305, 50)
    end
end

function viola72()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(496, 306, 50)
    else
        fallout.gsay_message(496, 307, 50)
    end
end

function viola73()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(496, 300, 50)
    else
        fallout.gsay_message(496, 301, 50)
    end
end

function viola74()
    fallout.gsay_message(496, 294, 50)
end

function viola75()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(496, 295, 50)
    else
        fallout.gsay_message(496, 296, 50)
    end
end

function viola76()
    fallout.gsay_message(496, 297, 50)
end

function violadone()
    fallout.gsay_option(496, 298, violaend, 50)
end

function violaend()
end

function violacombat()
    fallout.set_global_var(195, 1)
    hostile = true
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        armed = true
    else
        armed = false
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
