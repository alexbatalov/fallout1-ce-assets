local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local map_enter_p_proc
local use_obj_on_p_proc
local talk_p_proc
local timed_event_p_proc
local Katja01
local Katja02
local Katja03
local Katja04
local Katja05
local Katja06
local Katja07
local Katja08
local Katja09
local Katja10
local Katja11
local Katja12
local Katja13
local Katja14
local Katja15
local Katja16
local Katja17
local Katja18
local Katja19
local Katja20
local Katja21
local Katja22
local Katja23
local Katja24
local Katja25
local Katja26
local Katja27
local Katja28
local KatjaEnd
local KatjaLeave
local KatjaTactics
local KatjaClose
local KatjaModerate
local KatjaFar
local KatjaExit
local follow_player
local map_commentary
local pick_lock
local set_lock

local hostile = 0
local item = 0
local unwield_flag = 0
local lock = 0
local prev_tile = 7000
local dest_tile = 7000
local line173flag = 0
local line174flag = 0
local line176flag = 0
local line184flag = 0
local line186flag = 0
local line187flag = 0
local line188flag = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 15 then
                map_enter_p_proc()
            else
                if fallout.script_action() == 7 then
                    use_obj_on_p_proc()
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

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        map_commentary()
    end
end

function destroy_p_proc()
    fallout.set_global_var(244, 3)
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function map_enter_p_proc()
    if fallout.global_var(244) < 2 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    else
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 1)
    end
    fallout.set_external_var("Katja_ptr", fallout.self_obj())
end

function use_obj_on_p_proc()
    if fallout.global_var(244) == 2 then
        item = fallout.obj_pid(fallout.obj_being_used_with())
        if (item ~= 40) and (item ~= 47) and (item ~= 91) then
            fallout.script_overrides()
            if fallout.obj_item_subtype(fallout.obj_being_used_with()) == 3 then
                if (item == 4) or (item == 9) or (item == 22) or (item == 45) or (item == 7) or (item == 159) or (item == 25) or (item == 26) or (item == 27) or (item == 19) or (item == 21) or (item == 234) or (item == 235) or (item == 116) or (item == 236) or (item == 241) then
                    fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
                    fallout.add_obj_to_inven(fallout.self_obj(), fallout.obj_being_used_with())
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(634, 109), 5)
                end
            else
                fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
                fallout.add_obj_to_inven(fallout.self_obj(), fallout.obj_being_used_with())
            end
        end
    end
end

function talk_p_proc()
    fallout.start_gdialog(623, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.global_var(244) == 3 then
        Katja28()
    else
        if fallout.global_var(244) == 2 then
            Katja24()
        else
            if fallout.global_var(244) == 1 then
                Katja25()
            else
                Katja01()
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if unwield_flag == 1 then
        unwield_flag = 0
        fallout.inven_unwield()
    end
    if lock then
        pick_lock()
    end
    if fallout.global_var(244) == 2 then
        if fallout.global_var(315) == 0 then
            fallout.set_global_var(315, 1)
            fallout.give_exp_points(200)
            fallout.display_msg(fallout.message_str(623, 180))
        end
    end
end

function timed_event_p_proc()
    if fallout.global_var(244) == 2 then
        follow_player()
    end
end

function Katja01()
    fallout.set_global_var(244, 1)
    fallout.gsay_reply(623, 102)
    fallout.giq_option(4, 623, fallout.message_str(623, 103) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(623, 104), Katja02, 50)
    fallout.giq_option(4, 623, 105, Katja02, 50)
    fallout.giq_option(5, 623, 106, Katja05, 50)
    fallout.giq_option(-3, 623, 189, KatjaExit, 50)
end

function Katja02()
    fallout.gsay_reply(623, 107)
    fallout.giq_option(5, 623, 108, Katja03, 50)
    fallout.giq_option(5, 623, 109, Katja04, 50)
    fallout.giq_option(4, 623, 110, Katja07, 50)
    if (fallout.global_var(101) ~= 2) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 623, 111, Katja06, 50)
    end
end

function Katja03()
    fallout.gsay_reply(623, 112)
    fallout.giq_option(5, 623, 109, Katja04, 50)
    fallout.giq_option(4, 623, 110, Katja07, 50)
    if (fallout.global_var(101) ~= 2) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 623, 111, Katja06, 50)
    end
end

function Katja04()
    fallout.gsay_reply(623, 113)
    fallout.giq_option(5, 623, 114, Katja21, 50)
    fallout.giq_option(4, 623, 116, Katja09, 50)
    fallout.giq_option(4, 623, 115, KatjaEnd, 50)
