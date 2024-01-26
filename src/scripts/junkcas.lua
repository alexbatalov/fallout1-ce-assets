local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

local start
local Kill_Neal

local HEREBEFORE = 0
local time = 0
local item = 0

fallout.create_external_var("Killian_ptr")
fallout.create_external_var("Gizmo_ptr")
fallout.create_external_var("growling")
fallout.create_external_var("dog_is_angry")
fallout.set_external_var("dog_is_angry", 1)
fallout.create_external_var("smartass")
fallout.create_external_var("smartass2")
fallout.create_external_var("Phil_approaches")
fallout.create_external_var("KillSafe_ptr")
fallout.create_external_var("assassin_seed")
fallout.create_external_var("helped_Killian")
fallout.create_external_var("Killian_barter_var")
fallout.create_external_var("Killian_store1_ptr")
fallout.create_external_var("Killian_store2_ptr")
fallout.create_external_var("Killian_store3_ptr")
fallout.create_external_var("weapon_checked")
fallout.create_external_var("sneak_checked")
fallout.create_external_var("times_caught_sneaking")
fallout.create_external_var("Gizmo_is_angry")
fallout.create_external_var("show_to_door")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("payment")
fallout.create_external_var("messing_with_SkumDoor")
fallout.create_external_var("Neal_closing_door")
fallout.create_external_var("Neal_ptr")
fallout.create_external_var("Skul_target")
fallout.create_external_var("SkumDoor_ptr")
fallout.create_external_var("Trish_ptr")
fallout.create_external_var("challenger_ptr")
fallout.create_external_var("fight")
fallout.create_external_var("Saul_loses")
fallout.create_external_var("Saul_wins")
fallout.create_external_var("shot_challenger")

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

function start()
    local v0 = 0
    local v1 = 0
    if fallout.script_action() == 15 then
        fallout.set_global_var(571, 1)
        light.lighting()
        if fallout.global_var(32) == 1 then
            fallout.override_map_start(99, 94, 0, 3)
        else
            if (fallout.global_var(32) == 4) and (not misc.is_loading_game()) then
                fallout.gfade_in(600)
                fallout.override_map_start(120, 87, 0, 5)
                v0 = fallout.create_object_sid(16777295, 0, 0, 47)
                fallout.critter_add_trait(v0, 1, 6, 0)
                item = fallout.create_object_sid(18, 0, 0, -1)
                fallout.critter_attempt_placement(v0, 17522, 0)
                fallout.add_obj_to_inven(v0, item)
                v1 = fallout.create_object_sid(16777296, 0, 0, 518)
                fallout.critter_add_trait(v1, 1, 6, 0)
                item = fallout.create_object_sid(94, 0, 0, -1)
                fallout.critter_attempt_placement(v1, 17323, 0)
                fallout.add_obj_to_inven(v1, item)
                item = fallout.create_object_sid(95, 0, 0, -1)
                fallout.add_obj_to_inven(v1, item)
                item = fallout.create_object_sid(100, 0, 0, -1)
                fallout.add_obj_to_inven(v1, item)
            else
                if (fallout.global_var(32) == 7) and (not misc.is_loading_game()) then
                    Kill_Neal()
                else
                    fallout.override_map_start(99, 94, 0, 5)
                end
            end
        end
        if (fallout.global_var(283) ~= 0) and (fallout.external_var("Neal_ptr") ~= 0) then
            if (fallout.global_var(283) < time.game_time_in_days()) and (not misc.is_loading_game()) then
                fallout.kill_critter(fallout.external_var("Neal_ptr"), 49)
            end
        end
    else
        if fallout.script_action() == 23 then
            party_elevation = party.update_party(party_elevation)
            light.lighting()
            if not misc.is_loading_game() then
                if (fallout.global_var(38) == 1) and (fallout.map_var(3) == 0) and (fallout.combat_is_initialized() == 0) and (fallout.global_var(348) == 0) then
                    fallout.display_msg(fallout.message_str(44, 217))
                    fallout.give_exp_points(600)
                    fallout.set_global_var(155, fallout.global_var(155) + 3)
                    fallout.set_map_var(3, 1)
                    fallout.debug_msg("gave_exp")
                    if fallout.global_var(32) == 4 then
                        if v0 ~= 0 then
                            fallout.set_obj_visibility(v0, 1)
                        end
                        if v1 ~= 0 then
                            fallout.set_obj_visibility(v1, 1)
                        end
                        fallout.set_global_var(104, 2)
                        fallout.load_map(10, 5)
                    end
                end
                if (fallout.map_var(2) == 1) and (fallout.combat_is_initialized() == 0) then
                    if fallout.map_var(0) <= 0 then
                        fallout.set_global_var(555, 2)
                        fallout.set_map_var(2, 2)
                        fallout.set_global_var(283, 0)
                        fallout.display_msg(fallout.message_str(518, 154))
                        fallout.set_global_var(155, fallout.global_var(155) + 1)
                        fallout.give_exp_points(300)
                    else
                        if (fallout.map_var(1) <= 0) and (fallout.global_var(284) == 1) then
                            fallout.set_global_var(285, 2)
                            fallout.set_map_var(2, 2)
                            fallout.display_msg(fallout.message_str(385, 164))
                            fallout.give_exp_points(300)
                            fallout.set_global_var(155, fallout.global_var(155) - 1)
                            if fallout.global_var(247) == 0 then
                                fallout.set_global_var(247, 1)
                                fallout.set_global_var(155, fallout.global_var(155) - 5)
                            end
                        end
                    end
                end
                if (fallout.global_var(283) ~= 0) and (fallout.external_var("Neal_ptr") ~= 0) then
                    if fallout.global_var(283) < time.game_time_in_days() then
                        fallout.kill_critter(fallout.external_var("Neal_ptr"), 49)
                    end
                end
                if fallout.external_var("removal_ptr") ~= 0 then
                    fallout.destroy_object(fallout.external_var("removal_ptr"))
                    fallout.set_external_var("removal_ptr", 0)
                end
            end
        else
            if fallout.script_action() == 16 then
                if fallout.external_var("challenger_ptr") ~= 0 then
                    fallout.destroy_object(fallout.external_var("challenger_ptr"))
                end
                fallout.set_external_var("fight", 0)
                fallout.set_external_var("Saul_wins", 0)
                fallout.set_external_var("Saul_loses", 0)
            end
        end
    end
