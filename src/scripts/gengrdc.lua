local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local map_update_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local flee_dude

local hostile = 0
local initialized = false
local scared = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 23 then
                map_update_p_proc()
            else
                if fallout.script_action() == 4 then
                    pickup_p_proc()
                else
                    if fallout.script_action() == 11 then
                        talk_p_proc()
                    else
                        if fallout.script_action() == 22 then
                            timed_event_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if scared then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
            flee_dude()
        end
    else
        if hostile then
            hostile = 0
            scared = 1
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.global_var(289) == 1 then
                hostile = 1
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    fallout.set_global_var(289, 1)
end

function map_update_p_proc()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 15 + fallout.random(0, 4))
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 3)), 1)
        hostile = fallout.global_var(334)
        initialized = true
    end
end

function pickup_p_proc()
    if scared == 0 then
        hostile = 1
        fallout.set_global_var(334, 1)
    end
end

function talk_p_proc()
    if scared then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(755, fallout.random(100, 105)), 3)
    end
end

function timed_event_p_proc()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(3, 5)), 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(0, 3)), 1)
end

function flee_dude()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    while v1 < 5 do
        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)) > v2 then
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)
            v2 = fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), v0)
        end
        v1 = v1 + 1
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