end

function Katja05()
    fallout.gsay_reply(623, 117)
    fallout.giq_option(4, 623, fallout.message_str(623, 103) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(623, 104), Katja02, 50)
    fallout.giq_option(4, 623, 118, Katja07, 50)
    fallout.giq_option(4, 623, 115, KatjaEnd, 50)
end

function Katja06()
    fallout.gsay_reply(623, 119)
    fallout.giq_option(5, 623, 121, Katja11, 50)
    fallout.giq_option(4, 623, 122, Katja10, 50)
    fallout.giq_option(4, 623, 120, KatjaEnd, 50)
end

function Katja07()
    fallout.gsay_reply(623, 123)
    fallout.giq_option(4, 623, 124, Katja06, 50)
    fallout.giq_option(4, 623, 125, Katja08, 50)
end

function Katja08()
    fallout.gsay_message(623, 126, 51)
end

function Katja09()
    fallout.gsay_reply(623, 127)
    if (fallout.global_var(101) ~= 2) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 623, 128, Katja06, 50)
    end
    fallout.giq_option(4, 623, 129, Katja10, 50)
    fallout.giq_option(4, 623, 130, Katja17, 50)
end

function Katja10()
    fallout.giq_option(4, 623, 131, Katja13, 50)
    fallout.giq_option(4, 623, 133, Katja15, 50)
    fallout.giq_option(4, 623, 134, Katja16, 50)
    fallout.giq_option(4, 623, 135, Katja12, 50)
    fallout.giq_option(4, 623, 130, Katja17, 50)
    fallout.giq_option(4, 623, 136, KatjaEnd, 50)
end

function Katja11()
    fallout.gsay_reply(623, 137)
    fallout.giq_option(4, 623, 135, Katja12, 50)
    fallout.giq_option(4, 623, 138, KatjaEnd, 50)
end

function Katja12()
    fallout.gsay_reply(623, 139)
    Katja10()
end

function Katja13()
    fallout.gsay_reply(623, 140)
    Katja10()
end

function Katja14()
    fallout.gsay_reply(623, 141)
    Katja10()
end

function Katja15()
    fallout.gsay_reply(623, 142)
    Katja10()
end

function Katja16()
    fallout.gsay_reply(623, 143)
    Katja10()
end

function Katja17()
    fallout.gsay_reply(623, 144)
    if not(fallout.global_var(77)) then
        fallout.set_global_var(77, 1)
    end
    fallout.giq_option(4, 623, 145, Katja18, 50)
    fallout.giq_option(4, 623, 147, Katja10, 50)
    fallout.giq_option(4, 623, 146, KatjaEnd, 50)
end

function Katja18()
    fallout.gsay_reply(623, 148)
    fallout.giq_option(4, 623, 149, Katja20, 50)
    fallout.giq_option(4, 623, 151, Katja10, 50)
    fallout.giq_option(4, 623, 150, KatjaEnd, 50)
end

function Katja19()
    fallout.gsay_reply(623, 152)
    Katja10()
end

function Katja20()
    fallout.set_global_var(244, 2)
    fallout.party_add(fallout.self_obj())
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
    fallout.gsay_message(623, 153, 50)
end

function Katja21()
    fallout.gsay_reply(623, 154)
    fallout.giq_option(4, 623, 156, Katja22, 50)
    fallout.giq_option(6, 623, 157, Katja23, 50)
    fallout.giq_option(4, 623, 155, KatjaEnd, 50)
end

function Katja22()
    fallout.gsay_reply(623, 158)
    Katja10()
end

function Katja23()
    fallout.gsay_reply(623, 159)
    fallout.giq_option(4, 623, 160, Katja09, 50)
    if (fallout.global_var(101) == 0) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 623, 161, Katja06, 50)
    end
    fallout.giq_option(4, 623, 162, KatjaEnd, 50)
end

function Katja24()
    fallout.gsay_reply(623, 163)
    if fallout.cur_map_index() == 30 then
        if fallout.map_var(3) then
            fallout.giq_option(4, 623, 164, set_lock, 50)
        end
    end
    if (fallout.cur_map_index() == 10) and (fallout.elevation(fallout.dude_obj()) == 1) then
        if fallout.map_var(4) then
            fallout.giq_option(4, 623, 164, set_lock, 50)
        end
    end
    fallout.giq_option(4, 389, 159, KatjaTactics, 49)
    fallout.giq_option(4, 623, 177, Katja26, 50)
    fallout.giq_option(4, 623, 174, Katja27, 50)
    fallout.giq_option(4, 623, 167, KatjaLeave, 50)
    fallout.giq_option(4, 623, 168, KatjaEnd, 50)
    fallout.giq_option(-3, 623, 168, KatjaEnd, 50)
    fallout.giq_option(-3, 623, 190, KatjaLeave, 50)
