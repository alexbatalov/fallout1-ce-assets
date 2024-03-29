local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local Brat02
local Brat03
local Brat04
local Brat05
local Brat06
local Brat07
local BratEnd

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 20)
        misc.set_ai(self_obj, 69)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.global_var(195) == 1 then
        if reputation.has_rep_berserker() or (fallout.global_var(158) > 2) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(395, 102), 0)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(395, 101), 0)
        end
    else
        fallout.start_gdialog(395, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Brat02()
        fallout.gsay_end()
        fallout.end_dialogue()
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
    fallout.display_msg(fallout.message_str(395, 100))
end

function Brat02()
    fallout.gsay_reply(395, 103)
    fallout.giq_option(7, 395, 104, Brat03, 50)
    fallout.giq_option(4, 395, 105, Brat04, 50)
    fallout.giq_option(4, 395, 106, Brat05, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 395, 107, Brat06, 50)
    end
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 395, 108, Brat07, 50)
    end
    fallout.giq_option(-3, 395, 109, Brat07, 50)
end

function Brat03()
    fallout.gsay_reply(395, 110)
    fallout.gsay_option(395, 115, BratEnd, 50)
end

function Brat04()
    fallout.gsay_reply(395, 111)
    fallout.gsay_option(395, 115, BratEnd, 50)
end

function Brat05()
    fallout.gsay_reply(395, 112)
    fallout.gsay_option(395, 115, BratEnd, 50)
end

function Brat06()
    fallout.gsay_reply(395, 113)
    fallout.gsay_option(395, 115, BratEnd, 50)
end

function Brat07()
    fallout.gsay_reply(395, 114)
    fallout.gsay_option(395, 115, BratEnd, 50)
end

function BratEnd()
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
