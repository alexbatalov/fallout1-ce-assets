local fallout = require("fallout")

local start
local Lighting

fallout.create_external_var("local weapon_checked")
fallout.create_external_var("local sneak_checked")
fallout.create_external_var("local times_caught_sneaking")
fallout.create_external_var("local fetch_dude")
fallout.create_external_var("local ladder_down")
fallout.create_external_var("local ladder_up")
fallout.create_external_var("local Gretch_call")
fallout.create_external_var("local helped_Killian")
fallout.create_external_var("local messing_with_Morbid_stuff")
fallout.create_external_var("local jail_door_ptr")
fallout.create_external_var("local Morbid_ptr")
fallout.create_external_var("local removal_ptr")

local add_party
local update_party
local remove_party

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("local Ian_ptr")
fallout.create_external_var("local Dog_ptr")
fallout.create_external_var("local Tycho_ptr")
fallout.create_external_var("local Katja_ptr")
fallout.create_external_var("local Tandi_ptr")

local Darkness
local Invasion

function start()
    if fallout.script_action() == 15 then
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 104))
        end
        Lighting()
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
                    fallout.set_map_var(5, fallout.game_time() // (10 * 60 * 60 * 24))
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
                Lighting()
            end
            if fallout.external_var("removal_ptr") ~= 0 then
                fallout.destroy_object(fallout.external_var("removal_ptr"))
                fallout.set_external_var("removal_ptr", 0)
            end
        end
    end
end

function Lighting()
    local v0 = 0
    v0 = fallout.game_time_hour()
    if (v0 >= 600) and (v0 < 700) then
        fallout.set_light_level(v0 - 600 + 40)
    else
        if (v0 >= 700) and (v0 < 1800) then
            fallout.set_light_level(100)
        else
            if (v0 >= 1800) and (v0 < 1900) then
                fallout.set_light_level(100 - (v0 - 1800))
            else
                fallout.set_light_level(40)
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

function Darkness()
    fallout.set_light_level(40)
end

function Invasion()
    if not(fallout.global_var(18) == 2) then
        if fallout.global_var(149) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(13, 1)
        end
        if fallout.global_var(150) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(14, 1)
        end
        if fallout.global_var(151) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(16, 1)
        end
        if fallout.global_var(152) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(15, 1)
        end
        if fallout.global_var(153) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(12, 1)
        end
        if fallout.global_var(154) <= 0 then
            fallout.set_global_var(11, 1)
        end
        if fallout.global_var(148) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(7, 1)
        end
    end
end

local exports = {}
exports.start = start
return exports
