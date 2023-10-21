local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local talk_p_proc
local timed_event_p_proc
local use_obj_on_p_proc
local Tycho01
local Tycho02
local Tycho03
local Tycho04
local Tycho05
local Tycho06
local Tycho07
local Tycho08
local Tycho09
local Tycho10
local Tycho11
local Tycho12
local Tycho13
local Tycho14
local Tycho15
local Tycho16
local Tycho17
local Tycho18
local Tycho19
local Tycho20
local Tycho21
local Tycho22
local Tycho23
local Tycho24
local Tycho25
local Tycho26
local Tycho27
local Tycho28
local Tycho29
local Tycho30
local Tycho31
local Tycho32
local follow_player
local TychoEnd
local TychoCombat
local TychoJoins
local TychoTactics
local TychoClose
local TychoModerate
local TychoFar
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = 0
local item = 0
local unwield_flag = 0
local cola2_ptr = 0
local prev_tile = 0
local dest_tile = 0
local line08flag = 0

local exit_line = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 21 then
                look_at_p_proc()
            else
                if fallout.script_action() == 15 then
                    map_enter_p_proc()
                else
                    if fallout.script_action() == 11 then
                        talk_p_proc()
                    else
                        if fallout.script_action() == 22 then
                            timed_event_p_proc()
                        else
                            if fallout.script_action() == 7 then
                                use_obj_on_p_proc()
                            end
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.global_var(121) < 2 then
            sleeping()
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(121, 3)
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.global_var(121) > 0 then
        fallout.display_msg(fallout.message_str(389, 101))
    else
        fallout.display_msg(fallout.message_str(389, 100))
    end
end

function map_enter_p_proc()
    sleep_time = 2200
    wake_time = 1600
    home_tile = 19690
    sleep_tile = 7000
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 106) >= 2 then
        cola2_ptr = fallout.obj_carrying_pid_obj(fallout.self_obj(), 106)
    end
    if fallout.global_var(121) == 2 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
    else
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 26)
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(389, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.global_var(121) == 3 then
        Tycho28()
    else
        if fallout.global_var(121) == 2 then
            Tycho22()
        else
            if fallout.global_var(121) == 0 then
                Tycho01()
            else
                if (fallout.global_var(39) == 1) and (fallout.global_var(36) == 0) then
                    Tycho19()
                else
                    if fallout.local_var(1) < 2 then
                        Tycho14()
                    else
                        Tycho15()
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if fallout.global_var(121) == 2 then
        if fallout.global_var(314) == 0 then
            fallout.display_msg(fallout.message_str(389, 173))
            fallout.give_exp_points(300)
            fallout.set_global_var(314, 1)
        end
    end
    if unwield_flag == 1 then
        unwield_flag = 0
        fallout.inven_unwield()
    end
end

function timed_event_p_proc()
    if fallout.global_var(121) == 2 then
        follow_player()
    end
end

function use_obj_on_p_proc()
    if fallout.global_var(121) == 2 then
        item = fallout.obj_pid(fallout.obj_being_used_with())
        if (item ~= 40) and (item ~= 47) and (item ~= 91) then
            fallout.script_overrides()
            if fallout.obj_item_subtype(fallout.obj_being_used_with()) ~= 3 then
                fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
                fallout.add_obj_to_inven(fallout.self_obj(), fallout.obj_being_used_with())
            else
                if (item == 8) or (item == 18) or (item == 143) or (item == 10) or (item == 94) or (item == 7) or (item == 21) or (item == 234) or (item == 235) or (item == 24) or (item == 16) or (item == 120) or (item == 242) then
                    fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
                    fallout.add_obj_to_inven(fallout.self_obj(), fallout.obj_being_used_with())
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(634, 109), 3)
                end
            end
        end
    end
end

function Tycho01()
    fallout.gsay_reply(389, 102)
    fallout.giq_option(4, 389, 103, TychoEnd, 50)
    fallout.giq_option(4, 389, 104, Tycho02, 50)
    fallout.giq_option(-3, 389, 105, Tycho03, 50)
end

function Tycho02()
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), fallout.obj_pid(cola2_ptr)) then
        fallout.rm_obj_from_inven(fallout.self_obj(), cola2_ptr)
        fallout.add_obj_to_inven(fallout.dude_obj(), cola2_ptr)
    end
    fallout.gsay_reply(389, 106)
    fallout.giq_option(4, 389, 107, Tycho04, 50)
end

function Tycho03()
    fallout.gsay_message(389, 108, 50)
end

