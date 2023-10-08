local fallout = require("fallout")
local light = require("lib.light")
local time = require("lib.time")

local start

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

local add_party
local update_party
local remove_party

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

local Invasion

function start()
    if fallout.script_action() == 15 then
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 104))
        end
        light.lighting()
        fallout.set_global_var(569, 1)
        if fallout.metarule(22, 0) == 0 then
            if fallout.global_var(32) == 3 then
                fallout.override_map_start(107, 138, 0, 2)
            else
                if fallout.global_var(32) == 6 then
                    fallout.override_map_start(61, 91, 0, 5)
                    if fallout.item_caps_total(fallout.dude_obj()) >= 100 then
                        fallout.item_caps_adjust(fallout.dude_obj(), -100)
                    else
                        fallout.set_global_var(155, fallout.global_var(155) - 2)
                    end
                    fallout.set_map_var(1, 1)
                    fallout.set_map_var(5, time.game_time_in_days())
                else
                    if fallout.global_var(32) == 5 then
                        fallout.override_map_start(103, 115, 0, 5)
                        if fallout.map_var(0) == 0 then
                            fallout.set_map_var(0, 1)
                        end
                    else
                        fallout.override_map_start(107, 138, 0, 5)
                    end
                end
            end
        end
    else
        if fallout.script_action() == 23 then
            update_party()
            if fallout.elevation(fallout.dude_obj()) == 1 then
                fallout.set_light_level(40)
            else
                light.lighting()
            end
            if fallout.external_var("removal_ptr") ~= 0 then
                fallout.destroy_object(fallout.external_var("removal_ptr"))
                fallout.set_external_var("removal_ptr", 0)
            end
        end
    end
end

function add_party()
    local v0 = 0
    local v1 = 0
    party_elevation = fallout.elevation(fallout.dude_obj())
    if fallout.global_var(26) == 5 then
        if fallout.external_var("Tandi_ptr") == 0 then
        end
        fallout.critter_add_trait(fallout.external_var("Tandi_ptr"), 1, 6, 0)
    end
end

function update_party()
    local v0 = 0
    local v1 = 0
    if fallout.elevation(fallout.dude_obj()) ~= party_elevation then
        party_elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(118) == 2 then
            if fallout.external_var("Ian_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Ian_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(5) then
            if fallout.external_var("Dog_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Dog_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 2, 1), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(121) == 2 then
            if fallout.external_var("Tycho_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Tycho_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 3, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(244) == 2 then
            if fallout.external_var("Katja_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Katja_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(26) == 5 then
            if fallout.external_var("Tandi_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Tandi_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 4), fallout.elevation(fallout.dude_obj()))
            end
        end
    end
end

function remove_party()
    if fallout.global_var(118) == 2 then
        fallout.set_global_var(118, 2)
    end
    if fallout.global_var(5) then
        fallout.set_global_var(5, 1)
    end
    if fallout.global_var(121) == 2 then
        fallout.set_global_var(121, 2)
    end
    if fallout.global_var(244) == 2 then
        fallout.set_global_var(244, 2)
    end
    if fallout.global_var(26) == 5 then
    end
end

function Invasion()
    if not(fallout.global_var(18) == 2) then
        if fallout.global_var(149) > time.game_time_in_days() then
            fallout.set_global_var(13, 1)
        end
        if fallout.global_var(150) > time.game_time_in_days() then
            fallout.set_global_var(14, 1)
        end
        if fallout.global_var(151) > time.game_time_in_days() then
            fallout.set_global_var(16, 1)
        end
        if fallout.global_var(152) > time.game_time_in_days() then
            fallout.set_global_var(15, 1)
        end
        if fallout.global_var(153) > time.game_time_in_days() then
            fallout.set_global_var(12, 1)
        end
        if fallout.global_var(154) <= 0 then
            fallout.set_global_var(11, 1)
        end
        if fallout.global_var(148) > time.game_time_in_days() then
            fallout.set_global_var(7, 1)
        end
    end
end

local exports = {}
exports.start = start
return exports
