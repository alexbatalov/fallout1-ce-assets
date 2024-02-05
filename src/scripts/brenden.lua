local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local talk_p_proc
local Brenden01
local Brenden02
local Brenden03
local Brenden04
local Brenden05
local Brenden06
local Brenden07
local Brenden08
local Brenden09
local Brenden10
local Brenden11
local Brenden12
local BrendenEnd

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 44)
        misc.set_ai(self_obj, 62)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function talk_p_proc()
    fallout.start_gdialog(666, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Brenden01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Brenden01()
    if fallout.local_var(0) ~= 0 then
        fallout.gsay_reply(666, 112)
    else
        fallout.set_local_var(0, 1)
        fallout.gsay_reply(666, 102)
    end
    fallout.giq_option(-3, 666, 107, Brenden05, 50)
    fallout.giq_option(4, 666, 103, Brenden02, 50)
    fallout.giq_option(4, 666, 104, Brenden03, 50)
    fallout.giq_option(4, 666, 105, Brenden04, 50)
    if fallout.local_var(1) == 0 then
        fallout.giq_option(4, 666, 106, Brenden06, 50)
    end
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden02()
    fallout.gsay_reply(666, 109)
    fallout.giq_option(0, 634, 106, Brenden01, 50)
end

function Brenden03()
    fallout.gsay_reply(666, 110)
    fallout.giq_option(0, 634, 106, Brenden01, 50)
end

function Brenden04()
    fallout.gsay_reply(666, 111)
    fallout.giq_option(0, 634, 106, Brenden01, 50)
end

function Brenden05()
    fallout.gsay_message(666, 108, 50)
end

function Brenden06()
    fallout.set_local_var(1, 1)
    fallout.gsay_reply(666, 114)
    fallout.giq_option(4, 666, 115, Brenden07, 49)
    fallout.giq_option(4, 666, 116, Brenden12, 51)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden07()
    fallout.gsay_reply(666, 117)
    fallout.giq_option(6, 666, 118, Brenden08, 50)
    fallout.giq_option(4, 666, 119, Brenden11, 50)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden08()
    fallout.gsay_reply(666, 120)
    fallout.giq_option(6, 666, 121, Brenden09, 49)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden09()
    fallout.gsay_reply(666, 122)
    fallout.giq_option(6, 666, 123, Brenden10, 50)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden10()
    fallout.gsay_reply(666, 124)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden11()
    fallout.gsay_reply(666, 125)
    fallout.giq_option(4, 666, 126, Brenden09, 49)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden12()
    fallout.gsay_message(666, 127, 51)
end

function BrendenEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.talk_p_proc = talk_p_proc
return exports
