local fallout = require("fallout")
local light = require("lib.light")
local time = require("lib.time")

local start

local HEREBEFORE = 0
local time = 0
local know_Tycho = 0
local item = 0

fallout.create_external_var("Trish_ptr")
fallout.create_external_var("Killian_ptr")
fallout.create_external_var("Gizmo_ptr")
fallout.create_external_var("growling")
fallout.create_external_var("dog_is_angry")
fallout.set_external_var("dog_is_angry", 1)
fallout.create_external_var("smartass")
fallout.create_external_var("smartass2")
fallout.create_external_var("Phil_approaches")
fallout.create_external_var("weapon_checked")
fallout.create_external_var("sneak_checked")
fallout.create_external_var("times_caught_sneaking")
fallout.create_external_var("Gizmo_is_angry")
fallout.create_external_var("show_to_door")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("payment")

local add_party
local update_party
local remove_party

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")

function start()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    if fallout.script_action() == 15 then
        fallout.set_global_var(571, 1)
        if time.game_time_in_days() >= fallout.global_var(152) then
            fallout.set_global_var(15, 1)
        end
        light.lighting()
        if fallout.global_var(32) == 1 then
            fallout.override_map_start(99, 94, 0, 3)
        else
            if fallout.global_var(32) == 4 then
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
            else
                fallout.override_map_start(99, 94, 0, 5)
            end
        end
        if fallout.global_var(121) < 2 then
            fallout.set_external_var("Tycho_ptr", fallout.create_object_sid(16777426, 0, 0, 389))
            fallout.critter_attempt_placement(fallout.external_var("Tycho_ptr"), 7000, 0)
            fallout.critter_add_trait(fallout.external_var("Tycho_ptr"), 1, 6, 26)
            v2 = fallout.create_object_sid(1, 0, 0, -1)
            fallout.add_obj_to_inven(fallout.external_var("Tycho_ptr"), v2)
            fallout.wield_obj_critter(fallout.external_var("Tycho_ptr"), v2)
            v2 = fallout.create_object_sid(94, 0, 0, -1)
            fallout.add_obj_to_inven(fallout.external_var("Tycho_ptr"), v2)
        end
        add_party()
    else
        if fallout.script_action() == 23 then
            update_party()
            light.lighting()
            if fallout.map_var(2) == 1 then
                fallout.display_msg(fallout.message_str(527, 101))
                fallout.give_exp_points(150)
                fallout.set_map_var(2, 2)
            end
            if fallout.global_var(38) == 1 then
                fallout.display_msg(fallout.message_str(44, 217))
                fallout.give_exp_points(300)
                fallout.set_global_var(38, 2)
            end
            local removal_obj = fallout.external_var("removal_ptr")
            if removal_obj ~= nil then
                fallout.destroy_object(removal_obj)
                fallout.set_external_var("removal_ptr", nil)
            end
        else
            if fallout.script_action() == 16 then
                know_Tycho = fallout.global_var(121)
                if fallout.global_var(121) < 2 then
                    if fallout.external_var("Tycho_ptr") ~= 0 then
                        fallout.destroy_object(fallout.external_var("Tycho_ptr"))
                    end
                    fallout.set_global_var(121, know_Tycho)
                end
                remove_party()
                if v0 then
                    fallout.destroy_object(v0)
                end
                if v1 then
                    fallout.destroy_object(v1)
                end
            end
        end
    end
end

