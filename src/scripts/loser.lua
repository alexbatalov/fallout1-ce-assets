local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc

local hostile = 0
local initialized = false
local round_counter = 0
local PsstTime = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(15, 60)), 1)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
        initialized = true
    else
        if fallout.script_action() == 13 then
            combat_p_proc()
        else
            if fallout.script_action() == 12 then
                critter_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
                else
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
                end
            end
        end
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
        if round_counter > 3 then
            if (fallout.global_var(246) == 0) and ((fallout.cur_map_index() == 26) or (fallout.cur_map_index() == 25)) then
                fallout.set_global_var(246, 1)
                fallout.set_global_var(155, fallout.global_var(155) - 5)
            end
        end
    end
end

function critter_p_proc()
    local v0 = 0
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(0) ~= 0 then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
                behaviour.flee_dude(1)
            end
        end
    end
    v0 = fallout.global_var(343)
    if ((time.game_time_in_seconds() - v0) >= 10) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 4) and (fallout.global_var(246) == 0) and ((fallout.cur_map_index() == 26) or (fallout.cur_map_index() == 25)) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(115, fallout.random(110, 114)), 0)
        v0 = time.game_time_in_seconds()
        fallout.set_global_var(343, v0)
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(0, 1)
    end
end

function destroy_p_proc()
    if (fallout.source_obj() == fallout.dude_obj()) and ((fallout.cur_map_index() == 26) or (fallout.cur_map_index() == 25)) then
        fallout.set_global_var(246, 1)
    end
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(9, 100))
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.local_var(0) or fallout.global_var(246) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 0)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(9, fallout.random(101, 106)), 0)
    end
end

function timed_event_p_proc()
    if fallout.obj_on_screen(fallout.self_obj()) then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(1, 5)), 0)
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(6, 10)), 1)
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
