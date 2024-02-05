local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

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
fallout.create_external_var("patient")
fallout.create_external_var("lets_go")
fallout.create_external_var("contpan")
fallout.create_external_var("J_Door_Ptr")
fallout.create_external_var("Psy_Field_Ptr")

fallout.set_external_var("Ian_ptr", nil)
fallout.set_external_var("Dog_ptr", nil)
fallout.set_external_var("Tycho_ptr", nil)
fallout.set_external_var("Katja_ptr", nil)
fallout.set_external_var("Tandi_ptr", nil)
fallout.set_external_var("patient", nil)
fallout.set_external_var("lets_go", 0)
fallout.set_external_var("contpan", nil)
fallout.set_external_var("J_Door_Ptr", nil)
fallout.set_external_var("Psy_Field_Ptr", nil)

local cur_count = 0
local prev_count = 0

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
    light.darkness()
    if fallout.elevation(fallout.dude_obj()) == 0 then
        if time.is_day() and not misc.is_loading_game() then
            if fallout.map_var(10) == 0 then
                local monstr_obj
                fallout.set_map_var(10, 1)
                monstr_obj = fallout.create_object_sid(16777259, 0, 0, 686)
                fallout.critter_attempt_placement(monstr_obj, 24678, 0)
                misc.set_team(monstr_obj, 34)
                monstr_obj = fallout.create_object_sid(16777261, 0, 0, 686)
                fallout.critter_attempt_placement(monstr_obj, 25680, 0)
                misc.set_team(monstr_obj, 34)
                monstr_obj = fallout.create_object_sid(16777261, 0, 0, 686)
                fallout.critter_attempt_placement(monstr_obj, 25276, 0)
                misc.set_team(monstr_obj, 34)
            end
        end
    end
    if fallout.global_var(32) == 0 then
        fallout.override_map_start(136, 107, 0, 3)
    elseif fallout.global_var(32) == 4 then
        fallout.override_map_start(98, 60, 0, 3)
    elseif fallout.global_var(32) == 1 then
        fallout.override_map_start(94, 98, 1, 3)
    else
        fallout.override_map_start(136, 107, 0, 3)
    end
    party_elevation = party.add_party()
end

function map_exit_p_proc()
    fallout.kill_critter_type(16777259, 0)
    fallout.kill_critter_type(16777261, 0)
    party.remove_party()
end

function map_update_p_proc()
    light.darkness()
    if fallout.global_var(55) ~= 0 then
        cur_count = 240 - (time.game_time_in_seconds() - fallout.global_var(55))
        if cur_count ~= prev_count then
            fallout.display_msg(fallout.message_str(447, 100) .. cur_count .. fallout.message_str(447, 101))
            prev_count = cur_count
        end
        if time.game_time_in_seconds() - fallout.global_var(55) > 240 then
            fallout.display_msg(fallout.message_str(446, 106))
            fallout.play_gmovie(4)
            misc.signal_end_game()
        end
    end
    party_elevation = party.update_party(party_elevation)
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
