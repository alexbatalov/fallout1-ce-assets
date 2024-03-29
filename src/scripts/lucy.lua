local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local dialog_end
local lucy00
local lucy01
local lucy02
local lucy03
local lucy04
local lucy05

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 50)
        misc.set_ai(self_obj, 67)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(671, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 0 then
        lucy00()
    elseif fallout.local_var(4) == 1 then
        lucy04()
    elseif fallout.local_var(4) > 1 then
        lucy05()
    end
    local temp = fallout.local_var(4)
    if temp < 2 then
        fallout.set_local_var(4, temp + 1)
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(671, 300))
end

function dialog_end()
end

function lucy00()
    fallout.gsay_reply(671, 302)
    fallout.giq_option(-3, 671, 303, lucy01, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 304, lucy02, 49 + fallout.random(0, 2))
    fallout.giq_option(6, 671, 305, lucy03, 49 + fallout.random(0, 2))
end

function lucy01()
    fallout.gsay_message(671, 306, 49 + fallout.random(0, 2))
    dialog_end()
end

function lucy02()
    fallout.gsay_message(671, 307, 49 + fallout.random(0, 2))
    dialog_end()
end

function lucy03()
    fallout.gsay_message(671, 308, 49 + fallout.random(0, 2))
    dialog_end()
end

function lucy04()
    fallout.gsay_message(671, 309, 49 + fallout.random(0, 2))
    dialog_end()
end

function lucy05()
    fallout.gsay_message(671, 310, 49 + fallout.random(0, 2))
    dialog_end()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
