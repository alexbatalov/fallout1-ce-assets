local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local gameover
local do_dialogue
local Critter_Action
local harryleave
local harryend
local harrycbt
local harryturn
local harryextra
local surprise
local harrytime
local harrytime2
local harry00
local harry00a
local harry00b
local harry00_2
local harry00_3
local harry01
local harry02
local harry03
local harry03_2
local harry03_5
local harry04
local harry05
local harry06
local harry07
local harry07b
local harry08
local harry08_2
local harry09
local harry10
local harry11
local harry12
local harry12_2
local harry12_3
local harry13
local harry13_2
local harry14
local harry14_2
local harry15
local harry16
local harry17
local harry18
local harry19
local harry19_2
local harry20
local harry21
local harry22
local harry23
local harry24
local harry25
local harry26
local harry27
local harry200
local harry201
local harry202
local harry203
local harry204
local harry205
local harry206
local harry207
local harry300
local harry301
local harry302
local harry303
local harry304
local harry305
local harry306
local harry307
local harry308
local pickup_p_proc
local harryxxx

local Hostile = 0
local init_teams = 0
local noevent = 0
local loopcount = 0

local exit_line = 0

function start()
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 79)
        fallout.set_local_var(5, 0)
        init_teams = 1
    end
    if fallout.script_action() == 11 then
        if fallout.global_var(306) == 0 then
            do_dialogue()
        else
            fallout.display_msg(fallout.message_str(16, 193))
        end
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(16, 100))
        else
            if fallout.script_action() == 22 then
                if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                    if fallout.fixed_param() == 1 then
                        harry07b()
                    else
                        if fallout.fixed_param() == 2 then
                            harry21()
                        end
                    end
                end
            else
                if fallout.script_action() == 4 then
                    pickup_p_proc()
                else
                    if fallout.script_action() == 12 then
                        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8) then
                            if fallout.local_var(4) == 0 then
                                fallout.dialogue_system_enter()
                            else
                                Critter_Action()
                            end
                        else
                            Critter_Action()
                        end
                    else
                        if fallout.script_action() == 18 then
                            fallout.set_global_var(35, fallout.global_var(35) + 1)
                            if fallout.global_var(35) > fallout.global_var(551) then
                                fallout.set_global_var(155, fallout.global_var(155) + 3)
                                fallout.set_global_var(29, 2)
                                fallout.set_global_var(225, time.game_time_in_days())
                            end
                            reputation.inc_evil_critter()
                        end
                    end
                end
            end
        end
    end
end

function gameover()
    fallout.gsay_message(16, 191, 50)
end

function do_dialogue()
    reaction.get_reaction()
    fallout.start_gdialog(16, fallout.self_obj(), 4, 5, 4)
    fallout.gsay_start()
    if fallout.local_var(4) then
        if fallout.local_var(1) >= 2 then
            harry19()
        else
            harry11()
        end
    else
        fallout.set_local_var(4, 1)
        if fallout.global_var(17) then
            harry26()
        else
            if fallout.global_var(59) == 1 then
                harry23()
            else
                if fallout.global_var(35) > 0 then
                    harry18()
                else
                    if (fallout.local_var(1) >= 2) and (Hostile == 0) then
                        if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) and (fallout.get_critter_stat(fallout.dude_obj(), 34) == 1) then
                            harry12()
                        else
                            harry00()
                        end
                    else
                        harry07()
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Critter_Action()
    if Hostile > 0 then
        Hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if (fallout.global_var(306) == 1) and (fallout.tile_num(fallout.self_obj()) ~= 15507) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 15507, 0)
        else
            if (fallout.global_var(306) == 1) and (fallout.tile_num(fallout.self_obj()) == 15507) then
                fallout.set_global_var(306, 2)
            else
                if (fallout.global_var(306) == 2) and (fallout.tile_num(fallout.self_obj()) ~= 12536) then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 12536, 0)
                else
                    if (fallout.tile_num(fallout.self_obj()) == 12536) and (fallout.global_var(306) == 2) then
                        fallout.set_obj_visibility(fallout.self_obj(), 1)
                    end
                end
            end
        end
    end
