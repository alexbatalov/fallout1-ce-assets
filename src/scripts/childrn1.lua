local fallout = require("fallout")

local start
local Lighting
local Darkness

fallout.create_external_var("Master_Ptr")
fallout.create_external_var("Red_Door_Ptr")
fallout.create_external_var("Black_Door_Ptr")
fallout.create_external_var("Laura_Ptr")
fallout.create_external_var("Shop_Ptr")
fallout.create_external_var("Shopkepper_Ptr")

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

local Player_Elevation = 0
local cur_count = 0
local prev_count = 0

local Invasion

function start()
    if fallout.script_action() == 15 then
        Lighting()
        fallout.set_global_var(77, 2)
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 110))
        end
        Player_Elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(32) == 0 then
            fallout.override_map_start(100, 102, 0, 5)
        else
            if fallout.global_var(32) == 2 then
                fallout.override_map_start(100, 86, 0, 2)
            else
                if fallout.global_var(32) == 1 then
                    fallout.override_map_start(99, 113, 1, 5)
                else
                    if fallout.global_var(32) == 3 then
                        fallout.override_map_start(96, 63, 1, 1)
                    else
                        if fallout.global_var(32) == 4 then
                            fallout.override_map_start(85, 63, 1, 4)
                        else
                            fallout.override_map_start(100, 102, 0, 5)
                        end
                    end
                end
            end
        end
        add_party()
    end
    if fallout.script_action() == 23 then
        Lighting()
        if fallout.elevation(fallout.dude_obj()) == 1 then
            fallout.set_global_var(600, 1)
        end
        if fallout.global_var(55) ~= 0 then
            cur_count = 240 - ((fallout.game_time() // 10) - fallout.global_var(55))
            if cur_count ~= prev_count then
                fallout.display_msg(fallout.message_str(447, 100) .. cur_count .. fallout.message_str(447, 101))
                prev_count = cur_count
            end
            if ((fallout.game_time() // 10) - fallout.global_var(55)) > 240 then
                fallout.display_msg(fallout.message_str(444, 106))
                fallout.play_gmovie(4)
                fallout.metarule(13, 0)
            end
        end
        update_party()
    end
    if fallout.script_action() == 16 then
        remove_party()
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

function Darkness()
    fallout.set_light_level(40)
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
