local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local PaladinARandom
local PaladinABackground
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local time_p_proc

local initialized = false
local hostile = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 65)
        fallout.add_timer_event(self_obj, fallout.game_ticks(300), 1)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        time_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function PaladinARandom()
    local line = 0
    if line == 0 then
        line = fallout.random(1, 9)
    end
    if line > 10 then
        line = 1
    end
    local msg = fallout.message_str(325, 101)
    if line == 2 then
        msg = fallout.message_str(325, 102)
    elseif line == 3 then
        msg = fallout.message_str(325, 103)
    elseif line == 4 then
        msg = fallout.message_str(325, 104) ..
            fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(325, 105)
    elseif line == 5 then
        msg = fallout.message_str(325, 106)
    elseif line == 6 then
        msg = fallout.message_str(325, 107)
    elseif line == 7 then
        msg = fallout.message_str(325, 108)
    elseif line == 8 then
        msg = fallout.message_str(325, 109)
    elseif line == 9 then
        msg = fallout.message_str(325, 110)
    else
        line = 1
    end
    line = line + 1
    fallout.float_msg(fallout.self_obj(), msg, 0)
end

function PaladinABackground()
    local self_obj = fallout.self_obj()
    local msg
    fallout.add_timer_event(self_obj, fallout.game_ticks(300), 1)
    if fallout.random(0, 1) then
        msg = fallout.message_str(325, 112)
    else
        msg = fallout.message_str(325, 113)
    end
    fallout.float_msg(self_obj, msg, 0)
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
    PaladinARandom()
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(325, 100))
end

function time_p_proc()
    PaladinABackground()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.time_p_proc = time_p_proc
return exports
