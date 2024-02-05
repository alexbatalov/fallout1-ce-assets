local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local dane00
local dane01
local dane02
local dane03
local dane04
local dane05
local dane06
local dane07
local dane08
local dane09
local dane10
local dane11
local dane12
local dane13
local dane14
local dane15
local dane16
local dane17
local dane18
local dane19
local dane20
local dane21
local dane22
local dane23
local dane24
local danemore
local danereturn

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 20)
        fallout.critter_add_trait(self_obj, 1, 5, 69)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(6) == 0 then
        dane00()
    elseif fallout.local_var(7) == 0 then
        dane01()
    elseif fallout.local_var(8) == 0 then
        dane02()
    elseif fallout.local_var(9) == 0 then
        dane03()
    elseif fallout.local_var(10) == 0 then
        dane04()
    elseif fallout.local_var(11) == 0 then
        dane05()
    elseif fallout.local_var(12) == 0 then
        dane06()
    elseif fallout.local_var(13) == 0 then
        dane07()
    elseif fallout.local_var(14) == 0 then
        dane08()
    elseif fallout.local_var(15) == 0 then
        dane09()
    elseif fallout.local_var(16) == 0 then
        dane10()
    elseif fallout.local_var(17) == 0 then
        dane11()
    elseif fallout.local_var(18) == 0 then
        dane12()
    elseif fallout.local_var(19) == 0 then
        dane13()
    elseif fallout.local_var(20) == 0 then
        dane14()
    elseif fallout.local_var(21) == 0 then
        dane15()
    elseif fallout.local_var(22) == 0 then
        dane16()
    elseif fallout.local_var(23) == 0 then
        dane17()
    elseif fallout.local_var(24) == 0 then
        dane18()
    elseif fallout.local_var(25) == 0 then
        dane19()
    elseif fallout.local_var(26) == 0 then
        dane20()
    elseif fallout.local_var(5) == 1 then
        dane24()
    end
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
    fallout.display_msg(fallout.message_str(499, 100))
end

function dane00()
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(499, 101)
    danemore()
    fallout.gsay_reply(499, 102)
    danemore()
    fallout.gsay_message(499, 103, 50)
end

function dane01()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(499, 104)
    danemore()
    fallout.gsay_reply(499, 105)
    danemore()
    fallout.gsay_message(499, 106, 50)
end

function dane02()
    fallout.set_local_var(8, 1)
    fallout.gsay_reply(499, 107)
    danemore()
    fallout.gsay_reply(499, 108)
    danemore()
    fallout.gsay_reply(499, 109)
    danemore()
    fallout.gsay_message(499, 110, 50)
end

function dane03()
    fallout.set_local_var(9, 1)
    fallout.gsay_reply(499, 111)
    danemore()
    fallout.gsay_reply(499, 112)
    danemore()
    fallout.gsay_message(499, 113, 50)
end

function dane04()
    fallout.set_local_var(10, 1)
    fallout.gsay_reply(499, 114)
    danemore()
    fallout.gsay_reply(499, 115)
    danemore()
    fallout.gsay_reply(499, 116)
    danemore()
    fallout.gsay_message(499, 117, 50)
end

function dane05()
    fallout.set_local_var(11, 1)
    fallout.gsay_reply(499, 118)
    danemore()
    fallout.gsay_reply(499, 119)
    danemore()
    fallout.gsay_message(499, 120, 50)
end

function dane06()
    fallout.set_local_var(12, 1)
    fallout.gsay_reply(499, 121)
    danemore()
    fallout.gsay_reply(499, 122)
    danemore()
    fallout.gsay_reply(499, 123)
    danemore()
    fallout.gsay_message(499, 124, 50)
end

function dane07()
    fallout.set_local_var(13, 1)
    fallout.gsay_reply(499, 125)
    danemore()
    fallout.gsay_reply(499, 126)
    danemore()
    fallout.gsay_message(499, 127, 50)
end

function dane08()
    fallout.set_local_var(14, 1)
    fallout.gsay_reply(499, 128)
    danemore()
    fallout.gsay_reply(499, 129)
    danemore()
    fallout.gsay_reply(499, 130)
    danemore()
    fallout.gsay_message(499, 131, 50)
end

function dane09()
    fallout.set_local_var(15, 1)
    fallout.gsay_reply(499, 132)
    danemore()
    fallout.gsay_reply(499, 133)
    danemore()
    fallout.gsay_reply(499, 134)
    danemore()
    fallout.gsay_message(499, 135, 50)
end

function dane10()
    fallout.set_local_var(16, 1)
    fallout.gsay_reply(499, 136)
    danemore()
    fallout.gsay_reply(499, 137)
    danemore()
    fallout.gsay_message(499, 138, 50)
end

function dane11()
    fallout.set_local_var(17, 1)
    fallout.gsay_reply(499, 139)
    danemore()
    fallout.gsay_reply(499, 140)
    danemore()
    fallout.gsay_reply(499, 141)
    danemore()
    fallout.gsay_message(499, 142, 50)
end

function dane12()
    fallout.set_local_var(18, 1)
    fallout.gsay_reply(499, 143)
    danemore()
    fallout.gsay_reply(499, 144)
    danemore()
    fallout.gsay_reply(499, 145)
    danemore()
    fallout.gsay_message(499, 146, 50)
