local fallout = require("fallout")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local VFenceMt00
local VFenceMt03
local VFenceMt03a
local VFenceMt03b
local VFenceMt04
local VFenceMt05
local VFenceMt06
local VFenceMt07
local VFenceMt08
local VFenceMtAlert
local VFenceMtxx

local initialized = 0
local hostile = 0
local round_count = 0
local home_tile = 7000
local fence_tile_1 = 16706
local fence_tile_2 = 25705
local waypoint = 0

local get_reaction
local ReactToLevel
local LevelToReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

local exit_line = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 1)
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
        VFenceMtAlert()
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
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.global_var(54) then
        VFenceMt08()
    else
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and not(hostile) then
            if fallout.random(0, 5) == 5 then
                VFenceMt00()
            else
                hostile = 1
            end
        else
            fallout.start_gdialog(433, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            VFenceMt03()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function timed_event_p_proc()
    if not(fallout.map_var(0)) then
        if fallout.tile_num(fallout.self_obj()) == fence_tile_1 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fence_tile_2, 0)
        else
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fence_tile_1, 0)
        end
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60), 1)
    end
end

function VFenceMt00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(101, 103)), 2)
    hostile = 1
end

function VFenceMt03()
    fallout.gsay_reply(433, fallout.random(104, 106))
    fallout.giq_option(-3, 433, 107, VFenceMt04, 51)
    fallout.giq_option(4, 433, 108, VFenceMt04, 51)
    fallout.giq_option(5, 433, 109, VFenceMt05, 50)
    fallout.giq_option(6, 433, 110, VFenceMt03a, 50)
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        fallout.giq_option(6, 433, 111, VFenceMt03b, 50)
    end
end

function VFenceMt03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        VFenceMt07()
    else
        VFenceMt06()
    end
end

function VFenceMt03b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 25)) then
        VFenceMt07()
    else
        VFenceMt06()
    end
end

function VFenceMt04()
    hostile = 1
    fallout.gsay_message(433, fallout.random(112, 114), 51)
end

function VFenceMt05()
    fallout.gsay_reply(433, 115)
    fallout.giq_option(5, 433, 116, VFenceMtxx, 50)
    fallout.giq_option(5, 433, 117, VFenceMtAlert, 51)
end

function VFenceMt06()
    hostile = 1
    fallout.gsay_message(433, fallout.random(118, 120), 51)
end

function VFenceMt07()
    fallout.set_external_var("ignoring_dude", 1)
    fallout.gsay_message(433, fallout.random(121, 123), 50)
end

function VFenceMt08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(124, 127)), 2)
    hostile = 1
end

function VFenceMtAlert()
    fallout.set_global_var(146, 1)
    hostile = 1
end

function VFenceMtxx()
    fallout.set_global_var(57, 2)
    fallout.load_map(32, 5)
end

function get_reaction()
    if fallout.local_var(2) == 0 then
        fallout.set_local_var(0, 50)
        fallout.set_local_var(1, 2)
        fallout.set_local_var(2, 1)
        fallout.set_local_var(0, fallout.local_var(0) + (5 * fallout.get_critter_stat(fallout.dude_obj(), 3)) - 25)
        fallout.set_local_var(0, fallout.local_var(0) + (10 * fallout.has_trait(0, fallout.dude_obj(), 10)))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            end
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            end
        end
        if fallout.global_var(158) > 2 then
            fallout.set_local_var(0, fallout.local_var(0) - 30)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) - 20)
        end
        ReactToLevel()
    end
end

function ReactToLevel()
    if fallout.local_var(0) <= 25 then
        fallout.set_local_var(1, 1)
    else
        if fallout.local_var(0) <= 75 then
            fallout.set_local_var(1, 2)
        else
            fallout.set_local_var(1, 3)
        end
    end
end

function LevelToReact()
    if fallout.local_var(1) == 1 then
        fallout.set_local_var(0, fallout.random(1, 25))
    else
        if fallout.local_var(1) == 2 then
            fallout.set_local_var(0, fallout.random(26, 75))
        else
            fallout.set_local_var(0, fallout.random(76, 100))
        end
    end
end

function UpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 10)
    ReactToLevel()
end

function DownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 10)
    ReactToLevel()
end

function BottomReact()
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function TopReact()
    fallout.set_local_var(0, 100)
    fallout.set_local_var(1, 3)
end

function BigUpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 25)
    ReactToLevel()
end

function BigDownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 25)
    ReactToLevel()
end

function UpReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(1, 3)
    end
    LevelToReact()
end

function DownReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) - 1)
    if fallout.local_var(1) < 1 then
        fallout.set_local_var(1, 1)
    end
    LevelToReact()
end

function Goodbyes()
    exit_line = fallout.message_str(634, fallout.random(100, 105))
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
