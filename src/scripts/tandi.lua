local fallout = require("fallout")
local reputation = require("lib.reputation")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0
local g3 = 0
local g4 = 0
local g5 = 0
local g6 = 0
local g7 = 0
local g8 = 0
local g9 = 0
local g10 = 0
local g11 = 1
local g12 = 0
local g13 = 0

local start
local do_dialogue
local tandi00
local tandi00_1
local tandi01
local tandi01a
local tandi02
local tandi03
local tandi04
local tandi05
local tandi06
local tandi12
local tandi13
local tandi14
local tandi15
local tandi16
local tandi20
local tandi21
local tandi22
local tandi23
local tandi24
local tandi27
local tandi28
local tandi29
local tandi30
local tandi35
local tandi36
local tandi36a
local tandi37
local tandi38
local tandi38a
local tandi38b
local tandi39
local tandi40
local tandi41
local tandi42
local tandi43
local tandi43a
local tandi43b
local tandi44
local tandi45
local tandi46
local tandi47
local tandi48
local tandi49
local tandi50
local tandi51
local tandi52
local tandi53
local tandi54
local tandi55
local tandi62
local tandi63
local tandi64
local tandi65
local tandi66
local tandi67
local tandi68
local tandi69
local tandi70
local tandi71
local tandi72
local tandix
local tandixx
local tandix1
local tandix2
local tandix3
local tandix4
local tandix5
local tandiend
local TandiSchedule
local follow_player
local Random_Following
local map_update_p_proc
local map_enter_p_proc
local critter_p_proc

-- ?import? variable DESTROYED
-- ?import? variable KIDNAP
-- ?import? variable ILLEGAL
-- ?import? variable ILLEGBEFORE
-- ?import? variable TRESPASS
-- ?import? variable BYE
-- ?import? variable rndx
-- ?import? variable rndy
-- ?import? variable rndz
-- ?import? variable MALE
-- ?import? variable Counter
-- ?import? variable Only_Once
-- ?import? variable hostile
-- ?import? variable Tandi_Ptr

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

-- ?import? variable exit_line

function start()
    if g11 then
        g11 = 0
        if fallout.global_var(26) == 5 then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 2)
        end
        if (fallout.cur_map_index() == 26) or (fallout.cur_map_index() == 25) then
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        else
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 2)
    end
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        else
            if fallout.script_action() == 11 then
                do_dialogue()
            else
                if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(57, 100))
                else
                    if fallout.script_action() == 22 then
                        if fallout.fixed_param() == 1 then
                            follow_player()
                        else
                            if fallout.fixed_param() == 2 then
                                Random_Following()
                            end
                        end
                    else
                        if fallout.script_action() == 12 then
                            critter_p_proc()
                        else
                            if fallout.script_action() == 18 then
                                reputation.inc_good_critter()
                                fallout.set_global_var(26, 3)
                            else
                                if fallout.script_action() == 14 then
                                    if (fallout.source_obj() == fallout.dude_obj()) and ((fallout.cur_map_index() == 26) or (fallout.cur_map_index() == 25)) then
                                        fallout.set_global_var(246, 1)
                                    end
                                else
                                    if fallout.script_action() == 4 then
                                        g12 = 1
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

function do_dialogue()
    local v0 = 0
    if (fallout.cur_map_index() ~= 24) and (fallout.cur_map_index() ~= 26) and (fallout.cur_map_index() ~= 25) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(57, fallout.random(300, 305)), 8)
    end
    if (fallout.cur_map_index() == 24) or (fallout.cur_map_index() == 26) or (fallout.cur_map_index() == 25) then
        v0 = 9
        if fallout.cur_map_index() == 24 then
            v0 = 13
        end
        if fallout.global_var(26) == 5 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(57, 208), 2)
        else
            fallout.start_gdialog(57, fallout.self_obj(), 4, 9, v0)
            get_reaction()
            fallout.gsay_start()
            if fallout.global_var(217) == 1 then
                if fallout.global_var(26) == 0 then
                    if fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
                        tandi06()
                    else
                        tandi30()
                    end
                else
                    if fallout.global_var(26) == 1 then
                        fallout.set_global_var(218, 1)
                        tandi43()
                    else
                        if fallout.global_var(26) == 2 then
                            if fallout.cur_map_index() == 24 then
                                tandi43b()
                            else
                                tandi36()
                            end
                        end
                    end
                end
            else
                fallout.set_global_var(217, 1)
                if fallout.global_var(26) == 0 then
                    tandi01()
                end
                if fallout.global_var(26) == 1 then
                    tandi37()
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function tandi00()
    fallout.giq_option(5, 57, 101, tandi15, 50)
    fallout.giq_option(4, 57, 102, tandi00_1, 50)
    fallout.giq_option(5, 57, 103, tandi23, 50)
    fallout.giq_option(4, 57, 104, tandi24, 50)
    fallout.giq_option(4, 57, 105, tandi28, 50)
