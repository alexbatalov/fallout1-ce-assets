local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Harold00
local Harold00a
local Harold00b
local Harold01
local Harold02
local Harold03
local Harold04
local Harold05
local Harold06
local Harold07
local Harold08
local Harold09
local Harold09a
local Harold10
local Harold10a
local Harold11
local Harold12
local Harold13
local Harold14
local Harold15
local Harold15a
local Harold16
local Harold17
local Harold17a
local Harold18
local Harold19
local Harold20
local Harold21
local Harold22
local Harold23
local Harold24
local Harold25
local Harold25a
local Harold26
local Harold26a
local Harold26b
local Harold27
local Harold28
local Harold29
local Harold30
local Harold31
local Harold32
local Harold33
local Harold34
local Harold36
local Harold37
local Harold38
local Harold39
local Harold39a
local Harold39b
local Harold40
local Harold41
local Harold41a
local Harold42
local Harold43
local Harold43a
local Harold43b
local Harold44
local Harold45
local Harold47
local Harold49
local Harold50
local Harold51
local Harold52
local Harold53
local Harold54
local Harold55
local Harold56
local Harold57
local HaroldEnd

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 41)
        misc.set_ai(self_obj, 53)
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

function combat()
    hostile = true
end

function critter_p_proc()
    if hostile then
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
    if fallout.local_var(4) == 0 then
        if fallout.local_var(1) > 1 then
            fallout.set_local_var(4, 1)
            fallout.start_gdialog(45, fallout.self_obj(), 4, 14, 3)
            fallout.gsay_start()
            Harold00()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.start_gdialog(45, fallout.self_obj(), 4, 14, 3)
            fallout.gsay_start()
            Harold39()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    else
        if fallout.local_var(1) > 1 then
            fallout.set_local_var(4, 1)
            fallout.start_gdialog(45, fallout.self_obj(), 4, 14, 3)
            fallout.gsay_start()
            Harold41()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.start_gdialog(45, fallout.self_obj(), 4, 14, 3)
            fallout.gsay_start()
            Harold55()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(45, 100))
end

function Harold00()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(45, 266)
    else
        fallout.gsay_reply(45, 267)
    end
    fallout.giq_option(4, 45, 102, Harold00a, 50)
    fallout.giq_option(4, 45, 103, Harold00b, 50)
    fallout.giq_option(4, 45, 104, Harold38, 50)
    if fallout.global_var(226) == 2 then
        fallout.giq_option(4, 45, 225, Harold45, 50)
    end
    fallout.giq_option(4, 45, 105, Harold37, 51)
    fallout.giq_option(-3, 45, 106, Harold01, 50)
end

function Harold00a()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 25 then
        fallout.item_caps_adjust(dude_obj, -25)
        Harold02()
    else
        Harold01()
    end
end

function Harold00b()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 5 then
        fallout.item_caps_adjust(dude_obj, -5)
        Harold02()
    else
        Harold01()
    end
end

function Harold01()
    fallout.gsay_message(45, 107, 50)
end

function Harold02()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(45, 268)
    else
        fallout.gsay_reply(45, 269)
    end
    fallout.giq_option(4, 45, 109, Harold03, 50)
    if fallout.global_var(226) == 2 then
        fallout.giq_option(4, 45, 225, Harold45, 50)
    end
    fallout.giq_option(4, 45, 110, HaroldEnd, 50)
end

function Harold03()
    fallout.gsay_reply(45, 111)
    fallout.giq_option(4, 45, 112, Harold04, 50)
    fallout.giq_option(4, 45, 113, Harold36, 50)
    fallout.giq_option(4, 45, 114, HaroldEnd, 50)
end

function Harold04()
    fallout.gsay_reply(45, 115)
    fallout.giq_option(4, 45, 116, Harold05, 50)
    fallout.giq_option(4, 45, 117, Harold32, 50)
end

function Harold05()
    fallout.gsay_reply(45, 118)
    fallout.giq_option(4, 45, 119, Harold07, 50)
    fallout.giq_option(4, 45, 120, Harold06, 50)
    fallout.giq_option(4, 45, 121, Harold30, 50)
end

function Harold06()
    fallout.gsay_reply(45, 122)
    fallout.giq_option(4, 45, 123, Harold07, 50)
end

function Harold07()
    fallout.gsay_reply(45, 124)
    fallout.giq_option(4, 45, 125, Harold08, 50)
end

function Harold08()
    fallout.gsay_reply(45, 126)
    fallout.giq_option(4, 45, 127, Harold09, 50)
    fallout.giq_option(4, 45, 128, Harold10, 50)
end

function Harold09()
    fallout.gsay_reply(45, 129)
    fallout.giq_option(4, 45, 130, Harold09a, 50)
end

