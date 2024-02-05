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
local Mike01
local Mike02
local Mike03
local Mike04
local Mike05
local Mike06

local hostile = false
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 40)
        misc.set_ai(self_obj, 4)
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
    fallout.start_gdialog(821, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Mike01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(821, 100))
end

function Mike01()
    fallout.gsay_reply(821, 101)
    fallout.giq_option(-3, 821, 102, Mike02, 50)
    fallout.giq_option(4, 821, 103, Mike03, 50)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 821, 104, Mike04, 50)
    end
    fallout.giq_option(4, 821, 105, Mike05, 50)
end

function Mike02()
    fallout.gsay_message(821, 106, 50)
end

function Mike03()
    fallout.gsay_reply(821, 107)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 821, 108, Mike04, 50)
    end
    fallout.giq_option(4, 821, 109, Mike05, 50)
end

function Mike04()
    fallout.gsay_reply(821, 110)
    fallout.giq_option(4, 821, 111, Mike06, 50)
    fallout.giq_option(4, 821, 112, Mike03, 50)
    fallout.giq_option(4, 821, 113, Mike05, 50)
end

function Mike05()
end

function Mike06()
    combat()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