end

function tandi00_1()
    if fallout.global_var(43) == 0 then
        tandi20()
    else
        if fallout.global_var(43) == 2 then
            tandi21()
        else
            tandi22()
        end
    end
end

function tandi01()
    fallout.gsay_reply(57, 106)
    fallout.giq_option(4, 57, fallout.message_str(57, 107) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(57, 108), tandi02, 50)
    fallout.giq_option(4, 57, fallout.message_str(57, 109) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(57, 110), tandi01a, 51)
    fallout.giq_option(-3, 57, 111, tandi29, 50)
end

function tandi01a()
    DownReact()
    tandi02()
end

function tandi02()
    fallout.gsay_reply(57, 112)
    fallout.giq_option(4, 57, 113, tandi03, 50)
    fallout.giq_option(5, 57, 114, tandi14, 49)
    fallout.giq_option(4, 57, 115, tandi04, 50)
    fallout.giq_option(4, 57, 116, tandi14, 49)
end

function tandi03()
    fallout.gsay_reply(57, 117)
    tandi00()
end

function tandi04()
    fallout.gsay_reply(57, 118)
    fallout.giq_option(5, 57, 119, tandi05, 50)
    fallout.giq_option(5, 57, 120, tandi12, 51)
    fallout.giq_option(4, 57, 121, tandi13, 50)
end

function tandi05()
    fallout.gsay_reply(57, 122)
    fallout.giq_option(0, 57, 123, tandi03, 50)
    fallout.giq_option(0, 57, 124, tandi28, 50)
end

function tandi06()
    fallout.gsay_message(57, 125, 50)
    tandix2()
end

function tandi12()
    DownReact()
    fallout.gsay_reply(57, 126)
    tandi00()
end

function tandi13()
    fallout.gsay_reply(57, 127)
    fallout.giq_option(5, 57, 128, tandi05, 50)
    fallout.giq_option(4, 57, 129, tandi03, 50)
end

function tandi14()
    fallout.gsay_reply(57, 130)
    fallout.giq_option(5, 57, 131, tandi05, 50)
    fallout.giq_option(5, 57, 132, tandi12, 51)
    fallout.giq_option(4, 57, 133, tandi13, 50)
end

function tandi15()
    if fallout.local_var(1) > 2 then
        fallout.gsay_reply(57, 134)
        if fallout.global_var(71) == 0 then
            fallout.set_global_var(71, 1)
        end
    else
        fallout.gsay_reply(57, 135)
    end
    fallout.giq_option(5, 57, 136, tandi16, 50)
end

function tandi16()
    fallout.gsay_reply(57, 137)
    tandi00()
end

function tandi20()
    fallout.gsay_reply(57, 138)
    tandi00()
end

function tandi21()
    fallout.gsay_reply(57, 139)
    tandi00()
end

function tandi22()
    fallout.gsay_reply(57, 140)
    tandi00()
end

function tandi23()
    if fallout.local_var(1) > 2 then
        fallout.gsay_reply(57, 141)
    else
        fallout.gsay_reply(57, 142)
    end
    fallout.giq_option(4, 57, 143, tandi16, 50)
    if fallout.local_var(1) > 2 then
        fallout.giq_option(4, 57, 144, tandi52, 50)
    end
end

function tandi24()
    fallout.gsay_reply(57, 145)
    fallout.giq_option(5, 57, 146, tandi05, 50)
    fallout.giq_option(5, 57, 147, tandi12, 51)
    fallout.giq_option(4, 57, 148, tandi13, 50)
end

function tandi27()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(57, 149, 51)
    else
        fallout.gsay_message(57, 150, 51)
    end
    tandix2()
end

function tandi28()
    if g5 < 1 then
        g5 = 1
        fallout.gsay_reply(57, 151)
        fallout.giq_option(0, 57, 152, tandix, 50)
    else
        tandix()
    end
