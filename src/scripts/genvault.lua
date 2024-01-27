local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Vault00
local Vault00a
local Vault00b
local Vault00c
local Vault01
local Vault02
local Vault03
local Vault04
local Vault05
local Vault06
local Vault07
local Vault08
local Vault09
local Vault10
local Vault11
local get_rations
local set_ration_tile
local set_sleep_tile

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = false
local sleeping_disabled = false
local ration_tile = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        local self_obj = fallout.self_obj()
        if fallout.local_var(7) and (fallout.tile_distance_objs(self_obj, dude_obj) < 8) then
            behaviour.flee_dude(1)
        end
        if fallout.global_var(101) == 0 then
            if fallout.local_var(5) == 0 then
                local self_elevation = fallout.elevation(self_obj)
                if self_elevation == fallout.elevation(fallout.external_var("WtrGrd_ptr"))
                    and self_elevation == fallout.elevation(dude_obj) then
                    if fallout.game_time_hour() > 700 and fallout.game_time_hour() < 900 then
                        get_rations()
                    end
                end
            end
        end
        if not time.is_day() then
            sleeping_disabled = false
            fallout.set_local_var(5, 0)
        end
        if not sleeping_disabled then
            behaviour.sleeping(6, night_person, wake_time, sleep_time, home_tile, sleep_tile)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(7, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(261, 1)
    end
end

function map_enter_p_proc()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, fallout.tile_num(fallout.self_obj()))
    end
    home_tile = fallout.local_var(4)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 1)
    set_ration_tile()
    set_sleep_tile()
    sleep_time = fallout.random(1900, 1930)
    wake_time = sleep_time - 1300
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(6) ~= 0 then
        if fallout.random(0, 1) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
        else
            fallout.display_msg(fallout.message_str(185, 167))
        end
    elseif fallout.local_var(7) ~= 0 or fallout.global_var(261) ~= 0 then
        Vault00()
    elseif fallout.global_var(101) ~= 0 and fallout.global_var(101) ~= 1 then
        Vault01()
    elseif misc.is_armed(fallout.dude_obj()) then
        Vault02()
    elseif fallout.global_var(10) < 80 then
        Vault00b()
    elseif fallout.global_var(10) < 40 then
        Vault00c()
    else
        Vault00a()
    end
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(),
            fallout.tile_num_in_direction(fallout.tile_num(fallout.external_var("WtrGrd_ptr")), 2, 1), 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 2)
    elseif event == 2 then
        fallout.set_external_var("getting_ration", 1)
        if fallout.random(0, 1) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 165), 0)
        end
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 3)
    elseif event == 3 then
        fallout.set_external_var("recipient", nil)
        fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
    end
end

function Vault00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(101, 104)), 0)
end

function Vault00a()
    if fallout.local_var(1) == 3 then
        Vault03()
    elseif fallout.local_var(1) == 2 then
        Vault06()
    else
        Vault09()
    end
end

function Vault00b()
    if fallout.local_var(1) == 3 then
        Vault04()
    elseif fallout.local_var(1) == 2 then
        Vault07()
    else
        Vault10()
    end
end

function Vault00c()
    if fallout.local_var(1) == 3 then
        Vault05()
    elseif fallout.local_var(1) == 2 then
        Vault08()
    else
        Vault11()
    end
end

function Vault01()
    local rnd = fallout.random(1, 5)
    if rnd == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 109), 0)
    elseif rnd == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 110), 0)
    elseif rnd == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 111), 0)
    elseif rnd == 4 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 112), 0)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 113), 0)
        end
    elseif rnd == 5 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 114), 0)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 115), 0)
        end
    end
end

function Vault02()
    reaction.DownReact()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(116, 119)), 0)
end

function Vault03()
    local rnd = fallout.random(1, 4)
    if rnd == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 120), 0)
    elseif rnd == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 121), 0)
    elseif rnd == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 122), 0)
    elseif rnd == 4 then
        fallout.float_msg(fallout.self_obj(),
            fallout.message_str(185, 123) ..
            fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(0, 124), 0)
    end
end

function Vault04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(125, 128)), 0)
end

function Vault05()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(129, 133)), 0)
end

function Vault06()
    local rnd = fallout.random(1, 5)
    if rnd == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 134), 0)
    elseif rnd == 2 then
        fallout.float_msg(fallout.self_obj(),
            fallout.message_str(185, 135) ..
            fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(185, 136), 0)
    elseif rnd == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 137), 0)
    elseif rnd == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 138), 0)
    elseif rnd == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 139), 0)
    end
end

function Vault07()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(140, 144)), 0)
end

function Vault08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(145, 149)), 0)
end

function Vault09()
    local rnd = fallout.random(1, 5)
    if rnd == 1 then
        fallout.float_msg(fallout.self_obj(),
            fallout.message_str(185, 150) ..
            fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(185, 151), 0)
    elseif rnd >= 4 then
        fallout.display_msg(fallout.message_str(185, 150 + rnd))
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 150 + rnd), 0)
    end
end

function Vault10()
    local rnd = fallout.random(1, 5)
    if rnd == 5 then
        fallout.display_msg(fallout.message_str(185, 160))
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 155 + rnd), 0)
    end
end

function Vault11()
    local rnd = fallout.random(1, 5)
    if rnd == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 161), 0)
    elseif rnd == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 162), 0)
    elseif rnd == 3 then
        fallout.display_msg(fallout.message_str(185, 163))
    elseif rnd == 4 then
        fallout.display_msg(fallout.message_str(185, 164))
    end
    -- FIXME: Missing 5.
end

function get_rations()
    local self_obj = fallout.self_obj()
    sleeping_disabled = true
    if fallout.tile_num(self_obj) ~= ration_tile then
        if fallout.random(0, 1) then
            fallout.animate_move_obj_to_tile(self_obj, ration_tile, 0)
        else
            fallout.animate_move_obj_to_tile(self_obj, ration_tile, 1)
        end
    else
        if fallout.external_var("recipient") == nil then
            fallout.set_external_var("recipient", self_obj)
            fallout.add_timer_event(self_obj, fallout.game_ticks(3), 1)
            fallout.set_local_var(5, 1)
            sleeping_disabled = false
        end
    end
end

function set_ration_tile()
    local self_elevation = fallout.elevation(fallout.self_obj())
    if self_elevation == 0 then
        ration_tile = fallout.tile_num_in_direction(14704, fallout.random(0, 5), fallout.random(1, 2))
    elseif self_elevation == 1 then
        ration_tile = fallout.tile_num_in_direction(21895, fallout.random(0, 5), fallout.random(1, 2))
    elseif self_elevation == 2 then
        ration_tile = fallout.tile_num_in_direction(22513, fallout.random(0, 5), fallout.random(1, 2))
    end
end

function set_sleep_tile()
    local self_elevation = fallout.elevation(fallout.self_obj())
    if self_elevation == 0 then
        sleep_tile = 7000
    elseif self_elevation == 1 then
        sleep_tile = home_tile
    elseif self_elevation == 2 then
        sleep_tile = 7000
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
