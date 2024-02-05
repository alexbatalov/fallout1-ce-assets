local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc

local initialized = false
local hostile = 0
local scared = 0

function start()
    if not initialized then
        misc.set_team(fallout.self_obj(), 6)
        misc.set_ai(fallout.self_obj(), 20)
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
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

function critter_p_proc()
    if hostile then
        hostile = 0
        scared = 1
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(290, fallout.global_var(290) + 1)
        reputation.inc_evil_critter()
    end
    fallout.set_global_var(289, fallout.global_var(289) - 1)
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if scared then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(750, fallout.random(102, 103)), 0)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(750, fallout.random(100, 101)), 0)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
