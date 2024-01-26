local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc

local party_elevation = 0
local dude_carrying_bomb = false

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")
fallout.create_external_var("removal_ptr")

fallout.set_external_var("Ian_ptr", nil)
fallout.set_external_var("Dog_ptr", nil)
fallout.set_external_var("Tycho_ptr", nil)
fallout.set_external_var("Katja_ptr", nil)
fallout.set_external_var("Tandi_ptr", nil)
fallout.set_external_var("removal_ptr", nil)

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 16 then
        map_exit_p_proc()
    end
end

function map_enter_p_proc()
    if misc.map_first_run() then
        fallout.display_msg(fallout.message_str(194, 114))
    end
    if fallout.global_var(129) == 2 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) then
            fallout.display_msg(fallout.message_str(194, 118))
        else
            fallout.display_msg(fallout.message_str(194, 117))
        end
    end
    fallout.set_global_var(595, 1)
    light.lighting()
    if time.game_time_in_days() >= fallout.global_var(148) then
        fallout.set_global_var(7, 1)
    end
    fallout.override_map_start(82, 114, 0, 5)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 72) ~= 0 then
        dude_carrying_bomb = true
    end
end

function map_update_p_proc()
    light.lighting()
    party_elevation = party.update_party(party_elevation)
    local removal_obj = fallout.external_var("removal_ptr")
    if removal_obj ~= nil then
        fallout.destroy_object(removal_obj)
        fallout.set_external_var("removal_ptr", 0)
    end
end

function map_exit_p_proc()
    if dude_carrying_bomb then
        if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 72) == 0 then
            fallout.set_global_var(129, 2)
        end
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
