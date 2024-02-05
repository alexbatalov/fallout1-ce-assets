local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local timed_event_p_proc

local hostile = false
local initialized = false
local maxleash = 9
local noevent = false
local loopcount = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.local_var(1) == 0 then
            fallout.set_local_var(1, fallout.tile_num(self_obj))
            fallout.set_local_var(0, 1)
            if fallout.cur_map_index() == 9 then
                fallout.set_local_var(3, 1)
            end
        end
        misc.set_team(self_obj, 87)
        fallout.critter_add_trait(self_obj, 1, 5, 93)
        fallout.critter_injure(self_obj, 4)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 13 then
        damage_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(32, 105 + fallout.random(0, 3)), 7)
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.obj_can_see_obj(self_obj, dude_obj) and (fallout.tile_distance_objs(self_obj, dude_obj) < 3) then
        hostile = true
    end
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(0) ~= 0 then
            loopcount = loopcount + 1
            if loopcount > 40 then
                loopcount = 0
                if not noevent then
                    noevent = true
                    fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(10, 15)), 0)
                end
            end
        end
    end
end

function damage_p_proc()
    if fallout.local_var(3) ~= 0 then
        if fallout.fixed_param() == 2 then
            local rads = fallout.random(1, 6) - 5
            if rads < 0 then
                rads = 0
            end
            if rads > 0 then
                fallout.radiation_inc(fallout.target_obj(), rads)
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.obj_on_screen(self_obj) then
        noevent = false
        fallout.set_local_var(2, fallout.tile_num(self_obj))
        local new_tile = fallout.tile_num_in_direction(fallout.local_var(2), fallout.random(0, 5), fallout.random(1, 5))
        if fallout.tile_distance(fallout.local_var(1), new_tile) < maxleash then
            if fallout.random(0, 1) > 0 then
                fallout.float_msg(self_obj, fallout.message_str(32, 105 + fallout.random(0, 3)), 7)
            end
            fallout.animate_move_obj_to_tile(self_obj, new_tile, 0)
        end
    else
        critter_p_proc()
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
