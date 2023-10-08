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
local George01
local George01a
local George01b
local George02
local George02a
local George03
local George04
local George05
local George06
local George07
local George08
local GeorgeEnd

local hostile = 0
local Only_Once = 1
local lastTraverse = 0
local currentLocation = 0
local hereBefore = 0
local visible = 1

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.set_map_var(3, 0)
        if fallout.global_var(111) == 5 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            visible = 0
            fallout.set_map_var(3, 1)
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
                if (fallout.obj_can_hear_obj(fallout.self_obj(), fallout.dude_obj()) == 1) or (fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) == 1) then
                    fallout.dialogue_system_enter()
                else
                    if (fallout.global_var(111) == 1) or (fallout.global_var(107) == 1) then
                        fallout.set_map_var(3, 1)
                        if (time.game_time_in_seconds() - lastTraverse) >= 20 then
                            lastTraverse = time.game_time_in_seconds()
                            if currentLocation == 0 then
                                currentLocation = 1
                                fallout.animate_move_obj_to_tile(fallout.self_obj(), 19516, 0)
                            else
                                currentLocation = 0
                                fallout.animate_move_obj_to_tile(fallout.self_obj(), 22529, 0)
                            end
                        end
                    else
                        if fallout.tile_num(fallout.self_obj()) ~= 22529 then
                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 22529, 0)
                        end
                    end
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= 22529 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 22529, 0)
                end
                if fallout.map_var(2) == 1 then
                    fallout.dialogue_system_enter()
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
        fallout.float_msg(fallout.self_obj(), fallout.message_str(870, 118), 2)
        combat()
    else
        if fallout.global_var(248) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(870, 120), 2)
            combat()
        else
            if fallout.map_var(2) == 1 then
                fallout.set_map_var(2, 0)
                George08()
            else
                if hereBefore == 0 then
                    hereBefore = 1
                    fallout.start_gdialog(870, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    George01()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    George07()
                end
            end
        end
    end
end

function destroy_p_proc()
    fallout.set_map_var(4, 1)
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(870, 100))
end

function damage_p_proc()
    fallout.set_map_var(5, 1)
end

function George01()
    fallout.gsay_reply(870, 101)
    fallout.giq_option(4, 870, 103, George01a, 50)
    fallout.giq_option(4, 870, 104, George01b, 50)
    fallout.giq_option(4, 870, 105, George06, 50)
    fallout.giq_option(-3, 870, 102, George06, 50)
end

function George01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        George03()
    else
        George02()
    end
end

function George01b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 10)) then
        George05()
    else
        George02()
    end
end

function George02()
    fallout.gsay_reply(870, 106)
    fallout.giq_option(4, 870, 107, George02a, 50)
    fallout.giq_option(4, 870, 108, George06, 50)
    fallout.giq_option(4, 870, 109, George03, 50)
    fallout.giq_option(4, 870, 110, GeorgeEnd, 50)
end

function George02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        George03()
    else
        George06()
    end
end

function George03()
    fallout.set_map_var(3, 1)
    fallout.gsay_message(870, 111, 50)
end

function George04()
    fallout.gsay_message(870, 112, 51)
end

function George05()
    fallout.set_map_var(3, 1)
    fallout.gsay_message(870, 113, 50)
end

function George06()
    fallout.gsay_message(870, 114, 51)
end

function George07()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(870, fallout.random(114, 117)), 2)
end

function George08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(870, 119), 2)
end

function GeorgeEnd()
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
