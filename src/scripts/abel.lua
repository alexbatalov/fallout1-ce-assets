local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local destroy_p_proc
local Abel00
local Abel01
local Abel02
local Abel03
local Abel04
local Abel05
local Abel06
local Abel07
local Abel08
local AbelCombat

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 48)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
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

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.start_gdialog(359, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        Abel06()
    else
        if fallout.local_var(4) == 1 then
            Abel08()
        else
            Abel00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function timed_event_p_proc()
    hostile = true
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function Abel00()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(359, 102)
    fallout.giq_option(-3, 359, 103, Abel01, 0)
    fallout.giq_option(4, 359, 104, Abel03, 0)
    fallout.giq_option(5, 359, 105, Abel04, 0)
end

function Abel01()
    fallout.gsay_reply(359, 106)
    fallout.giq_option(-3, 359, 107, Abel02, 0)
end

function Abel02()
    fallout.gsay_reply(359, 108)
    fallout.giq_option(-3, 359, 109, Abel03, 0)
end

function Abel03()
    fallout.gsay_message(359, 110, 0)
    AbelCombat()
end

function Abel04()
    fallout.gsay_reply(359, 111)
    fallout.giq_option(5, 359, 112, Abel05, 0)
end

function Abel05()
    fallout.gsay_message(359, 113, 0)
    AbelCombat()
end

function Abel06()
    fallout.gsay_reply(359, 114)
    fallout.giq_option(-3, 359, 115, Abel01, 0)
    fallout.giq_option(4, 359, 116, Abel07, 0)
end

function Abel07()
    fallout.gsay_message(359, 117, 0)
end

function Abel08()
    fallout.gsay_message(359, 118, 0)
    AbelCombat()
end

function AbelCombat()
    fallout.set_external_var("field_change", "off")
    fallout.use_obj(fallout.map_var(11))
    fallout.move_to(fallout.map_var(11), 7000, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
