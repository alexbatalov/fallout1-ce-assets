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

local only_once = 1
local hostile = 0

function start()
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(300), 1)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            end
        end
    end
    if fallout.script_action() == 22 then
        time_p_proc()
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

function PaladinARandom()
    local v0 = 0
    local v1 = 0
    if not(v0) then
        v0 = fallout.random(1, 9)
    end
    if v0 > 10 then
        v0 = 1
    end
    v1 = fallout.message_str(325, 101)
    if v0 == 2 then
        v1 = fallout.message_str(325, 102)
    else
        if v0 == 3 then
            v1 = fallout.message_str(325, 103)
        else
            if v0 == 4 then
                v1 = fallout.message_str(325, 104) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(325, 105)
            else
                if v0 == 5 then
                    v1 = fallout.message_str(325, 106)
                else
                    if v0 == 6 then
                        v1 = fallout.message_str(325, 107)
                    else
                        if v0 == 7 then
                            v1 = fallout.message_str(325, 108)
                        else
                            if v0 == 8 then
                                v1 = fallout.message_str(325, 109)
                            else
                                if v0 == 9 then
                                    v1 = fallout.message_str(325, 110)
                                else
                                    v0 = 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    v0 = v0 + 1
    fallout.float_msg(fallout.self_obj(), v1, 0)
end

function PaladinABackground()
    local v0 = 0
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(300), 1)
    if fallout.random(0, 1) then
        v0 = fallout.message_str(325, 112)
    else
        v0 = fallout.message_str(325, 113)
    end
    fallout.float_msg(fallout.self_obj(), v0, 0)
end

function critter_p_proc()
    if fallout.global_var(250) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
    if hostile then
        fallout.set_global_var(250, 1)
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
