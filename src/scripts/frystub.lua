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
local combat_p_proc
local damage_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.set_external_var("Fry_Stub_Ptr", self_obj)
        fallout.set_obj_visibility(self_obj, true)
        misc.set_team(self_obj, 0)
        fallout.critter_add_trait(self_obj, 1, 5, 86)
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
    elseif script_action == 13 then
        combat_p_proc()
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
    fallout.float_msg(fallout.self_obj(), fallout.message_str(914, 101), 2)
end

function destroy_p_proc()
    reputation.inc_good_critter()
    fallout.set_global_var(469, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(914, 100))
end

function combat_p_proc()
    if fallout.map_var(54) == 1 then
        fallout.script_overrides()
    end
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil and fallout.map_var(52) == 0 then
        fallout.set_global_var(248, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.combat_p_proc = combat_p_proc
exports.damage_p_proc = damage_p_proc
return exports
