local fallout = require("fallout")

local start
local combat_p_proc
local critter_p_proc
local damage_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local use_skill_on_p_proc
local overend
local overcbt
local over00
local over01
local over01a
local over02
local over03
local over04
local over05
local over06
local over07
local over08
local over09
local over10
local over12
local over13
local over14
local over16
local over19
local over20
local over21
local over22
local over23
local over24
local over25
local over26
local over27
local over28
local over29
local over30
local over31
local over32
local over33
local over34
local over34_1
local over37
local over38
local over38a
local over39
local over40
local over41
local over41a
local over42
local over43
local over44
local over45
local over46
local over47
local over48
local over49
local over50
local over51
local over52
local over53
local over54
local over55
local over58
local over59
local over60
local over61
local over61a
local over62
local over63
local over64
local over66
local over68
local over69
local over70
local over71
local over72
local over73
local over74
local over75
local over76
local over77
local over78
local over79
local over80
local over81
local Over81b
local Over81c
local Over81d
local Over81e
local over100
local over200
local over201
local over202
local over203
local destroy_p_proc

local rndx = 0
local rndy = 0
local rndz = 0
local HOSTILE = 0
local HEREBEFORE = 0
local stealing = 0
local SEED = 0
local Visits_without_chip = 1
local Visits_with_caravans = 1
local Visits_master_alive = 1
local Visits_with_chip = 1
local Visits_vats_blown = 1
local initialized = 0

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
    if fallout.script_action() == 13 then
        combat_p_proc()
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 14 then
                damage_p_proc()
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
                                    if fallout.script_action() == 8 then
                                        use_skill_on_p_proc()
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

function combat_p_proc()
    local v0 = 0
    if fallout.fixed_param() == 4 then
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 36) == 0 then
            v0 = fallout.create_object_sid(36, 0, 0, -1)
            fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 2)
        end
    end
end

function critter_p_proc()
    if HOSTILE then
        HOSTILE = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 100, 250, 300, 0, 128)
    else
        if (fallout.global_var(261) == 1) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12) then
            if fallout.local_var(8) == 0 then
                fallout.dialogue_system_enter()
            end
        else
            if fallout.global_var(17) and fallout.global_var(18) and (fallout.local_var(6) == 0) then
                fallout.dialogue_system_enter()
            end
        end
    end
end

function damage_p_proc()
    fallout.script_overrides()
    fallout.critter_heal(fallout.self_obj(), 100)
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(261, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(55, 100))
end

function map_enter_p_proc()
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 1)
end

function pickup_p_proc()
    stealing = 1
    fallout.dialogue_system_enter()
end

function talk_p_proc()
    get_reaction()
    fallout.start_gdialog(55, fallout.self_obj(), 4, 1, 10)
    fallout.gsay_start()
    SEED = 0
    if fallout.global_var(17) and fallout.global_var(18) then
        over81()
    else
        if fallout.global_var(261) then
            over72()
        else
            if stealing then
                over71()
            else
                if fallout.global_var(101) == 0 then
                    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) then
                        over28()
                    else
                        if Visits_without_chip == 1 then
                            over07()
                        else
                            if Visits_without_chip == 2 then
                                over12()
                            else
                                if Visits_without_chip > 2 then
                                    over19()
                                end
                            end
                        end
                        Visits_without_chip = Visits_without_chip + 1
                    end
                else
                    if fallout.global_var(101) == 1 then
                        if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) then
                            over28()
                        else
                            if Visits_with_caravans == 1 then
                                over73()
                            else
                                if Visits_with_caravans > 1 then
                                    over80()
                                end
                            end
                        end
                        Visits_with_caravans = Visits_with_caravans + 1
                    else
                        if not(fallout.global_var(17)) then
                            if fallout.global_var(18) then
                                over54()
                            else
                                if Visits_master_alive == 1 then
                                    over42()
                                else
                                    over50()
                                end
                            end
                            Visits_master_alive = Visits_master_alive + 1
                        else
                            if fallout.global_var(18) then
                                over81()
                            else
                                if Visits_vats_blown == 1 then
                                    over62()
                                else
                                    over68()
                                end
                            end
                            Visits_vats_blown = Visits_vats_blown + 1
                        end
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if fallout.external_var("Ian_ptr") ~= 0 then
        if fallout.local_var(7) == 0 then
            fallout.float_msg(fallout.external_var("Ian_ptr"), fallout.message_str(235, 171), 0)
            fallout.set_local_var(7, 1)
        end
    end
    if fallout.local_var(4) == 1 then
        fallout.gfade_out(600)
        fallout.display_msg(fallout.message_str(55, 252))
        fallout.give_exp_points(7500)
        fallout.set_local_var(4, 2)
        fallout.move_to(fallout.dude_obj(), 21135, 2)
        fallout.display_msg(fallout.message_str(163, 117))
        fallout.gfade_in(600)
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
        stealing = 1
        fallout.dialogue_system_enter()
    end
