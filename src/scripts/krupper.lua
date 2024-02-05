local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local destroy_p_proc
local krupper00
local krupper01
local krupper02
local krupper03
local krupper04
local kruppercombat

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
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    if fallout.local_var(4) == 0 and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        fallout.dialogue_system_enter()
    end
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(434, 100))
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        krupper01()
    else
        kruppercombat()
    end
    fallout.set_local_var(4, 1)
end

function timed_event_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        hostile = true
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function krupper00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(434, 101), 0)
    kruppercombat()
end

function krupper01()
    fallout.start_gdialog(434, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.gsay_reply(434, 102)
    fallout.giq_option(4, 434, 103, krupper03, 50)
    fallout.giq_option(4, 434, 104, kruppercombat, 50)
    fallout.giq_option(-3, 434, 105, krupper02, 50)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function krupper02()
    fallout.gsay_message(434, 106, 50)
    kruppercombat()
end

function krupper03()
    fallout.gsay_reply(434, 107)
    fallout.giq_option(4, 434, 108, krupper02, 50)
    fallout.giq_option(4, 434, 109, krupper04, 50)
end

function krupper04()
    fallout.gsay_message(434, 110, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(20), 1)
end

function kruppercombat()
    hostile = true
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
