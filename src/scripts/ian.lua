local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local use_obj_on_p_proc
local join_party
local hire_Ian
local Ian01
local Ian02
local Ian03
local Ian04
local Ian05
local Ian06
local Ian07
local Ian08
local Ian09
local Ian10
local Ian11
local Ian12
local Ian12a
local Ian13
local Ian14
local Ian15
local Ian16
local Ian17
local Ian17a
local Ian18
local Ian19
local Ian20
local Ian21
local follow_player
local map_commentary
local IanEnd
local IanCombat
local IanTactics
local IanClose
local IanModerate
local IanFar
local IanChange

local hostile = 0
local item = 0
local unwield_flag = 0
local line151flag = 0
local line152flag = 0
local line153flag = 0
local line154flag = 0
local line155flag = 0
local line162flag = 0
local line163flag = 0
local line164flag = 0
local line165flag = 0
local line166flag = 0
local line167flag = 0
local line170flag = 0
local line172flag = 0
local dest_tile = 7000
local prev_tile = 7000

local exit_line = 0

function start()
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
                    if fallout.script_action() == 15 then
                        map_enter_p_proc()
                    else
                        if fallout.script_action() == 4 then
                            pickup_p_proc()
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
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    map_commentary()
end

function description_p_proc()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0))) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(235, 130))
    end
end

function destroy_p_proc()
    fallout.set_global_var(118, 3)
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.global_var(118) == 0 then
        fallout.display_msg(fallout.message_str(235, 100))
    else
        fallout.display_msg(fallout.message_str(235, 113))
    end
end

function map_enter_p_proc()
    if fallout.global_var(118) == 2 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
    else
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
    end
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 89)
end

function pickup_p_proc()
    if fallout.global_var(118) < 2 then
        hostile = 1
    else
        fallout.script_overrides()
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(235, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if (fallout.global_var(246) == 1) and (fallout.global_var(118) ~= 2) then
        Ian14()
    else
        if fallout.global_var(118) == 0 then
            Ian02()
        else
            if fallout.global_var(118) == 2 then
                Ian15()
            else
                if fallout.global_var(118) == 3 then
                    Ian21()
                else
                    Ian12()
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if (fallout.global_var(118) == 2) and (fallout.global_var(313) == 0) then
        fallout.set_global_var(313, 1)
        fallout.display_msg(fallout.message_str(235, 169))
        fallout.give_exp_points(100)
    end
    if unwield_flag == 1 then
        unwield_flag = 0
        fallout.inven_unwield()
    end
end

function timed_event_p_proc()
    follow_player()
end

function use_obj_on_p_proc()
    if fallout.global_var(118) == 2 then
        item = fallout.obj_pid(fallout.obj_being_used_with())
        if (item ~= 40) and (item ~= 47) and (item ~= 91) then
            fallout.script_overrides()
            if fallout.obj_item_subtype(fallout.obj_being_used_with()) ~= 3 then
                fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
                fallout.add_obj_to_inven(fallout.self_obj(), fallout.obj_being_used_with())
            else
                if (item == 4) or (item == 8) or (item == 18) or (item == 120) or (item == 22) or (item == 9) or (item == 16) or (item == 24) or (item == 241) or (item == 116) or (item == 236) or (item == 234) or (item == 235) or (item == 21) then
                    fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
                    fallout.add_obj_to_inven(fallout.self_obj(), fallout.obj_being_used_with())
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(634, 109), 3)
                end
            end
        end
    end
end

function join_party()
    fallout.set_global_var(118, 2)
    fallout.party_add(fallout.self_obj())
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
    fallout.gsay_message(235, 150, 50)
end

function hire_Ian()
    fallout.item_caps_adjust(fallout.dude_obj(), -100)
    fallout.item_caps_adjust(fallout.self_obj(), 100)
    join_party()
end

function Ian01()
    fallout.gsay_message(235, 101, 51)
end

function Ian02()
    fallout.gsay_reply(235, 102)
    fallout.giq_option(4, 235, 103, Ian03, 51)
    fallout.giq_option(4, 235, fallout.message_str(235, 104) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(235, 105), Ian04, 50)
    fallout.giq_option(-3, 235, 106, Ian05, 50)
