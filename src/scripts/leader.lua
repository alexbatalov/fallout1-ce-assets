local fallout = require("fallout")

local start
local do_dialogue
local leadercbt
local leaderend
local leader00
local leader02
local leader03
local leader03a
local leader04
local leader04a
local leader04b
local leader05
local leader05a
local leader06
local leader06a
local leader06b
local leader07
local leader08
local leader09
local leader10
local leader10a
local leader11
local leader12
local leader13
local leader14
local leader15
local leader15a
local leader15b
local leader16
local leader17
local leader18
local leader19
local leader19a
local leader19b
local leader20
local leader21
local leader22
local leader23
local leader24
local leader25
local leader26
local leader27
local leader28
local leader29
local leader30
local leader31

local Hostile = 0
local init_teams = 0
local has_parts = 0
local repair_skill = 0
local stuff = 0

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
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 31)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 41)
        init_teams = 1
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(81, 100))
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    if Hostile then
                        Hostile = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    else
                        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                            if fallout.local_var(7) == 0 then
                                fallout.set_local_var(7, 1)
                                if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(81, 193), 8)
                                else
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(81, 194), 8)
                                end
                            end
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

function do_dialogue()
    get_reaction()
    has_parts = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 98)
    fallout.start_gdialog(81, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) then
        if fallout.local_var(1) < 2 then
            leader30()
        else
            if fallout.global_var(31) == 2 then
                leader26()
            else
                if fallout.local_var(6) == 1 then
                    leader20()
                else
                    if fallout.global_var(30) == 1 then
                        leader29()
                    else
                        if fallout.local_var(5) == 1 then
                            if has_parts then
                                leader18()
                            else
                                leader16()
                            end
                        else
                            leader00()
                        end
                    end
                end
            end
        end
    else
        fallout.set_local_var(4, 1)
        leader00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function leadercbt()
    BigDownReact()
    Hostile = 1
end

function leaderend()
end

function leader00()
    fallout.gsay_reply(81, 101)
    fallout.giq_option(4, 81, 102, leader04, 50)
    fallout.giq_option(4, 81, 103, leader03, 50)
    fallout.giq_option(-3, 81, 104, leader02, 50)
end

function leader02()
    fallout.gsay_reply(81, 105)
    fallout.giq_option(-3, 81, 106, leaderend, 50)
end

function leader03()
    fallout.gsay_reply(81, 107)
    fallout.giq_option(4, 81, 108, leader04, 50)
    fallout.giq_option(4, 81, 109, leader03a, 51)
    fallout.giq_option(4, 81, 110, leaderend, 50)
end

function leader03a()
    DownReact()
    leader30()
end

function leader04()
    fallout.gsay_reply(81, 111)
    if fallout.global_var(553) ~= 1 then
        fallout.giq_option(4, 81, 112, leader05, 50)
    else
        fallout.giq_option(4, 81, 113, leader23, 50)
    end
    fallout.giq_option(5, 81, 114, leader04a, 50)
    fallout.giq_option(5, 81, 115, leader04b, 51)
end

function leader04a()
    if fallout.global_var(553) ~= 1 then
        leader06()
    else
        leader07()
    end
end

function leader04b()
    DownReact()
    leader05()
end

function leader05()
    fallout.gsay_reply(81, 116)
    fallout.giq_option(4, 81, 117, leader05a, 51)
    fallout.giq_option(4, 81, 118, leader06, 50)
end

function leader05a()
    DownReact()
    leader06()
end

function leader06()
    fallout.gsay_reply(81, 119)
    fallout.giq_option(4, 81, 120, leader07, 50)
    fallout.giq_option(4, 81, 121, leader06a, 51)
    fallout.giq_option(4, 81, 122, leader08, 50)
    fallout.giq_option(4, 81, 123, leader06b, 51)
end

function leader06a()
    DownReact()
    leader08()
end

function leader06b()
    DownReact()
    leader07()
end

function leader07()
    fallout.gsay_reply(81, 124)
    fallout.giq_option(6, 81, 125, leader25, 50)
    fallout.giq_option(4, 81, 126, leader09, 50)
    fallout.giq_option(4, 81, 127, leader24, 50)
end

function leader08()
    fallout.gsay_reply(81, 128)
    fallout.giq_option(4, 81, 129, leaderend, 50)
    fallout.giq_option(4, 81, 130, leader09, 50)
end

function leader09()
    fallout.gsay_reply(81, 131)
    fallout.giq_option(4, 81, 129, leader10, 50)
end

