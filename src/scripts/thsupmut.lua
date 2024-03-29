local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local goto0
local goto1
local goto2
local goto3
local goto4
local goto5
local goto6
local goto7
local combat
local gotoend

local rndx = 0
local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 49)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if rndx == 0 then
        rndx = fallout.random(100, 109)
    end
    fallout.display_msg(fallout.message_str(265, rndx))
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.script_overrides()
    fallout.start_gdialog(265, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(0) ~= 0 then
        goto7()
    else
        goto0()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function goto0()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(265, 110)
    fallout.giq_option(-3, 265, 111, goto1, 50)
    fallout.giq_option(4, 265, 112, combat, 50)
    fallout.giq_option(4, 265, 113, goto2, 50)
    fallout.giq_option(6, 265, 114, goto3, 50)
end

function goto1()
    fallout.gsay_message(265, 115, 50)
    combat()
end

function goto2()
    fallout.gsay_message(265, 116, 50)
    combat()
end

function goto3()
    fallout.gsay_reply(265, 117)
    fallout.giq_option(6, 265, 118, goto4, 50)
    fallout.giq_option(6, 265, 119, goto6, 50)
end

function goto4()
    fallout.gsay_reply(265, 120)
    fallout.giq_option(6, 265, 121, combat, 50)
    fallout.giq_option(6, 265, 122, combat, 50)
    fallout.giq_option(8, 265, 123, goto5, 50)
end

function goto5()
    fallout.gsay_reply(265, 124)
    fallout.giq_option(8, 265, 125, combat, 50)
    fallout.giq_option(8, 265, 126, combat, 50)
end

function goto6()
    fallout.gsay_message(265, 127, 50)
    combat()
end

function goto7()
    fallout.gsay_message(265, 128, 50)
    combat()
end

function combat()
    hostile = true
end

function gotoend()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
