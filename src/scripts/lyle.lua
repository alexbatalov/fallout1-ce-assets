local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local Lyle01
local Lyle02
local Lyle03
local Lyle04
local LyleEnd

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
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(5) ~= 0 then
            local self_obj = fallout.self_obj()
            if fallout.tile_distance_objs(self_obj, dude_obj) < 8 then
                behaviour.flee_dude(1)
            else
                if fallout.tile_distance(fallout.tile_num(dude_obj), home_tile) > 4 then
                    if fallout.local_var(4) == 0 then
                        fallout.animate_move_obj_to_tile(self_obj, home_tile, 0)
                    end
                end
            end
        end
    end
    behaviour.sleeping(4, night_person, wake_time, sleep_time, home_tile, sleep_tile)
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(5, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(261, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(507, 100))
end

function map_enter_p_proc()
    misc.set_team(fallout.self_obj(), 1)
    sleep_time = 1920
    wake_time = 710
    home_tile = 24911
    sleep_tile = home_tile
end

function pickup_p_proc()
    if time.game_time_in_days() >= 30 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(507, 101), 0)
    end
    fallout.set_global_var(261, 1)
    hostile = true
end

function talk_p_proc()
    if fallout.local_var(4) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    elseif fallout.global_var(261) ~= 0 or fallout.local_var(5) ~= 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(507, 114), 0)
    elseif fallout.global_var(101) == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(507, 102), 0)
    elseif fallout.global_var(188) == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(507, 113), 0)
    else
        fallout.start_gdialog(507, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Lyle01()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function Lyle01()
    fallout.gsay_reply(507,
        fallout.message_str(507, 103) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(507, 104))
    fallout.giq_option(4, 507, 105, Lyle02, 50)
    fallout.giq_option(-3, 507, 107, LyleEnd, 50)
end

function Lyle02()
    if time.game_time_in_days() < 30 then
        fallout.gsay_message(507, 106, 50)
    else
        fallout.gsay_reply(507, 108)
        fallout.giq_option(4, 507, 109, Lyle03, 50)
        fallout.giq_option(4, 507, 110, Lyle04, 49)
    end
end

function Lyle03()
    fallout.gsay_message(507, 111, 50)
end

function Lyle04()
    fallout.set_global_var(188, 1)
    fallout.gsay_message(507, 112, 49)
end

function LyleEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
