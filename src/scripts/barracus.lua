local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local do_dialogue
local social_skills
local weapon_check
local Barracus00
local Barracus01
local Barracus02
local Barracus03
local Barracus04
local Barracus05
local Barracus05a
local Barracus06
local Barracus07
local Barracus08
local Barracus09
local Barracus10
local Barracus11
local Barracus12
local Barracus13
local Barracus14
local Barracus14a
local Barracus15
local Barracus16
local Barracus17
local Barracus18
local Barracus19
local Barracus20
local Barracus21
local Barracus22
local Barracus23
local Barracus24
local Barracus25
local Barracus26
local Barracus26a
local Barracus27
local Barracus28
local Barracus29
local Barracus30
local Barracus31
local Barracus32
local Barracus33
local Barracus34
local Barracus35
local Barracus35a
local Barracus36
local Barracus37
local Barracus38
local Barracus38a
local Barracus39
local Barracus40
local Barracus41
local Barracus42
local Barracus43
local Barracus44
local Barracus45
local Barracus46
local Barracus47
local Barracus48
local Barracus49
local Barracus50
local Barracus51
local Barracus52
local Barracus53
local Barracus54
local Barracus55
local BarracusCombat
local BarracusEnd

local hostile = 0
local armed = 0
local Only_Once = 1

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
            if fallout.local_var(4) == 1 then
                fallout.display_msg(fallout.message_str(397, 100))
            else
                fallout.display_msg(fallout.message_str(397, 101))
            end
        else
            if fallout.script_action() == 18 then
                reputation.inc_evil_critter()
            else
                if fallout.script_action() == 4 then
                    hostile = 1
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
    reaction.get_reaction()
    fallout.start_gdialog(397, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if armed then
        Barracus04()
    else
        if fallout.local_var(4) == 1 then
            Barracus03()
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                Barracus06()
            else
                if fallout.get_critter_stat(fallout.dude_obj(), 3) > 6 then
                    Barracus07()
                else
                    Barracus06()
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    fallout.set_local_var(4, 1)
end

function social_skills()
    reaction.get_reaction()
    fallout.dialogue_system_enter()
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        armed = 1
    else
        armed = 0
    end
end

function Barracus00()
    local v0 = 0
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(397, fallout.message_str(397, 106))
    else
        fallout.gsay_reply(397, fallout.message_str(397, 107))
    end
    fallout.giq_option(0, 397, 104, BarracusCombat, 50)
end

function Barracus01()
    fallout.gsay_reply(397, 108)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus02()
    fallout.gsay_reply(397, 109)
    fallout.giq_option(7, 397, 110, Barracus08, 50)
    fallout.giq_option(7, 397, 111, Barracus09, 50)
    fallout.giq_option(4, 397, 112, Barracus10, 50)
    fallout.giq_option(4, 397, 113, Barracus11, 50)
    fallout.giq_option(4, 397, 114, Barracus12, 50)
    fallout.giq_option(4, 397, 115, BarracusCombat, 50)
    fallout.giq_option(-3, 397, 116, Barracus13, 50)
end

function Barracus03()
    fallout.gsay_reply(397, 117)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus04()
    local v0 = 0
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(397, fallout.message_str(397, 120))
    else
        fallout.gsay_reply(397, fallout.message_str(397, 121))
    end
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus05()
    fallout.gsay_reply(397, 122)
    fallout.giq_option(7, 397, 123, Barracus05a, 50)
    fallout.giq_option(7, 397, 124, Barracus16, 50)
    fallout.giq_option(4, 397, 125, Barracus17, 50)
    fallout.giq_option(4, 397, 126, Barracus18, 50)
    fallout.giq_option(4, 397, 127, Barracus19, 50)
    fallout.giq_option(-3, 397, 116, Barracus20, 50)
end

function Barracus05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Barracus14()
    else
        Barracus15()
    end
end

function Barracus06()
    fallout.gsay_reply(397, 128)
    fallout.giq_option(7, 397, 123, Barracus05a, 50)
    fallout.giq_option(7, 397, 129, Barracus20, 50)
    fallout.giq_option(4, 397, 130, Barracus21, 50)
    fallout.giq_option(4, 397, 131, Barracus22, 50)
    fallout.giq_option(4, 397, 132, Barracus23, 50)
    fallout.giq_option(4, 397, 133, Barracus24, 50)
    fallout.giq_option(-3, 397, 116, Barracus13, 50)
end

function Barracus07()
    fallout.gsay_reply(397, 134)
    fallout.giq_option(7, 397, 123, Barracus05a, 50)
    fallout.giq_option(4, 397, 135, Barracus25, 50)
    fallout.giq_option(4, 397, 136, Barracus26, 50)
    fallout.giq_option(4, 397, 131, Barracus22, 50)
    fallout.giq_option(4, 397, 137, Barracus27, 50)
    fallout.giq_option(-3, 397, 116, Barracus13, 50)
end

function Barracus08()
    fallout.gsay_reply(397, 138)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus09()
    fallout.gsay_reply(397, 139)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus10()
    fallout.gsay_reply(397, 140)
    fallout.giq_option(4, 397, 141, Barracus28, 50)
    fallout.giq_option(4, 397, 142, Barracus29, 50)
    fallout.giq_option(4, 397, 143, Barracus30, 50)
    fallout.giq_option(4, 397, 144, BarracusCombat, 50)
end

function Barracus11()
    fallout.gsay_reply(397, 145)
    fallout.giq_option(7, 397, 146, Barracus10, 50)
    fallout.giq_option(4, 397, 147, Barracus31, 50)
    fallout.giq_option(4, 397, 148, Barracus30, 50)
    fallout.giq_option(4, 397, 149, BarracusCombat, 50)
end

function Barracus12()
    fallout.gsay_reply(397, 150)
    fallout.giq_option(7, 397, 146, Barracus10, 50)
    fallout.giq_option(4, 397, 151, Barracus31, 50)
    fallout.giq_option(4, 397, 148, Barracus30, 50)
    fallout.giq_option(4, 397, 149, BarracusCombat, 50)
    fallout.giq_option(4, 397, 152, BarracusCombat, 50)
end

function Barracus13()
    fallout.gsay_reply(397, 153)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus14()
    fallout.gsay_reply(397, 154)
    fallout.giq_option(7, 397, 155, Barracus14a, 50)
    fallout.giq_option(7, 397, 156, Barracus33, 50)
    fallout.giq_option(4, 397, 157, Barracus46, 50)
    fallout.giq_option(4, 397, 158, Barracus47, 50)
    fallout.giq_option(4, 397, 159, Barracus21, 50)
end

function Barracus14a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Barracus32()
    else
        Barracus15()
    end
end

function Barracus15()
    fallout.gsay_reply(397, 160)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus16()
    fallout.gsay_reply(397, 161)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus17()
    fallout.gsay_reply(397, 162)
    fallout.giq_option(7, 397, 163, Barracus05a, 50)
    fallout.giq_option(7, 397, 164, Barracus34, 50)
    fallout.giq_option(4, 397, 165, Barracus30, 50)
    fallout.giq_option(4, 397, 166, Barracus35, 50)
    fallout.giq_option(4, 397, 167, Barracus10, 50)
end

function Barracus18()
    fallout.gsay_reply(397, 168)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus19()
    fallout.gsay_reply(397, 169)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus20()
    fallout.gsay_reply(397, 170)
    fallout.giq_option(7, 397, 123, Barracus05a, 50)
    fallout.giq_option(4, 397, 171, Barracus36, 50)
    fallout.giq_option(4, 397, 131, Barracus22, 50)
    fallout.giq_option(4, 397, 172, Barracus37, 50)
end

function Barracus21()
    fallout.gsay_reply(397, 173)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus22()
    fallout.gsay_reply(397, 174)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus23()
    fallout.gsay_reply(397, 175)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus24()
    fallout.gsay_reply(397, 176)
    fallout.giq_option(7, 397, 123, Barracus05a, 50)
    fallout.giq_option(4, 397, 171, Barracus36, 50)
    fallout.giq_option(4, 397, 131, Barracus22, 50)
    fallout.giq_option(4, 397, 172, Barracus37, 50)
end

function Barracus25()
    fallout.gsay_reply(397, 177)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus26()
    fallout.gsay_reply(397, 178)
    fallout.giq_option(7, 397, 179, Barracus26a, 50)
    fallout.giq_option(4, 397, 180, Barracus25, 50)
    fallout.giq_option(4, 397, 181, Barracus26, 50)
    fallout.giq_option(4, 397, 182, Barracus39, 50)
    fallout.giq_option(4, 397, 183, BarracusCombat, 50)
end

function Barracus26a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Barracus38()
    else
        Barracus25()
    end
end

function Barracus27()
    fallout.gsay_reply(397, 184)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus28()
    fallout.gsay_reply(397, 185)
    fallout.giq_option(7, 397, 186, Barracus40, 50)
    fallout.giq_option(4, 397, 187, Barracus41, 50)
    fallout.giq_option(4, 397, 188, Barracus42, 50)
    fallout.giq_option(4, 397, 189, Barracus29, 50)
    fallout.giq_option(4, 397, 190, Barracus43, 50)
    fallout.giq_option(4, 397, 191, Barracus19, 50)
end

function Barracus29()
    fallout.gsay_reply(397, 192)
    fallout.giq_option(7, 397, 193, Barracus44, 50)
    fallout.giq_option(4, 397, 190, Barracus43, 50)
    fallout.giq_option(4, 397, 194, Barracus31, 50)
    fallout.giq_option(4, 397, 195, Barracus45, 50)
end

function Barracus30()
    fallout.gsay_reply(397, 196)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus31()
    fallout.gsay_reply(397, 197)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus32()
    fallout.gsay_reply(397, 198)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus33()
    fallout.gsay_reply(397, 199)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus34()
    fallout.gsay_reply(397, 200)
    fallout.giq_option(7, 397, 123, Barracus05a, 50)
    fallout.giq_option(4, 397, 171, Barracus36, 50)
    fallout.giq_option(4, 397, 131, Barracus22, 50)
    fallout.giq_option(4, 397, 172, Barracus37, 50)
end

function Barracus35()
    fallout.gsay_reply(397, 201)
    fallout.giq_option(7, 397, 202, Barracus35a, 50)
    fallout.giq_option(4, 397, 203, Barracus36, 50)
    fallout.giq_option(4, 397, 204, Barracus22, 50)
    fallout.giq_option(4, 397, 205, Barracus21, 50)
end

function Barracus35a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Barracus48()
    else
        Barracus15()
    end
end

function Barracus36()
    fallout.gsay_reply(397, 206)
    fallout.giq_option(7, 397, 207, Barracus49, 50)
    fallout.giq_option(7, 397, 208, Barracus15, 50)
    fallout.giq_option(7, 397, 209, Barracus50, 50)
    fallout.giq_option(4, 397, 210, Barracus51, 50)
    fallout.giq_option(4, 397, 211, Barracus52, 50)
    fallout.giq_option(4, 397, 212, Barracus53, 50)
end

function Barracus37()
    fallout.gsay_reply(397, 213)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus38()
    fallout.gsay_reply(397, 214)
    fallout.giq_option(7, 397, 215, Barracus38a, 50)
    fallout.giq_option(4, 397, 216, Barracus39, 50)
    fallout.giq_option(4, 397, 217, Barracus25, 50)
    fallout.giq_option(4, 397, 218, Barracus19, 50)
end

function Barracus38a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Barracus54()
    else
        Barracus55()
    end
end

function Barracus39()
    fallout.gsay_reply(397, 219)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus40()
    fallout.gsay_reply(397, 220)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus41()
    fallout.gsay_reply(397, 221)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus42()
    fallout.gsay_reply(397, 222)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus43()
    fallout.gsay_reply(397, 223)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus44()
    fallout.gsay_reply(397, 224)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus45()
    fallout.gsay_reply(397, 225)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus46()
    fallout.gsay_reply(397, 226)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus47()
    fallout.gsay_reply(397, 227)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus48()
    fallout.gsay_reply(397, 228)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus49()
    fallout.gsay_reply(397, 229)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus50()
    fallout.gsay_reply(397, 230)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus51()
    fallout.gsay_reply(397, 231)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus52()
    fallout.gsay_reply(397, 232)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus53()
    fallout.gsay_reply(397, 233)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus54()
    fallout.gsay_reply(397, 234)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function Barracus55()
    fallout.gsay_reply(397, 235)
    fallout.giq_option(0, 397, 104, BarracusEnd, 50)
end

function BarracusCombat()
    hostile = 1
end

function BarracusEnd()
end

local exports = {}
exports.start = start
return exports
