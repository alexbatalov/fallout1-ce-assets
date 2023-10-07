local fallout = require("fallout")

local start
local do_dialogue
local first
local notfirst
local garl00
local garl01
local garl01a
local garl01b
local garl01c
local garl01d
local garl02
local garl03
local garl03a
local garl04
local garl04a
local garl04b
local garl04c
local garl05
local garl06
local garl06a
local garl07
local garl08
local garl09
local garl10
local garl11
local garl12
local garl12a
local garl12b
local garl15
local garl15a
local garl16
local garl17
local garl17a
local garl18
local garl19
local garl20
local garl21
local garl22
local garl23
local garl24
local garl25
local garl26
local garl27
local garl28
local garl29
local garl30
local garl31
local garl32
local garl33
local garl34
local garl35
local garl36
local garl37
local garl37a
local garl38
local garl38a
local garl39
local garl39a
local garl40
local garl41
local garl42
local garl43
local garlx
local garlend
local freetandi
local garlcbt
local honorcbt
local honorarea
local garlbarter
local return_to_map
local Critter_Action
local damage_p_proc

local HOSTILE = 0
local only_once = 1
local temp = 0
local tandi_pid_ptr = 0

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

local exit_line = 0

function start()
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 6)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 22)
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 22 then
            if fallout.fixed_param() == 1 then
                if fallout.global_var(611) ~= 1 then
                    fallout.dialogue_system_enter()
                end
            else
                if fallout.fixed_param() == 2 then
                    freetandi()
                else
                    if fallout.fixed_param() == 3 then
                        honorarea()
                    else
                        if fallout.fixed_param() == 4 then
                            return_to_map()
                            freetandi()
                        end
                    end
                end
            end
        else
            if fallout.script_action() == 21 then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(137, 100))
            else
                if fallout.script_action() == 4 then
                    HOSTILE = 1
                else
                    if fallout.script_action() == 12 then
                        Critter_Action()
                        if HOSTILE then
                            HOSTILE = 0
                            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                        end
                    else
                        if fallout.script_action() == 14 then
                            damage_p_proc()
                        else
                            if fallout.script_action() == 18 then
                                if fallout.local_var(7) == 1 then
                                    fallout.move_to(fallout.dude_obj(), fallout.local_var(6), 0)
                                    fallout.move_obj_inven_to_obj(fallout.external_var("Garls_Inven_Ptr"), fallout.dude_obj())
                                    fallout.set_global_var(26, 5)
                                    fallout.set_map_var(2, 2)
                                    fallout.obj_unlock(fallout.external_var("Cell_Door_Ptr"))
                                end
                                if fallout.source_obj() == fallout.dude_obj() then
                                    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                                        fallout.set_global_var(156, 1)
                                        fallout.set_global_var(157, 0)
                                    end
                                    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                                        fallout.set_global_var(157, 1)
                                        fallout.set_global_var(156, 0)
                                    end
                                    fallout.set_global_var(160, fallout.global_var(160) + 1)
                                    if (fallout.global_var(160) % 6) == 0 then
                                        fallout.set_global_var(155, fallout.global_var(155) + 1)
                                    end
                                end
                                if fallout.local_var(7) == 0 then
                                    fallout.set_global_var(254, 1)
                                    fallout.set_global_var(611, 0)
                                end
                                fallout.set_global_var(114, 1)
                                fallout.set_global_var(115, fallout.global_var(115) - 1)
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    if fallout.elevation(fallout.self_obj()) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(137, 208), 2)
        fallout.add_timer_event(fallout.self_obj(), 5, 4)
    else
        if fallout.external_var("killing_women") then
            garl39a()
        else
            fallout.set_local_var(3, 1)
            get_reaction()
            fallout.start_gdialog(137, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if fallout.external_var("women_killed") > 1 then
                garl11()
            else
                if fallout.global_var(116) then
                    garl01()
                else
                    if fallout.local_var(4) < 1 then
                        first()
                        fallout.set_local_var(4, 1)
                    else
                        notfirst()
                    end
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
    if fallout.obj_carrying_pid_obj(fallout.dude_obj(), 212) then
        fallout.rm_obj_from_inven(fallout.dude_obj(), tandi_pid_ptr)
        fallout.destroy_object(tandi_pid_ptr)
        fallout.set_global_var(26, 5)
        fallout.set_map_var(2, 2)
        fallout.obj_unlock(fallout.external_var("Cell_Door_Ptr"))
        fallout.add_timer_event(fallout.self_obj(), 1, 2)
    else
        if fallout.obj_carrying_pid_obj(fallout.self_obj(), 212) then
            fallout.rm_obj_from_inven(fallout.self_obj(), tandi_pid_ptr)
            fallout.destroy_object(tandi_pid_ptr)
            garl20()
        end
    end
end

function first()
    if fallout.global_var(26) > 1 then
        garl43()
    else
        if fallout.global_var(26) > 0 then
            garl12()
        else
            garl32()
        end
    end
end

function notfirst()
    if fallout.global_var(26) > 1 then
        garl43()
    else
        if fallout.global_var(26) > 0 then
            garl22()
        else
            garl41()
        end
    end
end

function garl00()
    fallout.gsay_message(137, 101, 50)
    garlcbt()
end

function garl01()
    fallout.gsay_reply(137, 102)
    fallout.giq_option(-3, 137, 207, garl09, 50)
    fallout.giq_option(4, 137, 103, garl01a, 50)
    fallout.giq_option(5, 137, 104, garl01b, 50)
    fallout.giq_option(6, 137, 105, garl01c, 50)
end

function garl01a()
    garl02()
end

function garl01b()
    garl03()
end

function garl01c()
    garl04()
end

function garl01d()
    fallout.gsay_reply(137, 106)
    fallout.giq_option(4, 137, 107, garl02, 50)
    fallout.giq_option(5, 137, 108, garl03, 50)
    fallout.giq_option(6, 137, 109, garl04, 50)
end

function garl02()
    fallout.gsay_message(137, 110, 50)
    fallout.set_global_var(116, 0)
    garlcbt()
end

function garl03()
    fallout.gsay_reply(137, 111)
    fallout.giq_option(8, 137, 112, garl03a, 50)
end

function garl03a()
    fallout.set_global_var(116, 0)
    garlcbt()
end

function garl04()
    fallout.gsay_reply(137, 113)
    fallout.giq_option(6, 137, 114, garl04a, 50)
    fallout.giq_option(6, 137, 115, garl04b, 50)
end

function garl04a()
    garl06()
end

function garl04b()
    garl05()
end

function garl04c()
    fallout.gsay_reply(137, 116)
    fallout.giq_option(6, 137, 117, garl06, 50)
    fallout.giq_option(6, 137, 118, garl05, 50)
end

function garl05()
    fallout.gsay_message(137, 119, 50)
    fallout.set_global_var(116, 0)
    garlcbt()
end

function garl06()
    fallout.gsay_reply(137, 120)
    if fallout.global_var(26) == 1 then
        fallout.giq_option(6, 137, 121, garl06a, 50)
    end
    fallout.giq_option(6, 137, 122, garl10, 50)
    fallout.giq_option(6, 137, 123, garl10, 50)
end

function garl06a()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) or fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 10)) then
        garl08()
    else
        garl09()
    end