function Harold09a()
    fallout.gsay_reply(45, 131)
    fallout.giq_option(4, 45, 132, Harold11, 50)
end

function Harold10()
    fallout.gsay_reply(45, 133)
    fallout.giq_option(4, 45, 134, Harold11, 50)
    fallout.giq_option(4, 45, 135, Harold12, 50)
    fallout.giq_option(4, 45, 136, Harold10a, 50)
end

function Harold10a()
    fallout.gsay_message(45, 137, 50)
    Harold11()
end

function Harold11()
    fallout.gsay_reply(45, 138)
    fallout.giq_option(4, 45, 139, Harold14, 50)
    fallout.giq_option(4, 45, 140, Harold13, 50)
end

function Harold12()
    fallout.gsay_reply(45, 141)
    fallout.giq_option(4, 45, 142, Harold11, 50)
end

function Harold13()
    fallout.gsay_reply(45, 143)
    fallout.giq_option(4, 45, 144, Harold15, 50)
    fallout.giq_option(4, 45, 145, Harold14, 50)
end

function Harold14()
    fallout.gsay_reply(45, 146)
    fallout.giq_option(4, 45, 147, Harold18, 50)
end

function Harold15()
    fallout.gsay_reply(45, 148)
    fallout.giq_option(4, 45, 149, Harold14, 50)
    fallout.giq_option(4, 45, 150, Harold15a, 50)
    fallout.giq_option(4, 45, 152, HaroldEnd, 50)
end

function Harold15a()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 25 then
        fallout.item_caps_adjust(dude_obj, -25)
        fallout.set_local_var(6, 1)
        Harold14()
    else
        Harold17()
    end
end

function Harold16()
    fallout.gsay_message(45, 153, 50)
    fallout.giq_option(4, 45, 154, Harold14, 50)
end

function Harold17()
    fallout.gsay_message(45, 156, 50)
    if fallout.local_var(1) >= 3 then
        Harold16()
    else
        Harold17a()
    end
end

function Harold17a()
    fallout.gsay_reply(45, 157)
    fallout.giq_option(4, 45, 158, HaroldEnd, 50)
    fallout.giq_option(4, 45, 159, Harold14, 50)
end

function Harold18()
    fallout.gsay_reply(45, 160)
    fallout.giq_option(4, 45, 161, Harold20, 50)
    fallout.giq_option(4, 45, 162, Harold19, 50)
end

function Harold19()
    fallout.gsay_reply(45, 163)
    fallout.giq_option(4, 45, 164, Harold21, 50)
end

function Harold20()
    fallout.gsay_reply(45, 165)
    fallout.giq_option(4, 45, 166, Harold21, 50)
end

function Harold21()
    fallout.gsay_reply(45, 167)
    fallout.giq_option(4, 45, 168, Harold22, 50)
end

function Harold22()
    fallout.gsay_reply(45, 169)
    fallout.giq_option(4, 45, 170, Harold23, 50)
    fallout.giq_option(4, 45, 171, Harold24, 50)
end

function Harold23()
    fallout.gsay_reply(45, 172)
    fallout.giq_option(4, 45, 173, Harold24, 50)
end

function Harold24()
    fallout.gsay_reply(45, 174)
    fallout.giq_option(4, 45, 175, Harold25, 50)
end

function Harold25()
    fallout.gsay_reply(45, 176)
    fallout.giq_option(4, 45, 177, Harold25a, 50)
    fallout.giq_option(4, 45, 178, Harold27, 50)
end

function Harold25a()
    fallout.gsay_reply(45, 179)
    fallout.giq_option(4, 45, 180, Harold26, 50)
end

function Harold26()
    fallout.gsay_reply(45, 181)
    fallout.giq_option(4, 45, 182, Harold28, 50)
    fallout.giq_option(4, 45, 183, Harold26a, 50)
end

function Harold26a()
    fallout.set_local_var(5, 1)
    if fallout.local_var(6) == 1 then
        fallout.gsay_reply(45, 184)
        fallout.giq_option(4, 45, 185, Harold26b, 50)
    else
        fallout.gsay_message(45, 184, 50)
    end
end

function Harold26b()
    fallout.gsay_message(45, 187, 50)
end

function Harold27()
    fallout.gsay_reply(45, 188)
    fallout.giq_option(4, 45, 189, Harold26, 50)
end

function Harold28()
    fallout.gsay_reply(45, 190)
    fallout.giq_option(4, 45, 191, Harold29, 50)
    fallout.giq_option(4, 45, 192, Harold26a, 50)
end

function Harold29()
    fallout.gsay_reply(45, 193)
    fallout.giq_option(4, 45, 194, Harold26a, 50)
end

function Harold30()
    fallout.gsay_reply(45, 195)
    fallout.giq_option(4, 45, 196, Harold31, 50)
end

