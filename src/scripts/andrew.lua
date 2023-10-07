local fallout = require("fallout")

local start
local combat_p_proc
local critter_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local damage_p_proc
local destroy_p_proc
local Andrew01
local Andrew02
local Andrew03
local Andrew04
local Andrew05
local Andrew06

local hostile = 0
local round_counter = 0
local moving_flag = 1

local map_enter_p_proc

function start()
    if fallout.script_action() == 13 then
        combat_p_proc()
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 21 then
                look_at_p_proc()
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

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
    end
    if round_counter > 3 then
        if fallout.global_var(247) == 0 then
            fallout.set_global_var(247, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if (fallout.map_var(1) == 1) and ((fallout.game_time() // (10 * 60 * 60 * 24)) > fallout.map_var(5)) then
            if fallout.external_var("jail_door_ptr") ~= 0 then
                fallout.obj_unlock(fallout.external_var("jail_door_ptr"))
                fallout.use_obj(fallout.external_var("jail_door_ptr"))
                moving_flag = 0
                fallout.rm_timer_event(fallout.self_obj())
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
            end
            fallout.set_map_var(1, 0)
            fallout.float_msg(fallout.self_obj(), fallout.message_str(172, 101), 3)
        else
            if fallout.map_var(3) == 1 then
                fallout.set_map_var(3, fallout.map_var(3) + 1)
                fallout.float_msg(fallout.self_obj(), fallout.message_str(172, 116), 2)
            else
                if fallout.map_var(3) == 3 then
                    if fallout.external_var("jail_door_ptr") ~= 0 then
                        fallout.obj_unlock(fallout.external_var("jail_door_ptr"))
                    end
                    hostile = 1
                else
                    if moving_flag == 1 then
                        if fallout.tile_num(fallout.self_obj()) ~= fallout.local_var(1) then
                            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(1), 0)
                        end
                    end
                    if (fallout.global_var(247) == 1) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                        fallout.dialogue_system_enter()
                    end
                end
            end
        end
    end
end

function look_at_p_proc()
    if fallout.local_var(0) == 1 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(172, 100))
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.global_var(247) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(172, 102), 2)
        hostile = 1
    else
        fallout.start_gdialog(172, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Andrew01()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        fallout.obj_close(fallout.external_var("jail_door_ptr"))
        fallout.rm_timer_event(fallout.self_obj())
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 2)
    else
        if fallout.fixed_param() == 2 then
            moving_flag = 1
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
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

function Andrew01()
    fallout.gsay_reply(172, 103)
    fallout.giq_option(4, 172, 104, Andrew02, 50)
    fallout.giq_option(4, 172, 105, Andrew03, 50)
    fallout.giq_option(4, 172, 106, Andrew04, 50)
    fallout.giq_option(-3, 172, 113, Andrew06, 50)
end

function Andrew02()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(172, 107)
    fallout.giq_option(4, 172, 105, Andrew03, 50)
    fallout.giq_option(4, 172, 106, Andrew04, 50)
end

function Andrew03()
    fallout.gsay_reply(172, 108)
    fallout.giq_option(6, 172, 109, Andrew05, 50)
    fallout.giq_option(4, 172, 110, Andrew04, 50)
end

function Andrew04()
    fallout.gsay_message(172, 111, 50)
end

function Andrew05()
    fallout.gsay_reply(172, 112)
    fallout.giq_option(4, 172, 110, Andrew04, 50)
end

function Andrew06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(172, 114, 50)
    else
        fallout.gsay_message(172, 115, 50)
    end
end

function map_enter_p_proc()
    if fallout.global_var(15) == 1 then
        fallout.kill_critter(fallout.self_obj(), 49)
    end
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 12)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 17)
    if fallout.local_var(1) == 0 then
        fallout.set_local_var(1, fallout.tile_num(fallout.self_obj()))
    end
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
return exports