end

function garl07()
    fallout.gsay_message(137, 124, 50)
    fallout.giq_option(6, 137, 125, garl08, 50)
end

function garl08()
    fallout.gsay_message(137, 126, 50)
    fallout.set_global_var(116, 0)
    freetandi()
end

function garl09()
    fallout.gsay_message(137, 127, 50)
    garlcbt()
end

function garl10()
    fallout.gsay_message(137, 128, 50)
    fallout.set_global_var(116, 0)
    garlcbt()
end

function garl11()
    if fallout.external_var("women_killed") > 1 then
        fallout.set_external_var("women_killed", 0)
        fallout.gsay_message(137, 129, 50)
        garlcbt()
    end
end

function garl12()
    fallout.gsay_reply(137, 130)
    if fallout.global_var(218) == 1 then
        fallout.giq_option(4, 137, 131, garl12b, 50)
        fallout.giq_option(5, 137, 133, garl15, 50)
    else
        fallout.giq_option(5, 137, 200, garl12a, 50)
    end
    fallout.giq_option(4, 137, 132, garlcbt, 50)
    fallout.giq_option(-3, 137, 134, garl17, 50)
end

function garl12a()
    fallout.gsay_message(137, 201, 50)
end

function garl12b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 10)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
        garl15()
    else
        garl10()
    end
