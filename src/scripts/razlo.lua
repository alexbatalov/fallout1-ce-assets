local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat_p_proc
local map_update_p_proc
local talk_p_proc
local razlo00
local razlo00a
local razlo01
local razlo02
local razlo03
local razlo04
local razlo05
local razlo06
local razlo06na
local razlo06nb
local razlo07
local razlo08
local razlo09
local razlo10
local razlo11
local razlo12
local razlo14
local razlo15
local Razlo17
local razlo18
local razlo19
local razlo20
local razlo21
local razlo22
local razlo23
local razlo23a
local razlo24
local razlo25
local razlo26
local razlo27
local razlo27a
local razlo28
local razlo29
local razlo30
local razlo31
local razlo00n
local razlo01n
local razlo02n
local razlo03n
local razlo04n
local razlo05n
local razlo06n
local razlo07n
local razlo08n
local razlo09n
local razlo10n
local razlo11n
local razlo14n
local razlo15n
local razlo16n
local razlowmpa
local razlowmpb
local razlofixa
local razlofixb
local razlofixc
local razlox
local razloend
local givestuff
local remove_items
local critter_p_proc
local look_at_p_proc
local destroy_p_proc
local pickup_p_proc

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local STIM = 0
local FRUIT = 0
local damage = 0
local HOSTILE = 0
local heal = 0
local COST = 0
local BONUS = 0
local NIGHT = 0
local round_counter = 0
local dummyvar = 0
local MONEY = 0
local MAX_HITS = 0
local HITS = 0
local initialized = false
local tail = 0

local exit_line = 0

