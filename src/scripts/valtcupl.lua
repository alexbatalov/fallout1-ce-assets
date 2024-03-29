local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local ValtCupl00
local ValtCupl00a
local ValtCupl01
local ValtCupl02
local ValtCupl03
local ValtCupl04
local ValtCupl05
local ValtCupl06
local ValtCupl07
local ValtCuplEnd

local initialized = false
local hostile = false

function start()
    if not initialized then
        misc.set_team(fallout.self_obj(), 1)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
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
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(209, 100))
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(209, fallout.self_obj(), -1, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) ~= 0 then
        if fallout.local_var(1) < 2 then
            ValtCupl07()
        else
            ValtCupl06()
        end
    else
        ValtCupl00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function ValtCupl00()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(209, 101)
    fallout.giq_option(4, 209, 102, ValtCupl02, 50)
    fallout.giq_option(4, 209, 103, ValtCupl03, 50)
    fallout.giq_option(5, 209, 104, ValtCupl00a, 50)
    fallout.giq_option(-3, 209, 105, ValtCupl01, 50)
end

function ValtCupl00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        ValtCupl04()
    else
        ValtCupl01()
    end
end

function ValtCupl01()
    reaction.BigDownReact()
    fallout.gsay_message(209, 106, 51)
end

function ValtCupl02()
    fallout.gsay_reply(209, 107)
    fallout.giq_option(4, 209, 108, ValtCupl01, 50)
    fallout.giq_option(4, 209, 109, ValtCupl03, 50)
end

function ValtCupl03()
    reaction.BigUpReact()
    fallout.gsay_message(209, 110, 49)
end

function ValtCupl04()
    fallout.gsay_reply(209, 111)
    fallout.giq_option(5, 209, 112, ValtCupl03, 50)
    fallout.giq_option(5, 209, 113, ValtCupl05, 50)
end

function ValtCupl05()
    fallout.gsay_message(209, 114, 50)
end

function ValtCupl06()
    fallout.gsay_message(209, 115, 50)
end

function ValtCupl07()
    fallout.gsay_message(209, 116, 50)
end

function ValtCuplEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
