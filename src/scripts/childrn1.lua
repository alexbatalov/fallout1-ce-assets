local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_exit_p_proc
local map_update_p_proc

fallout.create_external_var("Master_Ptr")
fallout.create_external_var("Red_Door_Ptr")
fallout.create_external_var("Black_Door_Ptr")
fallout.create_external_var("Laura_Ptr")
fallout.create_external_var("Shop_Ptr")
fallout.create_external_var("Shopkepper_Ptr")

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
    light.lighting()
    fallout.set_global_var(77, 2)
    if misc.map_first_run() then
        fallout.display_msg(fallout.message_str(194, 110))
    end

    if fallout.global_var(32) == 0 then
        fallout.override_map_start(100, 102, 0, 5)
    elseif fallout.global_var(32) == 2 then
        fallout.override_map_start(100, 86, 0, 2)
    elseif fallout.global_var(32) == 1 then
        fallout.override_map_start(99, 113, 1, 5)
    elseif fallout.global_var(32) == 3 then
        fallout.override_map_start(96, 63, 1, 1)
    elseif fallout.global_var(32) == 4 then
        fallout.override_map_start(85, 63, 1, 4)
    else
        fallout.override_map_start(100, 102, 0, 5)
    end
    party_elevation = party.add_party()
end

function map_exit_p_proc()
    party.remove_party()
end

function map_update_p_proc()
    light.lighting()
    if fallout.elevation(fallout.dude_obj()) == 1 then
        fallout.set_global_var(600, 1)
    end
    if fallout.global_var(55) ~= 0 then
        local cur_count = 240 - (time.game_time_in_seconds() - fallout.global_var(55))
        if cur_count ~= prev_count then
            fallout.display_msg(fallout.message_str(447, 100) .. cur_count .. fallout.message_str(447, 101))
            prev_count = cur_count
        end
        if time.game_time_in_seconds() - fallout.global_var(55) > 240 then
            fallout.display_msg(fallout.message_str(444, 106))
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
