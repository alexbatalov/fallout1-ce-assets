local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local PalGuard01
local PalGuard02

local line = 0
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 44)
        misc.set_ai(self_obj, 65)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(1) < 2 then
        PalGuard01()
    else
        PalGuard02()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(317, 100))
end

function timed_event_p_proc()
    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
end

function PalGuard01()
    if line == 0 then
        line = fallout.random(1, 9)
    else
        line = line + 1
    end
    if line > 9 then
        line = 1
    end
    if line == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 101), 2)
    elseif line == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 102), 2)
    elseif line == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 103), 2)
    elseif line == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 104), 2)
    elseif line == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 105), 2)
    elseif line == 6 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 106), 2)
        else
            line = line + 1
        end
    elseif line == 7 then
        if fallout.global_var(108) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 107), 2)
        else
            line = line + 1
        end
    elseif line == 8 then
        if fallout.global_var(108) < 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 108), 2)
        else
            line = line + 1
        end
    elseif line == 9 then
        if fallout.global_var(108) < 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 109), 2)
        else
            line = 1
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 110), 2)
        end
    end
end

function PalGuard02()
    if line == 0 then
        line = fallout.random(1, 8)
    else
        line = line + 1
    end
    if line > 8 then
        line = 1
    end
    if line == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 111), 2)
    elseif line == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 112), 2)
    elseif line == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 113), 2)
    elseif line == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 114), 2)
    elseif line == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 115), 2)
    elseif line == 7 then
        if fallout.global_var(108) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 116), 2)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 117), 2)
        end
    elseif line == 8 then
        if fallout.global_var(108) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 118), 2)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 119), 2)
        end
    end
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