end

function garl15()
    fallout.gsay_reply(137, 140)
    if fallout.has_skill(fallout.dude_obj(), 14) >= 45 then
        fallout.giq_option(6, 137, 141, garl15a, 50)
    end
    fallout.giq_option(6, 137, 142, garl18, 50)
    fallout.giq_option(6, 137, 143, garl21, 50)
    fallout.giq_option(5, 137, 203, garl28, 50)
end

function garl15a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 10)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
        garl16()
    else
        garl17()
    end
end

function garl16()
    fallout.gsay_message(137, 145, 50)
    freetandi()
end

function garl17()
    fallout.gsay_message(137, 146, 50)
    garlcbt()
end

function garl17a()
    fallout.gsay_message(137, 204, 50)
    garlcbt()
end

function garl18()
    tandi_pid_ptr = fallout.create_object_sid(212, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.self_obj(), tandi_pid_ptr)
    fallout.gsay_message(137, 147, 50)
    garlbarter()
end

function garl19()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(137, 148), 2)
    freetandi()
end

function garl20()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(137, 149), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(137, 205), 2)
    end
    garlcbt()
end

function garl21()
    fallout.gsay_message(137, 150, 50)
    garlcbt()
end

function garl22()
    fallout.gsay_reply(137, 151)
    fallout.giq_option(4, 137, 152, garl23, 50)
    fallout.giq_option(4, 137, 153, garl24, 50)
    fallout.giq_option(-3, 137, 207, garl17, 50)
end

function garl23()
    fallout.gsay_message(137, 155, 50)
end

function garl24()
    fallout.gsay_reply(137, 156)
    fallout.giq_option(4, 137, 157, garl25, 50)
    fallout.giq_option(6, 137, 158, garl18, 50)
    fallout.giq_option(6, 137, 159, garl15a, 50)
end

function garl25()
    fallout.gsay_reply(137, 160)
    fallout.giq_option(4, 137, 161, garl26, 50)
    fallout.giq_option(4, 137, 162, garl27, 50)
end

function garl26()
    fallout.gsay_message(137, 163, 50)
    garlcbt()
end

function garl27()
    fallout.gsay_reply(137, 164)
    fallout.giq_option(4, 137, 165, garl26, 50)
    fallout.giq_option(4, 137, 166, garl28, 50)
    fallout.giq_option(6, 137, 167, garl29, 50)
end

function garl28()
    fallout.gsay_reply(137, 168)
    fallout.giq_option(4, 137, 169, honorcbt, 50)
end

function garl29()
    fallout.gsay_reply(137, 170)
    fallout.giq_option(4, 137, 171, garlcbt, 50)
end

function garl30()
    fallout.gsay_message(137, 172, 50)
    freetandi()
end

function garl31()
    fallout.gsay_message(137, 173, 50)
end

function garl32()
    fallout.gsay_reply(137, 174)
    fallout.giq_option(4, 137, 175, garl33, 50)
    fallout.giq_option(6, 137, 176, garl34, 50)
    fallout.giq_option(-3, 137, 154, garl23, 50)
end

function garl33()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(137, 177, 50)
    else
        fallout.gsay_message(137, 206, 50)
    end
    garlcbt()
end

function garl34()
    fallout.gsay_reply(137, 178)
    fallout.giq_option(6, 137, 179, garl35, 50)
    fallout.giq_option(6, 137, 180, garl33, 50)
end

function garl35()
    fallout.gsay_reply(137, 181)
    fallout.giq_option(4, 137, 182, garl37, 50)
    fallout.giq_option(4, 137, 183, garl36, 50)
end

function garl36()
    fallout.gsay_message(137, 184, 50)
end

function garl37()
    fallout.gsay_reply(137, 185)
    fallout.giq_option(4, 137, 186, garl38, 50)
    fallout.giq_option(4, 137, 187, garl37a, 50)
end

function garl37a()
    fallout.set_external_var("signal_women", 2)
    fallout.set_external_var("killing_women", 1)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 1)
end

