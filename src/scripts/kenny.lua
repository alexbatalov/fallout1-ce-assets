local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local Kenny00

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 40)
        misc.set_ai(self_obj, 86)
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
    if fallout.global_var(221) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(950, 101), 2)
    else
        if fallout.map_var(53) == 1 then
            fallout.set_map_var(53, 0)
            fallout.start_gdialog(950, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Kenny00()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(950, 102), 2)
        end
    end
end

function destroy_p_proc()
    fallout.display_msg(fallout.message_str(950, 106))
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(950, 100))
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function Kenny00()
    fallout.item_caps_adjust(fallout.dude_obj(), 1000)
    fallout.set_global_var(155, fallout.global_var(155) + 4)
    fallout.give_exp_points(1400)
    fallout.display_msg(fallout.message_str(766, 103) .. 1400 .. fallout.message_str(766, 104))
    fallout.gsay_message(950, 103, 50)
    fallout.gsay_message(950, 104, 50)
    fallout.gsay_message(950, 105, 50)
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
