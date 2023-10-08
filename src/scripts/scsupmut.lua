local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local ScSupMut0
local ScSupMut1
local ScSupMut2
local ScSupMut3
local combat

local herebefore = 0
local hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 47)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 11 then
                            talk_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(277, 100))
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    fallout.script_overrides()
    if herebefore then
        ScSupMut3()
    else
        herebefore = 1
        fallout.start_gdialog(277, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        ScSupMut0()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function ScSupMut0()
    fallout.gsay_reply(277, 101)
    fallout.giq_option(-3, 277, 102, combat, 50)
    fallout.giq_option(4, 277, 103, combat, 50)
    fallout.giq_option(4, 277, 104, ScSupMut1, 50)
    fallout.giq_option(4, 277, 105, combat, 50)
end

function ScSupMut1()
    fallout.gsay_reply(277, 106)
    fallout.giq_option(4, 277, 107, combat, 50)
    fallout.giq_option(4, 277, 108, ScSupMut2, 50)
    fallout.giq_option(4, 277, 109, combat, 50)
end

function ScSupMut2()
    fallout.gsay_message(277, 110, 50)
end

function ScSupMut3()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(277, 111), 0)
end

function combat()
    hostile = 1
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