function garl38()
    fallout.set_external_var("women_killed", 0)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(137, 188, 50)
    else
        fallout.gsay_message(137, 189, 50)
    end
    garlcbt()
end

function garl38a()
    fallout.set_external_var("women_killed", 0)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(137, 188), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(137, 189), 2)
    end
    garlcbt()
end

function garl39()
    fallout.gsay_message(137, 190, 50)
    garlcbt()
end

function garl39a()
    fallout.set_external_var("killing_women", 0)
    if fallout.external_var("women_killed") > 1 then
        garl40()
    else
        garl38a()
    end
end

function garl40()
    fallout.set_external_var("women_killed", 0)
    TopReact()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(137, 191), 2)
    temp = 500
    fallout.display_msg(fallout.message_str(238, 100) + temp + fallout.message_str(238, 102))
    fallout.give_exp_points(temp)
    fallout.set_global_var(155, fallout.global_var(155) + -2)
    fallout.set_global_var(611, 1)
end

function garl41()
    fallout.gsay_reply(137, 192)
    fallout.giq_option(4, 137, 193, garl23, 50)
    fallout.giq_option(6, 137, 194, garl42, 50)
    fallout.giq_option(-3, 137, 195, garl23, 50)
end

function garl42()
    fallout.gsay_message(137, 196, 50)
end

function garl43()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(137, 197, 50)
    else
        fallout.gsay_message(137, 198, 50)
    end
    garlcbt()
end

function garlx()
end

function garlend()
end

function freetandi()
    fallout.set_global_var(26, 5)
    fallout.set_map_var(2, 2)
    fallout.obj_unlock(fallout.external_var("Cell_Door_Ptr"))
end

function garlcbt()
    HOSTILE = 1
end

function honorcbt()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 3)
end

function honorarea()
    local v0 = 0
    fallout.set_local_var(6, fallout.tile_num(fallout.dude_obj()))
    fallout.set_local_var(7, 1)
    fallout.move_to(fallout.dude_obj(), 20102, 1)
    fallout.move_to(fallout.self_obj(), 20301, 1)
    v0 = fallout.critter_inven_obj(fallout.dude_obj(), 0)
    fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
    fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Garls_Inven_Ptr"))
    fallout.move_obj_inven_to_obj(fallout.dude_obj(), fallout.external_var("Garls_Inven_Ptr"))
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.wield_obj_critter(fallout.dude_obj(), v0)
    if fallout.party_member_obj(16777292) ~= 0 then
        fallout.move_to(fallout.party_member_obj(16777292), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 0, 10), 1)
    end
    if fallout.party_member_obj(16777518) ~= 0 then
        fallout.move_to(fallout.party_member_obj(16777518), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 10), 1)
    end
    if fallout.party_member_obj(16777426) ~= 0 then
        fallout.move_to(fallout.party_member_obj(16777426), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 2, 10), 1)
    end
    if fallout.party_member_obj(16777338) ~= 0 then
        fallout.move_to(fallout.party_member_obj(16777338), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 10), 1)
    end
    if fallout.party_member_obj(16777279) ~= 0 then
        fallout.move_to(fallout.party_member_obj(16777279), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 5, 10), 1)
    end
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 43)
    garlcbt()
end

function garlbarter()
    fallout.gdialog_mod_barter(0)
    fallout.gsay_message(137, "", 50)
end

function return_to_map()
    fallout.move_to(fallout.dude_obj(), fallout.local_var(6), 0)
    fallout.move_obj_inven_to_obj(fallout.external_var("Garls_Inven_Ptr"), fallout.dude_obj())
    fallout.set_global_var(26, 5)
    fallout.set_map_var(2, 2)
    fallout.obj_unlock(fallout.external_var("Cell_Door_Ptr"))
end

function Critter_Action()
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    else
        if fallout.global_var(116) then
            fallout.set_global_var(254, 0)
        else
            if fallout.global_var(213) then
                fallout.set_global_var(254, 1)
            end
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if fallout.global_var(214) then
                    fallout.set_global_var(254, 1)
                end
            end
        end
    end
    if fallout.global_var(254) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        HOSTILE = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        HOSTILE = 0
    end
end

function damage_p_proc()
    if fallout.local_var(7) == 0 then
        fallout.set_global_var(254, 1)
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
    exit_line = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
return exports