end

function harryleave()
    fallout.set_global_var(306, 1)
end

function harryend()
end

function harrycbt()
    Hostile = 1
end

function harryturn()
    Hostile = 1
end

function harryextra()
    Hostile = 1
end

function surprise()
    Hostile = 1
end

function harrytime()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 1)
end

function harrytime2()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 2)
end

function harry00()
    fallout.gsay_reply(16, 101)
    fallout.giq_option(5, 16, 102, harry00_2, 50)
    fallout.giq_option(4, 16, 103, harry00_3, 50)
    fallout.giq_option(4, 16, 104, harry02, 51)
    fallout.giq_option(-3, 16, 105, harry00a, 50)
end

function harry00a()
    fallout.gsay_reply(16, 106)
    fallout.giq_option(-3, 16, 107, harry00b, 50)
end

function harry00b()
    fallout.gsay_reply(16, 108)
    fallout.giq_option(-3, 16, 109, harry02, 50)
end

function harry00_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        harry01()
    else
        harry02()
    end
end

function harry00_3()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        harry20()
    else
        harry02()
    end
end

function harry01()
    fallout.gsay_reply(16, 110)
    fallout.giq_option(5, 16, 111, harry02, 50)
    fallout.giq_option(5, 16, 112, harry04, 50)
end

function harry02()
    fallout.gsay_reply(16, 113)
    fallout.giq_option(4, 16, 114, harry03, 50)
    fallout.giq_option(4, 16, 115, harrycbt, 51)
end

function harry03()
    fallout.gsay_reply(16, 116)
    fallout.giq_option(4, 16, 117, harry03_2, 50)
    fallout.giq_option(4, 16, 118, harry03_5, 50)
end

function harry03_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        harry04()
    else
        harry05()
    end
end

function harry03_5()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        harry06()
    else
        harry07()
    end
end

function harry04()
    fallout.gsay_reply(16, 119)
    fallout.giq_option(4, 16, 120, harry08, 50)
    if fallout.global_var(17) ~= 1 then
        fallout.giq_option(4, 16, 121, harryxxx, 50)
    end
    fallout.giq_option(4, 16, 122, harryturn, 50)
end

function harry05()
    fallout.gsay_reply(16, 123)
    if fallout.global_var(17) ~= 1 then
        fallout.giq_option(4, 16, 192, harryxxx, 50)
    end
    fallout.giq_option(4, 16, 191, harrycbt, 50)
end

function harry06()
    fallout.gsay_message(16, 124, 50)
    harrytime()
end

function harry07()
    fallout.gsay_message(16, 125, 51)
    harrycbt()
end

function harry07b()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(16, 125), 2)
    harrycbt()
end

function harry08()
    fallout.gsay_reply(16, 126)
    fallout.giq_option(4, 16, 127, harry09, 51)
    fallout.giq_option(4, 16, 128, harry08_2, 50)
    fallout.giq_option(4, 16, 129, harry07, 50)
end

function harry08_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        harry10()
    else
        harry09()
    end
end

function harry09()
    fallout.gsay_message(16, 130, 51)
    harrycbt()
end

function harry10()
    fallout.gsay_message(16, 131, 50)
    harrytime()
end

function harry11()
    fallout.gsay_message(16, 132, 51)
    harrycbt()
end

function harry12()
    fallout.gsay_reply(16, 133)
    fallout.giq_option(4, 16, 134, harry12_2, 50)
    fallout.giq_option(4, 16, 135, harry12_3, 50)
    fallout.giq_option(-3, 16, 105, harry00a, 50)
end

function harry12_2()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 1)) then
        harry13()
    else
        harry14()
    end
end

function harry12_3()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 2)) then
        harry17()
    else
        harry14()
    end
end

function harry13()
    fallout.gsay_reply(16, 136)
    fallout.giq_option(4, 16, 137, harry13_2, 50)
    fallout.giq_option(4, 16, 138, harry14, 50)
end

function harry13_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        harry16()
    else
        harry14()
    end
end

