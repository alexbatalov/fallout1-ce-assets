local fallout = require("fallout")
local time = require("lib.time")

local start
local add_party
local update_party
local remove_party

local party_elevation = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")

local Player_Elevation = 0

function start()
    if fallout.script_action() == 15 then
        fallout.set_light_level(75)
        Player_Elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(32) == 0 then
            fallout.override_map_start(137, 103, 0, 3)
        else
            if fallout.global_var(32) == 4 then
                fallout.override_map_start(98, 60, 0, 3)
            else
                if fallout.global_var(32) == 1 then
                    fallout.override_map_start(94, 98, 1, 3)
                else
                    fallout.override_map_start(137, 103, 0, 3)
                end
            end
        end
        if fallout.global_var(55) ~= 0 then
            fallout.display_msg(fallout.message_str(446, 100) .. (240 - (time.game_time_in_seconds() - fallout.global_var(55))) .. fallout.message_str(446, 101))
            if (time.game_time_in_seconds() - fallout.global_var(55)) > 240 then
                fallout.display_msg(fallout.message_str(446, 102))
                fallout.play_gmovie(6)
                fallout.metarule(13, 0)
            end
        end
        add_party()
    end
    if fallout.script_action() == 23 then
        fallout.set_light_level(75)
        if fallout.global_var(55) ~= 0 then
            fallout.display_msg(fallout.message_str(446, 104) .. (240 - (time.game_time_in_seconds() - fallout.global_var(55))) .. fallout.message_str(446, 105))
            if (time.game_time_in_seconds() - fallout.global_var(55)) > 240 then
                fallout.display_msg(fallout.message_str(446, 106))
                fallout.play_gmovie(6)
                fallout.metarule(13, 0)
            end
        end
        update_party()
    end
    if fallout.script_action() == 16 then
        if fallout.global_var(55) ~= 0 then
            fallout.display_msg(fallout.message_str(446, 108) .. (240 - (time.game_time_in_seconds() - fallout.global_var(55))) .. fallout.message_str(446, 109))
            if (time.game_time_in_seconds() - fallout.global_var(55)) > 240 then
                fallout.display_msg(fallout.message_str(446, 110))
                fallout.play_gmovie(6)
                fallout.metarule(13, 0)
            end
        end
        remove_party()
    end
end

function add_party()
    local v0 = 0
    party_elevation = fallout.elevation(fallout.dude_obj())
    if fallout.global_var(118) == 2 then
        if not(fallout.external_var("Ian_ptr")) then
            fallout.set_external_var("Ian_ptr", fallout.create_object_sid(16777233, 0, 0, 235))
            fallout.critter_attempt_placement(fallout.external_var("Ian_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), fallout.elevation(fallout.dude_obj()))
        end
        fallout.critter_add_trait(fallout.external_var("Ian_ptr"), 1, 6, 0)
        v0 = fallout.create_object_sid(74, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.external_var("Ian_ptr"), v0)
        fallout.wield_obj_critter(fallout.external_var("Ian_ptr"), v0)
        v0 = fallout.create_object_sid(8, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.external_var("Ian_ptr"), v0)
    end
    if fallout.global_var(5) then
        if not(fallout.external_var("Dog_ptr")) then
            fallout.set_external_var("Dog_ptr", fallout.create_object_sid(16777252, 0, 0, 229))
            fallout.critter_attempt_placement(fallout.external_var("Dog_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 2, 2), fallout.elevation(fallout.dude_obj()))
        end
        fallout.critter_add_trait(fallout.external_var("Dog_ptr"), 1, 6, 0)
    end
    if fallout.global_var(121) == 2 then
        if not(fallout.external_var("Tycho_ptr")) then
            fallout.set_external_var("Tycho_ptr", fallout.create_object_sid(16777218, 0, 0, 389))
            fallout.critter_attempt_placement(fallout.external_var("Tycho_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 3, 2), fallout.elevation(fallout.dude_obj()))
        end
        fallout.critter_add_trait(fallout.external_var("Tycho_ptr"), 1, 6, 0)
        v0 = fallout.create_object_sid(1, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.external_var("Tycho_ptr"), v0)
        fallout.wield_obj_critter(fallout.external_var("Tycho_ptr"), v0)
        v0 = fallout.create_object_sid(94, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.external_var("Tycho_ptr"), v0)
    end
end

function update_party()
    if fallout.elevation(fallout.dude_obj()) ~= party_elevation then
        party_elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(118) == 2 then
            fallout.move_to(fallout.external_var("Ian_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), fallout.elevation(fallout.dude_obj()))
        end
        if fallout.global_var(5) then
            fallout.move_to(fallout.external_var("Dog_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 2, 1), fallout.elevation(fallout.dude_obj()))
        end
        if fallout.global_var(121) == 2 then
            fallout.move_to(fallout.external_var("Tycho_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 3, 2), fallout.elevation(fallout.dude_obj()))
        end
    end
end

function remove_party()
    if fallout.global_var(118) == 2 then
        fallout.destroy_object(fallout.external_var("Ian_ptr"))
        fallout.set_global_var(118, 2)
    end
    if fallout.global_var(5) then
        fallout.destroy_object(fallout.external_var("Dog_ptr"))
        fallout.set_global_var(5, 1)
    end
    if fallout.global_var(121) == 2 then
        fallout.destroy_object(fallout.external_var("Tycho_ptr"))
        fallout.set_global_var(121, 2)
    end
end

local exports = {}
exports.start = start
return exports
