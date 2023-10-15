local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local MasterMerch00
local MasterMerch01
local MasterMerch02
local MasterMerch03
local MasterMerch04
local MasterMerch05
local MasterMerch06
local MasterMerch07
local MasterMerch08
local MasterMerch09
local MasterMerch10
local MasterMerch11
local MasterMerch12
local MasterMerch13
local MasterMerch14
local MasterMerch15
local MasterMerch16
local MasterMerch17
local MasterMerch18
local MasterMerch19
local MasterMerch20
local MasterMerchEnd

local hostile = 0
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 35)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    else
                        if fallout.script_action() == 14 then
                            damage_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    MasterMerch00()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.map_var(2) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(598, 156), 2)
    else
        if fallout.local_var(4) == 0 then
            fallout.set_local_var(4, 1)
            fallout.start_gdialog(598, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            MasterMerch01()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            if (fallout.local_var(5) > 0) and (fallout.global_var(101) ~= 1) then
                fallout.start_gdialog(598, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                MasterMerch19()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                fallout.start_gdialog(598, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                MasterMerch10()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(598, 100))
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function MasterMerch00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(598, 101), 2)
    combat()
end

function MasterMerch01()
    fallout.gsay_reply(598, 102)
    fallout.giq_option(4, 598, 103, MasterMerch02, 50)
    if (fallout.global_var(101) ~= 2) or ((fallout.global_var(30) == 1) and (fallout.global_var(31) == 0)) then
        fallout.giq_option(4, 598, 104, MasterMerch04, 50)
    end
    fallout.giq_option(4, 598, 105, MasterMerchEnd, 50)
    fallout.giq_option(-3, 598, 106, MasterMerch03, 50)
end

function MasterMerch02()
    fallout.set_map_var(1, 1)
    fallout.gsay_reply(598, 107)
    fallout.giq_option(4, 598, 108, MasterMerchEnd, 50)
    if (fallout.global_var(101) ~= 2) or ((fallout.global_var(30) == 1) and (fallout.global_var(31) == 0)) then
        fallout.giq_option(4, 598, 109, MasterMerch04, 50)
    end
    fallout.giq_option(-3, 598, 110, MasterMerch03, 50)
end

function MasterMerch03()
    fallout.gsay_message(598, 111, 50)
end

function MasterMerch04()
    if fallout.global_var(72) == 0 then
        fallout.set_global_var(72, 1)
    end
    fallout.gsay_reply(598, 112)
    fallout.giq_option(4, 598, 113, MasterMerch13, 50)
    fallout.giq_option(4, 598, 114, MasterMerch05, 50)
    fallout.giq_option(4, 598, 115, MasterMerch06, 50)
    fallout.giq_option(4, 598, 116, MasterMerch07, 50)
end

function MasterMerch05()
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(598, 117)
    fallout.giq_option(4, 598, 118, MasterMerch14, 50)
    fallout.giq_option(4, 598, 119, MasterMerch08, 50)
    fallout.giq_option(4, 598, 120, MasterMerch07, 50)
end

function MasterMerch06()
    fallout.gsay_message(598, 121, 50)
end

function MasterMerch07()
    fallout.gsay_message(598, 122, 50)
end

function MasterMerch08()
    fallout.gsay_reply(598, 123)
    fallout.giq_option(4, 598, 124, MasterMerch14, 50)
    fallout.giq_option(4, 598, 125, MasterMerch09, 50)
end

function MasterMerch09()
    fallout.gsay_message(598, 126, 50)
end

function MasterMerch10()
    fallout.gsay_reply(598, 127)
    if (fallout.global_var(101) ~= 2) and (fallout.global_var(101) ~= 1) and (fallout.local_var(6) == 0) then
        fallout.giq_option(4, 598, 128, MasterMerch04, 50)
    else
        if (fallout.global_var(101) ~= 2) and (fallout.global_var(101) ~= 1) and (fallout.local_var(6) == 1) then
            fallout.giq_option(4, 598, 129, MasterMerch12, 50)
        end
    end
    fallout.giq_option(4, 598, 130, MasterMerch11, 50)
    fallout.giq_option(4, 598, 131, MasterMerchEnd, 50)
    fallout.giq_option(-3, 598, 106, MasterMerch03, 50)
end

function MasterMerch11()
    fallout.set_map_var(1, 1)
    fallout.gsay_message(598, 132, 50)
end

function MasterMerch12()
    fallout.gsay_reply(598, 133)
    fallout.giq_option(4, 598, 134, MasterMerch13, 50)
    fallout.giq_option(4, 598, 135, MasterMerch14, 50)
    fallout.giq_option(4, 598, 136, MasterMerchEnd, 50)
end

function MasterMerch13()
    fallout.gsay_reply(598, 137)
    fallout.giq_option(4, 598, 138, MasterMerch14, 50)
    fallout.giq_option(4, 598, 139, MasterMerch07, 50)
end

function MasterMerch14()
    fallout.gsay_reply(598, 140)
    MasterMerch15()
end

function MasterMerch15()
    if fallout.local_var(5) == 0 then
        fallout.set_local_var(5, 2000)
    end
    fallout.giq_option(4, 598, 141, MasterMerch16, 50)
    if fallout.local_var(7) == 0 then
        fallout.giq_option(4, 598, 142, MasterMerch17, 50)
    end
    if fallout.local_var(7) == 0 then
        fallout.giq_option(4, 598, 143, MasterMerch18, 50)
    end
    fallout.giq_option(4, 598, 144, MasterMerchEnd, 50)
end

function MasterMerch16()
    if fallout.item_caps_total(fallout.dude_obj()) < fallout.local_var(5) then
        fallout.gsay_message(598, fallout.message_str(598, 145) .. fallout.local_var(5) .. fallout.message_str(598, 146), 50)
        MasterMerchEnd()
    else
        fallout.gsay_reply(598, 147)
        fallout.giq_option(4, 598, 148, MasterMerchEnd, 50)
        fallout.giq_option(4, 598, 149, MasterMerch20, 50)
    end
end

function MasterMerch17()
    fallout.set_local_var(7, 1)
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, -15)) then
        fallout.set_local_var(5, 1000)
        fallout.gsay_message(598, 150, 50)
        MasterMerch16()
    else
        fallout.gsay_reply(598, 151)
        MasterMerch15()
    end
end

function MasterMerch18()
    fallout.set_local_var(7, 1)
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, -30)) then
        fallout.set_local_var(5, 500)
        fallout.gsay_message(598, 152, 50)
        MasterMerch16()
    else
        fallout.gsay_reply(598, 153)
        MasterMerch15()
    end
end

function MasterMerch19()
    fallout.gsay_reply(598, fallout.message_str(598, 157) .. fallout.local_var(5) .. fallout.message_str(598, 158))
    MasterMerch15()
end

function MasterMerch20()
    local v0 = 0
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), -1 * fallout.local_var(5))
    fallout.set_global_var(101, 1)
    fallout.set_global_var(10, fallout.global_var(10) + 100)
    if fallout.global_var(154) >= 100 then
        fallout.set_global_var(154, fallout.global_var(154) - 90)
    end
    fallout.give_exp_points(1000)
    fallout.display_msg(fallout.message_str(766, 103) .. 1000 .. fallout.message_str(766, 104))
    fallout.gsay_message(598, 155, 50)
end

function MasterMerchEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.damage_p_proc = damage_p_proc
return exports
