local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local VGateMut00
local VGateMut03
local VGateMut03a
local VGateMut03b
local VGateMut04
local VGateMut05
local VGateMut06
local VGateMut07
local VGateMut08
local VGateMutAlert
local VGateMutxx

local initialized = 0
local hostile = 0
local round_count = 0
local gate_tile = 22106
local guard_tile = 20902
local home_tile = 7000
local waypoint = 0

local exit_line = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 49)
        if fallout.map_var(0) then
            fallout.move_to(fallout.self_obj(), home_tile, 0)
        else
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 1)
        end
        initialized = 1
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
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_count = round_count + 1
    end
    if round_count > 2 then
        VGateMutAlert()
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if hostile then
            hostile = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.global_var(146) then
                hostile = 1
            else
                if not(fallout.external_var("ignoring_dude")) then
                    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12 then
                        fallout.dialogue_system_enter()
                    end
                end
            end
        end
    end
    if fallout.map_var(0) then
        if not(waypoint) then
            if fallout.tile_num(fallout.self_obj()) ~= 22312 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), 22312, 0)
            else
                waypoint = 1
            end
        else
            if waypoint == 1 then
                if fallout.tile_num(fallout.self_obj()) ~= 26317 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 26317, 0)
                else
                    waypoint = 2
                end
            else
                if waypoint == 2 then
                    if fallout.tile_num(fallout.self_obj()) ~= 31517 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 32319, 0)
                    else
                        waypoint = 3
                    end
                else
                    if waypoint == 3 then
                        fallout.set_external_var("removal_ptr", fallout.self_obj())
                    end
                end
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.global_var(54) then
        VGateMut08()
    else
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and not(hostile) then
            if fallout.random(0, 5) == 5 then
                VGateMut00()
            else
                hostile = 1
            end
        else
            fallout.start_gdialog(433, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            VGateMut03()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function timed_event_p_proc()
    if not(fallout.map_var(0)) then
        if fallout.tile_num(fallout.self_obj()) == guard_tile then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), gate_tile, 0)
        else
            fallout.animate_move_obj_to_tile(fallout.self_obj(), guard_tile, 0)
        end
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 1)
    end
end

function VGateMut00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(101, 103)), 2)
    hostile = 1
end

function VGateMut03()
    fallout.gsay_reply(433, fallout.random(104, 106))
    fallout.giq_option(-3, 433, 107, VGateMut04, 51)
    fallout.giq_option(4, 433, 108, VGateMut04, 51)
    fallout.giq_option(5, 433, 109, VGateMut05, 50)
    fallout.giq_option(6, 433, 110, VGateMut03a, 50)
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        fallout.giq_option(6, 433, 111, VGateMut03b, 50)
    end
end

function VGateMut03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        VGateMut07()
    else
        VGateMut06()
    end
end

function VGateMut03b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 25)) then
        VGateMut07()
    else
        VGateMut06()
    end
end

function VGateMut04()
    hostile = 1
    fallout.gsay_message(433, fallout.random(112, 114), 51)
end

function VGateMut05()
    fallout.gsay_reply(433, 115)
    fallout.giq_option(5, 433, 116, VGateMutxx, 50)
    fallout.giq_option(5, 433, 117, VGateMutAlert, 51)
end

function VGateMut06()
    hostile = 1
    fallout.gsay_message(433, fallout.random(118, 120), 51)
end

function VGateMut07()
    fallout.set_external_var("ignoring_dude", 1)
    fallout.gsay_message(433, fallout.random(121, 123), 50)
end

function VGateMut08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(124, 127)), 2)
    hostile = 1
end

function VGateMutAlert()
    fallout.set_global_var(146, 1)
    hostile = 1
end

function VGateMutxx()
    fallout.set_global_var(57, 2)
    fallout.load_map(32, 5)
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