function Tycho04()
    fallout.gsay_reply(389, 109)
    fallout.giq_option(4, 389, 110, Tycho05, 50)
    fallout.giq_option(6, 389, 111, Tycho06, 50)
end

function Tycho05()
    fallout.gsay_reply(389, 112)
    fallout.giq_option(4, 389, 113, Tycho07, 50)
    fallout.giq_option(6, 389, 114, Tycho08, 50)
end

function Tycho06()
    fallout.gsay_reply(389, 115)
    fallout.giq_option(4, 389, 116, Tycho11, 50)
    fallout.giq_option(6, 389, 117, Tycho09, 50)
end

function Tycho07()
    fallout.gsay_reply(389, 118)
    fallout.giq_option(4, 389, 119, Tycho11, 50)
end

function Tycho08()
    fallout.gsay_reply(389, 120)
    if line08flag then
        exit_line = reaction.Goodbyes()
        fallout.giq_option(4, 389, exit_line, TychoEnd, 50)
    else
        line08flag = 1
        fallout.giq_option(4, 389, 121, Tycho11, 50)
    end
end

function Tycho09()
    fallout.gsay_reply(389, 122)
    fallout.giq_option(4, 389, 123, Tycho10, 50)
    fallout.giq_option(4, 389, 116, Tycho11, 50)
end

function Tycho10()
    fallout.gsay_reply(389, 124)
    fallout.giq_option(4, 389, 125, Tycho17, 50)
    fallout.giq_option(4, 389, 126, Tycho11, 50)
end

function Tycho11()
    fallout.set_global_var(121, 1)
    fallout.gsay_reply(389, 127)
    fallout.giq_option(4, 389, fallout.message_str(389, 128) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(389, 129), Tycho12, 50)
    fallout.giq_option(4, 389, 130, Tycho13, 50)
end

function Tycho12()
    reaction.UpReact()
    fallout.gsay_message(389, 131, 50)
end

function Tycho13()
    reaction.DownReact()
    fallout.gsay_reply(389, 132)
    fallout.giq_option(4, 389, 133, TychoCombat, 50)
    fallout.giq_option(4, 389, 134, TychoEnd, 50)
end

function Tycho14()
    fallout.gsay_reply(389, 135)
    fallout.giq_option(4, 389, 136, Tycho13, 50)
    fallout.giq_option(4, 389, 137, Tycho08, 50)
    fallout.giq_option(4, 389, 138, Tycho16, 50)
end

function Tycho15()
    fallout.gsay_reply(389, 139)
    fallout.giq_option(4, 389, 137, Tycho08, 50)
    fallout.giq_option(4, 389, 138, Tycho16, 50)
    if fallout.global_var(36) ~= 0 then
        fallout.giq_option(4, 389, 140, Tycho18, 50)
    end
end

function Tycho16()
    fallout.gsay_reply(389, 141)
    exit_line = reaction.Goodbyes()
    fallout.giq_option(4, 389, exit_line, TychoEnd, 50)
end

function Tycho17()
    fallout.gfade_out(600)
    fallout.critter_mod_skill(fallout.dude_obj(), 17, 5)
    fallout.game_time_advance(fallout.game_ticks(120))
    fallout.gsay_reply(389, 142)
    fallout.gfade_in(600)
    exit_line = reaction.Goodbyes()
    fallout.giq_option(4, 389, exit_line, Tycho11, 50)
end

function Tycho18()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(389, 168, 49)
    else
        fallout.gsay_message(389, 169, 49)
    end
    TychoJoins()
end

function Tycho19()
    fallout.gsay_reply(389, 144)
    fallout.giq_option(4, 389, 145, Tycho20, 50)
    fallout.giq_option(4, 389, 146, Tycho21, 50)
    fallout.giq_option(-3, 389, 105, TychoEnd, 50)
end

function Tycho20()
    fallout.gsay_message(389, 147, 50)
end

function Tycho21()
    reaction.DownReact()
    fallout.gsay_message(389, 148, 50)
end

