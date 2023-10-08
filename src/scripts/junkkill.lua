local fallout = require("fallout")
local time = require("lib.time")

local start
local Lighting
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
fallout.create_external_var("raider_dead")
fallout.create_external_var("Sinthia_dead")
fallout.create_external_var("award")
fallout.create_external_var("assassin_seed")
fallout.create_external_var("KillSafe_ptr")
fallout.create_external_var("Killian_store1_ptr")
fallout.create_external_var("Killian_store2_ptr")
fallout.create_external_var("Killian_store3_ptr")
fallout.create_external_var("Killian_store4_ptr")
fallout.create_external_var("Killian_barter_var")
fallout.create_external_var("jail_door_ptr")
fallout.create_external_var("messing_with_fridge")
fallout.create_external_var("weapon_checked")
fallout.create_external_var("sneak_checked")
fallout.create_external_var("times_caught_sneaking")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("JTRaider_ptr")
fallout.create_external_var("Killian_ptr")
fallout.create_external_var("Neal_ptr")
fallout.create_external_var("Sinthia_ptr")
fallout.create_external_var("Trish_ptr")

local item = 0
local Kenji_ptr = 0

local Darkness
local Invasion

function start()
    local v0 = 0
    if fallout.script_action() == 15 then
        fallout.set_global_var(570, 1)
        Lighting()
        fallout.override_map_start(99, 113, 0, 0)
        add_party()
        if fallout.map_var(7) == 1 then
            fallout.display_msg(fallout.message_str(338, fallout.random(139, 140)))
        end
    else
        if fallout.script_action() == 23 then
            Lighting()
            if fallout.external_var("award") and not(fallout.map_var(4)) and (fallout.global_var(143) == 2) then
                fallout.display_msg(fallout.message_str(338, 175) .. fallout.external_var("award") .. fallout.message_str(338, 176))
                fallout.give_exp_points(fallout.external_var("award"))
                fallout.set_map_var(4, 1)
            end
            if (fallout.global_var(37) == 1) and (fallout.global_var(349) == 0) then
                fallout.display_msg(fallout.message_str(47, 269))
                fallout.give_exp_points(600)
                fallout.set_global_var(155, fallout.global_var(155) - 5)
                fallout.set_global_var(349, 1)
            end
            if fallout.external_var("removal_ptr") then
                fallout.destroy_object(fallout.external_var("removal_ptr"))
                fallout.set_external_var("removal_ptr", 0)
            end
        else
            if fallout.script_action() == 16 then
                remove_party()
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