function leader10()
    fallout.gsay_reply(81, 132)
    fallout.giq_option(4, 81, 133, leader10a, 51)
    fallout.giq_option(4, 81, 134, leader11, 50)
    fallout.giq_option(4, 81, 135, leader11, 50)
end

function leader10a()
    DownReact()
    leader13()
end

function leader11()
    fallout.gsay_reply(81, 136)
    fallout.giq_option(4, 81, 137, leader12, 50)
    fallout.giq_option(4, 81, 138, leader14, 50)
end

function leader12()
    fallout.gsay_message(81, 139, 50)
    leadercbt()
end

function leader13()
    fallout.gsay_reply(81, 140)
    fallout.giq_option(4, 81, 141, leader11, 50)
    fallout.giq_option(4, 81, 142, leadercbt, 51)
end

function leader14()
    fallout.gsay_reply(81, 143)
    fallout.giq_option(4, 81, 144, leader15, 50)
    if has_parts then
        fallout.giq_option(4, 81, 145, leader21, 50)
    end
end

function leader15()
    fallout.gsay_reply(81, 146)
    fallout.giq_option(4, 81, 147, leader12, 50)
    fallout.giq_option(4, 81, 148, leader15b, 50)
    fallout.giq_option(4, 81, 149, leader15a, 51)
end

function leader15a()
    DownReact()
    leader15b()
end

function leader15b()
    if fallout.global_var(31) ~= 2 then
        fallout.set_global_var(31, 1)
    end
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(81, 150)
    fallout.giq_option(4, 81, 151, leaderend, 50)
end

function leader16()
    fallout.gsay_reply(81, 152)
    fallout.giq_option(4, 81, 153, leader17, 50)
    fallout.giq_option(4, 81, 154, leader12, 50)
    fallout.giq_option(4, 81, 155, leader22, 50)
end

function leader17()
    fallout.gsay_message(81, 156, 50)
end

function leader18()
    fallout.gsay_reply(81, 157)
    fallout.giq_option(4, 81, 158, leader19, 50)
    fallout.giq_option(4, 81, 159, leader12, 50)
end

function leader19()
    fallout.set_local_var(6, 1)
    repair_skill = fallout.has_skill(fallout.dude_obj(), 13)
    if repair_skill < 60 then
        leader19a()
    else
        leader19b()
    end
end

function leader19a()
    stuff = fallout.create_object_sid(76, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
    stuff = fallout.create_object_sid(76, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
    stuff = fallout.create_object_sid(76, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
    fallout.gsay_message(81, 160, 50)
end

function leader19b()
    fallout.gsay_message(81, 161, 50)
end

function leader20()
    fallout.gsay_reply(81, 162)
    fallout.giq_option(4, 81, 163, leader17, 50)
    fallout.giq_option(4, 81, 164, leader12, 50)
end

function leader21()
    fallout.gsay_reply(81, 165)
    fallout.giq_option(4, 81, 166, leader19, 50)
    fallout.giq_option(4, 81, 167, leader12, 50)
end

function leader22()
    fallout.gsay_reply(81, 168)
    fallout.giq_option(4, 81, 169, leaderend, 50)
end

function leader23()
    fallout.gsay_reply(81, 170)
    fallout.giq_option(4, 81, 171, leader07, 50)
end

function leader24()
    fallout.gsay_reply(81, 172)
    fallout.giq_option(4, 81, 173, leader09, 50)
    fallout.giq_option(4, 81, 129, leader10, 50)
end

function leader25()
    fallout.gsay_reply(81, 174)
    fallout.giq_option(4, 81, 175, leader09, 50)
    fallout.giq_option(4, 81, 176, leader24, 50)
end

function leader26()
    fallout.gsay_reply(81, 177)
    fallout.giq_option(4, 81, 178, leaderend, 50)
end

function leader27()
    fallout.gsay_reply(81, 179)
    fallout.giq_option(4, 81, 180, leader28, 50)
end

function leader28()
    fallout.gsay_reply(81, 181)
    fallout.giq_option(4, 81, 129, leaderend, 50)
end

function leader29()
    fallout.gsay_reply(81, 182)
    if fallout.local_var(5) == 1 then
        fallout.giq_option(4, 81, 183, leader22, 50)
    end
    fallout.giq_option(4, 81, 184, leader12, 50)
    fallout.giq_option(4, 81, 185, leader31, 50)
end

function leader30()
    fallout.gsay_message(81, 186, 50)
end

function leader31()
    fallout.gsay_reply(81, 187)
    fallout.giq_option(4, 81, 189, leader15, 50)
    if has_parts then
        fallout.giq_option(4, 81, 145, leader21, 50)
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
return exports
