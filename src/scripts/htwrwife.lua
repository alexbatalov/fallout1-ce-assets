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
local combat_p_proc
local Wife01
local Wife02
local Wife03
local Wife04

local hostile = 0
local initialized = false
local visible = 1

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        if fallout.global_var(111) == 5 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            visible = 0
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 42)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 5)
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
                        else
                            if fallout.script_action() == 13 then
                                combat_p_proc()
                            end
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
            if time.is_morning() or time.is_day() then
                if fallout.tile_num(fallout.self_obj()) ~= 22114 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 22114, 0)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= 25108 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 25108, 0)
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
    if time.is_night() then
        Wife03()
    else
        if fallout.global_var(248) == 1 then
            Wife04()
        else
            if fallout.local_var(4) == 0 then
                fallout.set_local_var(4, 1)
                Wife01()
            else
                Wife02()
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    fallout.set_map_var(0, fallout.map_var(0) + 1)
    if fallout.map_var(0) > 1 then
        fallout.set_global_var(111, 2)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(584, 100))
end

function damage_p_proc()
    fallout.set_map_var(5, 1)
    fallout.set_global_var(111, 5)
end

function combat_p_proc()
    fallout.critter_set_flee_state(fallout.self_obj(), 1)
end

function Wife01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(584, 101), 2)
end

function Wife02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(584, 102), 2)
end

function Wife03()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(584, fallout.random(103, 105)), 2)
end

function Wife04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(584, 106), 2)
    combat()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.damage_p_proc = damage_p_proc
exports.combat_p_proc = combat_p_proc
return exports
