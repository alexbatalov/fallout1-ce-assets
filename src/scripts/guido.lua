local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local Guido00
local Guido01
local Guido02

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.set_external_var("Guido_Ptr", self_obj)
        fallout.critter_add_trait(self_obj, 1, 6, 73)
        fallout.critter_add_trait(self_obj, 1, 5, 4)
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
    elseif script_action == 22 then
        timed_event_p_proc()
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
    if fallout.map_var(16) == 0 then
        fallout.set_map_var(16, 1)
        Guido00()
    else
        Guido01()
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(576, 100))
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        Guido02()
    end
end

function Guido00()
    local self_obj = fallout.self_obj()
    local leon_obj = fallout.external_var("Leon_Ptr")
    fallout.float_msg(self_obj, fallout.message_str(576, 101), 2)
    fallout.float_msg(leon_obj, fallout.message_str(596, 105), 3)
    fallout.add_timer_event(self_obj, fallout.game_ticks(3), 1)
    fallout.add_timer_event(leon_obj, fallout.game_ticks(3), 1)
end

function Guido01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(576, 104), 2)
end

function Guido02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(576, 102), 2)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.external_var("Leon_Ptr"), fallout.message_str(596, 102), 3)
    else
        fallout.float_msg(fallout.external_var("Leon_Ptr"), fallout.message_str(596, 103), 3)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
