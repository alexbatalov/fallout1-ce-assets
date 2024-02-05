local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local initialize_p_proc

local initialized = false
local Hostile = 1

function start()
    if not initialized then
        initialize_p_proc()
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            end
        end
    end
end

function critter_p_proc()
    if Hostile and (fallout.elevation(fallout.self_obj()) == fallout.elevation(fallout.dude_obj())) then
        Hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function initialize_p_proc()
    initialized = true
    misc.set_team(fallout.self_obj(), 86)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.initialize_p_proc = initialize_p_proc
return exports
