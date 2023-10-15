local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local pre_dialogue
local do_dialogue
local checkarea
local jerem00
local jerem00a
local jerem01
local jerem02
local jerem02a
local jerem02b
local jerem03
local jerem03a
local jerem04
local jerem05
local jerem05a
local jerem06
local jerem07
local jerem08
local jerem08a
local jerem08b
local jerem09
local jerem09a
local jerem10
local jerem11
local jerem12
local jerem13
local jerem14
local jerem14a
local jerem15
local jerem17
local jerem18
local jerem18a
local jerem19
local jerem19a
local jerem20
local jerem20a
local jerem21
local jerem21a
local jerem22
local jerem23
local jerem24
local jerem25
local jerem26
local jerem27
local jerem28
local jerem29
local jeremend
local jeremcbt
local jeremret

local HOSTILE = 0
local initialized = false
local Weapons = 0
local DISGUISED = 0
local again = 0
local area = 0
local here = 0
local moving = 1
local my_hex = 0
local home_tile = 0

local jerem16

function start()
    if fallout.local_var(0) == 0 then
        fallout.set_local_var(0, 1)
        fallout.set_local_var(1, 0)
        fallout.set_local_var(2, 0)
        fallout.set_local_var(3, 7)
        fallout.set_local_var(4, 12098)
    end
    if not initialized then
        initialized = true
        home_tile = 12098
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        if fallout.global_var(233) == 1 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            moving = 0
        else
            if fallout.global_var(232) == 1 then
                fallout.set_obj_visibility(fallout.self_obj(), 1)
                moving = 0
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(300), 1)
            end
        end
    else
        if fallout.global_var(233) ~= 1 then
            if fallout.script_action() == 11 then
                pre_dialogue()
            else
                if fallout.script_action() == 22 then
                    if fallout.fixed_param() == 1 then
                        moving = 1
                        fallout.set_global_var(232, 0)
                        if fallout.local_var(1) == 0 then
                            fallout.move_to(fallout.self_obj(), home_tile, 0)
                            fallout.set_local_var(3, 7)
                            fallout.set_local_var(4, 12098)
                            fallout.set_obj_visibility(fallout.self_obj(), 0)
                        end
                    else
                        if fallout.fixed_param() == 2 then
                            fallout.set_local_var(2, 2)
                        else
                            if fallout.fixed_param() == 3 then
                                moving = 1
                                fallout.set_local_var(4, 19685)
                                fallout.set_local_var(3, 4)
                                fallout.set_local_var(1, 0)
                                fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(4), 0)
                            end
                        end
                    end
                else
                    if fallout.script_action() == 4 then
                        HOSTILE = 1
                    end
                end
            end
            if fallout.script_action() == 12 then
                fallout.set_map_var(1, 0)
                if fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < 8 then
                    fallout.set_map_var(1, 1)
                end
                if HOSTILE then
                    HOSTILE = 0
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
                if moving then
                    my_hex = fallout.tile_num(fallout.self_obj())
                    if my_hex == fallout.local_var(4) then
                        if fallout.local_var(1) then
                            fallout.set_local_var(3, fallout.local_var(3) + 1)
                        else
                            fallout.set_local_var(3, fallout.local_var(3) - 1)
                        end
                        if fallout.local_var(3) > 7 then
                            moving = 0
                            fallout.set_local_var(1, 0)
                            fallout.set_local_var(3, 6)
                            fallout.set_obj_visibility(fallout.self_obj(), 1)
                            fallout.set_global_var(232, 1)
                            fallout.move_to(fallout.self_obj(), 7000, 0)
                            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(300), 1)
                        else
                            if fallout.local_var(3) < 0 then
                                moving = 0
                                fallout.set_local_var(1, 1)
                                fallout.set_local_var(3, 1)
                                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(300), 1)
                            else
                                if (fallout.local_var(3) == 5) and (fallout.local_var(1) == 0) then
                                    moving = 0
                                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60), 3)
                                end
                            end
                        end
                        if fallout.local_var(3) == 0 then
                            fallout.set_local_var(4, 20936)
                        else
                            if fallout.local_var(3) == 1 then
                                fallout.set_local_var(4, 25336)
                            else
                                if fallout.local_var(3) == 2 then
                                    fallout.set_local_var(4, 25721)
                                else
                                    if fallout.local_var(3) == 3 then
                                        fallout.set_local_var(4, 27915)
                                    else
                                        if fallout.local_var(3) == 4 then
                                            fallout.set_local_var(4, 26094)
                                        else
                                            if fallout.local_var(3) == 5 then
                                                fallout.set_local_var(4, 19685)
                                            else
                                                if fallout.local_var(3) == 6 then
                                                    if fallout.local_var(1) == 0 then
                                                        fallout.set_local_var(4, 12889)
                                                    else
                                                        fallout.set_local_var(4, 14689)
                                                    end
                                                else
                                                    if fallout.local_var(3) == 7 then
                                                        fallout.set_local_var(4, 12098)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(4), 0)
                    end
                    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                        DISGUISED = 0
                        if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
                            if fallout.metarule(16, 0) > 1 then
                                DISGUISED = 0
                            else
                                DISGUISED = 1
                            end
                        end
                        if (DISGUISED == 0) and (again < 2) then
                            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
                                if fallout.local_var(2) < 1 then
                                    fallout.set_local_var(2, 1)
                                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 2)
                                    fallout.dialogue_system_enter()
                                else
                                    if fallout.local_var(2) > 1 then
                                        jerem29()
                                    end
                                end
                            end
                        end
                    end
                end
            else
                if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(672, 100))
                else
                    if fallout.script_action() == 18 then
                        fallout.set_global_var(233, 1)
                        reputation.inc_evil_critter()
                    end
                end
            end
        end
    end