end

function overend()
end

function overcbt()
    HOSTILE = 1
end

function over00()
    HEREBEFORE = 1
    fallout.gsay_message(55, 101, 50)
    fallout.gsay_message(55, 102, 50)
    over01()
end

function over01()
    fallout.gsay_message(55, 103, 50)
    over04()
end

function over01a()
    fallout.gsay_message(55, 104, 50)
end

function over02()
    fallout.gsay_message(55, 105, 50)
    over04()
end

function over03()
    fallout.gsay_message(55, 106, 50)
    over04()
end

function over04()
    fallout.gsay_message(55, 107, 50)
    fallout.gsay_message(55, 108, 50)
    over05()
end

function over05()
    fallout.gsay_message(55, 109, 50)
    over06()
end

function over06()
    fallout.set_global_var(70, 1)
    fallout.gsay_message(55, 110, 50)
end

function over07()
    fallout.gsay_reply(55, 111)
    fallout.giq_option(7, 55, 112, over10, 51)
    fallout.giq_option(6, 55, 113, over09, 50)
    fallout.giq_option(4, 55, 114, over08, 50)
    fallout.giq_option(-3, 55, 115, over08, 50)
end

function over08()
    fallout.gsay_reply(55, 116)
    fallout.giq_option(4, 55, 260, overend, 50)
end

function over09()
    fallout.gsay_reply(55, 117)
    fallout.giq_option(4, 55, 118, over08, 50)
end

function over10()
    fallout.gsay_reply(55, 119)
    fallout.giq_option(4, 55, 120, over08, 50)
end

function over12()
    fallout.gsay_reply(55, 121)
    fallout.giq_option(4, 55, 122, over13, 50)
    fallout.giq_option(5, 55, 123, over14, 50)
    fallout.giq_option(4, 55, 124, over16, 51)
    fallout.giq_option(-3, 55, 125, over16, 51)
end

function over13()
    fallout.gsay_message(55, 126, 50)
end

function over14()
    fallout.gsay_reply(55, 127)
    fallout.giq_option(6, 55, 128, overend, 50)
end

function over16()
    fallout.gsay_message(55, 129, 50)
end

function over19()
    fallout.gsay_reply(55, 130)
    fallout.giq_option(5, 55, 131, over21, 51)
    fallout.giq_option(6, 55, 132, over22, 50)
    fallout.giq_option(4, 55, 133, over20, 50)
    fallout.giq_option(-3, 55, 134, over20, 50)
end

function over20()
    fallout.gsay_message(55, 135, 50)
end

function over21()
    fallout.gsay_message(55, 136, 51)
end

function over22()
    fallout.gsay_reply(55, 137)
    fallout.giq_option(6, 55, 138, over23, 50)
    if not(fallout.local_var(5)) then
        fallout.giq_option(6, 55, 139, over24, 50)
    end
    fallout.giq_option(6, 55, 140, over25, 50)
end

function over23()
    fallout.gsay_message(55, 141, 50)
end

