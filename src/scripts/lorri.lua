local fallout = require("fallout")

local start
local do_dialogue
local Lorri01
local Lorri02
local Lorri03
local Lorri04
local Lorri05
local Lorri06
local Lorri07
local Lorri08
local Lorri09
local Lorri10
local Lorri11
local Lorri12
local Lorri13
local Lorri14
local Lorri15
local Lorri16
local Lorri17
local Lorri18
local Lorri19
local Lorri20
local Lorri21
local Lorri22
local Lorri23
local Lorri24
local Lorri25
local Lorri26
local Lorri27

local known = 0
local line21flag = 0
local line22flag = 0
local line23flag = 0
local line24flag = 0
local line25flag = 0

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
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            if not(known) then
                fallout.display_msg(fallout.message_str(0, 100))
            else
                fallout.display_msg(fallout.message_str(0, 101))
            end
        else
            if fallout.script_action() == 22 then
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if known then
        Lorri04()
    else
        Lorri01()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Lorri01()
    fallout.gsay_reply(0, 102)
    fallout.giq_option(4, 0, 103, Lorri02, 50)
    fallout.giq_option(4, 0, fallout.message_str(0, 104) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(0, 105), Lorri03, 50)
    fallout.giq_option(-3, 0, fallout.message_str(0, 106), Lorri15, 50)
end

function Lorri02()
    fallout.gsay_reply(0, 107)
    if not(known) then
        fallout.giq_option(4, 0, 108, Lorri03, 50)
    end
    fallout.giq_option(4, 0, 109, Lorri16, 50)
    fallout.giq_option(4, 0, 110, Lorri20, 50)
    fallout.giq_option(4, 0, 111, Lorri04, 50)
    fallout.giq_option(4, 0, 112, Lorri05, 50)
end

function Lorri03()
    known = 1
    fallout.gsay_reply(0, 113)
    fallout.giq_option(4, 0, 114, Lorri02, 50)
    Goodbyes()
    fallout.giq_option(4, 0, exit_line, Lorri05, 50)
end

function Lorri04()
    fallout.gsay_reply(0, 115)
    fallout.giq_option(4, 0, 116, Lorri06, 50)
    fallout.giq_option(4, 0, 117, Lorri07, 50)
    fallout.giq_option(4, 0, 118, Lorri02, 50)
end

function Lorri05()
    fallout.gsay_message(0, 119, 50)
end

function Lorri06()
    fallout.gsay_reply(0, 120)
    fallout.giq_option(4, 0, 121, Lorri08, 50)
    fallout.giq_option(4, 0, 122, Lorri10, 50)
    fallout.giq_option(4, 0, 123, Lorri02, 50)
    fallout.giq_option(4, 0, 124, Lorri05, 50)
end

function Lorri07()
    fallout.gsay_reply(0, 125)
    fallout.giq_option(4, 0, 126, Lorri02, 50)
    fallout.giq_option(4, 0, 127, Lorri05, 50)
end

function Lorri08()
    fallout.gsay_message(0, 128, 50)
    fallout.gsay_reply(0, 129)
    fallout.giq_option(4, 0, 130, Lorri09, 50)
    fallout.giq_option(4, 0, 131, Lorri02, 50)
    fallout.giq_option(4, 0, 132, Lorri05, 50)
end

function Lorri09()
    fallout.gsay_reply(0, 133)
    fallout.giq_option(4, 0, 134, Lorri12, 50)
    fallout.giq_option(4, 0, 135, Lorri02, 50)
    fallout.giq_option(4, 0, 136, Lorri05, 50)
end

function Lorri10()
    fallout.gsay_reply(0, 137)
    fallout.giq_option(4, 0, 138, Lorri11, 50)
    fallout.giq_option(4, 0, 139, Lorri06, 50)
    fallout.giq_option(4, 0, 140, Lorri02, 50)
    fallout.giq_option(4, 0, fallout.message_str(0, 141), Lorri05, 50)
end

function Lorri11()
    fallout.gsay_reply(0, 142)
    fallout.giq_option(4, 0, 143, Lorri13, 50)
    fallout.giq_option(4, 0, 144, Lorri14, 50)
    fallout.giq_option(4, 0, 145, Lorri02, 50)
    fallout.giq_option(4, 0, 146, Lorri05, 50)
end

function Lorri12()
    fallout.gsay_message(0, 147, 50)
end

function Lorri13()
    fallout.gsay_message(0, 148, 50)
end

function Lorri14()
    fallout.gsay_reply(0, 149)
    fallout.giq_option(4, 0, fallout.message_str(0, 150), Lorri02, 50)
    fallout.giq_option(4, 0, 151, Lorri05, 50)
end

function Lorri15()
    fallout.gsay_message(0, 152, 50)
end

function Lorri16()
    fallout.gsay_reply(0, 153)
    fallout.giq_option(4, 0, 154, Lorri17, 50)
    fallout.giq_option(4, 0, 155, Lorri05, 50)
end

function Lorri17()
    fallout.gsay_message(0, 156, 50)
    fallout.gsay_reply(0, 157)
    fallout.giq_option(4, 0, 158, Lorri18, 50)
    fallout.giq_option(4, 0, 159, Lorri08, 50)
    fallout.giq_option(4, 0, 160, Lorri19, 50)
    fallout.giq_option(4, 0, 161, Lorri27, 50)
    fallout.giq_option(4, 0, 162, Lorri05, 50)
end

function Lorri18()
    fallout.gsay_reply(0, 163)
    fallout.giq_option(4, 0, 164, Lorri02, 50)
    fallout.giq_option(4, 0, 165, Lorri05, 50)
end

function Lorri19()
    fallout.gsay_reply(0, 166)
    fallout.giq_option(4, 0, 167, Lorri08, 50)
    fallout.giq_option(4, 0, 168, Lorri02, 50)
    fallout.giq_option(4, 0, 169, Lorri05, 50)
end

function Lorri20()
    fallout.gsay_reply(0, 170)
    if not(line21flag) then
        fallout.giq_option(4, 0, 171, Lorri21, 50)
    end
    if not(line22flag) then
        fallout.giq_option(4, 0, 172, Lorri22, 50)
    end
    if not(line23flag) then
        fallout.giq_option(4, 0, 173, Lorri23, 50)
    end
    if not(line24flag) then
        fallout.giq_option(4, 0, 174, Lorri24, 50)
    end
    if not(line25flag) then
        fallout.giq_option(4, 0, 175, Lorri25, 50)
    end
    fallout.giq_option(4, 0, 176, Lorri05, 50)
end

function Lorri21()
    fallout.gsay_reply(0, 177)
    line21flag = 1
    Lorri26()
end

function Lorri22()
    fallout.gsay_reply(0, 178)
    line22flag = 1
    Lorri26()
end

function Lorri23()
    fallout.gsay_reply(0, 179)
    line23flag = 1
    Lorri26()
end

function Lorri24()
    fallout.gsay_reply(0, 180)
    line24flag = 1
    Lorri26()
end

function Lorri25()
    fallout.gsay_reply(0, 181)
    line25flag = 1
    Lorri26()
end

function Lorri26()
    fallout.giq_option(4, 0, 182, Lorri20, 50)
    fallout.giq_option(4, 0, 183, Lorri02, 50)
    Goodbyes()
    fallout.giq_option(4, 0, exit_line, Lorri05, 50)
end

function Lorri27()
    fallout.gsay_message(0, 184, 50)
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
