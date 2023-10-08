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
local Merchant00
local Merchant01
local Merchant02
local Merchant03
local Merchant04
local Merchant05
local Get_Stuff
local Put_Stuff

local hostile = 0
local Only_Once = 1

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 41)
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
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    Get_Stuff()
    fallout.start_gdialog(782, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Merchant00()
    fallout.gsay_end()
    fallout.end_dialogue()
    Put_Stuff()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(782, 110))
end

function Merchant00()
    fallout.gsay_reply(782, 101)
    fallout.giq_option(4, 782, 102, Merchant01, 50)
    fallout.giq_option(4, 782, 103, Merchant02, 50)
    fallout.giq_option(4, 782, 104, Merchant03, 50)
    fallout.giq_option(-3, 782, 105, Merchant04, 50)
end

function Merchant01()
    fallout.gsay_message(782, 106, 50)
    fallout.gdialog_mod_barter(-10)
    Merchant05()
end

function Merchant02()
    fallout.gsay_message(782, 107, 50)
    fallout.gdialog_mod_barter(-10)
    Merchant05()
end

function Merchant03()
end

function Merchant04()
    fallout.gsay_message(782, 108, 50)
end

function Merchant05()
    fallout.gsay_message(782, 109, 50)
end

function Get_Stuff()
    local v0 = 0
    v0 = fallout.create_object_sid(32, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 5)
    v0 = fallout.create_object_sid(14, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 5)
    v0 = fallout.create_object_sid(25, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 6)
    v0 = fallout.create_object_sid(11, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 2)
    v0 = fallout.create_object_sid(10, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 2)
    v0 = fallout.create_object_sid(23, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 1)
    v0 = fallout.create_object_sid(27, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 6)
    v0 = fallout.create_object_sid(13, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 1)
    v0 = fallout.create_object_sid(9, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 2)
    v0 = fallout.create_object_sid(143, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 1)
end

function Put_Stuff()
    local v0 = 0
    local v1 = 0
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 32)
    v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 5)
    fallout.destroy_object(v0)
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 14)
    v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 5)
    fallout.destroy_object(v0)
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 25)
    v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 6)
    fallout.destroy_object(v0)
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 11)
    v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 2)
    fallout.destroy_object(v0)
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 10)
    v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 2)
    fallout.destroy_object(v0)
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 23)
    v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 1)
    fallout.destroy_object(v0)
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 27)
    v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 6)
    fallout.destroy_object(v0)
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 13)
    v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 1)
    fallout.destroy_object(v0)
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 9)
    v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 2)
    fallout.destroy_object(v0)
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 143)
    v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 1)
    fallout.destroy_object(v0)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
