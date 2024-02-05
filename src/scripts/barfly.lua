local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local damage_p_proc
local destroy_p_proc

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = false

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    behaviour.sleeping(0, night_person, wake_time, sleep_time, home_tile, sleep_tile)
    local game_time_hour = fallout.game_time_hour()
    if game_time_hour > wake_time + 20 or game_time_hour < sleep_time then
        if fallout.tile_num(self_obj) ~= home_tile then
            fallout.animate_move_obj_to_tile(self_obj, home_tile, 0)
        end
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.global_var(15) == 1 then
        fallout.destroy_object(self_obj)
    end
    night_person = true
    wake_time = fallout.random(1610, 1640)
    sleep_time = fallout.random(310, 340)
    sleep_tile = 7000
    home_tile = 20675
    misc.set_team(self_obj, 26)
    fallout.critter_add_trait(self_obj, 1, 5, 5)
    if fallout.map_var(2) == 1 then
        fallout.destroy_object(self_obj)
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(473, fallout.random(100, 106)), 0)
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