function Harold31()
    fallout.gsay_reply(45, 197)
    fallout.giq_option(4, 45, 198, Harold07, 50)
end

function Harold32()
    fallout.gsay_reply(45, 199)
    fallout.giq_option(4, 45, 200, Harold11, 50)
end

function Harold33()
    fallout.gsay_reply(45, 201)
    fallout.giq_option(4, 45, 202, Harold34, 50)
    fallout.giq_option(4, 45, 203, HaroldEnd, 50)
end

function Harold34()
    fallout.gsay_reply(45, 204)
    fallout.giq_option(4, 45, 205, Harold05, 50)
end

function Harold36()
    fallout.gsay_message(45, 207, 50)
end

function Harold37()
    reaction.BigDownReact()
    fallout.gsay_message(45, 208, 51)
end

function Harold38()
    fallout.gsay_message(45, 209, 50)
end

function Harold39()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(45, 272)
    else
        fallout.gsay_reply(45, 273)
    end
    fallout.giq_option(4, 45, 211, Harold39a, 50)
    fallout.giq_option(4, 45, 212, Harold39b, 50)
    if fallout.global_var(226) == 2 then
        fallout.giq_option(4, 45, 225, Harold45, 50)
    end
    fallout.giq_option(4, 45, 213, Harold38, 50)
    fallout.giq_option(-3, 45, 214, Harold01, 50)
end

function Harold39a()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 25 then
        fallout.item_caps_adjust(dude_obj, -25)
        Harold40()
    else
        Harold01()
    end
end

function Harold39b()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 5 then
        fallout.item_caps_adjust(dude_obj, -5)
        Harold40()
    else
        Harold01()
    end
end

function Harold40()
    fallout.gsay_reply(45, 215)
    fallout.giq_option(4, 45, 216, Harold03, 50)
    fallout.giq_option(4, 45, 217, HaroldEnd, 50)
end

function Harold41()
    fallout.gsay_reply(45, 218)
    fallout.giq_option(4, 45, 219, Harold41a, 50)
    fallout.giq_option(4, 45, 220, Harold43, 50)
    fallout.giq_option(-3, 45, 221, HaroldEnd, 50)
end

function Harold41a()
    if fallout.item_caps_total(fallout.dude_obj()) >= 20 then
        fallout.item_caps_adjust(fallout.dude_obj(), -20)
        Harold43()
    else
        Harold01()
    end
end

function Harold42()
    reaction.DownReact()
    fallout.gsay_message(45, 222, 51)
end

function Harold43()
    fallout.gsay_reply(45, 223)
    if fallout.global_var(226) == 2 then
        fallout.giq_option(4, 45, 225, Harold45, 50)
    end
    if fallout.global_var(150) - time.game_time_in_days() < 10 or fallout.global_var(109) == 1 then
        fallout.giq_option(4, 45, 224, Harold43b, 50)
    end
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 45, 226, Harold43a, 50)
    end
    fallout.giq_option(4, 45, 265, HaroldEnd, 50)
end

function Harold43a()
    fallout.gsay_message(45, 228, 50)
    Harold04()
end

function Harold43b()
    if fallout.global_var(109) == 1 then
        Harold53()
    elseif fallout.global_var(150) - time.game_time_in_days() < 10 then
        Harold54()
    end
end

function Harold44()
    fallout.gsay_message(45, 229, 50)
end

function Harold45()
    fallout.set_global_var(226, 3)
    fallout.gsay_reply(45, 230)
    fallout.giq_option(4, 45, 231, Harold47, 50)
    fallout.giq_option(4, 45, 232, Harold47, 50)
end

function Harold47()
    fallout.gsay_reply(45, 233)
    fallout.giq_option(4, 45, 234, Harold49, 50)
end

function Harold49()
    fallout.gsay_reply(45, 235)
    fallout.giq_option(4, 45, 236, Harold50, 50)
end

function Harold50()
    fallout.gsay_reply(45, 237)
    fallout.giq_option(4, 45, 238, Harold51, 50)
end

function Harold51()
    fallout.gsay_reply(45, 239)
    fallout.giq_option(4, 45, 240, HaroldEnd, 50)
end

function Harold52()
    fallout.gsay_message(45, 241, 50)
end

function Harold53()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(45, 242)
    fallout.giq_option(4, 45, 243, HaroldEnd, 50)
end

function Harold54()
    fallout.gsay_reply(45, 244)
    fallout.giq_option(4, 45, 245, HaroldEnd, 50)
end

function Harold55()
    fallout.gsay_reply(45, 246)
    fallout.giq_option(4, 45, 247, Harold56, 50)
    fallout.giq_option(4, 45, 248, Harold57, 50)
end

function Harold56()
    fallout.gsay_message(45, 249, 51)
end

function Harold57()
    fallout.gsay_message(45, 250, 51)
end

function HaroldEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
