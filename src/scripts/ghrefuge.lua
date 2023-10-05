local fallout = require("fallout")

local start
local do_dialogue
local ghoulend
local ghoulcbt
local ghoul00
local ghoul00a
local ghoul01
local ghoul02
local ghoul03
local ghoul04
local ghoul05
local ghoul05a
local ghoul06
local ghoul07
local ghoul07a
local ghoul08
local ghoul09
local ghoul09a
local ghoul10
local ghoul11
local ghoul12
local ghoul13
local ghoul14
local ghoul15
local ghoul16
local Critter_Action
local timetomove
local pickup_p_proc

local Hostile = 0
local init = 0
local maxleash = 20
local noevent = 0
local loopcount = 0
local new_tile = 0
local HENRY = 0

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
    if not(init) then
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, fallout.tile_num(fallout.self_obj()))
            fallout.set_local_var(5, 0)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 40)
        init = 1
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(74, 100))
        else
            if fallout.script_action() == 4 then
                pickup_p_proc()
            else
                if fallout.script_action() == 12 then
                    Critter_Action()
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

function do_dialogue()
    get_reaction()
    fallout.start_gdialog(74, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) then
        if fallout.local_var(1) >= 2 then
            ghoul14()
        else
            ghoul03()
        end
    else
        if fallout.local_var(1) >= 2 then
            fallout.set_local_var(4, 1)
            ghoul00()
        else
            fallout.set_local_var(4, 1)
            ghoul03()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function ghoulend()
end

function ghoulcbt()
    Hostile = 1
end

function ghoul00()
    fallout.gsay_reply(74, 101)
    fallout.giq_option(4, 74, 102, ghoul00a, 50)
    fallout.giq_option(4, 74, 103, ghoulend, 50)
    fallout.giq_option(5, 74, 104, ghoul05, 50)
    fallout.giq_option(-3, 74, 105, ghoul01, 50)
end

function ghoul00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        ghoul02()
    else
        ghoul01()
    end
end

function ghoul01()
    fallout.gsay_message(74, 106, 50)
    ghoulcbt()
end

function ghoul02()
    fallout.gsay_reply(74, 107)
    fallout.giq_option(4, 74, 108, ghoulend, 50)
    fallout.giq_option(4, 74, 109, ghoul04, 50)
end

function ghoul03()
    fallout.gsay_message(74, 110, 50)
    ghoulcbt()
end

function ghoul04()
    fallout.gsay_reply(74, 111)
    fallout.giq_option(4, 74, 112, ghoulcbt, 50)
    fallout.giq_option(4, 74, 113, ghoul05, 50)
end

function ghoul05()
    if fallout.local_var(1) < 2 then
        fallout.gsay_reply(74, 114)
    else
        fallout.gsay_reply(74, 115)
    end
    fallout.giq_option(4, 74, 116, ghoul12, 50)
    fallout.giq_option(4, 74, 117, ghoul11, 50)
    fallout.giq_option(6, 74, 118, ghoul05a, 50)
end

function ghoul05a()
    if HENRY == 0 then
        ghoul07()
    else
        ghoul06()
    end
end

function ghoul06()
    fallout.gsay_reply(74, 119)
    fallout.giq_option(4, 74, 120, ghoulend, 50)
    fallout.giq_option(4, 74, 121, ghoul03, 50)
end

function ghoul07()
    fallout.gsay_reply(74, 122)
    fallout.giq_option(4, 74, 123, ghoul07a, 50)
    fallout.giq_option(4, 74, 124, ghoulend, 50)
end

function ghoul07a()
    if fallout.local_var(1) < 2 then
        ghoul08()
    else
        ghoul09()
    end
end

function ghoul08()
    fallout.gsay_reply(74, 125)
    fallout.giq_option(4, 74, 126, ghoulend, 50)
    fallout.giq_option(4, 74, 127, ghoul03, 50)
end

function ghoul09()
    fallout.gsay_reply(74, 128)
    fallout.giq_option(4, 74, 129, ghoulend, 50)
    fallout.giq_option(4, 74, 130, ghoul09a, 50)
end

function ghoul09a()
    DownReact()
    if fallout.local_var(1) < 2 then
        ghoul03()
    else
        ghoul10()
    end
end

function ghoul10()
    fallout.gsay_reply(74, 131)
    fallout.giq_option(4, 74, 132, ghoulend, 50)
end

function ghoul11()
    fallout.gsay_reply(74, 133)
    fallout.giq_option(4, 74, 134, ghoul05a, 50)
end

function ghoul12()
    fallout.gsay_reply(74, 135)
    fallout.giq_option(4, 74, 136, ghoul05a, 50)
    fallout.giq_option(4, 74, 137, ghoul13, 50)
end

function ghoul13()
    fallout.gsay_reply(74, 138)
    fallout.giq_option(4, 74, 139, ghoulcbt, 50)
    fallout.giq_option(4, 74, 140, ghoulend, 50)
end

function ghoul14()
    fallout.gsay_reply(74, 141)
    fallout.giq_option(4, 74, 142, ghoul15, 50)
    fallout.giq_option(4, 74, 143, ghoul16, 50)
    fallout.giq_option(-3, 74, 105, ghoul01, 50)
end

function ghoul15()
    fallout.gsay_reply(74, 144)
    fallout.giq_option(4, 74, 145, ghoulend, 50)
end

function ghoul16()
    fallout.gsay_message(74, 146, 50)
end

function Critter_Action()
    if Hostile > 0 then
        Hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(5) then
            loopcount = loopcount + 1
            if loopcount > 40 then
                loopcount = 0
                if noevent == 0 then
                    noevent = 1
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(5, 13)), 0)
                end
            end
        end
    end
end

function timetomove()
    noevent = 0
    fallout.set_local_var(6, fallout.tile_num(fallout.self_obj()))
    new_tile = fallout.tile_num_in_direction(fallout.local_var(6), fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(7), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        Hostile = 1
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
exports.pickup_p_proc = pickup_p_proc
return exports
