local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local critter_p_proc
local destroy_p_proc
local timed_event_p_proc

local hostile = false
local initialized = false
local maxleash = 10

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.local_var(3) == 0 then
            fallout.set_local_var(3, fallout.tile_num(self_obj))
            fallout.set_local_var(1, 1)
        end
        fallout.critter_add_trait(self_obj, 1, 6, 32)
        fallout.critter_add_trait(self_obj, 1, 5, 64)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then

    end
end

function pickup_p_proc()
    hostile = true
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
    else
        if fallout.local_var(1) ~= 0 then
            if fallout.random(1, 20) < 2 then
                if fallout.random(1, 10) < 2 then
                    fallout.use_obj(fallout.external_var("table_ptr"))
                else
                    timed_event_p_proc()
                end
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    fallout.set_local_var(4, fallout.tile_num(self_obj))
    local new_tile = fallout.tile_num_in_direction(fallout.local_var(4), fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(3), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(self_obj, new_tile, 0)
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