function harry14()
    fallout.gsay_reply(16, 139)
    if fallout.global_var(17) ~= 1 then
        fallout.giq_option(4, 16, 121, harryxxx, 50)
    end
    fallout.giq_option(4, 16, 140, harry14_2, 50)
    fallout.giq_option(4, 16, 141, harryturn, 51)
end

function harry14_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        harry15()
    else
        harry07()
    end
end

function harry15()
    fallout.gsay_message(16, 142, 50)
    harrytime()
end

function harry16()
    fallout.gsay_message(16, 143, 50)
    harrytime()
end

function harry17()
    fallout.gsay_reply(16, 144)
    fallout.giq_option(4, 16, 145, surprise, 51)
    fallout.giq_option(4, 16, 146, harry14, 50)
end

function harry18()
    fallout.gsay_message(16, 147, 51)
    harrycbt()
end

function harry19()
    fallout.gsay_reply(16, 148)
    if fallout.global_var(17) ~= 1 then
        fallout.giq_option(4, 16, 149, harry22, 50)
    end
    fallout.giq_option(4, 16, 150, harry19_2, 50)
    fallout.giq_option(4, 16, 151, harrycbt, 51)
    fallout.giq_option(-3, 16, 105, harry00a, 50)
end

function harry19_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        harry20()
    else
        harry07()
    end
end

function harry20()
    fallout.gsay_message(16, 152, 50)
    harrytime2()
end

function harry21()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(16, 153), 2)
    harrycbt()
end

function harry22()
    fallout.gsay_message(16, 154, 51)
    harryxxx()
end

function harry23()
    fallout.gsay_reply(16, 155)
    fallout.giq_option(5, 16, 156, harry24, 50)
    if fallout.global_var(17) ~= 1 then
        fallout.giq_option(4, 16, 121, harryxxx, 50)
    end
    fallout.giq_option(4, 16, 157, harry25, 51)
end

function harry24()
    fallout.gsay_message(16, 158, 50)
    if fallout.global_var(17) ~= 1 then
        fallout.giq_option(4, 16, 121, harryxxx, 50)
    end
    fallout.giq_option(4, 16, 191, harrycbt, 50)
end

function harry25()
    fallout.gsay_message(16, 159, 51)
    harrycbt()
end

function harry26()
    fallout.gsay_reply(16, 160)
    fallout.giq_option(4, 16, 161, harryturn, 51)
    fallout.giq_option(4, 16, 162, harry27, 49)
    fallout.giq_option(-3, 16, 163, harry27, 50)
end

function harry27()
    fallout.gsay_reply(16, 164)
    fallout.giq_option(4, 16, 165, harryturn, 51)
    fallout.giq_option(4, 16, 166, harryleave, 50)
    fallout.giq_option(-3, 16, 167, harryleave, 50)
end

function harry200()
    fallout.gsay_message(16, 168, 50)
end

function harry201()
    fallout.gsay_message(16, 169, 50)
end

function harry202()
    fallout.gsay_message(16, 170, 50)
end

function harry203()
    fallout.gsay_message(16, 171, 50)
end

function harry204()
    fallout.gsay_message(16, 172, 50)
end

function harry205()
    fallout.gsay_message(16, 173, 50)
end

function harry206()
    fallout.gsay_message(16, 174, 50)
end

function harry207()
    fallout.gsay_message(16, 175, 50)
end

function harry300()
    fallout.gsay_message(16, 176, 50)
end

function harry301()
    fallout.gsay_message(16, 177, 50)
end

function harry302()
    fallout.gsay_message(16, 178, 50)
end

function harry303()
    fallout.gsay_message(16, 179, 50)
end

function harry304()
    fallout.gsay_message(16, 180, 50)
end

function harry305()
    fallout.gsay_message(16, 181, 50)
end

function harry306()
    fallout.gsay_message(16, 182, 50)
end

function harry307()
    fallout.gsay_message(16, 183, 50)
end

function harry308()
    fallout.gsay_message(16, 184, 50)
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        Hostile = 1
    end
end

function harryxxx()
    fallout.game_time_advance(fallout.game_ticks(2 * 604800))
    fallout.set_global_var(57, 2)
    fallout.load_map(32, 5)
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
return exports