end

function pre_dialogue()
    again = again + 1
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.metarule(16, 0) > 1 then
            DISGUISED = 0
        else
            DISGUISED = 1
        end
    end
    if (DISGUISED == 0) and (again > 1) then
        jerem29()
    else
        again = again - 1
        do_dialogue()
    end
end

function do_dialogue()
    checkarea()
    fallout.start_gdialog(672, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    again = again + 1
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.metarule(16, 0) > 1 then
            DISGUISED = 0
        else
            DISGUISED = 1
        end
        if again == 1 then
            jerem00()
        else
            if again > 2 then
                jerem26()
            else
                if (again == 2) and (fallout.global_var(231) == 1) then
                    jerem23()
                else
                    jerem00()
                end
            end
        end
    else
        if area == 50 then
            if again > 1 then
                jerem28()
            else
                jerem13()
            end
        else
            if area == 2 then
                if again > 1 then
                    jerem28()
                else
                    jerem19()
                end
            else
                if area == 1 then
                    if again > 1 then
                        jerem28()
                    else
                        jerem20()
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function checkarea()
    here = fallout.tile_num(fallout.dude_obj())
    area = 2
    if fallout.tile_distance(here, 13475) < 15 then
        area = 1
    else
        if fallout.tile_distance(here, 13296) < 15 then
            area = 1
        else
            if fallout.tile_distance(here, 16089) < 15 then
                area = 1
            else
                if fallout.tile_distance(here, 25726) < 15 then
                    area = 50
                else
                    if fallout.tile_distance(here, 27322) < 15 then
                        area = 50
                    else
                        if fallout.tile_distance(here, 25737) < 15 then
                            area = 50
                        else
                            if fallout.tile_distance(here, 22136) < 15 then
                                area = 50
                            end
                        end
                    end
                end
            end
        end
    end
end

function jerem00()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(672, 102)
    else
        fallout.gsay_reply(672, 192)
    end
    fallout.giq_option(-3, 672, 103, jerem01, 50)
    fallout.giq_option(4, 672, 104, jerem00a, 50)
end

function jerem00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -5)) then
        jerem03()
    else
        jerem02()
    end
end

function jerem01()
    fallout.gsay_message(672, 105, 50)
end

function jerem02()
    fallout.gsay_reply(672, 106)
    fallout.giq_option(7, 672, 107, jerem02a, 50)
    fallout.giq_option(4, 672, 108, jerem04, 50)
    fallout.giq_option(4, 672, 109, jerem04, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 110, jerem02b, 50)
    end
end

function jerem02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        jerem05()
    else
        jerem07()
    end
end

function jerem02b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        jerem05()
    else
        jerem06()
    end
end

function jerem03()
    fallout.gsay_reply(672, 111)
    fallout.giq_option(4, 672, 112, jerem03a, 50)
    fallout.giq_option(4, 672, 113, jerem07, 50)
    fallout.giq_option(4, 672, 114, jeremend, 50)
end

function jerem03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        jerem08()
    else
        jerem09()
    end
end

function jerem04()
    fallout.gsay_message(672, 115, 50)
end

function jerem05()
    fallout.gsay_reply(672, 116)
    fallout.giq_option(4, 672, 117, jerem03, 50)
    fallout.giq_option(4, 672, 118, jerem05a, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 119, jeremcbt, 51)
    end
end

function jerem05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        jerem08()
    else
        jerem12()
    end
end

function jerem06()
    fallout.gsay_message(672, 120, 51)
    jeremcbt()
end

function jerem07()
    fallout.gsay_reply(672, 121)
    fallout.giq_option(4, 672, 122, jerem06, 51)
    fallout.giq_option(-4, 672, 103, jerem01, 50)
    fallout.giq_option(7, 672, 124, jerem10, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 125, jeremcbt, 51)
    end
end

function jerem08()
    fallout.gsay_reply(672, 126)
    jerem09a()
end

function jerem08a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        jerem11()
    else
        jerem12()
    end
end

function jerem08b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        jerem11()
    else
        jerem06()
    end
end

function jerem09()
    fallout.gsay_reply(672, 190)
    jerem09a()
end

