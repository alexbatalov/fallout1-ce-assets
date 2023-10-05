local fallout = require("fallout")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Flip00
local Flip01
local Flip02
local Flip03
local Flip03a
local Flip04
local Flip05
local FlipCombat
local transit
local FlipLeave

local known = 0
local hostile = 0
local initialized = 0
local round_counter = 0
local cell_tile = 23937
local home_tile = 14338

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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 43)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 4)
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
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
    end
    if round_counter > 2 then
        if fallout.global_var(146) == 0 then
            fallout.set_global_var(146, 1)
            fallout.set_map_var(7, 1)
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12) then
            if fallout.global_var(54) then
                Flip00()
            else
                if (fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) ~= 113) and (fallout.local_var(4) == 0) then
                    fallout.dialogue_system_enter()
                end
            end
        end
        if (fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), cell_tile, 0)
        else
            fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
        end
    end
end

function destroy_p_proc()
    fallout.set_map_var(8, 3)
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

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) then
        fallout.display_msg(fallout.message_str(367, 100))
    else
        fallout.display_msg(fallout.message_str(367, 101))
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    get_reaction()
    fallout.start_gdialog(367, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        Flip01()
    else
        if fallout.local_var(4) == 1 then
            Flip05()
        else
            Flip02()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            hostile = 1
        end
    else
        if fallout.fixed_param() == 2 then
            Flip00()
        end
    end
end

function Flip00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(367, 102), 0)
    FlipCombat()
end

function Flip01()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 1)
    fallout.gsay_message(367, 103, 50)
end

function Flip02()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(367, 104)
    fallout.giq_option(4, 367, 105, FlipCombat, 50)
    fallout.giq_option(4, 367, 106, transit, 50)
    fallout.giq_option(-3, 367, 107, FlipCombat, 50)
end

function Flip03()
    fallout.gsay_reply(367, 108)
    fallout.giq_option(4, 367, 109, transit, 50)
    fallout.giq_option(4, 367, 110, Flip03a, 50)
end

function Flip03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        FlipLeave()
    else
        Flip04()
    end
end

function Flip04()
    fallout.gsay_message(367, 111, 50)
    FlipCombat()
end

function Flip05()
    fallout.gsay_message(367, 112, 50)
    FlipCombat()
end

function FlipCombat()
    hostile = 1
end

function transit()
    fallout.set_global_var(57, 2)
    fallout.load_map(32, 5)
end

function FlipLeave()
    if fallout.tile_num(fallout.self_obj()) == home_tile then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(home_tile, 0, 5), 0)
    else
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), 5, 5), 0)
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 2)
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
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
