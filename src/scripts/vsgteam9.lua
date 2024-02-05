local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local pickup_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 48)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if hostile then
            hostile = false
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.global_var(146) == 1 then
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            else
                if not misc.is_wearing_coc_robe(fallout.dude_obj()) then
                    hostile = true
                end
            end
        end
    end
end

function destroy_p_proc()
    fallout.set_external_var("Team9_Count", fallout.external_var("Team9_Count") - 1)
    reputation.inc_evil_critter()
end

function pickup_p_proc()
    hostile = true
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
