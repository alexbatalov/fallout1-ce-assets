local fallout = require("fallout")
local time = require("lib.time")

local start
local Lighting
local Darkness

fallout.create_external_var("Team9_Count")
fallout.set_external_var("Team9_Count", 4)
fallout.create_external_var("radio_trick")
fallout.create_external_var("ignoring_dude")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("know_door_code")
fallout.create_external_var("comptroller_status")

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
local radio_kludge

function start()
    if fallout.script_action() == 15 then
        fallout.set_global_var(78, 2)
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 109))
        end
        fallout.set_external_var("radio_trick", fallout.map_var(0))
        fallout.set_external_var("know_door_code", fallout.map_var(1))
        Lighting()
        if fallout.global_var(32) == 0 then
            fallout.override_map_start(133, 111, 0, 5)
        else
            if fallout.global_var(32) == 1 then
                fallout.override_map_start(73, 107, 0, 2)
            else
                fallout.override_map_start(133, 111, 0, 5)
            end
        end
        add_party()
    else
        if fallout.script_action() == 23 then
            Lighting()
            if fallout.global_var(147) ~= 0 then
                fallout.display_msg(fallout.message_str(443, 103) .. (300 - (time.game_time_in_seconds() - fallout.global_var(147))) .. fallout.message_str(443, 104))
                if (time.game_time_in_seconds() - fallout.global_var(147)) >= 300 then
                    fallout.play_gmovie(3)
                    fallout.metarule(13, 0)
                end
            end
            if fallout.external_var("removal_ptr") ~= 0 then
                fallout.destroy_object(fallout.external_var("removal_ptr"))
                fallout.set_external_var("removal_ptr", 0)
            end
        else
            if fallout.script_action() == 16 then
                fallout.set_map_var(0, fallout.external_var("radio_trick"))
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

function radio_kludge()
    local v0 = 0
    local v1 = 0
    v0 = fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 100)
    if v0 > 0 then
        v1 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 100)
        v1 = fallout.destroy_mult_objs(v1, v0)
        v1 = fallout.create_object_sid(100, 0, 0, 361)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), v1, v0)
    end
end

local exports = {}
exports.start = start
return exports
