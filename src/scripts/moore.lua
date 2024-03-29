local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local dialog_end
local moore00
local moore01
local moore02
local moore03
local moore04

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

function combat()
    hostile = true
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
        moore00()
    else
        moore01()
    end
    fallout.set_local_var(4, 1)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(671, 200))
end

function dialog_end()
end

function moore00()
    fallout.gsay_reply(671, 202)
    fallout.giq_option(8, 671, 203, moore03, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 204, moore02, 49 + fallout.random(0, 2))
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 671, 205, moore04, 49 + fallout.random(0, 2))
    end
    fallout.giq_option(4, 671, 206, dialog_end, 49 + fallout.random(0, 2))
    fallout.giq_option(-3, 671, 207, moore04, 49 + fallout.random(0, 2))
end

function moore01()
    fallout.gsay_reply(671, 208)
    fallout.giq_option(8, 671, 209, moore03, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 210, moore04, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 211, moore02, 49 + fallout.random(0, 2))
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 671, 212, moore02, 49 + fallout.random(0, 2))
    end
    fallout.giq_option(4, 671, 213, dialog_end, 49 + fallout.random(0, 2))
end

function moore02()
    fallout.gsay_reply(671, 214)
    fallout.giq_option(4, 671, 216, moore03, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 217, moore04, 49 + fallout.random(0, 2))
end

function moore03()
    fallout.gsay_message(671, 218, 49 + fallout.random(0, 2))
    dialog_end()
end

function moore04()
    fallout.gsay_message(671, 219, 49 + fallout.random(0, 2))
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
