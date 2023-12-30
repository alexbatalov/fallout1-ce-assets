local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local Prisoner01
local Prisoner02
local Prisoner03
local PrisonerEnd

local hostile = false

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
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
    fallout.display_msg(fallout.message_str(289, 100))
end

function talk_p_proc()
    fallout.start_gdialog(289, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Prisoner01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Prisoner01()
    fallout.gsay_reply(289, 101)
    fallout.giq_option(3, 289, 102, Prisoner02, 50)
    fallout.giq_option(3, 289, 103, Prisoner02, 50)
    fallout.giq_option(3, 289, 104, Prisoner03, 50)
end

function Prisoner02()
    hostile = true
end

function Prisoner03()
    fallout.gsay_reply(289, 105)
    fallout.giq_option(3, 289, 106, PrisonerEnd, 50)
end

function PrisonerEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
