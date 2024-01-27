local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local calder00
local calder01
local calder01a
local calder01b
local calder02
local calder03
local calder04
local calder05
local calder05a
local calder06
local calder06a
local calder07
local calder07a
local calder07b
local calder08
local calder09
local calder09a
local calder10
local calder11
local calder12
local calder12a
local calder13
local calder14
local calder15
local calder16
local calder17
local calder18
local calder19
local calder20
local calder21
local calder22
local calder23
local calder24
local calder25
local calder25a
local calder26
local calder27
local calder28
local calder29
local calder29a
local calder29b
local calder29c
local calder30
local calder30a
local calder30b
local calder31
local calder32
local calder33
local calder34
local calderdone
local calderend
local caldercombat

local hostile = false
local GENDER = 0
local LASHERKNOWN = 0
local LASHERABUSEKNOWN = 0
local initialized = false

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
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        if fallout.local_var(4) == 1 then
            calder28()
        else
            fallout.set_local_var(4, 1)
            calder05()
        end
    else
        if fallout.global_var(158) > 2 then
            calder00()
        elseif fallout.local_var(4) == 1 then
            calder28()
        else
            fallout.set_local_var(4, 1)
            calder29()
        end
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
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(393, 100))
end

function calder00()
    fallout.gsay_reply(393, 101)
    fallout.giq_option(4, 393, 102, calder02, 50)
    fallout.giq_option(4, 393, 103, calder03, 50)
    fallout.giq_option(4, 393, 104, calder04, 50)
    fallout.giq_option(4, 393, 105, calder05, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 106, caldercombat, 50)
    end
end

function calder01()
    fallout.gsay_reply(393, 107)
    fallout.giq_option(4, 393, 108, calder01a, 50)
    fallout.giq_option(4, 393, 109, calder03, 50)
    fallout.giq_option(4, 393, 110, calder01b, 50)
    fallout.giq_option(-3, 393, 111, calder03, 50)
end

function calder01a()
    if fallout.get_critter_stat(fallout.dude_obj(), 3) > 6 then
        calder04()
    else
        calder03()
    end
end

function calder01b()
    if fallout.get_critter_stat(fallout.dude_obj(), 3) > 6 then
        calder02()
    else
        calder03()
    end
end

function calder02()
    fallout.gsay_message(393, 112, 51)
end

function calder03()
    fallout.gsay_message(393, 113, 51)
    caldercombat()
end

function calder04()
    fallout.gsay_message(393, 114, 51)
end

function calder05()
    if GENDER == 0 then
        fallout.gsay_reply(393, 115)
    else
        fallout.gsay_reply(393, 116)
    end
    fallout.giq_option(7, 393, 117, calder05a, 50)
    fallout.giq_option(4, 393, 118, calder08, 50)
    fallout.giq_option(4, 393, 119, calder09, 50)
    fallout.giq_option(-3, 393, 120, calder10, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 121, calder11, 50)
    end
end

function calder05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        calder06()
    else
        calder07()
    end
end

function calder06()
    fallout.set_global_var(196, 1)
    fallout.gsay_reply(393, 122)
    fallout.giq_option(7, 393, 123, calder06a, 50)
    fallout.giq_option(4, 393, 124, calder12, 50)
    fallout.giq_option(4, 393, 125, calder09, 50)
    fallout.giq_option(-3, 393, 126, calder10, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 127, calder11, 50)
    end
end

function calder06a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        calder12()
    else
        calder07()
    end
end

function calder07()
    LASHERKNOWN = 1
    LASHERABUSEKNOWN = 1
    fallout.gsay_reply(393, 128)
    fallout.giq_option(7, 393, 129, calder07a, 50)
    fallout.giq_option(4, 393, 130, calder07b, 50)
    fallout.giq_option(-3, 393, 131, calder16, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 132, calder15, 50)
    end
end

function calder07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        calder06()
    else
        calder13()
    end
end

function calder07b()
    if fallout.get_critter_stat(fallout.dude_obj(), 3) > 6 then
        calder14()
    else
        calder15()
    end
end

function calder08()
    local item_obj = fallout.create_object_sid(117, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.gsay_message(393, 133, 49)
end

function calder09()
    fallout.gsay_reply(393, 134)
    fallout.giq_option(7, 393, 135, calder15, 50)
    fallout.giq_option(4, 393, 136, calder16, 50)
    fallout.giq_option(4, 393, 137, calder17, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 138, calder09a, 50)
    end
end

function calder09a()
    if fallout.get_critter_stat(fallout.dude_obj(), 3) > 6 then
        calder02()
    else
        calder03()
    end
end

function calder10()
    fallout.gsay_message(393, 139, 50)
end

function calder11()
    fallout.gsay_message(393, 140, 50)
end

function calder12()
    fallout.gsay_reply(393, 141)
    fallout.giq_option(7, 393, 142, calder12a, 50)
    fallout.giq_option(4, 393, 143, calder08, 50)
    if GENDER == 0 then
        fallout.giq_option(4, 393, 144, calder19, 50)
    end
    if GENDER == 0 then
        fallout.giq_option(4, 393, 145, calder19, 50)
    end
    fallout.giq_option(-3, 393, 146, calder15, 50)
end

function calder12a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -3)) then
        calder18()
    else
        calder13()
    end