function add_party()
    local v0 = 0
    local v1 = 0
    party_elevation = fallout.elevation(fallout.dude_obj())
    if fallout.global_var(118) == 2 then
        if not(fallout.external_var("Ian_ptr")) then
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), (fallout.has_trait(1, fallout.dude_obj(), 10) + 4) % 6, 2)
            fallout.set_external_var("Ian_ptr", fallout.create_object_sid(16777292, v0, fallout.elevation(fallout.dude_obj()), 235))
            fallout.critter_attempt_placement(fallout.external_var("Ian_ptr"), v0, fallout.elevation(fallout.dude_obj()))
        end
        fallout.critter_add_trait(fallout.external_var("Ian_ptr"), 1, 6, 0)
        v1 = fallout.create_object_sid(74, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.external_var("Ian_ptr"), v1)
        fallout.wield_obj_critter(fallout.external_var("Ian_ptr"), v1)
        v1 = fallout.create_object_sid(8, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.external_var("Ian_ptr"), v1)
    end
    if fallout.global_var(5) ~= 0 then
        if not(fallout.external_var("Dog_ptr")) then
            fallout.set_external_var("Dog_ptr", fallout.create_object_sid(16777252, 0, 0, 229))
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), (fallout.has_trait(1, fallout.dude_obj(), 10) + 3) % 6, 2)
            fallout.critter_attempt_placement(fallout.external_var("Dog_ptr"), v0, fallout.elevation(fallout.dude_obj()))
        end
        fallout.critter_add_trait(fallout.external_var("Dog_ptr"), 1, 6, 0)
    end
    if fallout.global_var(121) == 2 then
        if not(fallout.external_var("Tycho_ptr")) then
            fallout.set_external_var("Tycho_ptr", fallout.create_object_sid(16777426, 0, 0, 389))
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), (fallout.has_trait(1, fallout.dude_obj(), 10) + 2) % 6, 2)
            fallout.critter_attempt_placement(fallout.external_var("Tycho_ptr"), v0, fallout.elevation(fallout.dude_obj()))
        end
        fallout.critter_add_trait(fallout.external_var("Tycho_ptr"), 1, 6, 0)
        v1 = fallout.create_object_sid(1, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.external_var("Tycho_ptr"), v1)
        fallout.wield_obj_critter(fallout.external_var("Tycho_ptr"), v1)
        v1 = fallout.create_object_sid(94, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.external_var("Tycho_ptr"), v1)
    end
    if fallout.global_var(244) == 2 then
        if not(fallout.external_var("Katja_ptr")) then
            fallout.set_external_var("Katja_ptr", fallout.create_object_sid(16777235, 0, 0, 623))
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), (fallout.has_trait(1, fallout.dude_obj(), 10) + 3) % 6, 4)
            fallout.critter_attempt_placement(fallout.external_var("Katja_ptr"), v0, fallout.elevation(fallout.dude_obj()))
        end
        fallout.critter_add_trait(fallout.external_var("Katja_ptr"), 1, 6, 0)
        v1 = fallout.create_object_sid(74, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.external_var("Katja_ptr"), v1)
        v1 = fallout.create_object_sid(20, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.external_var("Katja_ptr"), v1)
        v1 = fallout.create_object_sid(45, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.external_var("Katja_ptr"), v1, 3)
    end
end

function update_party()
    if fallout.elevation(fallout.dude_obj()) ~= party_elevation then
        party_elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(118) == 2 then
            fallout.move_to(fallout.external_var("Ian_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), fallout.elevation(fallout.dude_obj()))
        end
        if fallout.global_var(5) ~= 0 then
            fallout.move_to(fallout.external_var("Dog_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 2, 1), fallout.elevation(fallout.dude_obj()))
        end
        if fallout.global_var(121) == 2 then
            fallout.move_to(fallout.external_var("Tycho_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 3, 2), fallout.elevation(fallout.dude_obj()))
        end
        if fallout.global_var(244) == 2 then
            fallout.move_to(fallout.external_var("Katja_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 2), fallout.elevation(fallout.dude_obj()))
        end
    end
end

function remove_party()
    if fallout.global_var(118) == 2 then
        fallout.destroy_object(fallout.external_var("Ian_ptr"))
        fallout.set_global_var(118, 2)
    end
    if fallout.global_var(5) ~= 0 then
        fallout.destroy_object(fallout.external_var("Dog_ptr"))
        fallout.set_global_var(5, 1)
    end
    if fallout.global_var(121) == 2 then
        fallout.destroy_object(fallout.external_var("Tycho_ptr"))
        fallout.set_global_var(121, 2)
    end
    if fallout.global_var(244) == 2 then
        fallout.destroy_object(fallout.external_var("Katja_ptr"))
        fallout.set_global_var(244, 2)
    end
end

local exports = {}
exports.start = start
return exports
