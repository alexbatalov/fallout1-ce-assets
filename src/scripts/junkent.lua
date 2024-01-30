local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc

fallout.create_external_var("weapon_checked")
fallout.create_external_var("sneak_checked")
fallout.create_external_var("times_caught_sneaking")
fallout.create_external_var("fetch_dude")
fallout.create_external_var("ladder_down")
fallout.create_external_var("ladder_up")
fallout.create_external_var("Gretch_call")
fallout.create_external_var("helped_Killian")
fallout.create_external_var("messing_with_Morbid_stuff")
fallout.create_external_var("jail_door_ptr")
fallout.create_external_var("Morbid_ptr")
fallout.create_external_var("removal_ptr")

fallout.set_external_var("weapon_checked", 0)
fallout.set_external_var("sneak_checked", 0)
fallout.set_external_var("times_caught_sneaking", 0)
fallout.set_external_var("fetch_dude", 0)
fallout.set_external_var("ladder_down", 0)
fallout.set_external_var("ladder_up", 0)
fallout.set_external_var("Gretch_call", 0)
fallout.set_external_var("helped_Killian", 0)
fallout.set_external_var("messing_with_Morbid_stuff", 0)
fallout.set_external_var("jail_door_ptr", nil)
fallout.set_external_var("Morbid_ptr", nil)
fallout.set_external_var("removal_ptr", nil)

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

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    end
end

function map_enter_p_proc()
    if misc.map_first_run() then
        fallout.display_msg(fallout.message_str(194, 104))
    end
    light.lighting()
    fallout.set_global_var(569, 1)
    if not misc.is_loading_game() then
        if fallout.global_var(32) == 3 then
            fallout.override_map_start(107, 138, 0, 2)
        elseif fallout.global_var(32) == 6 then
            fallout.override_map_start(61, 91, 0, 5)
            if fallout.item_caps_total(fallout.dude_obj()) >= 100 then
                fallout.item_caps_adjust(fallout.dude_obj(), -100)
            else
                fallout.set_global_var(155, fallout.global_var(155) - 2)
            end
            fallout.set_map_var(1, 1)
            fallout.set_map_var(5, time.game_time_in_days())
        elseif fallout.global_var(32) == 5 then
            fallout.override_map_start(103, 115, 0, 5)
            if fallout.map_var(0) == 0 then
                fallout.set_map_var(0, 1)
            end
        else
            fallout.override_map_start(107, 138, 0, 5)
        end
    end
end

function map_update_p_proc()
    party_elevation = party.update_party(party_elevation)
    if fallout.elevation(fallout.dude_obj()) == 1 then
        fallout.set_light_level(40)
    else
        light.lighting()
    end
    local removal_obj = fallout.external_var("removal_ptr")
    if removal_obj ~= nil then
        fallout.destroy_object(removal_obj)
        fallout.set_external_var("removal_ptr", 0)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
