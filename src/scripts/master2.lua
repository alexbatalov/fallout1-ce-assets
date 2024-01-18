local fallout = require("fallout")
local light = require("lib.light")
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
fallout.create_external_var("Skill_Used")
fallout.create_external_var("Key_Used")
fallout.create_external_var("Master_Has_Armed")
fallout.create_external_var("Bomb_Armed")
fallout.create_external_var("Master_ptr")
fallout.create_external_var("signal_mutants")
fallout.create_external_var("Master_Has_Activated")

fallout.set_external_var("Ian_ptr", nil)
fallout.set_external_var("Dog_ptr", nil)
fallout.set_external_var("Tycho_ptr", nil)
fallout.set_external_var("Katja_ptr", nil)
fallout.set_external_var("Tandi_ptr", nil)
fallout.set_external_var("Skill_Used", 0)
fallout.set_external_var("Key_Used", 0)
fallout.set_external_var("Master_Has_Armed", 0)
fallout.set_external_var("Bomb_Armed", 0)
fallout.set_external_var("Master_ptr", nil)
fallout.set_external_var("signal_mutants", 0)
fallout.set_external_var("Master_Has_Activated", 0)

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
    if fallout.elevation(fallout.dude_obj()) == 0 then
        if time.is_day() and (fallout.metarule(22, 0) == 0) then
            if fallout.map_var(10) == 0 then
                local critter_obj
                local item_obj

                fallout.set_map_var(10, 1)

                critter_obj = fallout.create_object_sid(16777408, 0, 0, 524)
                fallout.critter_attempt_placement(critter_obj, 20532, 0)
                fallout.critter_add_trait(critter_obj, 1, 6, 34)
                item_obj = fallout.create_object_sid(15, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)
                item_obj = fallout.create_object_sid(39, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)
                item_obj = fallout.create_object_sid(40, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)

                critter_obj = fallout.create_object_sid(16777408, 0, 0, 524)
                fallout.critter_attempt_placement(critter_obj, 19337, 0)
                fallout.critter_add_trait(critter_obj, 1, 6, 34)
                item_obj = fallout.create_object_sid(28, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)
                item_obj = fallout.create_object_sid(39, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)
                item_obj = fallout.create_object_sid(40, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)

                critter_obj = fallout.create_object_sid(16777408, 0, 0, 524)
                fallout.critter_attempt_placement(critter_obj, 18740, 0)
                fallout.critter_add_trait(critter_obj, 1, 6, 34)
                item_obj = fallout.create_object_sid(28, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)
                item_obj = fallout.create_object_sid(39, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)
                item_obj = fallout.create_object_sid(40, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)

                critter_obj = fallout.create_object_sid(16777408, 0, 0, 524)
                fallout.critter_attempt_placement(critter_obj, 21339, 0)
                fallout.critter_add_trait(critter_obj, 1, 6, 34)
                item_obj = fallout.create_object_sid(28, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)
                item_obj = fallout.create_object_sid(39, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)
                item_obj = fallout.create_object_sid(40, 0, 0, -1)
                fallout.add_obj_to_inven(critter_obj, item_obj)
            end
        end
    end
    if fallout.global_var(32) == 2 then
        fallout.override_map_start(112, 84, 0, 3)
    elseif fallout.global_var(32) == 3 then
        fallout.override_map_start(140, 78, 1, 4)
    elseif fallout.global_var(32) == 5 then
        fallout.override_map_start(140, 78, 0, 4)
    elseif fallout.global_var(32) == 12 then
        fallout.override_map_start(55, 68, 0, 5)
        if fallout.metarule(22, 0) == 0 then
            local critter_obj
            local item_obj

            fallout.create_object_sid(16777363, 13854, 0, 53)

            critter_obj = fallout.create_object_sid(16777409, 0, 0, 524)
            fallout.critter_attempt_placement(critter_obj, 15468, 0)
            fallout.critter_add_trait(critter_obj, 1, 6, 55)
            item_obj = fallout.create_object_sid(15, 0, 0, -1)
            fallout.add_obj_to_inven(critter_obj, item_obj)
            item_obj = fallout.create_object_sid(39, 0, 0, -1)
            fallout.add_obj_to_inven(critter_obj, item_obj)
            item_obj = fallout.create_object_sid(40, 0, 0, -1)
            fallout.add_obj_to_inven(critter_obj, item_obj)

            critter_obj = fallout.create_object_sid(16777409, 0, 0, 524)
            fallout.critter_attempt_placement(critter_obj, 15450, 0)
            fallout.critter_add_trait(critter_obj, 1, 6, 55)
            item_obj = fallout.create_object_sid(15, 0, 0, -1)
            fallout.add_obj_to_inven(critter_obj, item_obj)
            item_obj = fallout.create_object_sid(39, 0, 0, -1)
            fallout.add_obj_to_inven(critter_obj, item_obj)
            item_obj = fallout.create_object_sid(40, 0, 0, -1)
            fallout.add_obj_to_inven(critter_obj, item_obj)
        end
    else
        fallout.override_map_start(112, 84, 0, 3)
    end
    light.darkness()
    party_elevation = party.add_party()
end

function map_exit_p_proc()
    fallout.kill_critter_type(16777408, 0)
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
            fallout.display_msg(fallout.message_str(447, 106))
            fallout.play_gmovie(4)
            fallout.metarule(13, 0)
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
