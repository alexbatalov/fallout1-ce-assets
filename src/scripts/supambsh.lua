local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc

local initialized = false
local crit_init = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 43)
        fallout.critter_add_trait(self_obj, 1, 5, 49)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    if not crit_init then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        crit_init = true
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        reputation.inc_evil_critter()
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
