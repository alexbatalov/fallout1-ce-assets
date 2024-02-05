local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local PaladinBRandom
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 44)
        misc.set_ai(self_obj, 65)
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

function PaladinBRandom()
    local line = 0
    if line == 0 then
        line = fallout.random(1, 6)
    end
    if line > 6 then
        line = 1
    end
    local msg = fallout.message_str(326, 101)
    if line == 2 then
        msg = fallout.message_str(326, 102)
    elseif line == 3 then
        msg = fallout.message_str(326, 103)
    elseif line == 4 then
        msg = fallout.message_str(326, 104)
    elseif line == 5 then
        msg = fallout.message_str(326, 105)
    elseif line == 6 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            msg = fallout.message_str(326, 106)
        else
            msg = fallout.message_str(326, 107)
        end
    else
        line = 1
    end
    line = line + 1
    fallout.float_msg(fallout.self_obj(), msg, 0)
end

function critter_p_proc()
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
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
    PaladinBRandom()
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(326, 100))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
