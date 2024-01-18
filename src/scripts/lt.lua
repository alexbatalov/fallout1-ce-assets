local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local timed_event_p_proc
local Ltcbt
local Lt01
local Lt01a
local Lt01b
local Lt02
local Lt03
local Lt04
local Lt05
local Lt06
local Lt07
local Lt08
local Lt08a
local Lt09
local Lt10
local Lt11
local Lt12
local Lt13
local Lt14
local Lt15
local Lt16
local Lt17
local Lt18
local Lt18a
local Lt19
local Lt20
local Lt21
local Lt22
local Lt23
local Lt24
local Lt25
local Lt26
local Lt27
local Lt28
local Lt29
local Lt30
local Lt31
local Lt32
local Lt33
local Lt34
local Lt35
local Lt35a
local Lt36
local Lt37
local Lt37b
local Lt38
local Lt39
local Lt39a
local Lt39b
local Lt40
local Lt40a
local Lt41
local Lt42
local Lt43
local Lt44
local Lt45
local Lt46
local Lt48
local Ltx1
local Ltx2
local Ltx3
local Ltx4
local Ltx6
local Torture
local Lt40_5
local Lt50
local Lt51
local Lt52
local Lt53
local Lt54
local Lt55
local Lt56
local Lt57
local Lt58
local Lt59
local Lt60
local Lt61
local Lt62
local Lt63
local Lt64
local Lt65
local Lt66

