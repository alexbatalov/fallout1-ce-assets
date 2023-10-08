local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc

local hostile = 0
local Only_Once = 1
local guardNumber = 0
local threatened = 0
local visible = 1

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        if fallout.tile_num(fallout.self_obj()) == 19511 then
            guardNumber = 1
        end
        if fallout.tile_num(fallout.self_obj()) == 19935 then
            guardNumber = 2
        end
        if fallout.global_var(111) == 5 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            visible = 0
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 42)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 16)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    else
                        if fallout.script_action() == 14 then
                            damage_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if visible == 0 then
        fallout.script_overrides()
    else
        if hostile then
            hostile = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.map_var(5) == 1 then
            if (fallout.obj_can_hear_obj(fallout.self_obj(), fallout.dude_obj()) == 1) or (fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) == 1) then
                combat()
            end
        else
            if time.is_night() then
                if (fallout.obj_can_hear_obj(fallout.self_obj(), fallout.dude_obj()) == 1) or (fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) == 1) and (threatened == 0) then
                    fallout.dialogue_system_enter()
                end
                if guardNumber == 1 then
                    if fallout.tile_num(fallout.self_obj()) ~= 17119 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 17119, 0)
                    end
                else
                    if guardNumber == 2 then
                        if fallout.tile_num(fallout.self_obj()) ~= 16930 then
                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 16930, 0)
                        end
                    end
                end
            else
                if guardNumber == 1 then
                    if fallout.tile_num(fallout.self_obj()) ~= 19511 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 19511, 0)
                    end
                else
                    if guardNumber == 2 then
                        if fallout.tile_num(fallout.self_obj()) ~= 19935 then
                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 19935, 0)
                        end
                    end
                end
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if (fallout.game_time_hour() > 700) and (fallout.game_time_hour() < 1900) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(583, fallout.random(101, 106)), 2)
    else
        threatened = 1
        fallout.float_msg(fallout.self_obj(), fallout.message_str(583, fallout.random(107, 109)), 2)
        combat()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(583, 100))
end

function damage_p_proc()
    fallout.set_map_var(5, 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.damage_p_proc = damage_p_proc
return exports
