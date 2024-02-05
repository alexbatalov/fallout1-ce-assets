local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local destroy_p_proc
local talk_p_proc
local critter_p_proc
local Dealer00
local Dealer01
local Dealer02
local Dealer03
local Dealer04
local Dealer05
local Dealer06
local Dealer07
local Dealer08
local DealerEnd

local initialized = false
local said_hi = false

function start()
    if not initialized then
        if misc.map_first_run() then
            local caps_obj = fallout.create_object_sid(41, 0, 0, -1)
            fallout.add_mult_objs_to_inven(fallout.self_obj(), caps_obj, fallout.random(0, 100))
            misc.set_team(fallout.self_obj(), 24)
            fallout.set_global_var(289, 0)
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 18 then
        destroy_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function talk_p_proc()
    if fallout.global_var(289) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(657, fallout.random(127, 130)), 0)
    else
        fallout.start_gdialog(657, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Dealer00()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    if not said_hi and fallout.tile_distance_objs(self_obj, fallout.dude_obj()) <= 6 then
        fallout.float_msg(self_obj, fallout.message_str(657, 131), 0)
        said_hi = true
    end
end

function Dealer00()
    fallout.set_global_var(289, 1)
    fallout.gsay_reply(657, 100)
    fallout.giq_option(4, 657, 101, Dealer02, 50)
    fallout.giq_option(4, 657, 102, DealerEnd, 50)
    fallout.giq_option(-3, 657, 103, Dealer01, 50)
end

function Dealer01()
    fallout.gsay_message(657, 104, 50)
end

function Dealer02()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(657, 105)
    else
        fallout.gsay_reply(657, 106)
    end
    fallout.giq_option(4, 657, 107, Dealer03, 50)
    fallout.giq_option(4, 657, 108, DealerEnd, 50)
end

function Dealer03()
    fallout.gsay_reply(657, 109)
    fallout.giq_option(4, 657, 110, Dealer04, 50)
    fallout.giq_option(4, 657, 111, Dealer08, 51)
    fallout.giq_option(4, 657, 112, DealerEnd, 50)
end

function Dealer04()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(657, 113)
    else
        fallout.gsay_reply(657, 114)
    end
    fallout.giq_option(4, 657, 115, Dealer05, 50)
    fallout.giq_option(4, 657, 116, Dealer08, 51)
    fallout.giq_option(4, 657, 112, DealerEnd, 50)
end

function Dealer05()
    fallout.gsay_reply(657, 117)
    fallout.giq_option(4, 657, 118, Dealer06, 50)
    fallout.giq_option(4, 657, 119, Dealer08, 51)
    fallout.giq_option(4, 657, 120, DealerEnd, 50)
end

function Dealer06()
    fallout.gsay_reply(657, 121)
    fallout.giq_option(4, 657, 122, Dealer07, 49)
    fallout.giq_option(4, 657, 123, Dealer08, 51)
    fallout.giq_option(4, 657, 124, DealerEnd, 50)
end

function Dealer07()
    fallout.gsay_message(657, 125, 49)
end

function Dealer08()
    fallout.gsay_message(657, 126, 51)
end

function DealerEnd()
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
return exports
