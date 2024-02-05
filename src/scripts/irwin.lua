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
local damage_p_proc
local IrwinTalks
local IrwinAccept
local IrwinEnd
local Irwin00
local Irwin01
local Irwin02
local Irwin03
local Irwin04
local Irwin05
local Irwin06
local Irwin07

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 41)
        misc.set_ai(self_obj, 51)
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
    if fallout.global_var(307) == 501 then
        if fallout.tile_num(fallout.self_obj()) ~= 27969 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 27969, 0)
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    IrwinTalks()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(935, 100))
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function IrwinTalks()
    if fallout.global_var(307) == 0 then
        fallout.start_gdialog(935, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Irwin00()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.global_var(307) == 1 or fallout.global_var(307) == 2 then
        fallout.start_gdialog(935, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Irwin05()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(935, 117), 8)
    end
end

function IrwinAccept()
    fallout.gsay_message(935, 109, 50)
    fallout.set_global_var(307, 1)
    fallout.game_time_advance(10 * 60 * 60 * 1)
    fallout.load_map("hubmis1.map", 1)
end

function IrwinEnd()
end

function Irwin00()
    fallout.gsay_reply(935, 101)
    fallout.giq_option(4, 935, 102, Irwin01, 50)
    fallout.giq_option(4, 935, 103, Irwin03, 50)
    fallout.giq_option(4, 935, 104, IrwinEnd, 50)
    fallout.giq_option(-3, 935, 118, Irwin07, 50)
end

function Irwin01()
    if fallout.get_pc_stat(1) < 5 then
        fallout.gsay_message(935, 105, 50)
    else
        Irwin02()
    end
end

function Irwin02()
    fallout.gsay_reply(935, 106)
    fallout.giq_option(4, 935, 107, IrwinAccept, 50)
    fallout.giq_option(4, 935, 108, Irwin04, 50)
end

function Irwin03()
    fallout.gsay_message(935, 110, 50)
end

function Irwin04()
    fallout.gsay_message(935, 111, 50)
end

function Irwin05()
    fallout.gsay_reply(935, 112)
    fallout.giq_option(4, 935, 113, Irwin06, 50)
    fallout.giq_option(4, 935, 114, IrwinEnd, 50)
    fallout.giq_option(-3, 935, 120, Irwin06, 50)
    fallout.giq_option(-3, 935, 121, IrwinEnd, 50)
end

function Irwin06()
    if fallout.global_var(307) == 2 then
        fallout.gsay_message(935, 115, 50)
        local item_obj = fallout.create_object_sid(241, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
        fallout.give_exp_points(500)
        fallout.set_global_var(155, fallout.global_var(155) + 2)
        fallout.set_global_var(307, 501)
    else
        fallout.gsay_message(935, 116, 50)
    end
end

function Irwin07()
    fallout.gsay_message(935, 119, 50)
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
