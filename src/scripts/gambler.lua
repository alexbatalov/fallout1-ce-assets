local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local talk_p_proc
local destroy_p_proc
local timed_event_p_proc
local look_at_p_proc
local Hernandez01
local Hernandez02
local Hernandez03
local Hernandez04
local Hernandez05
local Hernandez06
local Hernandez07
local Hernandez08
local Hernandez09
local Hernandez10
local Hernandez11
local Hernandez12
local Hernandez13
local Hernandez14
local Hernandezend

local known = false

function start()
    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if known then
        fallout.display_msg(fallout.message_str(247, 100))
    else
        fallout.display_msg(fallout.message_str(247, 101))
    end
end

function talk_p_proc()
    fallout.start_gdialog(247, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if known then
        Hernandez01()
    else
        Hernandez12()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function timed_event_p_proc()
    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
end

function Hernandez01()
    fallout.gsay_reply(247, 102)
    known = true
    fallout.giq_option(4, 247, 103, Hernandez02, 50)
    fallout.giq_option(4, 247, 104, Hernandez03, 50)
    fallout.giq_option(-3, 247, 105, Hernandez04, 50)
end

function Hernandez02()
    fallout.gsay_message(247, 106, 50)
    fallout.giq_option(4, 247, 107, Hernandez03, 50)
    fallout.giq_option(5, 247, 108, Hernandez09, 50)
    fallout.giq_option(5, 247, 109, Hernandez11, 50)
end

function Hernandez03()
    local roll = fallout.do_check(fallout.dude_obj(), 1, 0)
    local msg = fallout.message_str(247, 110)
    if fallout.is_success(roll) then
        msg = msg .. fallout.message_str(247, 111)
    end
    fallout.gsay_message(247, msg, 50)
    fallout.gsay_reply(247, 112)
    fallout.giq_option(4, 247, 113, Hernandez05, 50)
    fallout.giq_option(4, 247, 114, Hernandez06, 50)
    if fallout.is_success(roll) then
        fallout.giq_option(4, 247, 115, Hernandez14, 50)
    end
end

function Hernandez04()
    fallout.gsay_message(247, 116, 50)
end

function Hernandez05()
    fallout.gsay_message(247, 117, 50)
end

function Hernandez06()
    fallout.gsay_message(247, 118, 50)
end

function Hernandez07()
    fallout.gsay_reply(247, 119)
    fallout.giq_option(4, 247, 120, Hernandez08, 50)
    fallout.giq_option(4, 247, 121, Hernandez03, 50)
end

function Hernandez08()
end

function Hernandez09()
    fallout.gsay_message(247, 122, 50)
    fallout.gsay_reply(247, 123)
    fallout.giq_option(4, 247, 124, Hernandez07, 50)
    fallout.giq_option(6, 247, 125, Hernandez10, 50)
end

function Hernandez10()
    fallout.gsay_message(247, 126, 50)
end

function Hernandez11()
    fallout.gsay_reply(247, 127)
    fallout.giq_option(4, 247, 128, Hernandez03, 50)
end

function Hernandez12()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(247, 136)
    else
        fallout.gsay_reply(247, 137)
    end
    fallout.giq_option(4, 247, 130, Hernandez13, 50)
    fallout.giq_option(4, 247, 131, Hernandezend, 50)
end

function Hernandez13()
    fallout.gsay_message(247, 132, 50)
    fallout.giq_option(4, 247, 133, Hernandezend, 50)
    fallout.giq_option(4, 247, 134, Hernandez14, 50)
end

function Hernandez14()
    fallout.gsay_message(247, 135, 50)
    fallout.add_timer_event(fallout.self_obj(), 5, 1)
end

function Hernandezend()
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
