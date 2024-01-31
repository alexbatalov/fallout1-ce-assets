local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

fallout.create_external_var("Use_Manhole_Top")
fallout.create_external_var("Use_Manhole_Bottom")
fallout.create_external_var("Use_Manhole_Middle")
fallout.create_external_var("Manhole_Pointer_Top")
fallout.create_external_var("Manhole_Pointer_Middle")
fallout.create_external_var("Manhole_Pointer_Bottom")

fallout.set_external_var("Use_Manhole_Top", 0)
fallout.set_external_var("Use_Manhole_Bottom", 0)
fallout.set_external_var("Use_Manhole_Middle", 0)
fallout.set_external_var("Manhole_Pointer_Top", nil)
fallout.set_external_var("Manhole_Pointer_Middle", nil)
fallout.set_external_var("Manhole_Pointer_Bottom", nil)

local start
local map_enter_p_proc
local map_exit_p_proc
local map_update_p_proc

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
    elseif script_action == 16 then
        map_exit_p_proc()
    end
end

function map_enter_p_proc()
    light.lighting()
    if fallout.global_var(32) == 3 then
        fallout.override_map_start(94, 136, 1, 5)
    elseif fallout.global_var(32) == 12 then
        fallout.override_map_start(143, 64, 0, 2)
    else
        fallout.override_map_start(94, 136, 1, 5)
    end
    if misc.map_first_run() then
        fallout.display_msg(fallout.message_str(194, 106))
    end
    fallout.set_global_var(573, 1)
    if time.game_time_in_days() >= fallout.global_var(149) then
        fallout.set_global_var(13, 1)
    end
    if fallout.global_var(29) == 2 then
        if time.game_time_in_days() - fallout.global_var(225) > 29 then
            fallout.set_global_var(13, 1)
        end
    end
    if fallout.global_var(13) == 1 and fallout.global_var(18) == 0 and not misc.is_loading_game() then
        fallout.kill_critter_type(16777230, 1)
        fallout.kill_critter_type(16777521, 1)
        fallout.kill_critter_type(16777322, 1)
        fallout.kill_critter_type(16777232, 1)
        if fallout.map_var(10) == 0 then
            local fugee_obj
            fallout.set_map_var(10, 1)
            fugee_obj = fallout.create_object_sid(16777404, 0, 0, 912)
            fallout.critter_add_trait(fugee_obj, 1, 5, 48)
            fallout.critter_attempt_placement(fugee_obj, 25717, 1)
            fugee_obj = fallout.create_object_sid(16777404, 0, 0, 912)
            fallout.critter_add_trait(fugee_obj, 1, 5, 48)
            fallout.critter_attempt_placement(fugee_obj, 24516, 1)
            fugee_obj = fallout.create_object_sid(16777404, 0, 0, 912)
            fallout.critter_add_trait(fugee_obj, 1, 5, 48)
            fallout.critter_attempt_placement(fugee_obj, 24927, 1)
        end
    end
    if fallout.global_var(30) == 1 and not misc.is_loading_game() then
        if time.game_time_in_days() - fallout.global_var(552) > 7 then
            if fallout.global_var(31) ~= 2 then
                fallout.kill_critter_type(16777230, 2)
                fallout.kill_critter_type(16777521, 2)
                fallout.kill_critter_type(16777322, 2)
                fallout.kill_critter_type(16777232, 2)
            end
        end
    end
    party_elevation = party.add_party()
end

function map_exit_p_proc()
    party.remove_party()
end

function map_update_p_proc()
    if fallout.elevation(fallout.dude_obj()) == 0 then
        light.darkness()
    else
        light.lighting()
    end
    if fallout.external_var("Use_Manhole_Top") ~= 0 then
        fallout.animate_stand_reverse_obj(fallout.external_var("Manhole_Pointer_Top"))
    end
    if fallout.external_var("Use_Manhole_Middle") ~= 0 then
        fallout.animate_stand_reverse_obj(fallout.external_var("Manhole_Pointer_Middle"))
    end
    if fallout.external_var("Use_Manhole_Bottom") ~= 0 then
        fallout.animate_stand_reverse_obj(fallout.external_var("Manhole_Pointer_Bottom"))
    end
    party_elevation = party.update_party(party_elevation)
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
