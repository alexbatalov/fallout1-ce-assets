local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local destroy_p_proc
local critter_p_proc

local initialized = false
local hostile = false

function start()
    if not initialized and fallout.metarule(14, 0) ~= 0 then
        local self_obj = fallout.self_obj()
        local pid = fallout.obj_pid(self_obj)
        if pid == 16777261 then
            fallout.critter_add_trait(self_obj, 1, 5, 73)
            fallout.critter_add_trait(self_obj, 1, 6, 43)
        elseif pid == 16777259 then
            fallout.critter_add_trait(self_obj, 1, 5, 72)
            fallout.critter_add_trait(self_obj, 1, 6, 43)
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 18 then
        destroy_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        reputation.inc_evil_critter()
    end
end

function critter_p_proc()
    if not hostile then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        hostile = true
    end
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
return exports