end

function tandi29()
    fallout.gsay_reply(57, 153)
    tandix2()
end

function tandi30()
    fallout.gsay_reply(57, 154)
    fallout.giq_option(4, 57, 155, tandi03, 50)
    fallout.giq_option(4, 57, 156, tandi28, 50)
end

function tandi35()
    fallout.gsay_message(57, 157, 50)
    tandix()
end

function tandi36()
    fallout.gsay_reply(57, 158)
    fallout.giq_option(4, 57, 159, tandi03, 50)
    fallout.giq_option(6, 57, 160, tandi36a, 51)
    fallout.giq_option(4, 57, 161, tandi28, 50)
    fallout.giq_option(-3, 57, 162, tandi35, 50)
end

function tandi36a()
    BottomReact()
    tandi27()
end

function tandi37()
    fallout.gsay_reply(57, 163)
    fallout.giq_option(4, 57, fallout.message_str(57, 164) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(57, 165), tandi38, 50)
    fallout.giq_option(5, 57, 166, tandi42, 50)
    fallout.giq_option(-3, 57, 167, tandi43a, 50)
end

function tandi38()
    if fallout.global_var(114) == 1 then
        tandi38a()
    else
        tandi38b()
    end
end

function tandi38a()
    fallout.gsay_reply(57, 168)
    fallout.giq_option(4, 57, 169, tandiend, 50)
end

function tandi38b()
    fallout.gsay_reply(57, 168)
    fallout.giq_option(4, 57, 169, tandi39, 50)
    fallout.giq_option(5, 57, 170, tandi42, 50)
end

function tandi39()
    fallout.gsay_reply(57, 171)
    fallout.giq_option(4, 57, 172, tandi40, 50)
    fallout.giq_option(5, 57, 173, tandi41, 50)
end

function tandi40()
    fallout.gsay_message(57, 174, 50)
    tandix3()
end

function tandi41()
    fallout.gsay_message(57, 175, 50)
    tandix4()
end

function tandi42()
    fallout.gsay_reply(57, 176)
    fallout.giq_option(4, 57, 177, tandi40, 50)
    fallout.giq_option(5, 57, 178, tandi41, 50)
end

function tandi43()
    fallout.gsay_reply(57, 179)
    fallout.giq_option(4, 57, 180, tandi39, 50)
    fallout.giq_option(5, 57, 181, tandi42, 50)
    fallout.giq_option(-3, 57, 182, tandi43a, 50)
end

function tandi43a()
    fallout.gsay_message(57, 183, 50)
    tandix()
end

function tandi43b()
    fallout.gsay_message(57, 184, 50)
    tandix()
end

function tandi44()
    fallout.gsay_message(57, 185, 50)
end

function tandi45()
    fallout.gsay_message(57, 186, 50)
end

function tandi46()
    fallout.gsay_message(57, 187, 50)
end

function tandi47()
    fallout.gsay_message(57, 188, 50)
end

function tandi48()
    fallout.gsay_message(57, 189, 50)
end

function tandi49()
    fallout.gsay_message(57, 190, 50)
end

function tandi50()
    fallout.gsay_message(57, 191, 50)
end

function tandi51()
    fallout.gsay_message(57, 192, 50)
end

function tandi52()
    fallout.gsay_message(57, 193, 50)
end

function tandi53()
    fallout.gsay_message(57, 194, 50)
    if fallout.global_var(71) == 0 then
        fallout.set_global_var(71, 1)
    end
end

function tandi54()
    fallout.gsay_message(57, 195, 50)
    if fallout.global_var(73) == 0 then
        fallout.set_global_var(73, 1)
    end
end

function tandi55()
    fallout.gsay_message(57, 196, 50)
end

function tandi62()
    fallout.gsay_message(57, 197, 50)
end

function tandi63()
    fallout.gsay_message(57, 198, 50)
end

function tandi64()
    fallout.gsay_message(57, 199, 50)
end

function tandi65()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(57, 200), 2)
end

function tandi66()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(57, 201), 2)
    tandix5()
end

function tandi67()
    fallout.gsay_message(57, 202, 51)
end

function tandi68()
    fallout.gsay_message(57, 203, 51)
end

function tandi69()
    fallout.gsay_message(57, 204, 50)
end

function tandi70()
    fallout.gsay_message(57, 205, 50)