function Tycho22()
    fallout.gsay_reply(389, 149)
    if fallout.cur_map_index() == 51 then
        fallout.giq_option(4, 389, 150, Tycho23, 49)
    end
    if fallout.cur_map_index() == 27 then
        fallout.giq_option(4, 389, 150, Tycho25, 49)
    end
    if fallout.cur_map_index() == 37 then
        fallout.giq_option(4, 389, 150, Tycho26, 49)
    end
    if fallout.cur_map_index() == 3 then
        fallout.giq_option(4, 389, 150, Tycho30, 49)
    end
    if fallout.cur_map_index() == 31 then
        fallout.giq_option(4, 389, 150, Tycho31, 49)
    end
    if fallout.cur_map_index() == 32 then
        fallout.giq_option(4, 389, 150, Tycho32, 49)
    end
    fallout.giq_option(4, 389, 151, Tycho24, 49)
    fallout.giq_option(4, 389, 159, TychoTactics, 49)
    fallout.giq_option(4, 235, 200, Tycho29, 49)
    fallout.giq_option(4, 389, 164, Tycho27, 49)
    fallout.giq_option(4, 389, 166, TychoEnd, 49)
end

function Tycho23()
    fallout.gsay_message(389, 152, 49)
end

function Tycho24()
    fallout.rm_timer_event(fallout.self_obj())
    fallout.party_remove(fallout.self_obj())
    fallout.set_global_var(121, 3)
    fallout.gsay_message(389, 153, 49)
end

function Tycho25()
    fallout.gsay_message(389, 154, 49)
end

function Tycho26()
    fallout.gsay_message(389, 155, 49)
end

function Tycho27()
    fallout.gsay_message(389, 165, 49)
end

function Tycho28()
    fallout.gsay_reply(389, 170)
    fallout.giq_option(4, 389, 171, TychoJoins, 49)
    fallout.giq_option(4, 389, 172, TychoEnd, 50)
    fallout.giq_option(-3, 389, 105, TychoEnd, 50)
end

function Tycho29()
    fallout.gsay_message(235, 201, 49)
    unwield_flag = 1
    Tycho22()
end

function Tycho30()
    fallout.gsay_message(389, 158, 49)
end

function Tycho31()
    fallout.gsay_message(389, 157, 49)
end

function Tycho32()
    fallout.gsay_message(389, 156, 49)
end

function follow_player()
    local v0 = 0
    prev_tile = dest_tile
    v0 = (fallout.has_trait(1, fallout.dude_obj(), 10) + fallout.random(2, 4)) % 6
    dest_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), v0, (fallout.global_var(278) * 2) + fallout.random(1, 2))
    if (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > ((fallout.global_var(278) + 1) * 2)) or (fallout.random(0, 3) == 3) then
        if fallout.tile_distance(prev_tile, fallout.tile_num(fallout.dude_obj())) > fallout.tile_distance(dest_tile, fallout.tile_num(fallout.dude_obj())) then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 8 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), dest_tile, 1 | 16)
            else
                fallout.animate_move_obj_to_tile(fallout.self_obj(), dest_tile, 0 | 16)
            end
        else
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 8 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), dest_tile, 1)
            else
                fallout.animate_move_obj_to_tile(fallout.self_obj(), dest_tile, 0)
            end
        end
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
end

function TychoEnd()
end

function TychoCombat()
    hostile = 1
end

function TychoJoins()
    fallout.set_global_var(121, 2)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
    fallout.party_add(fallout.self_obj())
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
end

function TychoTactics()
    fallout.gsay_reply(389, 160)
    fallout.giq_option(4, 389, 161, TychoClose, 49)
    fallout.giq_option(4, 389, 162, TychoModerate, 49)
    fallout.giq_option(4, 389, 163, TychoFar, 49)
end

function TychoClose()
    fallout.set_global_var(278, 0)
end

function TychoModerate()
    fallout.set_global_var(278, 1)
end

function TychoFar()
    fallout.set_global_var(278, 2)
end

function sleeping()
    if fallout.local_var(4) == 1 then
        if not(night_person) and (fallout.game_time_hour() >= wake_time) and (fallout.game_time_hour() < sleep_time) or (night_person and ((fallout.game_time_hour() >= wake_time) or (fallout.game_time_hour() < sleep_time))) then
            if ((fallout.game_time_hour() - wake_time) < 10) and ((fallout.game_time_hour() - wake_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                else
                    fallout.set_local_var(4, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), home_tile, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == home_tile then
                    fallout.set_local_var(4, 0)
                end
            end
        end
    else
        if night_person and (fallout.game_time_hour() >= sleep_time) and (fallout.game_time_hour() < wake_time) or (not(night_person) and ((fallout.game_time_hour() >= sleep_time) or (fallout.game_time_hour() < wake_time))) then
            if ((fallout.game_time_hour() - sleep_time) < 10) and ((fallout.game_time_hour() - sleep_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(4, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.move_to(fallout.self_obj(), sleep_tile, fallout.elevation(fallout.self_obj()))
                else
                    fallout.set_local_var(4, 1)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
