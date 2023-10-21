local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local do_dialogue
local sys_dialog
local guard00
local guard01
local guard02
local guard03
local guard04
local guard05
local guard06
local guard07
local guard07a
local guard07b
local guard08
local guard09
local guard10
local guard11
local guard12
local guard13
local guard14
local guard15
local guardend
local combat
local weapon_check
local Critter_Action
local damage_p_proc

local hostile = 0
local initialized = false
local rndq = 0
local rndr = 0
local rndx = 0
local Weapons = 0

local exit_line = 0

local first
local notfirst

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 6)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 20)
        initialized = true
    end
    if fallout.script_action() == 22 then
        if fallout.fixed_param() == 1 then
            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                combat()
            end
        else
            if fallout.fixed_param() == 2 then
                if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
                    combat()
                end
            else
                if fallout.fixed_param() == 3 then
                    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
                        combat()
                    end
                end
            end
        end
    else
        if fallout.script_action() == 11 then
            if fallout.local_var(5) == 1 then
                fallout.display_msg(fallout.message_str(136, 100))
            else
                do_dialogue()
            end
        else
            if fallout.script_action() == 4 then
                hostile = 1
            else
                if fallout.script_action() == 12 then
                    Critter_Action()
                    if hostile then
                        hostile = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    end
                    rndq = fallout.random(0, 10)
                    if rndq == 1 then
                        rndr = fallout.random(0, 5)
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), rndr, 1), 0)
                    else
                        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.global_var(611) ~= 1) then
                            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and ((Weapons == 0) and (fallout.external_var("killing_women") == 0)) then
                                Weapons = 1
                                fallout.dialogue_system_enter()
                            end
                        end
                    end
                else
                    if fallout.script_action() == 14 then
                        damage_p_proc()
                    else
                        if fallout.script_action() == 18 then
                            reputation.inc_evil_critter()
                            fallout.set_global_var(254, 1)
                            fallout.set_global_var(611, 0)
                            fallout.set_global_var(115, fallout.global_var(115) - 1)
                        else
                            if fallout.script_action() == 21 then
                                fallout.script_overrides()
                                fallout.display_msg(fallout.message_str(136, 101))
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    if fallout.global_var(116) == 1 then
        guard00()
    else
        if (Weapons == 1) and (fallout.external_var("killing_women") == 0) and (fallout.global_var(611) ~= 1) then
            guard02()
        else
            sys_dialog()
        end
    end
end

function sys_dialog()
    fallout.set_local_var(3, 1)
    reaction.get_reaction()
    fallout.start_gdialog(136, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        guard04()
    else
        guard15()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function guard00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(102, 106)), 8)
end

function guard01()
    rndx = fallout.random(1, 5)
    if rndx == 1 then
        fallout.gsay_message(136, 107, 50)
    else
        if rndx == 2 then
            fallout.gsay_message(136, 108, 50)
        else
            if rndx == 3 then
                fallout.gsay_message(136, 109, 50)
            else
                if rndx == 4 then
                    fallout.gsay_message(136, 110, 50)
                else
                    if rndx == 5 then
                        fallout.gsay_message(136, 111, 50)
                    end
                end
            end
        end
    end
end

function guard02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(112, 115)), 8)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(9), 1)
end

function guard03()
    rndx = fallout.random(1, 3)
    if rndx == 1 then
        fallout.gsay_message(136, 116, 50)
    else
        if rndx == 2 then
            fallout.gsay_message(136, 117, 50)
        else
            if rndx == 3 then
                fallout.gsay_message(136, 118, 50)
            end
        end
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 2)
end

function guard04()
    fallout.gsay_reply(136, 119)
    if (fallout.global_var(103) == 1) and (fallout.global_var(218) == 1) then
        fallout.giq_option(4, 136, 120, guard07, 50)
    end
    fallout.giq_option(4, 136, 121, guard06, 50)
    fallout.giq_option(-3, 136, 122, guard05, 50)
end

function guard05()
    fallout.gsay_message(136, 123, 50)
end

function guard06()
    fallout.gsay_message(136, 124, 50)
    reaction.DownReact()
end

function guard07()
    fallout.gsay_reply(136, 125)
    fallout.giq_option(4, 136, 126, guard08, 50)
    fallout.giq_option(5, 136, 127, guard07a, 50)
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) then
        fallout.giq_option(4, 136, 128, guard07b, 50)
    end
end

function guard07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        guard09()
    else
        guard11()
    end
end

function guard07b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        guard12()
    else
        guard13()
    end
end

function guard08()
    fallout.gsay_message(136, 129, 50)
end

function guard09()
    fallout.gsay_reply(136, 130)
    fallout.giq_option(6, 136, 131, guard10, 50)
end

function guard10()
    fallout.gsay_message(136, 132, 50)
end

function guard11()
    fallout.gsay_message(136, 133, 50)
end

function guard12()
    fallout.gsay_message(136, 134, 50)
    fallout.set_local_var(5, 1)
end

function guard13()
    fallout.gsay_message(136, 135, 50)
    combat()
end

function guard14()
    fallout.gsay_message(136, 136, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(12), 3)
end

function guard15()
    fallout.gsay_message(136, 137, 50)
end

function guardend()
end

function combat()
    if fallout.global_var(116) == 1 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
    end
    hostile = 1
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        Weapons = 0
    else
        Weapons = 1
    end
end

function Critter_Action()
    local v0 = 0
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    else
        if fallout.global_var(116) ~= 0 then
            fallout.set_global_var(254, 0)
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 3 then
                v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), 3)
                if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), v0) > 2 then
                    if fallout.random(0, 9) == 0 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(102, 106)), 8)
                    end
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 0)
                end
            end
        else
            if fallout.global_var(213) ~= 0 then
                fallout.set_global_var(254, 1)
            end
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if fallout.global_var(214) ~= 0 then
                    fallout.set_global_var(254, 1)
                end
            end
            if fallout.map_var(2) == 1 then
                fallout.set_global_var(254, 1)
            end
        end
    end
    if fallout.global_var(254) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
end

function damage_p_proc()
    if fallout.global_var(116) == 0 then
        fallout.set_global_var(254, 1)
    end
end

function first()
end

function notfirst()
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
return exports
