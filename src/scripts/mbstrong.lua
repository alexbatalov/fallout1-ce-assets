local fallout = require("fallout")
local time = require("lib.time")

local start
local combat_p_proc
local Lighting
local Darkness
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

fallout.create_external_var("field_change")
fallout.create_external_var("ignoring_dude")
fallout.create_external_var("radio_computer")
fallout.create_external_var("radio_room_attacked")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("valid_target")
fallout.create_external_var("FieldC1a_ptr")
fallout.create_external_var("FieldC1b_ptr")
fallout.create_external_var("FieldC2a_ptr")
fallout.create_external_var("FieldC2b_ptr")
fallout.create_external_var("Field1a_Ptr")
fallout.create_external_var("Field2a_Ptr")
fallout.create_external_var("Field3a_Ptr")
fallout.create_external_var("Field4a_Ptr")
fallout.create_external_var("Field5a_Ptr")
fallout.create_external_var("Field6a_Ptr")
fallout.create_external_var("Field1b_Ptr")
fallout.create_external_var("Field2b_Ptr")

local Invasion

function start()
    if fallout.script_action() == 13 then
        combat_p_proc()
    else
        if fallout.script_action() == 15 then
            if fallout.metarule(14, 0) then
                fallout.set_external_var("field_change", "off")
            end
            if fallout.global_var(146) then
                fallout.set_external_var("field_change", "on")
            end
            if fallout.global_var(609) then
                fallout.set_external_var("field_change", "off")
            end
            if fallout.global_var(32) == 0 then
                fallout.override_map_start(120, 75, 0, 2)
            else
                if fallout.global_var(32) == 1 then
                    fallout.override_map_start(120, 75, 1, 2)
                else
                    if fallout.global_var(32) == 12 then
                        fallout.override_map_start(92, 135, 0, 5)
                    else
                        fallout.override_map_start(93, 143, 0, 5)
                    end
                end
            end
            fallout.set_external_var("radio_room_attacked", fallout.map_var(13))
            add_party()
        else
            if fallout.script_action() == 23 then
                if fallout.global_var(146) == 0 then
                    if fallout.elevation(fallout.dude_obj()) == 0 then
                        fallout.set_global_var(588, 1)
                    else
                        fallout.set_global_var(589, 1)
                    end
                else
                    if fallout.map_var(24) == 0 then
                        fallout.display_msg(fallout.message_str(766, 186))
                        fallout.set_map_var(24, 1)
                    end
                    fallout.set_global_var(588, 0)
                    fallout.set_global_var(589, 0)
                end
                if fallout.global_var(147) ~= 0 then
                    fallout.display_msg(fallout.message_str(441, 108) .. (300 - (time.game_time_in_seconds() - fallout.global_var(147))) .. fallout.message_str(441, 109))
                    if (time.game_time_in_seconds() - fallout.global_var(147)) >= 300 then
                        fallout.play_gmovie(3)
                        fallout.metarule(13, 0)
                    end
                end
                if fallout.external_var("removal_ptr") ~= 0 then
                    fallout.destroy_object(fallout.external_var("removal_ptr"))
                    fallout.set_external_var("removal_ptr", 0)
                end
                update_party()
            else
                if fallout.script_action() == 16 then
                    remove_party()
                end
            end
        end
    end
end

function combat_p_proc()
    if fallout.global_var(276) then
        fallout.script_overrides()
        fallout.set_global_var(276, 0)
        fallout.set_global_var(57, 3)
        fallout.load_map(32, 5)
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
exports.combat_p_proc = combat_p_proc
return exports
