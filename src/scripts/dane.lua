local fallout = require("fallout")

local start
local do_dialogue
local social_skills
local dane00
local dane01
local dane02
local dane03
local dane04
local dane05
local dane06
local dane07
local dane08
local dane09
local dane10
local dane11
local dane12
local dane13
local dane14
local dane15
local dane16
local dane17
local dane18
local dane19
local dane20
local dane21
local dane22
local dane23
local dane24
local danemore
local danereturn

local hostile = 0
local Only_Once = 1

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
    if Only_Once then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        Only_Once = 0
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(499, 100))
        else
            if fallout.script_action() == 4 then
                hostile = 1
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
                        fallout.set_global_var(160, fallout.global_var(160) + 1)
                        if (fallout.global_var(160) % 6) == 0 then
                            fallout.set_global_var(155, fallout.global_var(155) + 1)
                        end
                    end
                else
                    if fallout.script_action() == 12 then
                        if hostile then
                            hostile = 0
                            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    get_reaction()
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(6) == 0 then
        dane00()
    else
        if fallout.local_var(7) == 0 then
            dane01()
        else
            if fallout.local_var(8) == 0 then
                dane02()
            else
                if fallout.local_var(9) == 0 then
                    dane03()
                else
                    if fallout.local_var(10) == 0 then
                        dane04()
                    else
                        if fallout.local_var(11) == 0 then
                            dane05()
                        else
                            if fallout.local_var(12) == 0 then
                                dane06()
                            else
                                if fallout.local_var(13) == 0 then
                                    dane07()
                                else
                                    if fallout.local_var(14) == 0 then
                                        dane08()
                                    else
                                        if fallout.local_var(15) == 0 then
                                            dane09()
                                        else
                                            if fallout.local_var(16) == 0 then
                                                dane10()
                                            else
                                                if fallout.local_var(17) == 0 then
                                                    dane11()
                                                else
                                                    if fallout.local_var(18) == 0 then
                                                        dane12()
                                                    else
                                                        if fallout.local_var(19) == 0 then
                                                            dane13()
                                                        else
                                                            if fallout.local_var(20) == 0 then
                                                                dane14()
                                                            else
                                                                if fallout.local_var(21) == 0 then
                                                                    dane15()
                                                                else
                                                                    if fallout.local_var(22) == 0 then
                                                                        dane16()
                                                                    else
                                                                        if fallout.local_var(23) == 0 then
                                                                            dane17()
                                                                        else
                                                                            if fallout.local_var(24) == 0 then
                                                                                dane18()
                                                                            else
                                                                                if fallout.local_var(25) == 0 then
                                                                                    dane19()
                                                                                else
                                                                                    if fallout.local_var(26) == 0 then
                                                                                        dane20()
                                                                                    else
                                                                                        if fallout.local_var(5) == 1 then
                                                                                            dane24()
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
    fallout.gsay_end()
    fallout.end_dialogue()
end

function social_skills()
    fallout.script_overrides()
    get_reaction()
    do_dialogue()
end

function dane00()
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(499, 101)
    danemore()
    fallout.gsay_reply(499, 102)
    danemore()
    fallout.gsay_message(499, 103, 50)
end

function dane01()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(499, 104)
    danemore()
    fallout.gsay_reply(499, 105)
    danemore()
    fallout.gsay_message(499, 106, 50)
end

function dane02()
    fallout.set_local_var(8, 1)
    fallout.gsay_reply(499, 107)
    danemore()
    fallout.gsay_reply(499, 108)
    danemore()
    fallout.gsay_reply(499, 109)
    danemore()
    fallout.gsay_message(499, 110, 50)
end

function dane03()
    fallout.set_local_var(9, 1)
    fallout.gsay_reply(499, 111)
    danemore()
    fallout.gsay_reply(499, 112)
    danemore()
    fallout.gsay_message(499, 113, 50)
end

function dane04()
    fallout.set_local_var(10, 1)
    fallout.gsay_reply(499, 114)
    danemore()
    fallout.gsay_reply(499, 115)
    danemore()
    fallout.gsay_reply(499, 116)
    danemore()
    fallout.gsay_message(499, 117, 50)
end

function dane05()
    fallout.set_local_var(11, 1)
    fallout.gsay_reply(499, 118)
    danemore()
    fallout.gsay_reply(499, 119)
    danemore()
    fallout.gsay_message(499, 120, 50)
end

function dane06()
    fallout.set_local_var(12, 1)
    fallout.gsay_reply(499, 121)
    danemore()
    fallout.gsay_reply(499, 122)
    danemore()
    fallout.gsay_reply(499, 123)
    danemore()
    fallout.gsay_message(499, 124, 50)
end

function dane07()
    fallout.set_local_var(13, 1)
    fallout.gsay_reply(499, 125)
    danemore()
    fallout.gsay_reply(499, 126)
    danemore()
    fallout.gsay_message(499, 127, 50)
end

function dane08()
    fallout.set_local_var(14, 1)
    fallout.gsay_reply(499, 128)
    danemore()
    fallout.gsay_reply(499, 129)
    danemore()
    fallout.gsay_reply(499, 130)
    danemore()
    fallout.gsay_message(499, 131, 50)
end

function dane09()
    fallout.set_local_var(15, 1)
    fallout.gsay_reply(499, 132)
    danemore()
    fallout.gsay_reply(499, 133)
    danemore()
    fallout.gsay_reply(499, 134)
    danemore()
    fallout.gsay_message(499, 135, 50)
end

function dane10()
    fallout.set_local_var(16, 1)
    fallout.gsay_reply(499, 136)
    danemore()
    fallout.gsay_reply(499, 137)
    danemore()
    fallout.gsay_message(499, 138, 50)
