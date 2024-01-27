local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local talk_p_proc
local timed_event_p_proc
local damage_p_proc
local gambler1
local gambler2
local gambler3
local gambler4
local gambler5

local hostile = false
local weapon_check = false

local pickup_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if misc.is_armed(dude_obj) then
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            if fallout.tile_distance_objs(self_obj, dude_obj) < 12 then
                if not (weapon_check) then
                    fallout.dialogue_system_enter()
                    fallout.add_timer_event(self_obj, fallout.game_ticks(600), 1)
                end
            end
        end
    end
    if hostile then
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
    end
    if fallout.cur_map_index() == 11 then
        if fallout.global_var(104) == 2 or fallout.global_var(38) == 1 then
            fallout.destroy_object(self_obj)
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(351, 100))
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.local_var(0) == 0 then
        fallout.set_local_var(0, fallout.tile_num(self_obj))
    end
    if fallout.obj_is_carrying_obj_pid(self_obj, 41) == 0 then
        fallout.item_caps_adjust(self_obj, fallout.random(0, 200))
    end
    if fallout.cur_map_index() == 11 then
        fallout.critter_add_trait(self_obj, 1, 6, 24)
        if fallout.global_var(104) == 2 or fallout.global_var(38) == 1 then
            fallout.destroy_object(self_obj)
        end
    end
end

function talk_p_proc()
    fallout.script_overrides()

    local dude_obj = fallout.dude_obj()
    if misc.is_armed(dude_obj) then
        gambler1()
    elseif fallout.global_var(158) > 2 then
        gambler3()
    elseif fallout.global_var(105) == 2 then
        gambler4()
    elseif fallout.global_var(155) < -10 then
        gambler2()
    else
        gambler5()
    end
end

function timed_event_p_proc()
    weapon_check = false
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function gambler1()
    weapon_check = true
    local rnd = fallout.random(1, 3)
    if rnd == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 101), 0)
    elseif rnd == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 102), 0)
    elseif rnd == 3 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 103), 0)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 104), 0)
        end
    end
end

function gambler2()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(351, fallout.random(105, 107)), 0)
end

function gambler3()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(351, fallout.random(108, 110)), 0)
end

function gambler4()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(351, fallout.random(111, 113)), 0)
end

function gambler5()
    local rnd = fallout.random(1, 6)
    if rnd == 1 then
        if time.is_day() then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 114), 0)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 115), 0)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 114 + rnd), 0)
    end
end

function pickup_p_proc()
    hostile = true
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.damage_p_proc = damage_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