function start()
    if fallout.script_action() == 13 then
        combat_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 4 then
                    pickup_p_proc()
                else
                    if fallout.script_action() == 12 then
                        critter_p_proc()
                    else
                        if fallout.script_action() == 21 then
                            look_at_p_proc()
                        else
                            if fallout.script_action() == 18 then
                                destroy_p_proc()
                            end
                        end
                    end
                end
            end
        end
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
    end
    if round_counter > 3 then
        if fallout.global_var(246) == 0 then
            fallout.set_global_var(246, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
end

function map_update_p_proc()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
        home_tile = 24529
        sleep_tile = 23133
        wake_time = 630
        sleep_time = 2230
        initialized = false
    end
end

function talk_p_proc()
    MAX_HITS = fallout.get_critter_stat(fallout.dude_obj(), 7)
    HITS = fallout.get_critter_stat(fallout.dude_obj(), 35)
    reaction.get_reaction()
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.set_global_var(156, 1)
        fallout.set_global_var(157, 0)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
        fallout.set_global_var(157, 1)
        fallout.set_global_var(156, 0)
    end
    if fallout.local_var(9) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    else
        if time.is_night() then
            fallout.set_local_var(6, 1)
            fallout.start_gdialog(129, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            razlo00n()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            if fallout.global_var(43) == 1 then
                if (fallout.global_var(26) == 1) and (fallout.local_var(4) == 0) and (fallout.global_var(218) == 1) then
                    fallout.set_local_var(4, 1)
                    fallout.start_gdialog(129, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    razlo01()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    fallout.start_gdialog(129, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    razlo23()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            else
                if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 92) then
                    fallout.start_gdialog(129, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    razlo23()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    if (fallout.local_var(6) == 0) and (fallout.local_var(1) >= 2) then
                        fallout.set_local_var(6, 1)
                        fallout.start_gdialog(129, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        razlo10()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    else
                        if fallout.local_var(6) == 0 then
                            fallout.set_local_var(6, 1)
                            fallout.start_gdialog(129, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            razlo18()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        else
                            if fallout.global_var(26) == 3 then
                                razlo09()
                            else
                                if (fallout.global_var(26) == 2) and (fallout.local_var(5) == 0) then
                                    fallout.set_local_var(5, 1)
                                    razlo08()
                                else
                                    if (fallout.global_var(26) == 1) and (fallout.local_var(4) == 0) and (fallout.global_var(218) == 1) then
                                        fallout.set_local_var(4, 1)
                                        fallout.start_gdialog(129, fallout.self_obj(), 4, -1, -1)
                                        fallout.gsay_start()
                                        razlo01()
                                        fallout.gsay_end()
                                        fallout.end_dialogue()
                                    else
                                        if (fallout.global_var(26) == 1) and (fallout.global_var(218) == 1) and (fallout.local_var(4) == 1) then
                                            fallout.set_local_var(4, 2)
                                            razlo07()
                                        else
                                            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) or (fallout.global_var(158) > 2) then
                                                fallout.start_gdialog(129, fallout.self_obj(), 4, -1, -1)
                                                fallout.gsay_start()
                                                razlo00()
                                                fallout.gsay_end()
                                                fallout.end_dialogue()
                                                fallout.display_msg(fallout.message_str(129, 103))
                                            else
                                                if fallout.local_var(1) >= 2 then
                                                    fallout.start_gdialog(129, fallout.self_obj(), 4, -1, -1)
                                                    fallout.gsay_start()
                                                    razlo19()
                                                    fallout.gsay_end()
                                                    fallout.end_dialogue()
                                                else
                                                    fallout.start_gdialog(129, fallout.self_obj(), 4, -1, -1)
                                                    fallout.gsay_start()
                                                    razlo21()
                                                    fallout.gsay_end()
                                                    fallout.end_dialogue()
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
    remove_items()
end

function razlo00()
    fallout.gsay_message(129, 101, 50)
end

function razlo00a()
    fallout.display_msg(fallout.message_str(129, 103))
end

function razlo01()
    fallout.gsay_reply(129, 104)
    if (fallout.global_var(26) == 1) and (fallout.global_var(218) == 1) then
        fallout.giq_option(4, 129, 105, razlo03, 50)
    end
    fallout.giq_option(4, 129, 143, razlo22, 50)
    fallout.giq_option(4, 129, 144, razlo23a, 50)
    fallout.giq_option(-3, 129, 106, razlo02, 50)
end

function razlo02()
    fallout.gsay_message(129, 107, 50)
    fallout.set_local_var(4, 1)
end

function razlo03()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(129, 108)
    fallout.giq_option(5, 129, 110, razlo04, 50)
    fallout.giq_option(4, 129, 109, razloend, 50)
    fallout.giq_option(5, 129, 111, razloend, 50)
end

function razlo04()
    fallout.gsay_reply(129, 112)
    fallout.giq_option(4, 129, 113, razlo05, 50)
    fallout.giq_option(4, 129, 114, razlo06, 50)
end

function razlo05()
    fallout.gsay_message(129, 115, 50)
end

function razlo06()
    fallout.gsay_message(129, 116, 50)
    givestuff()
end

function razlo06na()
    fallout.gsay_message(129, 306, 50)
    razlo06nb()
end

function razlo06nb()
    local v0 = 0
    local v1 = 0
    fallout.gsay_message(129, 307, 50)
    v0 = fallout.create_object_sid(49, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v1 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 92)
    fallout.rm_obj_from_inven(fallout.dude_obj(), v1)
    fallout.destroy_object(v1)
    if fallout.local_var(7) == 0 then
        fallout.set_local_var(7, 1)
        fallout.give_exp_points(250)
        fallout.display_msg(fallout.message_str(129, 300))
    end
    fallout.gfade_out(400)
    fallout.gfade_in(400)
    fallout.game_time_advance(fallout.game_ticks(1200 * damage))
    fallout.critter_heal(fallout.dude_obj(), damage)
end

function razlo07()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(129, 117), 2)
end

function razlo08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(129, 118), 7)
end

function razlo09()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(129, 119), 12)
end

function razlo10()
    fallout.gsay_reply(129, 120)
    fallout.giq_option(4, 129, 122, razlo14, 50)
    fallout.giq_option(4, 129, 144, razlo23a, 50)
    fallout.giq_option(4, 129, 121, razloend, 50)
    fallout.giq_option(-3, 129, 123, razlo11, 50)
end

function razlo11()
    fallout.gsay_message(129, 124, 50)
    damage = MAX_HITS - HITS
    if damage > (MAX_HITS // 4) then
        razlo14()
    else
        razlo12()
    end
end

function razlo12()
    fallout.gsay_message(129, 125, 50)
end

function razlo14()
    fallout.gsay_message(129, 126, 50)
    damage = MAX_HITS - HITS
    if damage < (MAX_HITS // 4) then
        razlowmpa()
    else
        if damage < (MAX_HITS // 2) then
            razlofixa()
        else
            if damage < (3 * MAX_HITS // 4) then
                razlofixb()
            else
                razlofixc()
            end
        end
    end
end

function razlo15()
    fallout.gsay_message(129, 127, 50)
end

function Razlo17()
    local v0 = 0
    if damage < (MAX_HITS // 2) then
        v0 = fallout.create_object_sid(218, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.self_obj(), v0)
    else
        if damage < (3 * MAX_HITS // 4) then
            v0 = fallout.create_object_sid(219, 0, 0, -1)
            fallout.add_obj_to_inven(fallout.self_obj(), v0)
        else
            v0 = fallout.create_object_sid(220, 0, 0, -1)
            fallout.add_obj_to_inven(fallout.self_obj(), v0)
        end
    end
    fallout.gdialog_mod_barter(0)
    fallout.gsay_message(129, 126, 50)
    razlo08n()
end

function razlo18()
    fallout.gsay_reply(129, 128)
    fallout.giq_option(4, 129, 130, razlo14, 50)
    fallout.giq_option(4, 129, 144, razlo23a, 50)
    fallout.giq_option(5, 129, 129, razloend, 50)
end

function razlo19()
    fallout.gsay_reply(129, 131)
    fallout.giq_option(4, 129, 132, razlo20, 50)
    fallout.giq_option(4, 129, 143, razlo22, 50)
    fallout.giq_option(4, 129, 144, razlo23a, 50)
    fallout.giq_option(-3, 129, 134, razlo11, 50)
end

function razlo20()
    fallout.gsay_message(129, 135, 50)
end

function razlo21()
    fallout.gsay_reply(129, 136)
    fallout.giq_option(4, 129, 138, razlo22, 50)
    fallout.giq_option(4, 129, 144, razlo23a, 50)
    fallout.giq_option(-3, 129, 139, razlo11, 50)
    fallout.giq_option(4, 129, 137, razloend, 50)
end

function razlo22()
    fallout.gsay_message(129, 140, 50)
    razlo14()
end

function razlo23()
    fallout.gsay_reply(129, 141)
    fallout.giq_option(4, 129, 143, razlo22, 50)
    fallout.giq_option(4, 129, 144, razlo23a, 50)
    fallout.giq_option(5, 129, 145, razlo27, 50)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 92) then
        fallout.giq_option(4, 129, 146, razlo30, 50)
        fallout.giq_option(-3, 129, 303, razlo30, 50)
    end
    fallout.giq_option(4, 129, 142, razloend, 50)
    fallout.giq_option(-3, 129, 147, razlo11, 50)
end

function razlo23a()
    if fallout.local_var(8) == 1 then
        razlo25()
    else
        razlo24()
    end
end

function razlo24()
    fallout.gsay_message(129, 148, 50)
end

function razlo25()
    fallout.gsay_message(129, 149, 50)
    if fallout.get_poison(fallout.dude_obj()) > 0 then
        fallout.gsay_message(129, 150, 50)
        fallout.poison(fallout.dude_obj(), -fallout.get_poison(fallout.dude_obj()))
        razlo26()
    else
        fallout.gsay_message(129, 151, 50)
    end
    fallout.poison(fallout.dude_obj(), -fallout.get_poison(fallout.dude_obj()))
end

function razlo26()
    fallout.gsay_message(129, 152, 50)
end

function razlo27()
    fallout.gsay_message(129, 153, 50)
    fallout.gsay_reply(129, 154)
    fallout.giq_option(5, 129, 156, razlo29, 50)
    fallout.giq_option(5, 129, 157, razlo28, 50)
    fallout.giq_option(4, 129, 155, razlo27a, 49)
end

function razlo27a()
    reaction.UpReact()
end

function razlo28()
    fallout.gsay_reply(129, 158)
    fallout.giq_option(5, 129, 159, razloend, 50)
end

function razlo29()
    fallout.gsay_message(129, 160, 50)
end

function razlo30()
    fallout.gsay_message(129, 161, 50)
    fallout.gfade_out(400)
    fallout.gfade_in(400)
    fallout.game_time_advance(fallout.game_ticks(14400))
    fallout.set_local_var(8, 1)
    razlo31()
end

function razlo31()
    local v0 = 0
    fallout.gsay_message(129, 162, 50)
    v0 = fallout.create_object_sid(49, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    tail = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 92)
    fallout.rm_obj_from_inven(fallout.dude_obj(), tail)
    fallout.destroy_object(tail)
    if fallout.local_var(7) == 0 then
        fallout.set_local_var(7, 1)
        fallout.give_exp_points(250)
        fallout.display_msg(fallout.message_str(129, 300))
    end
end

function razlo00n()
    fallout.gsay_reply(129, 163)
    fallout.giq_option(4, 129, 164, razlo02n, 50)
    if fallout.global_var(43) == 1 then
        fallout.giq_option(5, 129, 165, razlo09n, 50)
    end
    if (fallout.global_var(26) == 1) and (fallout.global_var(218) == 1) then
        fallout.giq_option(5, 129, 166, razlo15n, 50)
    end
    fallout.giq_option(-3, 129, 167, razlo01n, 50)
end

function razlo01n()
    fallout.gsay_message(129, 168, 50)
    reaction.DownReact()
end

function razlo02n()
    fallout.gsay_reply(129, 169)
    fallout.giq_option(4, 129, 170, razlo04n, 50)
    fallout.giq_option(4, 129, 171, razlo03n, 50)
end

function razlo03n()
    fallout.gsay_message(129, 172, 50)
    reaction.DownReact()
end

function razlo04n()
    fallout.gsay_reply(129, 173)
    fallout.giq_option(4, 129, 174, razlo05n, 50)
end

function razlo05n()
    damage = MAX_HITS - HITS
    if damage < (MAX_HITS // 4) then
        razlowmpb()
    else
        if damage < (MAX_HITS // 2) then
            razlofixa()
        else
            if damage < (3 * MAX_HITS // 4) then
                razlofixb()
            else
                razlofixc()
            end
        end
    end
end

function razlo06n()
    fallout.gsay_reply(129, 186)
    fallout.giq_option(4, 129, 187, Razlo17, 50)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 92) then
        fallout.giq_option(4, 129, 305, razlo06na, 50)
        fallout.giq_option(-3, 129, 303, razlo06na, 50)
    end
    fallout.giq_option(4, 129, 188, razloend, 50)
    fallout.giq_option(-3, 129, 304, Razlo17, 50)
    fallout.giq_option(-3, 129, 302, razloend, 50)
end

function razlo07n()
    fallout.gsay_message(129, 189, 49)
end

function razlo08n()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 218) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 219) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 220) then
        razlo14n()
    else
        if fallout.item_caps_total(fallout.dude_obj()) >= COST then
            dummyvar = fallout.item_caps_adjust(fallout.dude_obj(), -COST)
            razlo14n()
        else
            razlo06n()
        end
    end
end

function razlo09n()
    fallout.gsay_reply(129, 190)
    fallout.giq_option(6, 129, 191, razlo10n, 50)
end

function razlo10n()
    fallout.gsay_message(129, 192, 50)
end

function razlo11n()
    fallout.gsay_reply(129, 108)
    fallout.giq_option(5, 129, 194, razlo04, 50)
    fallout.giq_option(5, 129, 195, razloend, 50)
end

function razlo14n()
    fallout.gsay_message(129, 196, 50)
    fallout.gfade_out(400)
    fallout.gfade_in(400)
    fallout.game_time_advance(fallout.game_ticks(1200 * damage))
    fallout.critter_heal(fallout.dude_obj(), damage)
end

function razlo15n()
    if fallout.local_var(11) == 1 then
        razlo16n()
    else
        fallout.set_local_var(11, 1)
        razlo11n()
    end
end

function razlo16n()
    fallout.gsay_message(129, 197, 50)
end

function razlowmpa()
    fallout.gsay_message(129, 175, 50)
end

function razlowmpb()
    fallout.gsay_message(129, 176, 50)
end

function razlofixa()
    COST = 25
    fallout.gsay_reply(129, 177)
    fallout.giq_option(4, 129, 178, razlo08n, 50)
    fallout.giq_option(4, 129, 179, razlo06n, 50)
    fallout.giq_option(-3, 129, 301, razlo08n, 50)
    fallout.giq_option(-3, 129, 302, razloend, 50)
end

function razlofixb()
    COST = 50
    fallout.gsay_reply(129, 180)
    fallout.giq_option(4, 129, 181, razlo08n, 50)
    fallout.giq_option(4, 129, 182, razlo06n, 50)
    fallout.giq_option(-3, 129, 301, razlo08n, 50)
    fallout.giq_option(-3, 129, 302, razloend, 50)
end

function razlofixc()
    COST = 100
    fallout.gsay_reply(129, 183)
    fallout.giq_option(4, 129, 184, razlo08n, 50)
    fallout.giq_option(4, 129, 185, razlo06n, 50)
    fallout.giq_option(-3, 129, 301, razlo08n, 50)
    fallout.giq_option(-3, 129, 302, razloend, 50)
end

function razlox()
end

function razloend()
end

function givestuff()
    local v0 = 0
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(71, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    if fallout.local_var(8) == 1 then
        v0 = fallout.create_object_sid(49, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    end
end

function remove_items()
    local v0 = 0
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 218) then
        v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 218)
        fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
        fallout.destroy_object(v0)
    end
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 218) then
        v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 218)
        fallout.rm_obj_from_inven(fallout.self_obj(), v0)
        fallout.destroy_object(v0)
    end
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 219) then
        v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 219)
        fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
        fallout.destroy_object(v0)
    end
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 219) then
        v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 219)
        fallout.rm_obj_from_inven(fallout.self_obj(), v0)
        fallout.destroy_object(v0)
    end
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 220) then
        v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 220)
        fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
        fallout.destroy_object(v0)
    end
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 220) then
        v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 220)
        fallout.rm_obj_from_inven(fallout.self_obj(), v0)
        fallout.destroy_object(v0)
    end
end

function critter_p_proc()
    if fallout.map_var(2) == 1 then
        fallout.set_local_var(10, fallout.local_var(10) + 1)
        fallout.set_map_var(2, 0)
        if fallout.local_var(10) < 3 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(129, 308), 2)
        else
            HOSTILE = 1
        end
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(246) == 1 then
            HOSTILE = 1
        end
    end
    if HOSTILE then
        HOSTILE = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(129, 100))
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
    reputation.inc_good_critter()
end

function pickup_p_proc()
    HOSTILE = 1
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
