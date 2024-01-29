local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_exit_p_proc
local map_update_p_proc

fallout.create_external_var("Team9_Count")
fallout.set_external_var("Team9_Count", 4)
fallout.create_external_var("radio_trick")
fallout.create_external_var("ignoring_dude")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("know_door_code")
fallout.create_external_var("comptroller_status")

fallout.set_external_var("radio_trick", 0)
fallout.set_external_var("ignoring_dude", 0)
fallout.set_external_var("removal_ptr", nil)
fallout.set_external_var("know_door_code", 0)
fallout.set_external_var("comptroller_status", 0)

local party_elevation = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

fallout.set_external_var("Ian_ptr", nil)
fallout.set_external_var("Dog_ptr", nil)
fallout.set_external_var("Tycho_ptr", nil)
fallout.set_external_var("Katja_ptr", nil)
fallout.set_external_var("Tandi_ptr", nil)

local radio_kludge

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
    fallout.set_global_var(78, 2)
    if misc.map_first_run() then
        fallout.display_msg(fallout.message_str(194, 109))
    end
    fallout.set_external_var("radio_trick", fallout.map_var(0))
    fallout.set_external_var("know_door_code", fallout.map_var(1))
    light.lighting()
    if fallout.global_var(32) == 0 then
        fallout.override_map_start(133, 111, 0, 5)
    elseif fallout.global_var(32) == 1 then
        fallout.override_map_start(73, 107, 0, 2)
    else
        fallout.override_map_start(133, 111, 0, 5)
    end
    party_elevation = party.add_party()
end

function map_exit_p_proc()
    fallout.set_map_var(0, fallout.external_var("radio_trick"))
    party.remove_party()
end

function map_update_p_proc()
    light.lighting()
    if fallout.global_var(147) ~= 0 then
        fallout.display_msg(fallout.message_str(443, 103) ..
            (300 - (time.game_time_in_seconds() - fallout.global_var(147))) .. fallout.message_str(443, 104))
        if time.game_time_in_seconds() - fallout.global_var(147) >= 300 then
            fallout.play_gmovie(3)
            misc.signal_end_game()
        end
    end
    local removal_obj = fallout.external_var("removal_ptr")
    if removal_obj ~= nil then
        fallout.destroy_object(removal_obj)
        fallout.set_external_var("removal_ptr", 0)
    end
end

function radio_kludge()
    local qty = fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 100)
    if qty > 0 then
        local item_obj
        item_obj = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 100)
        item_obj = fallout.destroy_mult_objs(item_obj, qty)
        item_obj = fallout.create_object_sid(100, 0, 0, 361)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), item_obj, qty)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
