local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local map_enter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_update_p_proc
local whoami

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 47)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function combat()
    hostile = true
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    local self_obj = fallout.self_obj()
    if fallout.tile_num(self_obj) == 12098 then
        fallout.set_external_var("lets_go", 0)
        fallout.move_to(self_obj, 7000, 0)
    end
    if fallout.external_var("lets_go") == 1 then
        fallout.animate_move_obj_to_tile(self_obj, 12098, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
end

function map_enter_p_proc()
    whoami()
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
end

function map_update_p_proc()
    whoami()
end

function whoami()
    fallout.set_external_var("patient", fallout.self_obj())
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
