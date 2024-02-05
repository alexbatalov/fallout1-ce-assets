local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local combat_p_proc
local destroy_p_proc

local initialized = false

function start()
    if not initialized then
        misc.set_team(fallout.self_obj(), 9)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    if fallout.obj_can_see_obj(fallout.self_obj(), dude_obj) then
        if fallout.has_trait(0, dude_obj, 44) == 0 then
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 2 then
        local rads = fallout.random(1, 6) - 5
        if rads < 0 then
            rads = 0
        end
        if rads > 0 then
            fallout.radiation_inc(fallout.target_obj(), rads)
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.combat_p_proc = combat_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