end

function Ian03()
    fallout.gsay_message(235, 107, 51)
end

function Ian04()
    fallout.gsay_reply(235, 108)
    fallout.set_global_var(118, 1)
    fallout.giq_option(4, 235, 109, Ian06, 50)
    fallout.giq_option(5, 235, 110, Ian07, 50)
end

function Ian05()
    fallout.gsay_message(235, 111, 50)
end

function Ian06()
    fallout.gsay_reply(235, 112)
    fallout.giq_option(4, 235, 114, Ian18, 50)
    fallout.giq_option(4, 235, 115, Ian13, 50)
    fallout.giq_option(4, 235, 149, Ian17, 50)
    fallout.giq_option(5, 235, 116, Ian08, 50)
end

function Ian07()
    fallout.gsay_reply(235, 117)
    fallout.giq_option(4, 235, 118, Ian09, 50)
    fallout.giq_option(4, 235, 119, Ian08, 50)
end

function Ian08()
    fallout.gsay_reply(235, 120)
    fallout.giq_option(4, 235, 121, Ian10, 50)
    fallout.giq_option(5, 235, 122, Ian11, 50)
end

function Ian09()
    fallout.gsay_reply(235, 123)
    fallout.giq_option(4, 634, 104, IanEnd, 50)
end

function Ian10()
    fallout.gsay_reply(235, 125)
    fallout.giq_option(4, 235, 126, Ian09, 50)
    fallout.giq_option(4, 634, 101, IanEnd, 50)
end

function Ian11()
    fallout.gsay_reply(235, 128)
    fallout.giq_option(4, 235, 129, Ian07, 50)
    fallout.giq_option(4, 634, 101, IanEnd, 50)
end

function Ian12()
    fallout.gsay_reply(235, fallout.message_str(235, 131) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(235, 132))
    Ian12a()
end

function Ian12a()
    fallout.giq_option(4, 235, 133, Ian11, 50)
    fallout.giq_option(4, 235, 134, Ian09, 50)
    fallout.giq_option(4, 235, 135, Ian07, 50)
    fallout.giq_option(4, 235, 136, Ian10, 50)
    fallout.giq_option(4, 235, 137, Ian13, 50)
    fallout.giq_option(4, 235, 149, Ian17, 50)
    fallout.giq_option(4, 235, 138, IanEnd, 50)
end

function Ian13()
    if not(fallout.global_var(73)) then
        fallout.set_global_var(73, 1)
    end
    if not(fallout.global_var(71)) then
        fallout.set_global_var(71, 1)
    end
    fallout.gsay_reply(235, 139)
    if fallout.global_var(118) == 2 then
        fallout.giq_option(4, 235, 140, Ian15, 50)
    else
        fallout.giq_option(4, 235, 140, Ian12, 50)
    end
end

function Ian14()
    hostile = 1
    fallout.gsay_message(235, 141, 51)
end

function Ian15()
    fallout.gsay_reply(235, fallout.message_str(235, 142) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(235, 143))
    fallout.giq_option(4, 235, 145, Ian16, 50)
    fallout.giq_option(4, 235, 146, Ian13, 50)
    fallout.giq_option(4, 235, 200, IanChange, 50)
    fallout.giq_option(4, 389, 159, IanTactics, 50)
    fallout.giq_option(4, 235, 173, Ian20, 50)
    fallout.giq_option(4, 235, 144, IanEnd, 50)
end

function Ian16()
    fallout.set_global_var(118, 3)
    fallout.party_remove(fallout.self_obj())
    fallout.gsay_message(235, 147, 50)
    fallout.rm_timer_event(fallout.self_obj())
end

function Ian17()
    if fallout.local_var(1) == 1 then
        fallout.gsay_message(235, 148, 51)
    else
        if fallout.local_var(1) == 2 then
            fallout.gsay_reply(235, 156)
            if fallout.item_caps_total(fallout.dude_obj()) >= 100 then
                fallout.giq_option(4, 235, 157, hire_Ian, 49)
            end
            fallout.giq_option(6, 235, 159, Ian17a, 50)
            fallout.giq_option(4, 235, 158, IanEnd, 50)
        else
            join_party()
        end
    end
