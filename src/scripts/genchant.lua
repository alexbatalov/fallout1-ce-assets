local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local Chant01
local Chant02
local Chant03
local Chant04
local Chant05
local Chant06
local ChantEnd

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 20)
        fallout.critter_add_trait(self_obj, 1, 5, 69)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
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
        fallout.float_msg(fallout.self_obj(), fallout.message_str(396, 101), 0)
    else
        fallout.start_gdialog(396, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Chant01()
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
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(396, 100))
end

function Chant01()
    fallout.gsay_reply(396, 102)
    fallout.giq_option(7, 396, 103, Chant02, 50)
    fallout.giq_option(4, 396, 104, Chant03, 50)
    fallout.giq_option(4, 396, 105, Chant04, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 396, 106, Chant05, 50)
    end
    fallout.giq_option(-3, 396, 107, Chant06, 50)
end

function Chant02()
    fallout.gsay_reply(396, 108)
    fallout.gsay_option(396, 113, ChantEnd, 50)
end

function Chant03()
    fallout.gsay_reply(396, 109)
    fallout.gsay_option(396, 113, ChantEnd, 50)
end

function Chant04()
    fallout.gsay_reply(396, 110)
    fallout.gsay_option(396, 113, ChantEnd, 50)
end

function Chant05()
    fallout.gsay_reply(396, 111)
    fallout.gsay_option(396, 113, ChantEnd, 50)
end

function Chant06()
    fallout.gsay_reply(396, 112)
    fallout.gsay_option(396, 113, ChantEnd, 50)
end

function ChantEnd()
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
