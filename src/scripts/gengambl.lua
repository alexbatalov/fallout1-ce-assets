local fallout = require("fallout")

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

local hostile = 0
local weapon_check = 0

local pickup_p_proc

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 21 then
                look_at_p_proc()
            else
                if fallout.script_action() == 15 then
                    map_enter_p_proc()
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
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12 then
                if not(weapon_check) then
                    fallout.dialogue_system_enter()
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(600), 1)
                end
            end
        end
    end
    if hostile then
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
    if fallout.cur_map_index() == 11 then
        if (fallout.global_var(104) == 2) or (fallout.global_var(38) == 1) then
            fallout.destroy_object(fallout.self_obj())
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        if fallout.source_obj() == fallout.dude_obj() then
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                fallout.set_global_var(156, 1)
                fallout.set_global_var(157, 0)
            end
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                fallout.set_global_var(157, 1)
                fallout.set_global_var(156, 0)
            end
            fallout.set_global_var(159, fallout.global_var(159) + 1)
            if (fallout.global_var(159) % 2) == 0 then
                fallout.set_global_var(155, fallout.global_var(155) - 1)
            end
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(351, 100))
end

function map_enter_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.set_local_var(0, fallout.tile_num(fallout.self_obj()))
    end
    if not(fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41)) then
        fallout.item_caps_adjust(fallout.self_obj(), fallout.random(0, 200))
    end
    if fallout.cur_map_index() == 11 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 24)
        if (fallout.global_var(104) == 2) or (fallout.global_var(38) == 1) then
            fallout.destroy_object(fallout.self_obj())
        end
    end
end

function talk_p_proc()
    fallout.script_overrides()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        gambler1()
    else
        if fallout.global_var(158) > 2 then
            gambler3()
        else
            if fallout.global_var(105) == 2 then
                gambler4()
            else
                if fallout.global_var(155) < -10 then
                    gambler2()
                else
                    gambler5()
                end
            end
        end
    end
end

function timed_event_p_proc()
    weapon_check = 0
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function gambler1()
    local v0 = 0
    weapon_check = 1
    v0 = fallout.random(1, 3)
    if v0 == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 101), 0)
    else
        if v0 == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 102), 0)
        else
            if v0 == 3 then
                if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 103), 0)
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 104), 0)
                end
            end
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
    local v0 = 0
    v0 = fallout.random(1, 6)
    if v0 == 1 then
        if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 114), 0)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 115), 0)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(351, 114 + v0), 0)
    end
end

function pickup_p_proc()
    hostile = 1
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