function over24()
    local v0 = 0
    fallout.set_local_var(5, 1)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(29, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(29, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(55, 142, 50)
end

function over25()
    fallout.gsay_reply(55, 143)
    fallout.giq_option(5, 55, 144, over26, 50)
    fallout.giq_option(5, 55, 145, over27, 50)
end

function over26()
    fallout.gsay_reply(55, 146)
    fallout.giq_option(5, 55, 147, overend, 50)
    fallout.giq_option(6, 55, 148, overend, 50)
end

function over27()
    fallout.gsay_message(55, 149, 50)
end

function over28()
    Visits_with_chip = Visits_with_chip + 1
    fallout.set_global_var(101, 2)
    if fallout.global_var(238) ~= 2 then
        fallout.set_global_var(238, 3)
    end
    if fallout.global_var(188) ~= 2 then
        fallout.set_global_var(188, 3)
    end
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(55, 150)
    fallout.giq_option(4, 55, 151, over31, 50)
    fallout.giq_option(6, 55, 152, over34, 50)
    fallout.giq_option(-3, 55, 153, over37, 50)
end

function over29()
    fallout.gsay_message(55, 154, 50)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) then
        over31()
    else
        over30()
    end
end

function over30()
    fallout.gsay_message(55, 155, 50)
    fallout.giq_option(4, 55, 164, over31, 50)
    fallout.giq_option(4, 55, 165, over30, 50)
end

function over31()
    local v0 = 0
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 55)
    fallout.destroy_object(v0)
    fallout.gsay_reply(55, 156)
    fallout.giq_option(6, 55, 157, over32, 50)
    fallout.giq_option(4, 55, 158, over33, 50)
end

function over32()
    fallout.gsay_reply(55, 159)
    fallout.giq_option(4, 55, 160, overend, 50)
end

function over33()
    fallout.gsay_reply(55, 161)
    fallout.giq_option(4, 55, 162, overend, 50)
end

function over34()
    fallout.gsay_reply(55, 163)
    fallout.giq_option(4, 55, 164, over31, 50)
    fallout.giq_option(4, 55, 165, over30, 50)
end

function over34_1()
end

function over37()
    fallout.gsay_reply(55, 166)
    fallout.giq_option(0, 55, 196, over38, 50)
end

function over38()
    fallout.gsay_reply(55, 167)
    fallout.giq_option(0, 55, 196, over38a, 50)
end

function over38a()
    fallout.gsay_reply(55, 168)
    fallout.giq_option(0, 55, 196, over39, 50)
end

function over39()
    fallout.gsay_reply(55, 169)
    fallout.giq_option(0, 55, 196, over40, 50)
end

function over40()
    local v0 = 0
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 55)
    fallout.destroy_object(v0)
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(55, 170)
    fallout.giq_option(-3, 55, 171, over41, 50)
    fallout.giq_option(-3, 55, 172, over41a, 50)
end

function over41()
    fallout.gsay_message(55, 173, 50)
end

function over41a()
    fallout.gsay_message(55, 174, 50)
end

function over42()
    fallout.set_global_var(308, 1)
    fallout.set_global_var(309, 1)
    fallout.gsay_reply(55, 175)
    fallout.giq_option(4, 55, 176, over43, 50)
    fallout.giq_option(-3, 55, 177, over49, 50)
end

function over43()
    fallout.gsay_reply(55, 178)
    fallout.giq_option(4, 55, 179, over44, 50)
end

function over44()
    fallout.gsay_reply(55, 180)
    fallout.giq_option(4, 55, 181, over45, 50)
    fallout.giq_option(7, 55, 182, over46, 50)
end

function over45()
    fallout.gsay_reply(55, 183)
    fallout.giq_option(4, 55, 184, over47, 50)
end

function over46()
    fallout.gsay_reply(55, 185)
    fallout.giq_option(6, 55, 186, over47, 50)
end

function over47()
    fallout.gsay_reply(55, 187)
    fallout.giq_option(4, 55, 188, overend, 50)
    fallout.giq_option(6, 55, 189, over48, 50)
end

function over48()
    fallout.gsay_message(55, 190, 50)
end

function over49()
    fallout.gsay_message(55, 191, 50)
end

function over50()
    fallout.gsay_reply(55, 192)
    fallout.giq_option(4, 55, 193, over51, 50)
    fallout.giq_option(6, 55, 194, over52, 50)
    fallout.giq_option(5, 55, 195, over53, 50)
    fallout.giq_option(-3, 55, 196, over51, 50)
end

function over51()
    fallout.gsay_message(55, 197, 50)
end

function over52()
    fallout.gsay_message(55, 198, 50)
end

function over53()
    fallout.gsay_message(55, 199, 50)
end

