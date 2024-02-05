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
local damage_p_proc
local look_at_p_proc
local Gunther00
local Gunther01
local Gunther02
local Gunther03
local Gunther04
local Gunther05
local Gunther06
local Gunther07
local Gunther08
local Gunther09
local Gunther10
local Gunther11
local GuntherEnd

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 41)
        misc.set_ai(self_obj, 51)
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
    fallout.set_local_var(4, 1)
    fallout.start_gdialog(841, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Gunther00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(841, 100))
end

function Gunther00()
    fallout.gsay_reply(841, 102)
    Gunther01()
end

function Gunther01()
    fallout.giq_option(4, 841, 103, Gunther03, 50)
    fallout.giq_option(4, 841, 104, Gunther06, 50)
    fallout.giq_option(4, 841, 105, Gunther09, 50)
    fallout.giq_option(4, 841, 106, Gunther10, 50)
    fallout.giq_option(4, 841, 112, GuntherEnd, 50)
    fallout.giq_option(-3, 841, 122, Gunther11, 50)
end

function Gunther02()
    fallout.gsay_reply(841, 107)
    Gunther01()
end

function Gunther03()
    fallout.gsay_reply(841, 108)
    fallout.giq_option(4, 841, 109, Gunther04, 50)
    fallout.giq_option(4, 841, 110, Gunther05, 50)
    fallout.giq_option(4, 841, 111, Gunther02, 50)
    fallout.giq_option(4, 841, 112, GuntherEnd, 50)
end

function Gunther04()
    fallout.gsay_reply(841, 113)
    fallout.giq_option(4, 841, 110, Gunther05, 50)
    fallout.giq_option(4, 841, 111, Gunther02, 50)
    fallout.giq_option(4, 841, 112, GuntherEnd, 50)
end

function Gunther05()
    fallout.gsay_reply(841, 114)
    fallout.giq_option(4, 841, 109, Gunther04, 50)
    fallout.giq_option(4, 841, 111, Gunther02, 50)
    fallout.giq_option(4, 841, 112, GuntherEnd, 50)
end

function Gunther06()
    fallout.gsay_reply(841, 115)
    fallout.giq_option(4, 841, 116, Gunther07, 50)
    fallout.giq_option(4, 841, 117, Gunther08, 50)
    fallout.giq_option(4, 841, 111, Gunther02, 50)
    fallout.giq_option(4, 841, 112, GuntherEnd, 50)
end

function Gunther07()
    fallout.gsay_reply(841, 118)
    fallout.giq_option(4, 841, 111, Gunther02, 50)
    fallout.giq_option(4, 841, 112, GuntherEnd, 50)
end

function Gunther08()
    fallout.gsay_reply(841, 119)
    fallout.giq_option(4, 841, 116, Gunther04, 50)
    fallout.giq_option(4, 841, 111, Gunther02, 50)
    fallout.giq_option(4, 841, 112, GuntherEnd, 50)
end

function Gunther09()
    fallout.gsay_reply(841, 120)
    fallout.giq_option(4, 841, 111, Gunther02, 50)
    fallout.giq_option(4, 841, 112, GuntherEnd, 50)
end

function Gunther10()
    fallout.gsay_reply(841, 121)
    fallout.giq_option(4, 841, 111, Gunther02, 50)
    fallout.giq_option(4, 841, 112, GuntherEnd, 50)
end

function Gunther11()
    fallout.gsay_message(841, 123, 50)
end

function GuntherEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