function jerem09a()
    fallout.giq_option(4, 672, 127, jerem08a, 50)
    fallout.giq_option(4, 672, 128, jerem12, 51)
    fallout.giq_option(8, 672, 129, jerem11, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 130, jerem08b, 50)
    end
end

function jerem10()
    fallout.gsay_reply(672, 131)
    fallout.giq_option(4, 672, 127, jerem08a, 50)
    fallout.giq_option(8, 672, 133, jerem11, 50)
end

function jerem11()
    fallout.gsay_message(672, 134, 50)
    fallout.set_global_var(231, 1)
end

function jerem12()
    fallout.gsay_message(672, 135, 51)
    jeremcbt()
end

function jerem13()
    fallout.gsay_reply(672, 136)
    jerem19a()
end

function jerem14()
    fallout.gsay_reply(672, 141)
    fallout.giq_option(4, 672, 142, jeremret, 50)
    fallout.giq_option(4, 672, 143, jerem14a, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 144, jeremcbt, 51)
    end
end

function jerem14a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        jerem17()
    else
        jerem18()
    end
end

function jerem15()
    fallout.gsay_message(672, 145, 51)
    jeremcbt()
end

function jerem17()
    fallout.gsay_reply(672, 150)
    jerem18a()
end

function jerem18()
    fallout.gsay_reply(672, 156)
    jerem18a()
end

function jerem18a()
    fallout.giq_option(4, 672, 151, jeremret, 50)
    fallout.giq_option(4, 672, 152, jerem12, 51)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 153, jeremcbt, 51)
    end
end

function jerem19()
    fallout.gsay_reply(672, 154)
    jerem19a()
end

function jerem19a()
    fallout.giq_option(4, 672, 137, jerem14, 50)
    fallout.giq_option(4, 672, 138, jerem15, 51)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 139, jeremcbt, 51)
    end
    fallout.giq_option(-3, 672, 140, jerem16, 50)
end

function jerem20()
    fallout.gsay_reply(672, 157)
    fallout.giq_option(-3, 672, 158, jerem01, 50)
    fallout.giq_option(4, 672, 159, jerem12, 51)
    fallout.giq_option(4, 672, 160, jerem15, 51)
    fallout.giq_option(7, 672, 161, jerem20a, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 162, jeremcbt, 51)
    end
end

function jerem20a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        jerem21()
    else
        jerem12()
    end
end

function jerem21()
    fallout.gsay_reply(672, 163)
    fallout.giq_option(4, 672, 164, jerem12, 51)
    fallout.giq_option(4, 672, 165, jerem12, 51)
    fallout.giq_option(4, 672, 166, jerem21a, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 167, jeremcbt, 51)
    end
end

function jerem21a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        jerem22()
    else
        jerem12()
    end
end

function jerem22()
    fallout.gsay_reply(672, 168)
    fallout.giq_option(4, 672, 169, jeremret, 50)
    fallout.giq_option(4, 672, 170, jerem12, 51)
    fallout.giq_option(4, 672, 171, jerem18, 50)
end

function jerem23()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(672, 172)
    else
        fallout.gsay_reply(672, 173)
    end
    fallout.giq_option(4, 672, 174, jerem24, 50)
    fallout.giq_option(4, 672, 175, jeremend, 50)
    fallout.giq_option(4, 672, 176, jeremend, 50)
    fallout.giq_option(4, 672, 177, jeremcbt, 51)
end

function jerem24()
    fallout.gsay_reply(672, 178)
    fallout.giq_option(4, 672, 179, jeremend, 50)
    fallout.giq_option(4, 672, 180, jerem26, 50)
    fallout.giq_option(4, 672, 181, jerem25, 50)
end

function jerem25()
    fallout.gsay_reply(672, 182)
    fallout.giq_option(4, 672, 183, jeremend, 50)
    fallout.giq_option(4, 672, 184, jerem26, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 185, jerem26, 50)
    end
end

function jerem26()
    fallout.gsay_message(672, 187, 51)
    jeremcbt()
end

function jerem27()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(672, 172)
    else
        fallout.gsay_reply(672, 173)
    end
    fallout.giq_option(4, 672, 174, jerem28, 51)
    fallout.giq_option(4, 672, 175, jeremend, 50)
    fallout.giq_option(4, 672, 176, jeremend, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 672, 177, jeremcbt, 51)
    end
end

function jerem28()
    fallout.gsay_message(672, 188, 51)
    jeremcbt()
end

function jerem29()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(672, 189), 2)
    jeremcbt()
end

function jeremend()
end

function jeremcbt()
    HOSTILE = 1
end

function jeremret()
    fallout.game_time_advance(fallout.game_ticks(120))
    fallout.load_map(17, 2)
end

function jerem16()
    fallout.gsay_reply(672, 146)
    fallout.giq_option(-3, 672, 147, jeremret, 50)
    fallout.giq_option(-3, 672, 148, jerem19, 50)
    fallout.giq_option(-3, 672, 149, jeremcbt, 51)
end

local exports = {}
exports.start = start
return exports