end

function dane11()
    fallout.set_local_var(17, 1)
    fallout.gsay_reply(499, 139)
    danemore()
    fallout.gsay_reply(499, 140)
    danemore()
    fallout.gsay_reply(499, 141)
    danemore()
    fallout.gsay_message(499, 142, 50)
end

function dane12()
    fallout.set_local_var(18, 1)
    fallout.gsay_reply(499, 143)
    danemore()
    fallout.gsay_reply(499, 144)
    danemore()
    fallout.gsay_reply(499, 145)
    danemore()
    fallout.gsay_message(499, 146, 50)
end

function dane13()
    fallout.set_local_var(19, 1)
    fallout.gsay_reply(499, 147)
    danemore()
    fallout.gsay_reply(499, 148)
    danemore()
    fallout.gsay_reply(499, 149)
    danemore()
    fallout.gsay_reply(499, 150)
    danemore()
    fallout.gsay_message(499, 151, 50)
end

function dane14()
    fallout.set_local_var(20, 1)
    fallout.gsay_reply(499, 152)
    danemore()
    fallout.gsay_reply(499, 153)
    danemore()
    fallout.gsay_reply(499, 154)
    danemore()
    fallout.gsay_message(499, 155, 50)
end

function dane15()
    fallout.set_local_var(21, 1)
    fallout.gsay_reply(499, 156)
    danemore()
    fallout.gsay_reply(499, 157)
    danemore()
    fallout.gsay_message(499, 158, 50)
end

function dane16()
    fallout.gsay_reply(499, 159)
    danemore()
    fallout.gsay_reply(499, 160)
    danemore()
    fallout.gsay_reply(499, 161)
    danemore()
    fallout.gsay_reply(499, 162)
    fallout.giq_option(7, 499, 163, dane17, 50)
    fallout.giq_option(7, 499, 164, dane18, 50)
    fallout.giq_option(4, 499, 165, dane19, 50)
    fallout.giq_option(4, 499, 166, dane20, 50)
    fallout.giq_option(4, 499, 167, dane21, 50)
    fallout.giq_option(4, 499, 168, dane22, 50)
    fallout.giq_option(-3, 499, 169, dane23, 50)
end

function dane17()
    fallout.gsay_reply(499, 170)
    danemore()
    fallout.gsay_reply(499, 171)
    danemore()
    fallout.gsay_reply(499, 172)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.gsay_reply(499, 173)
        fallout.giq_option(7, 499, 174, dane18, 50)
        fallout.giq_option(4, 499, 175, dane19, 50)
        fallout.giq_option(4, 499, 176, dane20, 50)
        fallout.giq_option(4, 499, 177, dane21, 50)
        fallout.giq_option(4, 499, 178, dane22, 50)
    else
        danemore()
        fallout.gsay_message(499, 179, 50)
    end
end

function dane18()
    fallout.gsay_reply(499, 180)
    danemore()
    fallout.gsay_reply(499, 181)
    danemore()
    fallout.gsay_reply(499, 182)
    danemore()
    fallout.gsay_reply(499, 183)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.gsay_reply(499, 184)
        fallout.giq_option(7, 499, 185, dane18, 50)
        fallout.giq_option(4, 499, 186, dane19, 50)
        fallout.giq_option(4, 499, 187, dane20, 50)
        fallout.giq_option(4, 499, 188, dane21, 50)
        fallout.giq_option(4, 499, 189, dane22, 50)
    else
        danemore()
        fallout.gsay_message(499, 190, 50)
    end
end

function dane19()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.gsay_reply(499, 191)
        fallout.giq_option(7, 499, 192, dane18, 50)
        fallout.giq_option(4, 499, 193, dane19, 50)
        fallout.giq_option(4, 499, 194, dane20, 50)
        fallout.giq_option(4, 499, 195, dane21, 50)
        fallout.giq_option(4, 499, 196, dane22, 50)
    else
        fallout.gsay_message(499, 197, 50)
    end
end

function dane20()
    fallout.gsay_reply(499, 198)
    danemore()
    fallout.gsay_reply(499, 199)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.giq_option(7, 499, 200, dane19, 50)
        fallout.giq_option(7, 499, 201, dane18, 50)
        fallout.giq_option(4, 499, 202, dane19, 50)
        fallout.giq_option(4, 499, 203, dane21, 50)
        fallout.giq_option(4, 499, 204, dane22, 50)
        fallout.giq_option(-3, 499, 205, dane23, 50)
    else
        danemore()
        fallout.gsay_message(499, 206, 50)
    end
end

function dane21()
    fallout.gsay_reply(499, 207)
    danemore()
    fallout.gsay_reply(499, 208)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.giq_option(7, 499, 209, dane19, 50)
        fallout.giq_option(7, 499, 210, dane18, 50)
        fallout.giq_option(4, 499, 211, dane19, 50)
        fallout.giq_option(4, 499, 212, dane20, 50)
        fallout.giq_option(4, 499, 213, dane22, 50)
        fallout.giq_option(-3, 499, 214, dane23, 50)
    else
        danemore()
        fallout.gsay_message(499, 215, 50)
    end
end

function dane22()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(499, 216)
    danemore()
    fallout.gsay_reply(499, 217)
    danemore()
    fallout.gsay_reply(499, 218)
    danemore()
    fallout.gsay_message(499, 219, 50)
end

function dane23()
    fallout.set_local_var(5, 1)
    fallout.gsay_message(499, 220, 50)
end

function dane24()
    fallout.gsay_message(499, 221, 50)
end

function danemore()
    fallout.gsay_option(499, 222, danereturn, 50)
end

function danereturn()
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
