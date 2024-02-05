local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local pickup_p_proc

local hostile = 0
local initialized = false
local scared = 0

function start()
    if not initialized then
        misc.set_team(fallout.self_obj(), 6)
        misc.set_ai(fallout.self_obj(), 20 + fallout.random(0, 1))
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
    else
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12 then
            if scared then
                behaviour.flee_dude(1)
            else
                hostile = 1
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function pickup_p_proc()
    if not(scared) then
        hostile = 1
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