end

function tandi71()
    fallout.gsay_message(57, 206, 50)
end

function tandi72()
    fallout.gsay_message(57, 207, 50)
end

function tandix()
end

function tandixx()
end

function tandix1()
end

function tandix2()
end

function tandix3()
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
end

function tandix4()
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
end

function tandix5()
    fallout.set_local_var(5, 1)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
end

function tandiend()
end

function TandiSchedule()
    local v0 = 0
    v0 = fallout.game_time_hour()
    if v0 == 600 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), 18709, 0)
    else
        if v0 == 610 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 23232, 0)
        else
            if v0 == 615 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), 18492, 0)
            else
                if v0 == 645 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 13565, 0)
                else
                    if v0 == 650 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 15683, 0)
                    else
                        if v0 == 1000 then
                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 18709, 0)
                        else
                            if v0 == 1200 then
                                fallout.animate_move_obj_to_tile(fallout.self_obj(), 24678, 0)
                            else
                                if v0 == 1300 then
                                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 23232, 0)
                                else
                                    if v0 == 1305 then
                                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 23701, 0)
                                    else
                                        if v0 == 1600 then
                                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 17279, 0)
                                        else
                                            if v0 == 1900 then
                                                fallout.animate_move_obj_to_tile(fallout.self_obj(), 13565, 0)
                                            else
                                                if v0 == 1905 then
                                                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 18709, 0)
                                                else
                                                    if v0 == 2100 then
                                                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 24678, 0)
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
        end
    end
end

function follow_player()
    if fallout.global_var(26) ~= 5 then
        fallout.set_global_var(213, 1)
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 8 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), 1)
    else
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 3 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), 0)
        end
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 1)
end

function Random_Following()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 8 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), 1 | 16)
    else
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 3 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), 0 | 16)
        end
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 2)
end

function map_update_p_proc()
end

function map_enter_p_proc()
end

function critter_p_proc()
    if fallout.cur_map_index() == 24 then
        if (fallout.map_var(2) ~= 0) and (fallout.local_var(5) == 0) then
            fallout.set_global_var(26, 5)
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
            fallout.set_local_var(5, 1)
            if fallout.party_member_obj(16777279) == 0 then
                fallout.party_add(fallout.self_obj())
            end
        end
    end
    if (fallout.global_var(26) == 5) and (fallout.local_var(5) == 0) then
        fallout.set_local_var(5, 1)
        if fallout.party_member_obj(16777279) == 0 then
            fallout.party_add(fallout.self_obj())
        end
    end
    if fallout.party_member_obj(16777279) ~= 0 then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 8 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), 1), 1)
        else
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 4 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), 3), 0)
            end
        end
    end
    if (fallout.cur_map_index() == 26) or (fallout.cur_map_index() == 25) then
        if (fallout.global_var(26) == 1) and (fallout.global_var(264) == 0) then
            fallout.party_add(fallout.self_obj())
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            fallout.set_global_var(264, 1)
        else
            if (fallout.global_var(26) > 1) and (fallout.global_var(264) == 3) then
                fallout.party_remove(fallout.self_obj())
                fallout.animate_move_obj_to_tile(fallout.self_obj(), 16710, 0)
                fallout.set_obj_visibility(fallout.self_obj(), 0)
                fallout.set_global_var(264, 4)
            end
        end
    else
        if fallout.cur_map_index() == 24 then
            if (fallout.global_var(26) == 1) and (fallout.global_var(264) == 1) then
                fallout.party_remove(fallout.self_obj())
                fallout.critter_attempt_placement(fallout.self_obj(), 17905, 0)
                fallout.set_obj_visibility(fallout.self_obj(), 0)
                fallout.set_global_var(264, 2)
            else
                if (fallout.global_var(26) == 5) and (fallout.global_var(264) == 2) then
                    fallout.party_add(fallout.self_obj())
                    fallout.set_global_var(264, 3)
                end
            end
        end
    end
    if (fallout.global_var(26) ~= 1) and (fallout.global_var(26) ~= 5) then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if fallout.global_var(246) == 1 then
                g12 = 1
            end
        end
        if g12 then
            g12 = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
        TandiSchedule()
        if fallout.random(1, 20) == 1 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(2, 4)), 0)
        end
    end
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
    g13 = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.map_update_p_proc = map_update_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.critter_p_proc = critter_p_proc
return exports
