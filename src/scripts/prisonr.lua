local fallout = require("fallout")

local start
local timeforwhat
local do_dialogue
local prisonrcbt
local prisonrend
local prisonr00
local prisonr01
local prisonr02
local prisonr03
local prisonr04
local prisonr05
local prisonr06
local prisonr07
local prisonr08
local leave_map

local Hostile = 0
local init_teams = 0
local rndx = 0
local rndy = 0
local rndz = 0
local my_hex = 0

function start()
    if not(init_teams) then
        init_teams = 1
        if fallout.local_var(3) > 9 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 40)
    end
    if fallout.local_var(3) < 10 then
        if fallout.script_action() == 22 then
            timeforwhat()
        else
            if fallout.script_action() == 11 then
                if fallout.local_var(1) == 0 then
                    do_dialogue()
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(89, 126), 2)
                end
            else
                if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(89, 100))
                else
                    if fallout.script_action() == 4 then
                        Hostile = 1
                    else
                        if fallout.script_action() == 12 then
                            if fallout.map_var(6) ~= 0 then
                                if fallout.local_var(1) == 1 then
                                    leave_map()
                                else
                                    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 5) then
                                        fallout.dialogue_system_enter()
                                    end
                                end
                            else
                                if Hostile then
                                    Hostile = 0
                                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                                end
                            end
                        else
                            if fallout.script_action() == 18 then
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
                        end
                    end
                end
            end
        end
    end
end

function timeforwhat()
    if fallout.fixed_param() == 1 then
        Hostile = 1
    end
end

function do_dialogue()
    fallout.start_gdialog(89, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.map_var(6) ~= 0 then
        prisonr06()
    else
        if fallout.local_var(0) then
            prisonr05()
        else
            fallout.set_local_var(0, 1)
            prisonr00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function prisonrcbt()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 1)
end

function prisonrend()
end

function prisonr00()
    fallout.gsay_reply(89, 101)
    fallout.giq_option(4, 89, 102, prisonrend, 50)
    fallout.giq_option(-3, 89, 103, prisonr01, 50)
    fallout.giq_option(4, 89, 104, prisonr02, 50)
    fallout.giq_option(6, 89, 105, prisonr03, 50)
end

function prisonr01()
    fallout.gsay_message(89, 106, 50)
end

function prisonr02()
    fallout.gsay_message(89, 107, 50)
end

function prisonr03()
    fallout.gsay_reply(89, 108)
    fallout.giq_option(6, 89, 109, prisonr04, 50)
    fallout.giq_option(6, 89, 110, prisonr02, 50)
end

function prisonr04()
    fallout.gsay_reply(89, 111)
    fallout.giq_option(6, 89, 112, prisonr02, 50)
    fallout.giq_option(6, 89, 113, prisonrend, 50)
end

function prisonr05()
    fallout.gsay_message(89, 114, 50)
end

function prisonr06()
    fallout.set_local_var(2, 15863)
    fallout.set_local_var(3, 0)
    fallout.set_local_var(1, 1)
    fallout.give_exp_points(500)
    fallout.display_msg(fallout.message_str(89, 124) + 500 + fallout.message_str(89, 125))
    fallout.gsay_reply(89, 115)
    fallout.giq_option(4, 89, 116, prisonrend, 50)
    fallout.giq_option(5, 89, 117, prisonr07, 50)
    fallout.giq_option(-3, 89, 118, prisonrend, 50)
end

function prisonr07()
    fallout.gsay_reply(89, 119)
    fallout.giq_option(5, 89, 120, prisonr08, 50)
    fallout.giq_option(5, 89, 121, prisonrend, 50)
end

function prisonr08()
    fallout.gsay_reply(89, 122)
    fallout.giq_option(5, 89, 123, prisonrend, 50)
end

function leave_map()
    my_hex = fallout.tile_num(fallout.self_obj())
    if my_hex == fallout.local_var(2) then
        fallout.set_local_var(3, fallout.local_var(3) + 1)
        if fallout.local_var(3) > 7 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
            fallout.set_local_var(3, 10)
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            fallout.move_to(fallout.self_obj(), 0, 0)
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(2, 15863)
            else
                if fallout.local_var(3) == 2 then
                    fallout.set_local_var(2, 13065)
                else
                    if fallout.local_var(3) == 3 then
                        fallout.set_local_var(2, 13081)
                    else
                        if fallout.local_var(3) == 4 then
                            fallout.set_local_var(2, 14496)
                        else
                            if fallout.local_var(3) == 5 then
                                fallout.set_local_var(2, 11900)
                            else
                                if fallout.local_var(3) == 6 then
                                    fallout.set_local_var(2, 8700)
                                else
                                    if fallout.local_var(3) == 7 then
                                        fallout.set_local_var(2, 5900)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(2), 0)
        end
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(2), 0)
end

local exports = {}
exports.start = start
return exports
