local fallout = require("fallout")
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
local Falcon00
local Falcon01
local Falcon02
local Falcon03
local Falcon04
local Falcon05
local Falcon05a
local Falcon06
local Falcon06a
local Falcon07
local Falcon07a
local Falcon09
local Falcon11
local Falcon14
local Falcon15
local Falcon16
local FalconEnd

local hostile = false
local initialized = false
local First_Water = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 38)
        misc.set_ai(self_obj, 50)
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
    fallout.start_gdialog(697, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Falcon00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(697, 100))
end

function Falcon00()
    fallout.gsay_reply(697, 101)
    fallout.giq_option(4, 697, 102, Falcon05, 50)
    fallout.giq_option(4, 697, 103, Falcon06, 50)
    fallout.giq_option(4, 697, 104, Falcon07, 50)
    fallout.giq_option(4, 697, 106, Falcon04, 50)
    fallout.giq_option(-3, 697, 107, Falcon03, 50)
end

function Falcon01()
    fallout.gsay_message(697, 108, 50)
end

function Falcon02()
    fallout.gsay_message(697, 109, 50)
end

function Falcon03()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(697, 110, 50)
    else
        fallout.gsay_message(697, 111, 50)
    end
end

function Falcon04()
    fallout.gsay_message(697, 112, 50)
end

function Falcon05()
    fallout.gsay_reply(697, 113)
    fallout.giq_option(4, 697, 114, Falcon05a, 50)
    fallout.giq_option(4, 697, 115, Falcon11, 50)
end

function Falcon05a()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 41) >= 2 then
        Falcon09()
    else
        Falcon01()
    end
end

function Falcon06()
    fallout.gsay_reply(697, 116)
    fallout.giq_option(4, 697, 117, Falcon06a, 50)
    fallout.giq_option(4, 697, 115, Falcon11, 50)
end

function Falcon06a()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 41) < 5 then
        Falcon01()
    else
        Falcon14()
    end
end

function Falcon07()
    fallout.gsay_reply(697, 118)
    fallout.giq_option(4, 697, 117, Falcon07a, 50)
    fallout.giq_option(4, 697, 115, Falcon11, 50)
end

function Falcon07a()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 41) < 10 then
        Falcon01()
    else
        Falcon16()
    end
end

function Falcon09()
    if First_Water then
        fallout.gsay_reply(697,
            fallout.message_str(697, 139) .. fallout.message_str(697, 140) .. fallout.message_str(697, 141))
    else
        fallout.gsay_reply(697,
            fallout.message_str(697, 136) .. fallout.message_str(697, 137) .. fallout.message_str(697, 138))
    end
    local money_obj = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 41)
    fallout.rm_mult_objs_from_inven(fallout.dude_obj(), money_obj, 2)
    fallout.destroy_object(money_obj)
    First_Water = true
    Falcon15()
end

function Falcon11()
    if fallout.random(0, 1) then
        fallout.gsay_message(697, fallout.message_str(697, 151) .. fallout.message_str(697, 152), 50)
    else
        fallout.gsay_message(697, fallout.message_str(697, 153) .. fallout.message_str(697, 154), 50)
    end
end

function Falcon14()
    local money_obj = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 41)
    fallout.rm_mult_objs_from_inven(fallout.dude_obj(), money_obj, 5)
    fallout.destroy_object(money_obj)
    local item_obj = fallout.create_object_sid(124, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.gsay_reply(697, fallout.message_str(697, 160) .. fallout.message_str(697, 161))
    Falcon15()
end

function Falcon15()
    fallout.giq_option(4, 697, 102, Falcon05, 50)
    fallout.giq_option(4, 697, 103, Falcon06, 50)
    fallout.giq_option(4, 697, 104, Falcon07, 50)
    fallout.giq_option(4, 697, 106, Falcon04, 50)
    fallout.giq_option(-3, 697, 107, Falcon03, 50)
end

function Falcon16()
    local money_obj = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 41)
    fallout.rm_mult_objs_from_inven(fallout.dude_obj(), money_obj, 10)
    fallout.destroy_object(money_obj)
    local item_obj = fallout.create_object_sid(125, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.gsay_reply(697, fallout.message_str(697, 163) .. fallout.message_str(697, 164))
    Falcon15()
end

function FalconEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
