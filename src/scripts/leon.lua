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
local timed_event_p_proc
local Leon00
local Leon01
local Leon02

local hostile = 0
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.set_external_var("Leon_Ptr", fallout.self_obj())
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 73)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 4)
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
                    if fallout.script_action() == 22 then
                        timed_event_p_proc()
                    else
                        if fallout.script_action() == 18 then
                            destroy_p_proc()
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
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.map_var(16) == 0 then
        fallout.set_map_var(16, 1)
        Leon00()
    else
        Leon01()
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(596, 100))
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        Leon02()
    end
end

function Leon00()
    fallout.float_msg(fallout.external_var("Guido_Ptr"), fallout.message_str(576, 101), 2)
    fallout.float_msg(fallout.self_obj(), fallout.message_str(596, 105), 3)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 1)
    fallout.add_timer_event(fallout.external_var("Guido_Ptr"), fallout.game_ticks(3), 1)
end

function Leon01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(596, 101), 3)
end

function Leon02()
    fallout.float_msg(fallout.external_var("Guido_Ptr"), fallout.message_str(576, 102), 2)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(596, 102), 3)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(596, 103), 3)
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