end

function Kill_Neal()
    local v0 = 0
    fallout.override_map_start(81, 103, 0, 5)
    fallout.set_map_var(2, 1)
    v0 = fallout.create_object_sid(16777318, 20277, 0, 385)
    item = fallout.create_object_sid(8, 0, 0, -1)
    fallout.add_obj_to_inven(v0, item)
    item = fallout.create_object_sid(74, 0, 0, -1)
    fallout.add_obj_to_inven(v0, item)
    item = fallout.create_object_sid(4, 0, 0, -1)
    fallout.add_obj_to_inven(v0, item)
    v0 = fallout.create_object_sid(16777240, 20476, 0, 390)
    item = fallout.create_object_sid(8, 0, 0, -1)
    fallout.add_obj_to_inven(v0, item)
    item = fallout.create_object_sid(4, 0, 0, -1)
    fallout.add_obj_to_inven(v0, item)
    v0 = fallout.create_object_sid(16777315, 20279, 0, 390)
    item = fallout.create_object_sid(4, 0, 0, -1)
    fallout.add_obj_to_inven(v0, item)
    v0 = fallout.create_object_sid(16777315, 20482, 0, 390)
    item = fallout.create_object_sid(4, 0, 0, -1)
    fallout.add_obj_to_inven(v0, item)
    fallout.set_map_var(0, 4)
    if fallout.global_var(287) == 1 then
        fallout.set_map_var(1, 4)
        v0 = fallout.create_object_sid(16777218, 22083, 0, 37)
        item = fallout.create_object_sid(8, 0, 0, -1)
        fallout.add_obj_to_inven(v0, item)
        fallout.add_timer_event(v0, fallout.game_ticks(2), 4)
        v0 = fallout.create_object_sid(16777218, 22485, 0, 37)
        item = fallout.create_object_sid(8, 0, 0, -1)
        fallout.add_obj_to_inven(v0, item)
        v0 = fallout.create_object_sid(16777218, 21082, 0, 37)
        item = fallout.create_object_sid(7, 0, 0, -1)
        fallout.add_obj_to_inven(v0, item)
        v0 = fallout.create_object_sid(16777218, 22885, 0, 37)
        item = fallout.create_object_sid(7, 0, 0, -1)
        fallout.add_obj_to_inven(v0, item)
    end
    fallout.game_time_advance(fallout.game_ticks(60 * (60 - (fallout.game_time_hour() % 100))))
    if fallout.game_time_hour() ~= 300 then
        if fallout.game_time_hour() < 300 then
            fallout.game_time_advance(fallout.game_ticks(36 * (300 - fallout.game_time_hour())))
        else
            fallout.game_time_advance(fallout.game_ticks(36 * (2700 - fallout.game_time_hour())))
        end
    end
end

local exports = {}
exports.start = start
return exports