local hostile = false
local initialized = false
local hit_dude = false
local torture_setting = 0
local End_The_Game = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 49)
        fallout.set_external_var("Lt_ptr", self_obj)
        if fallout.local_var(6) == 0 then
            local item_obj = fallout.create_object_sid(58, 0, 0, 947)
            fallout.add_obj_to_inven(self_obj, item_obj)
            fallout.set_local_var(6, 1)
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 2 then
        if fallout.global_var(276) ~= 0 then
            if fallout.random(0, 3) == 3 then
                fallout.critter_injure(fallout.dude_obj(), 1)
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        local self_obj = fallout.self_obj()
        local dude_obj = fallout.dude_obj()
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            if torture_setting > 0 then
                if not hit_dude then
                    Torture()
                end
            else
                if fallout.tile_distance_objs(self_obj, dude_obj) < 12 then
                    if fallout.global_var(276) == 0 then
                        if fallout.local_var(4) == 0 then
                            fallout.dialogue_system_enter()
                        elseif fallout.local_var(5) == 0 then
                            fallout.dialogue_system_enter()
                        end
                    else
                        hostile = true
                    end
                end
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_global_var(54, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(50, 100))
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(7) == 0 then
        fallout.start_gdialog(50, fallout.self_obj(), 4, 11, 6)
        fallout.gsay_start()
        if torture_setting == 2 then
            Lt36()
            torture_setting = 3
        elseif torture_setting == 3 then
            Lt37b()
            torture_setting = 4
        elseif torture_setting == 4 then
            Lt38()
            torture_setting = 5
        elseif fallout.global_var(57) == 1 then
            Lt01()
        elseif fallout.global_var(57) == 2 then
            Lt41()
        elseif fallout.global_var(57) == 3 then
            Lt46()
        else
            Lt45()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(50, 236), 2)
        hostile = true
    end
    if fallout.local_var(7) == 1 then
        fallout.set_local_var(7, 2)
        fallout.gfade_out(600)
        fallout.move_obj_inven_to_obj(fallout.dude_obj(), fallout.external_var("VWeapLocker_ptr"))
        fallout.move_to(fallout.dude_obj(), 25543, 0)
        fallout.critter_injure(fallout.dude_obj(), 2)
        fallout.reg_anim_func(2, fallout.dude_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(fallout.dude_obj(), 48, -1)
        fallout.reg_anim_animate(fallout.dude_obj(), 37, -1)
        fallout.reg_anim_func(3, 0)
        fallout.gfade_in(600)
    end
    if End_The_Game then
        fallout.set_obj_visibility(fallout.dude_obj(), true)
        fallout.move_to(fallout.dude_obj(), 12528, 1)
        fallout.move_to(fallout.self_obj(), 12528, 1)
        fallout.play_gmovie(10)
        fallout.play_gmovie(7)
        fallout.metarule(13, 0)
    end
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        if torture_setting == 1 then
            fallout.critter_dmg(fallout.dude_obj(), fallout.get_critter_stat(fallout.dude_obj(), 35) // 3, 0)
        elseif torture_setting == 2 then
            fallout.critter_dmg(fallout.dude_obj(), fallout.get_critter_stat(fallout.dude_obj(), 35) // 2, 0)
        elseif torture_setting == 3 then
            fallout.critter_dmg(fallout.dude_obj(), fallout.get_critter_stat(fallout.dude_obj(), 35) - 1, 0)
        end
        fallout.anim(fallout.dude_obj(), 37, 0)
        torture_setting = torture_setting + 1
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 2)
    elseif event == 2 then
        hit_dude = false
        fallout.game_ui_enable()
        fallout.dialogue_system_enter()
    end
end

function Ltcbt()
    hostile = true
end

function Lt01()
    fallout.gsay_reply(50, 101)
    fallout.giq_option(4, 50, 102, Lt02, 50)
    fallout.giq_option(4, 50, 103, Lt01a, 50)
    fallout.giq_option(5, 50, 104, Lt03, 50)
    fallout.giq_option(-3, 50, 105, Lt48, 50)
end

function Lt01a()
    fallout.gsay_reply(50, 106)
    fallout.giq_option(4, 50, 107, Lt35, 50)
    fallout.giq_option(4, 50, 108, Lt03, 50)
    fallout.giq_option(4, 50, 109, Lt01b, 49)
end

function Lt01b()
    fallout.gsay_message(50, 110, 50)
    Ltx3()
end

function Lt02()
    fallout.gsay_reply(50, 111)
    fallout.giq_option(4, 50, 112, Lt35a, 50)
    fallout.giq_option(4, 50, 113, Lt03, 50)
    fallout.giq_option(4, 50, 114, Lt35, 50)
    fallout.giq_option(4, 50, 115, Lt40, 50)
end

function Lt03()
    fallout.gsay_reply(50, 116)
    fallout.giq_option(4, 50, 117, Lt04, 50)
    fallout.giq_option(4, 50, 118, Lt04, 50)
    fallout.giq_option(4, 50, 119, Lt05, 50)
end

function Lt04()
    fallout.gsay_reply(50, 120)
    fallout.giq_option(4, 50, 121, Lt05, 50)
    fallout.giq_option(4, 50, 122, Lt35, 50)
    fallout.giq_option(5, 50, 123, Lt35a, 50)
end

function Lt05()
    fallout.gsay_message(50, 124, 50)
    Lt06()
end

function Lt06()
    fallout.giq_option(5, 50, 125, Lt07, 50)
    fallout.giq_option(6, 50, 126, Lt20, 50)
    fallout.giq_option(4, 50, 127, Lt27, 50)
    fallout.giq_option(4, 50, 128, Lt34, 50)
end

function Lt07()
    fallout.gsay_reply(50, 129)
    fallout.giq_option(5, 50, 130, Lt10, 50)
    fallout.giq_option(5, 50, 131, Lt08, 50)
    fallout.giq_option(4, 50, 132, Lt20, 50)
end

function Lt08()
    fallout.gsay_reply(50, 133)
    fallout.giq_option(4, 50, 134, Lt08a, 50)
end

function Lt08a()
    fallout.gsay_message(50, 135, 50)
    Lt06()
end

function Lt09()
    fallout.gsay_message(50, 136, 50)
    Lt06()
end

function Lt10()
    fallout.gsay_reply(50, 137)
    fallout.giq_option(4, 50, 138, Lt11, 50)
end

function Lt11()
    fallout.gsay_reply(50, 139)
    fallout.giq_option(4, 50, 140, Lt12, 50)
    fallout.giq_option(6, 50, 141, Lt14, 50)
    fallout.giq_option(6, 50, 142, Lt13, 50)
end

function Lt12()
    fallout.gsay_reply(50, 143)
    fallout.giq_option(6, 50, 144, Lt13, 50)
    fallout.giq_option(4, 50, 145, Lt19, 50)
end

function Lt13()
    fallout.gsay_reply(50, 146)
    fallout.giq_option(6, 50, 147, Lt14, 50)
    fallout.giq_option(5, 50, 148, Lt18a, 51)
end

function Lt14()
    fallout.gsay_reply(50, 149)
    fallout.giq_option(6, 50, 150, Lt15, 50)
end

function Lt15()
    fallout.gsay_reply(50, 151)
    fallout.giq_option(6, 50, 152, Lt16, 50)
end

function Lt16()
    fallout.gsay_reply(50, 153)
    fallout.giq_option(6, 50, 154, Lt17, 50)
end

function Lt17()
    fallout.gsay_reply(50, 155)
    fallout.giq_option(6, 50, 156, Lt09, 50)
    fallout.giq_option(6, 50, 157, Lt18a, 51)
end

function Lt18()
    fallout.gsay_reply(50, 158)
    fallout.giq_option(6, 50, 159, Lt35, 51)
    fallout.giq_option(6, 50, 160, Lt09, 50)
end

function Lt18a()
    reaction.DownReact()
    Lt18()
end

function Lt19()
    fallout.gsay_reply(50, 161)
    fallout.giq_option(4, 50, 162, Lt18, 50)
    fallout.giq_option(4, 50, 163, Lt14, 50)
end

function Lt20()
    fallout.gsay_reply(50, 164)
    fallout.giq_option(6, 50, 165, Lt21, 50)
    fallout.giq_option(4, 50, 166, Lt10, 50)
end

function Lt21()
    fallout.gsay_reply(50, 167)
    fallout.giq_option(6, 50, 168, Lt22, 50)
    fallout.giq_option(6, 50, 169, Lt29, 50)
end

function Lt22()
    fallout.gsay_reply(50, 170)
    fallout.giq_option(6, 50, 171, Lt23, 50)
    fallout.giq_option(6, 50, 172, Lt26, 50)
end

function Lt23()
    fallout.gsay_reply(50, 173)
    fallout.giq_option(6, 50, 174, Lt24, 50)
    fallout.giq_option(6, 50, 175, Lt25, 50)
end

function Lt24()
    fallout.gsay_reply(50, 176)
    fallout.giq_option(6, 50, 177, Lt18a, 51)
    fallout.giq_option(6, 50, 178, Lt09, 50)
end

function Lt25()
    fallout.gsay_reply(50, 179)
    fallout.giq_option(4, 50, 180, Lt18, 50)
    fallout.giq_option(6, 50, 181, Lt28, 50)
end

function Lt26()
    fallout.gsay_reply(50, 182)
    fallout.giq_option(5, 50, 183, Lt27, 50)
    fallout.giq_option(6, 50, 184, Lt28, 50)
end

function Lt27()
    fallout.gsay_reply(50, 185)
    fallout.giq_option(4, 50, 186, Lt35, 50)
    fallout.giq_option(6, 50, 187, Lt08a, 50)
    fallout.giq_option(6, 50, 188, Lt30, 50)
end

function Lt28()
    fallout.gsay_reply(50, 189)
    Lt06()
end

function Lt29()
    fallout.gsay_reply(50, 190)
    fallout.giq_option(4, 50, 191, Lt22, 50)
    fallout.giq_option(4, 50, 192, Lt28, 50)
    fallout.giq_option(4, 50, 193, Lt23, 50)
end

function Lt30()
    fallout.gsay_reply(50, 194)
    fallout.giq_option(6, 50, 195, Lt31, 50)
    fallout.giq_option(7, 50, 196, Lt33, 50)
end

function Lt31()
    fallout.gsay_reply(50, 197)
    fallout.giq_option(6, 50, 198, Lt32, 50)
end

function Lt32()
    fallout.gsay_reply(50, 199)
    fallout.giq_option(6, 50, 200, Lt35, 51)
    fallout.giq_option(6, 50, 201, Lt28, 50)
end

function Lt33()
    fallout.gsay_reply(50, 202)
    fallout.giq_option(6, 50, 203, Lt35, 51)
    fallout.giq_option(6, 50, 204, Lt08a, 50)
end

function Lt34()
    fallout.gsay_reply(50, 205)
    fallout.giq_option(4, 50, 206, Lt35, 51)
end

function Lt35()
    fallout.gsay_message(50, 207, 51)
    torture_setting = 1
end

function Lt35a()
    fallout.gsay_message(50, 208, 50)
    torture_setting = 1
end

function Lt36()
    fallout.gsay_reply(50, 209)
    fallout.giq_option(4, 50, 210, Lt37, 51)
    fallout.giq_option(4, 50, 211, Lt40, 49)
end

function Lt37()
    fallout.gsay_message(50, 212, 49)
    torture_setting = 2
end

function Lt37b()
    fallout.gsay_reply(50, 213)
    fallout.giq_option(4, 50, 214, Ltx1, 51)
    fallout.giq_option(4, 50, 215, Lt40, 49)
end

function Lt38()
    fallout.gsay_reply(50, 216)
    fallout.giq_option(4, 50, 217, Lt39, 50)
    fallout.giq_option(4, 50, 218, Lt40, 50)
end

function Lt39()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(50, 272)
    else
        fallout.gsay_reply(50, 271)
    end
    fallout.giq_option(6, 50, 220, Lt39a, 50)
end

function Lt39a()
    fallout.gsay_reply(50, 221)
    fallout.giq_option(7, 50, 222, Lt39b, 50)
    fallout.giq_option(6, 50, 223, Ltx2, 51)
end

function Lt39b()
    fallout.gsay_reply(50, 224)
    fallout.giq_option(7, 50, 225, Lt40, 49)
    fallout.giq_option(7, 50, 226, Ltx2, 51)
end

function Lt40()
    fallout.gsay_reply(50, 227)
    fallout.giq_option(4, 50, 228, Ltx3, 49)
    fallout.giq_option(4, 50, 229, Lt35, 50)
    fallout.giq_option(5, 50, 230, Lt09, 50)
end

function Lt40a()
    Lt40()
end

function Lt41()
    fallout.gsay_reply(50, 235)
    fallout.giq_option(4, 50, 236, Lt42, 51)
    fallout.giq_option(5, 50, 237, Lt43, 50)
    fallout.giq_option(-3, 50, 238, Lt48, 50)
end

function Lt42()
    fallout.gsay_reply(50, 239)
    fallout.giq_option(6, 50, 240, Lt43, 50)
    fallout.giq_option(4, 50, 241, Lt44, 50)
end

function Lt43()
    fallout.gsay_reply(50, 242)
    fallout.giq_option(4, 50, 243, Lt35, 50)
    fallout.giq_option(5, 50, 244, Lt03, 50)
end

function Lt44()
    fallout.gsay_reply(50, 245)
    fallout.giq_option(4, 50, 246, Lt35, 50)
    fallout.giq_option(4, 50, 247, Lt03, 50)
end

function Lt45()
    fallout.set_global_var(57, 3)
    fallout.set_local_var(4, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        fallout.gsay_message(50, 248, 50)
    else
        fallout.gsay_message(50, 270, 50)
    end
    Ltx4()
end

function Lt46()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(50, 249)
    fallout.giq_option(4, 50, 251, Lt43, 50)
end

function Lt48()
    fallout.gsay_message(50, 252, 50)
    Ltx2()
end

function Ltx1()
    torture_setting = 3
end

function Ltx2()
    torture_setting = 0
    fallout.set_local_var(7, 1)
end

function Ltx3()
    End_The_Game = true
end

function Ltx4()
    fallout.set_global_var(276, 1)
end

function Ltx6()
    torture_setting = 0
    fallout.set_local_var(7, 1)
end

function Torture()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.tile_num(self_obj) ~= fallout.tile_num_in_direction(fallout.tile_num(dude_obj), 1, 1) then
        fallout.animate_move_obj_to_tile(self_obj,
            fallout.tile_num_in_direction(fallout.tile_num(dude_obj), 1, 1), 0)
    else
        fallout.game_ui_disable()
        fallout.anim(self_obj, 1000, 4)
        fallout.anim(self_obj, 16, 0)
        fallout.anim(dude_obj, 20, 0)
        fallout.add_timer_event(self_obj, fallout.game_ticks(torture_setting), 1)
        hit_dude = true
    end
end

function Lt40_5()
    fallout.gsay_reply(50, 231)
    fallout.giq_option(4, 50, 232, Ltx3, 49)
    fallout.giq_option(4, 50, 233, Ltx2, 51)
    fallout.giq_option(5, 50, 234, Lt09, 50)
end

function Lt50()
    fallout.gsay_message(50, 253, 50)
end

function Lt51()
    fallout.gsay_message(50, 254, 50)
end

function Lt52()
    fallout.gsay_message(50, 255, 50)
end

function Lt53()
    fallout.gsay_message(50, 256, 50)
end

function Lt54()
    fallout.gsay_message(50, 257, 50)
end

function Lt55()
    fallout.gsay_message(50, 258, 50)
end

function Lt56()
    fallout.gsay_message(50, 259, 50)
end

function Lt57()
    fallout.gsay_message(50, 260, 50)
end

function Lt58()
    fallout.gsay_message(50, 261, 50)
end

function Lt59()
    fallout.gsay_message(50, 262, 50)
end

function Lt60()
    fallout.gsay_message(50, 263, 50)
end

function Lt61()
    fallout.gsay_message(50, 264, 50)
end

function Lt62()
    fallout.gsay_message(50, 265, 50)
end

function Lt63()
    fallout.gsay_message(50, 266, 50)
end

function Lt64()
    fallout.gsay_message(50, 267, 50)
end

function Lt65()
    fallout.gsay_message(50, 268, 50)
end

function Lt66()
    fallout.gsay_message(50, 269, 50)
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
