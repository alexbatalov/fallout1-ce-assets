local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local hostile = false
local initialized = false
local scared = false

local start
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc

function start()
    if not initialized then
        misc.set_team(fallout.self_obj(), 35)
        misc.set_ai(fallout.self_obj(), fallout.random(15, 19))
        hostile = fallout.global_var(334) ~= 0
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
        if scared then
            behaviour.flee_dude(1)
        else
            if hostile then
                hostile = false
                scared = true
                fallout.set_global_var(334, 1)
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_external_var("random_seed_2", 1)
    end
end

function pickup_p_proc()
    if not scared then
        hostile = true
        fallout.set_global_var(334, 1)
    end
end

function talk_p_proc()
    if scared then
        if fallout.external_var("random_seed_2") ~= 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(756, 103), 2)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(756, 104), 3)
        end
    else
        if fallout.external_var("random_seed_2") ~= 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(756, 102), 2)
        else
            if fallout.external_var("random_seed_1") == 0 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(756, 100), 4)
            else
                fallout.float_msg(fallout.self_obj(), fallout.message_str(756, 101), 3)
            end
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
