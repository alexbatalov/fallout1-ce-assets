local fallout = require("fallout")

local start
local Lighting
local Darkness
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
fallout.create_external_var("local patient")
fallout.create_external_var("local lets_go")
fallout.create_external_var("local contpan")
fallout.create_external_var("local J_Door_Ptr")
fallout.create_external_var("local Psy_Field_Ptr")

local Player_Elevation = 0
local monstr_ptr = 0
local stuff = 0
local cur_count = 0
local prev_count = 0

local Invasion

function start()
    if fallout.script_action() == 15 then
        Darkness()
        Player_Elevation = fallout.elevation(fallout.dude_obj())
        if Player_Elevation == 0 then
            if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800) and (fallout.metarule(22, 0) == 0) then
                if fallout.map_var(10) == 0 then
                    fallout.set_map_var(10, 1)
                    monstr_ptr = fallout.create_object_sid(16777259, 0, 0, 686)
                    fallout.critter_attempt_placement(monstr_ptr, 24678, 0)
                    fallout.critter_add_trait(monstr_ptr, 1, 6, 34)
                    monstr_ptr = fallout.create_object_sid(16777261, 0, 0, 686)
                    fallout.critter_attempt_placement(monstr_ptr, 25680, 0)
                    fallout.critter_add_trait(monstr_ptr, 1, 6, 34)
                    monstr_ptr = fallout.create_object_sid(16777261, 0, 0, 686)
                    fallout.critter_attempt_placement(monstr_ptr, 25276, 0)
                    fallout.critter_add_trait(monstr_ptr, 1, 6, 34)
                end
            end
        end
        if fallout.global_var(32) == 0 then
            fallout.override_map_start(136, 107, 0, 3)
        else
            if fallout.global_var(32) == 4 then
                fallout.override_map_start(98, 60, 0, 3)
            else
                if fallout.global_var(32) == 1 then
                    fallout.override_map_start(94, 98, 1, 3)
                else
                    fallout.override_map_start(136, 107, 0, 3)
                end
            end
        end
        add_party()
    end
    if fallout.script_action() == 23 then
        Darkness()
        if fallout.global_var(55) ~= 0 then
            cur_count = 240 - ((fallout.game_time() // 10) - fallout.global_var(55))
            if cur_count ~= prev_count then
                fallout.display_msg(fallout.message_str(447, 100) .. cur_count .. fallout.message_str(447, 101))
                prev_count = cur_count
            end
            if ((fallout.game_time() // 10) - fallout.global_var(55)) > 240 then
                fallout.display_msg(fallout.message_str(446, 106))
                fallout.play_gmovie(4)
                fallout.metarule(13, 0)
            end
        end
        update_party()
    end
    if fallout.script_action() == 16 then
        fallout.kill_critter_type(16777259, 0)
        fallout.kill_critter_type(16777261, 0)
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