end

function Ian17a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) then
        fallout.gsay_reply(235, 160)
        fallout.giq_option(4, 634, 106, join_party, 49)
    else
        reaction.DownReact()
        fallout.gsay_message(235, 161, 51)
    end
end

function Ian18()
    fallout.gsay_reply(235, 124)
    reaction.UpReact()
    fallout.giq_option(4, 634, 106, Ian19, 50)
end

function Ian19()
    fallout.gsay_reply(235, 127)
    Ian12a()
end

function Ian20()
    fallout.gsay_message(235, 174, 50)
    Ian15()
end

function Ian21()
    fallout.gsay_reply(235, 202)
    fallout.giq_option(4, 235, 203, join_party, 50)
    fallout.giq_option(4, 235, 204, IanEnd, 50)
end

function follow_player()
    local v0 = 0
    prev_tile = dest_tile
    v0 = (fallout.has_trait(1, fallout.dude_obj(), 10) + fallout.random(2, 4)) % 6
    dest_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), v0, (fallout.global_var(277) * 2) + fallout.random(1, 2))
    if (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > ((fallout.global_var(277) + 1) * 2)) or (fallout.random(0, 3) == 3) then
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
    if fallout.cur_map_index() == 12 then
        if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 27883) < 4 then
            if not(line151flag) then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 151), 0)
                line151flag = 1
            end
        end
    else
        if fallout.cur_map_index() == 11 then
            if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 27919) < 4 then
                if not(line152flag) then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 152), 0)
                    line152flag = 1
                end
            end
        else
            if fallout.cur_map_index() == 3 then
                if not(line153flag) then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 153), 0)
                    line153flag = 1
                end
            else
                if fallout.cur_map_index() == 27 then
                    if not(line154flag) then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 154), 0)
                        if fallout.global_var(244) == 2 then
                            fallout.float_msg(fallout.external_var("Katja_ptr"), fallout.message_str(623, 185), 5)
                        end
                        line154flag = 1
                    end
                else
                    if fallout.cur_map_index() == 30 then
                        if not(line155flag) then
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 155), 0)
                            line155flag = 1
                        end
                    else
                        if fallout.cur_map_index() == 38 then
                            if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 24890) < 4 then
                                if not(line162flag) then
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 162), 0)
                                    line162flag = 1
                                end
                            else
                                if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 14116) < 4 then
                                    if not(line165flag) then
                                        fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 165), 0)
                                        line165flag = 1
                                    end
                                else
                                    if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 18464) < 4 then
                                        if not(line166flag) then
                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 166), 0)
                                            line166flag = 1
                                        end
                                    else
                                        if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 21730) < 4 then
                                            if not(line167flag) then
                                                fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 167), 0)
                                                line167flag = 1
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if fallout.cur_map_index() == 40 then
                                if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 16082) < 4 then
                                    if line163flag == 0 then
                                        fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 163), 0)
                                        line163flag = 1
                                    end
                                end
                            else
                                if fallout.cur_map_index() == 41 then
                                    if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), 22497) < 4 then
                                        if line164flag == 0 then
                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 164), 0)
                                            line164flag = 1
                                        end
                                    end
                                else
                                    if fallout.cur_map_index() == 6 then
                                        if line170flag == 0 then
                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(235, 170), 0)
                                            line170flag = 1
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
end

function IanEnd()
end

function IanCombat()
    hostile = 1
end

function IanTactics()
    fallout.gsay_reply(389, 160)
    fallout.giq_option(4, 389, 161, IanClose, 50)
    fallout.giq_option(4, 389, 162, IanModerate, 50)
    fallout.giq_option(4, 389, 163, IanFar, 50)
end

function IanClose()
    fallout.set_global_var(277, 0)
    fallout.gsay_message(235, 201, 50)
    Ian15()
end

function IanModerate()
    fallout.set_global_var(277, 1)
    fallout.gsay_message(235, 201, 50)
    Ian15()
end

function IanFar()
    fallout.set_global_var(277, 2)
    fallout.gsay_message(235, 201, 50)
    Ian15()
end

function IanChange()
    fallout.gsay_message(235, 201, 50)
    unwield_flag = 1
    Ian15()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
