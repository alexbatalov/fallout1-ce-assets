local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
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
local Flower00
local Flower01
local Flower02
local Flower03
local Flower03a
local Flower04
local Flower04a
local Flower05
local Flower05a
local Flower06
local Flower07
local Flower08
local Flower09
local Flower10
local Flower11
local Flower12
local Flower13
local Flower14

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 72)
        misc.set_ai(self_obj, 68)
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
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.map_var(6) == 1 and fallout.obj_can_see_obj(self_obj, dude_obj) == 1 then
        fallout.critter_set_flee_state(self_obj, true)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.global_var(195) == 1 or fallout.map_var(0) == 1 then
        Flower00()
    elseif fallout.global_var(158) == 1 then
        Flower01()
    elseif fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 117) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(588, 114), 2)
    else
        fallout.start_gdialog(588, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Flower02()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(158, fallout.global_var(158) + 1)
        fallout.set_global_var(155, fallout.global_var(155) - 1)
    end
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(588, 100))
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_map_var(6, 1)
    end
end

function Flower00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(588, 101), 2)
    behaviour.flee_dude(0)
end

function Flower01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(588, 102), 2)
    behaviour.flee_dude(0)
end

function Flower02()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(588, 103)
    else
        fallout.gsay_reply(588, 104)
    end
    fallout.giq_option(7, 588, 106, Flower03, 50)
    fallout.giq_option(7, 588, 107, Flower04, 50)
    fallout.giq_option(4, 588, 108, Flower05, 50)
    fallout.giq_option(4, 588, 109, Flower06, 49)
    fallout.giq_option(4, 588, 110, Flower07, 51)
    fallout.giq_option(4, 588, 111, Flower07, 51)
    fallout.giq_option(-3, 588, 112, Flower08, 49)
    fallout.giq_option(-3, 588, 113, Flower09, 51)
end

function Flower03()
    fallout.gsay_reply(588, 115)
    fallout.giq_option(7, 588, 116, Flower03a, 49)
    fallout.giq_option(7, 588, 107, Flower04, 50)
    fallout.giq_option(4, 588, 109, Flower06, 49)
    fallout.giq_option(4, 588, 110, Flower07, 51)
    fallout.giq_option(4, 588, 119, Flower07, 51)
end

function Flower03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) then
        Flower10()
    else
        Flower11()
    end
end

function Flower04()
    fallout.gsay_reply(588, 121)
    fallout.giq_option(7, 588, 123, Flower12, 50)
    fallout.giq_option(7, 588, 124, Flower04a, 49)
    fallout.giq_option(4, 588, 125, Flower05, 50)
    fallout.giq_option(4, 588, 126, Flower06, 49)
    fallout.giq_option(4, 588, 110, Flower07, 51)
    fallout.giq_option(4, 588, 119, Flower07, 51)
end

function Flower04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Flower13()
    else
        Flower11()
    end
end

function Flower05()
    fallout.gsay_reply(588, 129)
    fallout.giq_option(7, 588, 130, Flower05a, 49)
    fallout.giq_option(7, 588, 131, Flower04a, 49)
    fallout.giq_option(4, 588, 132, Flower06, 49)
    fallout.giq_option(4, 588, 110, Flower07, 51)
    fallout.giq_option(4, 588, 119, Flower07, 51)
end

function Flower05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Flower14()
    else
        Flower11()
    end
end

function Flower06()
    local item_obj = fallout.create_object_sid(117, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.gsay_message(588, 135, 49)
end

function Flower07()
    fallout.gsay_message(588, 136, 51)
    behaviour.flee_dude(0)
end

function Flower08()
    local item_obj = fallout.create_object_sid(117, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.gsay_message(588, 137, 49)
end

function Flower09()
    fallout.gsay_message(588, 138, 51)
    behaviour.flee_dude(0)
end

function Flower10()
    local item_obj = fallout.create_object_sid(117, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.gsay_message(588, 139, 49)
end

function Flower11()
    fallout.gsay_message(588, 140, 51)
    behaviour.flee_dude(0)
end

function Flower12()
    fallout.gsay_reply(588, 141)
    fallout.giq_option(7, 588, 142, Flower05a, 50)
    fallout.giq_option(7, 588, 143, Flower04a, 50)
    fallout.giq_option(4, 588, 144, Flower06, 49)
    fallout.giq_option(4, 588, 145, Flower07, 51)
    fallout.giq_option(4, 588, 146, Flower07, 51)
end

function Flower13()
    fallout.gsay_reply(588, 147)
    fallout.giq_option(7, 588, 148, Flower11, 50)
    fallout.giq_option(4, 588, 149, Flower06, 49)
    fallout.giq_option(4, 588, 150, Flower07, 51)
    fallout.giq_option(4, 588, 151, Flower07, 51)
end

function Flower14()
    fallout.set_global_var(281, 1)
    fallout.gsay_reply(588, 152)
    fallout.giq_option(7, 588, 153, Flower11, 50)
    fallout.giq_option(4, 588, 154, Flower06, 49)
    fallout.giq_option(4, 588, 155, Flower07, 51)
    fallout.giq_option(4, 588, 151, Flower07, 51)
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
