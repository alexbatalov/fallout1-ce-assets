local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local timed_event_p_proc
local look_at_p_proc
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
local critter_p_proc
local damage_p_proc

local hostile = false
local initialized = false
local tandi_pid_ptr = nil

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 6)
        fallout.critter_add_trait(self_obj, 1, 5, 22)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.elevation(self_obj) == 1 then
        fallout.float_msg(self_obj, fallout.message_str(137, 208), 2)
        fallout.add_timer_event(self_obj, 5, 4)
    else
        if fallout.external_var("killing_women") then
            garl39a()
        else
            fallout.set_local_var(3, 1)
            reaction.get_reaction()
            fallout.start_gdialog(137, self_obj, 4, -1, -1)
            fallout.gsay_start()
            if fallout.external_var("women_killed") > 1 then
                garl11()
            elseif fallout.global_var(116) ~= 0 then
                garl01()
            elseif fallout.local_var(4) < 1 then
                first()
                fallout.set_local_var(4, 1)
            else
                notfirst()
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
    if fallout.obj_carrying_pid_obj(dude_obj, 212) then
        fallout.rm_obj_from_inven(dude_obj, tandi_pid_ptr)
        fallout.destroy_object(tandi_pid_ptr)
        fallout.set_global_var(26, 5)
        fallout.set_map_var(2, 2)
        fallout.obj_unlock(fallout.external_var("Cell_Door_Ptr"))
        fallout.add_timer_event(self_obj, 1, 2)
    else
        if fallout.obj_carrying_pid_obj(self_obj, 212) then
            fallout.rm_obj_from_inven(self_obj, tandi_pid_ptr)
            fallout.destroy_object(tandi_pid_ptr)
            garl20()
        end
    end
end

function destroy_p_proc()
    if fallout.local_var(7) == 1 then
        fallout.move_to(fallout.dude_obj(), fallout.local_var(6), 0)
        fallout.move_obj_inven_to_obj(fallout.external_var("Garls_Inven_Ptr"),
            fallout.dude_obj())
        fallout.set_global_var(26, 5)
        fallout.set_map_var(2, 2)
        fallout.obj_unlock(fallout.external_var("Cell_Door_Ptr"))
    end
    reputation.inc_evil_critter()
    if fallout.local_var(7) == 0 then
        fallout.set_global_var(254, 1)
        fallout.set_global_var(611, 0)
    end
    fallout.set_global_var(114, 1)
    fallout.set_global_var(115, fallout.global_var(115) - 1)
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        if fallout.global_var(611) ~= 1 then
            fallout.dialogue_system_enter()
        end
    elseif event == 2 then
        freetandi()
    elseif event == 3 then
        honorarea()
    elseif event == 4 then
        return_to_map()
        freetandi()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(137, 100))
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
    local dude_obj = fallout.dude_obj()
    if fallout.is_success(fallout.do_check(dude_obj, 3, 0)) or fallout.is_success(fallout.roll_vs_skill(dude_obj, 14, 10)) then
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
    local dude_obj = fallout.dude_obj()
    if fallout.is_success(fallout.roll_vs_skill(dude_obj, 14, 10)) or fallout.is_success(fallout.do_check(dude_obj, 3, 0)) then
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
    local dude_obj = fallout.dude_obj()
    if fallout.is_success(fallout.roll_vs_skill(dude_obj, 14, 10)) or fallout.is_success(fallout.do_check(dude_obj, 3, 0)) then
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
    reaction.TopReact()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(137, 191), 2)
    local xp = 500
    fallout.display_msg(fallout.message_str(238, 100) .. xp .. fallout.message_str(238, 102))
    fallout.give_exp_points(xp)
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
    hostile = true
end

function honorcbt()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 3)
end

local PARTY_MEMBER_LOCATIONS = {
    [16777292] = 0,
    [16777518] = 1,
    [16777426] = 2,
    [16777338] = 4,
    [16777279] = 5,
}

function honorarea()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local garls_inven_obj = fallout.external_var("Garls_Inven_Ptr")
    fallout.set_local_var(6, fallout.tile_num(dude_obj))
    fallout.set_local_var(7, 1)
    fallout.move_to(dude_obj, 20102, 1)
    fallout.move_to(self_obj, 20301, 1)
    local item_obj = fallout.critter_inven_obj(dude_obj, 0)
    fallout.rm_obj_from_inven(dude_obj, item_obj)
    fallout.move_obj_inven_to_obj(self_obj, garls_inven_obj)
    fallout.move_obj_inven_to_obj(dude_obj, garls_inven_obj)
    fallout.add_obj_to_inven(dude_obj, item_obj)
    fallout.wield_obj_critter(dude_obj, item_obj)
    local dude_tile_num = fallout.tile_num(dude_obj)
    for pid, rotation in ipairs(PARTY_MEMBER_LOCATIONS) do
        local party_member_obj = fallout.party_member_obj(pid)
        if party_member_obj ~= nil then
            fallout.move_to(party_member_obj, fallout.tile_num_in_direction(dude_tile_num, rotation, 10), 1)
        end
    end
    fallout.critter_add_trait(self_obj, 1, 6, 87)
    fallout.critter_add_trait(self_obj, 1, 5, 43)
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

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local self_can_see_dude = fallout.obj_can_see_obj(self_obj, dude_obj)
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    elseif fallout.global_var(116) ~= 0 then
        fallout.set_global_var(254, 0)
    else
        if fallout.global_var(213) ~= 0 then
            fallout.set_global_var(254, 1)
        end
        if self_can_see_dude then
            if fallout.global_var(214) ~= 0 then
                fallout.set_global_var(254, 1)
            end
        end
    end
    if fallout.global_var(254) ~= 0 and self_can_see_dude then
        hostile = true
    end
    if fallout.tile_distance_objs(self_obj, dude_obj) > 12 then
        hostile = false
    end
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
end

function damage_p_proc()
    if fallout.local_var(7) == 0 then
        fallout.set_global_var(254, 1)
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