end

function Katja25()
    fallout.gsay_reply(623, 169)
    fallout.giq_option(4, 623, 171, Katja10, 50)
    fallout.giq_option(4, 623, 170, KatjaEnd, 50)
    fallout.giq_option(-3, 623, 189, KatjaExit, 50)
end

function Katja26()
    fallout.gsay_message(623, 178, 50)
end

function Katja27()
    unwield_flag = 1
    fallout.gsay_message(623, 179, 50)
    Katja24()
end

function Katja28()
    fallout.gsay_reply(623, 181)
    fallout.giq_option(4, 623, 182, Katja20, 50)
    fallout.giq_option(4, 623, 183, KatjaEnd, 50)
    fallout.giq_option(-3, 623, 189, KatjaExit, 50)
end

function KatjaEnd()
end

function KatjaLeave()
    fallout.set_global_var(244, 3)
    fallout.party_remove(fallout.self_obj())
    fallout.rm_timer_event(fallout.self_obj())
end

function KatjaTactics()
    fallout.gsay_reply(389, 160)
    fallout.giq_option(4, 389, 161, KatjaClose, 49)
    fallout.giq_option(4, 389, 162, KatjaModerate, 49)
    fallout.giq_option(4, 389, 163, KatjaFar, 49)
end

function KatjaClose()
    fallout.set_global_var(279, 0)
end

function KatjaModerate()
    fallout.set_global_var(279, 1)
end

function KatjaFar()
    fallout.set_global_var(279, 2)
end

function KatjaExit()
    fallout.gsay_message(623, 191, 50)
end

function follow_player()
    local v0 = 0
    prev_tile = dest_tile
    v0 = (fallout.has_trait(1, fallout.dude_obj(), 10) + fallout.random(2, 4)) % 6
    dest_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), v0, (fallout.global_var(279) * 2) + fallout.random(1, 2))
    if (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > ((fallout.global_var(279) + 1) * 2)) or (fallout.random(0, 3) == 3) then
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

function map_commentary()
    if fallout.cur_map_index() == 33 then
        if (fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 27317) < 4) and (line173flag == 0) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(623, 173), 5)
            line173flag = 1
        end
    else
        if fallout.cur_map_index() == 6 then
            if fallout.elevation(fallout.self_obj()) == 1 then
                if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 19111) < 4 then
                    if (line174flag == 0) and (fallout.global_var(238) ~= 2) and (fallout.external_var("Ian_ptr") ~= 0) then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(623, 172), 5)
                        line174flag = 1
                    end
                end
            end
        else
            if fallout.cur_map_index() == 38 then
                if (fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 28104) < 5) and (line176flag == 0) then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(623, 176), 5)
                    if fallout.global_var(121) == 2 then
                        fallout.float_msg(fallout.external_var("Tycho_ptr"), fallout.message_str(389, 167), 12)
                    end
                    line176flag = 1
                end
            else
                if fallout.cur_map_index() == 32 then
                    if line184flag == 0 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(623, 184), 5)
                        if fallout.global_var(118) == 2 then
                            fallout.float_msg(fallout.external_var("Ian_ptr"), fallout.message_str(235, 175), 0)
                        end
                        line184flag = 1
                    end
                else
                    if fallout.cur_map_index() == 34 then
                        if line186flag == 0 then
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(623, 186), 5)
                            line186flag = 1
                        end
                    else
                        if fallout.cur_map_index() == 3 then
                            if (fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 17274) < 4) and (line187flag == 0) then
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(623, 187), 5)
                                line187flag = 1
                            end
                        else
                            if fallout.cur_map_index() == 45 then
                                if line188flag == 0 then
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(623, 188), 5)
                                    line188flag = 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function pick_lock()
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_obj(fallout.self_obj(), lock, -1)
    fallout.reg_anim_animate(fallout.self_obj(), 11, -1)
    fallout.reg_anim_func(3, 0)
    fallout.use_obj(lock)
    fallout.obj_unlock(lock)
    lock = 0
end

function set_lock()
    if fallout.cur_map_index() == 30 then
        lock = fallout.map_var(3)
    else
        if fallout.cur_map_index() == 10 then
            lock = fallout.map_var(4)
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
