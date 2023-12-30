local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local pickup_p_proc

local stealing = false
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 45)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 2 then
        local dude_obj = fallout.dude_obj()
        if fallout.obj_pid(fallout.critter_inven_obj(dude_obj, 2)) == 4 then
            fallout.poison(dude_obj, fallout.random(1, 6))
        end
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    if fallout.obj_can_see_obj(fallout.self_obj(), dude_obj) or stealing then
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function pickup_p_proc()
    stealing = true
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