end

function calder13()
    fallout.gsay_message(393, 147, 50)
end

function calder14()
    fallout.gsay_reply(393, 148)
    fallout.giq_option(7, 393, 149, calder20, 50)
    fallout.giq_option(4, 393, 150, calder21, 50)
    fallout.giq_option(4, 393, 151, calder22, 50)
    fallout.giq_option(-3, 393, 152, calder15, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 153, calder02, 50)
    end
end

function calder15()
    fallout.gsay_message(393, 154, 51)
end

function calder16()
    fallout.gsay_message(393, 155, 50)
end

function calder17()
    fallout.gsay_message(393, 156, 50)
end

function calder18()
    fallout.gsay_message(393, 157, 51)
end

function calder19()
    fallout.gsay_message(393, 158, 50)
end

function calder20()
    fallout.gsay_reply(393, 159)
    fallout.giq_option(7, 393, 160, calder23, 50)
    fallout.giq_option(4, 393, 161, calder24, 50)
    fallout.giq_option(4, 393, 162, calder25, 50)
    fallout.giq_option(-3, 393, 163, calder15, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 164, calder25, 50)
    end
end

function calder21()
    fallout.gsay_message(393, 165, 51)
end

function calder22()
    fallout.gsay_message(393, 166, 51)
end

function calder23()
    fallout.gsay_message(393, 167, 51)
end

function calder24()
    fallout.gsay_message(393, 168, 50)
end

function calder25()
    LASHERKNOWN = 1
    LASHERABUSEKNOWN = 1
    fallout.gsay_reply(393, 169)
    fallout.giq_option(7, 393, 171, calder25a, 50)
    fallout.giq_option(4, 393, 172, calder15, 50)
    fallout.giq_option(4, 393, 173, calder24, 50)
    fallout.giq_option(-3, 393, 174, calder15, 50)
end

function calder25a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        calder26()
    else
        calder15()
    end
end

function calder26()
    fallout.set_global_var(196, 1)
    fallout.gsay_reply(393, 175)
    fallout.giq_option(4, 393, 176, calder13, 50)
    fallout.giq_option(4, 393, 177, calder27, 50)
    fallout.giq_option(3, 393, 178, calder16, 50)
end

function calder27()
    fallout.gsay_message(393, 179, 51)
end

function calder28()
    fallout.gsay_reply(393, 180)
    fallout.giq_option(7, 393, 181, calder27, 50)
    fallout.giq_option(4, 393, 182, calder27, 50)
    fallout.giq_option(4, 393, 183, calder15, 50)
    fallout.giq_option(-3, 393, 184, calder15, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 185, calder15, 50)
    end
end

function calder29()
    fallout.gsay_reply(393, 186)
    fallout.giq_option(7, 393, 187, calder29a, 50)
    fallout.giq_option(4, 393, 188, calder29b, 50)
    fallout.giq_option(4, 393, 189, calder29c, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 190, calder02, 50)
    end
    fallout.giq_option(-3, 393, 191, calder15, 50)
end

function calder29a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        calder30()
    else
        calder32()
    end
end

function calder29b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        calder31()
    else
        calder32()
    end
end

function calder29c()
    if fallout.get_critter_stat(fallout.dude_obj(), 3) > 6 then
        calder33()
    else
        calder32()
    end
end

function calder30()
    fallout.gsay_reply(393, 192)
    fallout.giq_option(4, 393, 193, calder30a, 50)
    fallout.giq_option(4, 393, 194, calder30b, 50)
    fallout.giq_option(4, 393, 195, calder11, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 196, calder03, 50)
    end
end

function calder30a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        calder13()
    else
        calder15()
    end
end

function calder30b()
    if fallout.get_critter_stat(fallout.dude_obj(), 3) > 6 then
        calder31()
    else
        calder32()
    end
end

function calder31()
    fallout.gsay_reply(393, 197)
    fallout.giq_option(7, 393, 198, calder13, 50)
    fallout.giq_option(4, 393, 199, calder08, 50)
    fallout.giq_option(4, 393, 200, calder09, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 201, calder11, 50)
    end
end

function calder32()
    LASHERKNOWN = 1
    LASHERABUSEKNOWN = 1
    fallout.gsay_message(393, 202, 50)
end

function calder33()
    LASHERKNOWN = 1
    LASHERABUSEKNOWN = 1
    fallout.gsay_reply(393, 203)
    fallout.giq_option(7, 393, 204, calder34, 50)
    fallout.giq_option(4, 393, 205, calder14, 50)
    fallout.giq_option(4, 393, 206, calder34, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 393, 207, calder15, 50)
    end
end

function calder34()
    fallout.gsay_message(393, 208, 51)
end

function calderdone()
    fallout.gsay_option(393, 209, calderend, 50)
end

function calderend()
end

function caldercombat()
    fallout.set_global_var(195, 1)
    hostile = true
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
