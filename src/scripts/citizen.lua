local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat_p_proc
local critter_p_proc
local damage_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Citizen01
local Citizen02
local Citizen03
local Citizen04
local CitizenEnd
local flee_dude

local hostile = 0
local initialized = false
local round_counter = 0
local DisplayMessage = 100
local PsstTime = 0

local exit_line = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
        initialized = true
    else
        if fallout.script_action() == 13 then
            combat_p_proc()
        else
            if fallout.script_action() == 12 then
                critter_p_proc()
            else
                if fallout.script_action() == 3 then
                    description_p_proc()
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
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
        if round_counter > 3 then
            if fallout.global_var(246) == 0 then
                fallout.set_global_var(246, 1)
                fallout.set_global_var(155, fallout.global_var(155) - 5)
            end
        end
    end
end

function critter_p_proc()
    local v0 = 0
    if hostile then
        hostile = 1
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(4) and (fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < 8) then
            flee_dude()
        end
        v0 = fallout.global_var(343)
        if ((time.game_time_in_seconds() - v0) >= 10) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 4) and (fallout.global_var(246) == 0) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(115, fallout.random(110, 114)), 0)
            v0 = time.game_time_in_seconds()
            fallout.set_global_var(343, v0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(4, 1)
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(115, 100))
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(115, 100))
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.local_var(4) or fallout.global_var(246) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 0)
    else
        fallout.start_gdialog(115, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Citizen01()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function timed_event_p_proc()
    if fallout.obj_on_screen(fallout.self_obj()) then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(1, 5)), 0)
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
end

function Citizen01()
    DisplayMessage = 105
    fallout.gsay_reply(115, 101)
    fallout.giq_option(4, 115, 103, Citizen02, 50)
    fallout.giq_option(4, 115, 102, CitizenEnd, 50)
    fallout.giq_option(-3, 115, 104, CitizenEnd, 50)
end

function Citizen02()
    fallout.gsay_reply(115, DisplayMessage)
    fallout.giq_option(4, 115, 106, Citizen03, 50)
    fallout.giq_option(4, 115, 107, Citizen04, 50)
    exit_line = reaction.Goodbyes()
    fallout.giq_option(1, 115, exit_line, CitizenEnd, 50)
end

function Citizen03()
    DisplayMessage = 108
    Citizen02()
end

function Citizen04()
    DisplayMessage = 109
    Citizen02()
end

function CitizenEnd()
end

function flee_dude()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    while v1 < 5 do
        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)) > v2 then
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)
            v2 = fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), v0)
        end
        v1 = v1 + 1
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 1)
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