function over54()
    fallout.gsay_reply(55, 200)
    fallout.giq_option(4, 55, 201, over55, 50)
    fallout.giq_option(6, 55, 202, over55, 50)
    fallout.giq_option(-3, 55, 203, over61, 50)
end

function over55()
    fallout.gsay_reply(55, 204)
    fallout.giq_option(4, 55, 205, over60, 50)
end

function over58()
    fallout.gsay_message(55, 207, 50)
end

function over59()
    fallout.gsay_message(55, 208, 50)
end

function over60()
    fallout.gsay_message(55, 209, 50)
end

function over61()
    fallout.gsay_reply(55, 210)
    fallout.giq_option(-3, 55, 211, over61a, 50)
end

function over61a()
    fallout.gsay_message(55, 212, 50)
end

function over62()
    fallout.gsay_reply(55, 213)
    fallout.giq_option(4, 55, 214, over63, 50)
    fallout.giq_option(6, 55, 215, over64, 50)
    fallout.giq_option(-3, 55, 216, over63, 50)
end

function over63()
    fallout.gsay_reply(55, 217)
    fallout.giq_option(4, 55, 218, over64, 50)
    fallout.giq_option(-3, 55, 219, over64, 50)
end

function over64()
    fallout.gsay_reply(55, 220)
    fallout.giq_option(4, 55, 221, over66, 50)
    fallout.giq_option(-3, 55, 222, over66, 50)
end

function over66()
    fallout.gsay_message(55, 223, 50)
end

function over68()
    fallout.gsay_reply(55, 224)
    fallout.giq_option(4, 55, 225, over69, 50)
    fallout.giq_option(4, 55, 226, over70, 50)
    fallout.giq_option(-3, 55, 227, over69, 50)
end

function over69()
    fallout.gsay_message(55, 228, 50)
end

function over70()
    fallout.gsay_message(55, 229, 50)
end

function over71()
    stealing = 0
    fallout.gsay_message(55, 230, 51)
end

function over72()
    fallout.gsay_reply(55, 231)
    fallout.set_local_var(8, 1)
    fallout.giq_option(4, 55, 259, overcbt, 51)
end

function over73()
    fallout.gsay_reply(55, 232)
    fallout.giq_option(4, 55, 233, over75, 50)
    fallout.giq_option(-3, 55, 234, over74, 50)
end

function over74()
    fallout.gsay_message(55, 235, 50)
end

function over75()
    fallout.gsay_reply(55, 236)
    fallout.giq_option(4, 55, 237, over76, 50)
    fallout.giq_option(6, 55, 238, over77, 50)
end

function over76()
    fallout.gsay_message(55, 239, 50)
end

function over77()
    fallout.gsay_reply(55, 240)
    fallout.giq_option(5, 55, 241, over78, 50)
    fallout.giq_option(6, 55, 242, over79, 50)
end

function over78()
    fallout.gsay_message(55, 243, 50)
end

function over79()
    fallout.gsay_message(55, 244, 50)
end

function over80()
    fallout.gsay_message(55, 245, 50)
end

function over81()
    fallout.set_local_var(6, 1)
    fallout.set_local_var(8, 1)
    TopReact()
    fallout.gsay_reply(55, 261)
    fallout.giq_option(0, 634, 106, Over81b, 49)
end

function Over81b()
    fallout.set_local_var(1, 50)
    LevelToReact()
    fallout.gsay_reply(55, 262)
    fallout.giq_option(0, 634, 106, Over81c, 51)
end

function Over81c()
    BottomReact()
    fallout.gsay_reply(55, 263)
    fallout.giq_option(0, 634, 106, Over81d, 51)
end

function Over81d()
    fallout.gsay_reply(55, 264)
    fallout.giq_option(0, 634, 106, Over81e, 51)
end

function Over81e()
    fallout.gsay_message(55, 265, 51)
    fallout.add_timer_event(fallout.dude_obj(), 10, 5)
end

function over100()
    fallout.gsay_message(55, 247, 50)
end

function over200()
    fallout.gsay_message(55, 248, 50)
end

function over201()
    fallout.gsay_message(55, 249, 50)
end

function over202()
    fallout.gsay_message(55, 250, 50)
end

function over203()
    fallout.gsay_message(55, 251, 50)
end

function destroy_p_proc()
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
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