end

function dane13()
    fallout.set_local_var(19, 1)
    fallout.gsay_reply(499, 147)
    danemore()
    fallout.gsay_reply(499, 148)
    danemore()
    fallout.gsay_reply(499, 149)
    danemore()
    fallout.gsay_reply(499, 150)
    danemore()
    fallout.gsay_message(499, 151, 50)
end

function dane14()
    fallout.set_local_var(20, 1)
    fallout.gsay_reply(499, 152)
    danemore()
    fallout.gsay_reply(499, 153)
    danemore()
    fallout.gsay_reply(499, 154)
    danemore()
    fallout.gsay_message(499, 155, 50)
end

function dane15()
    fallout.set_local_var(21, 1)
    fallout.gsay_reply(499, 156)
    danemore()
    fallout.gsay_reply(499, 157)
    danemore()
    fallout.gsay_message(499, 158, 50)
end

function dane16()
    fallout.gsay_reply(499, 159)
    danemore()
    fallout.gsay_reply(499, 160)
    danemore()
    fallout.gsay_reply(499, 161)
    danemore()
    fallout.gsay_reply(499, 162)
    fallout.giq_option(7, 499, 163, dane17, 50)
    fallout.giq_option(7, 499, 164, dane18, 50)
    fallout.giq_option(4, 499, 165, dane19, 50)
    fallout.giq_option(4, 499, 166, dane20, 50)
    fallout.giq_option(4, 499, 167, dane21, 50)
    fallout.giq_option(4, 499, 168, dane22, 50)
    fallout.giq_option(-3, 499, 169, dane23, 50)
end

function dane17()
    fallout.gsay_reply(499, 170)
    danemore()
    fallout.gsay_reply(499, 171)
    danemore()
    fallout.gsay_reply(499, 172)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.gsay_reply(499, 173)
        fallout.giq_option(7, 499, 174, dane18, 50)
        fallout.giq_option(4, 499, 175, dane19, 50)
        fallout.giq_option(4, 499, 176, dane20, 50)
        fallout.giq_option(4, 499, 177, dane21, 50)
        fallout.giq_option(4, 499, 178, dane22, 50)
    else
        danemore()
        fallout.gsay_message(499, 179, 50)
    end
end

function dane18()
    fallout.gsay_reply(499, 180)
    danemore()
    fallout.gsay_reply(499, 181)
    danemore()
    fallout.gsay_reply(499, 182)
    danemore()
    fallout.gsay_reply(499, 183)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.gsay_reply(499, 184)
        fallout.giq_option(7, 499, 185, dane18, 50)
        fallout.giq_option(4, 499, 186, dane19, 50)
        fallout.giq_option(4, 499, 187, dane20, 50)
        fallout.giq_option(4, 499, 188, dane21, 50)
        fallout.giq_option(4, 499, 189, dane22, 50)
    else
        danemore()
        fallout.gsay_message(499, 190, 50)
    end
end

function dane19()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.gsay_reply(499, 191)
        fallout.giq_option(7, 499, 192, dane18, 50)
        fallout.giq_option(4, 499, 193, dane19, 50)
        fallout.giq_option(4, 499, 194, dane20, 50)
        fallout.giq_option(4, 499, 195, dane21, 50)
        fallout.giq_option(4, 499, 196, dane22, 50)
    else
        fallout.gsay_message(499, 197, 50)
    end
end

function dane20()
    fallout.gsay_reply(499, 198)
    danemore()
    fallout.gsay_reply(499, 199)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.giq_option(7, 499, 200, dane19, 50)
        fallout.giq_option(7, 499, 201, dane18, 50)
        fallout.giq_option(4, 499, 202, dane19, 50)
        fallout.giq_option(4, 499, 203, dane21, 50)
        fallout.giq_option(4, 499, 204, dane22, 50)
        fallout.giq_option(-3, 499, 205, dane23, 50)
    else
        danemore()
        fallout.gsay_message(499, 206, 50)
    end
end

function dane21()
    fallout.gsay_reply(499, 207)
    danemore()
    fallout.gsay_reply(499, 208)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.giq_option(7, 499, 209, dane19, 50)
        fallout.giq_option(7, 499, 210, dane18, 50)
        fallout.giq_option(4, 499, 211, dane19, 50)
        fallout.giq_option(4, 499, 212, dane20, 50)
        fallout.giq_option(4, 499, 213, dane22, 50)
        fallout.giq_option(-3, 499, 214, dane23, 50)
    else
        danemore()
        fallout.gsay_message(499, 215, 50)
    end
end

function dane22()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(499, 216)
    danemore()
    fallout.gsay_reply(499, 217)
    danemore()
    fallout.gsay_reply(499, 218)
    danemore()
    fallout.gsay_message(499, 219, 50)
end

function dane23()
    fallout.set_local_var(5, 1)
    fallout.gsay_message(499, 220, 50)
end

function dane24()
    fallout.gsay_message(499, 221, 50)
end

function danemore()
    fallout.gsay_option(499, 222, danereturn, 50)
end

function danereturn()
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
