local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
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

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.map_var(18) ~= 0 then
        if fallout.map_var(18) ~= fallout.local_var(5) then
            fallout.set_local_var(5, fallout.map_var(18))
            if fallout.map_var(18) > 2 then
                fallout.float_msg(self_obj, fallout.message_str(618, 201), 3)
                hostile = true
            else
                fallout.float_msg(self_obj, fallout.message_str(618, 200), 3)
            end
        end
    end
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(self_obj, dude_obj) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    local rnd = fallout.random(1, 9)
    local message
    if rnd == 1 then
        message = fallout.message_str(618, 101)
    elseif rnd == 2 then
        message = fallout.message_str(618, 102)
    elseif rnd == 3 then
        message = fallout.message_str(618, 103)
    elseif rnd == 4 then
        message = fallout.message_str(618, 104)
    elseif rnd == 5 then
        message = fallout.message_str(618, 105)
    elseif rnd == 6 then
        message = fallout.message_str(618, 106)
    elseif rnd == 7 then
        message = fallout.message_str(618, 107)
    elseif rnd == 8 then
        message = fallout.message_str(618, 108)
    elseif rnd == 9 then
        message = fallout.message_str(618, 110) ..
            fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(618, 111)
    end
    fallout.float_msg(fallout.self_obj(), message, 0)
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(618, 100))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
