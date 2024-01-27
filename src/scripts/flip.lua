local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

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
local hostile = false
local initialized = false
local round_counter = 0
local cell_tile = 23937
local home_tile = 14338

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 43)
        fallout.critter_add_trait(self_obj, 1, 5, 4)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
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
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        local self_obj = fallout.self_obj()
        local dude_obj = fallout.dude_obj()
        if fallout.obj_can_see_obj(self_obj, dude_obj) and fallout.tile_distance_objs(self_obj, dude_obj) < 12 then
            if fallout.global_var(54) ~= 0 then
                Flip00()
            else
                if fallout.obj_pid(fallout.critter_inven_obj(dude_obj, 0)) ~= 113 and fallout.local_var(4) == 0 then
                    fallout.dialogue_system_enter()
                end
            end
        end
        if time.is_night() then
            fallout.animate_move_obj_to_tile(self_obj, cell_tile, 0)
        else
            fallout.animate_move_obj_to_tile(self_obj, home_tile, 0)
        end
    end
end

function destroy_p_proc()
    fallout.set_map_var(8, 3)
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) ~= 0 then
        fallout.display_msg(fallout.message_str(367, 100))
    else
        fallout.display_msg(fallout.message_str(367, 101))
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(367, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
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
    local event = fallout.fixed_param()
    if event == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            hostile = true
        end
    elseif event == 2 then
        Flip00()
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
    hostile = true
end

function transit()
    fallout.set_global_var(57, 2)
    fallout.load_map(32, 5)
end

function FlipLeave()
    local self_obj = fallout.self_obj()
    if fallout.tile_num(self_obj) == home_tile then
        fallout.animate_move_obj_to_tile(self_obj, fallout.tile_num_in_direction(home_tile, 0, 5), 0)
    else
        fallout.animate_move_obj_to_tile(self_obj,
            fallout.tile_num_in_direction(fallout.tile_num(self_obj), 5, 5), 0)
    end
    fallout.add_timer_event(self_obj, fallout.game_ticks(5), 2)
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
