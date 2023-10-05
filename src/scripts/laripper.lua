local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc
local Lighting
local Darkness
local PlaceCritter
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

local Invasion

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        else
            if fallout.script_action() == 16 then
                map_exit_p_proc()
            end
        end
    end
end

function map_enter_p_proc()
    local v0 = 0
    fallout.set_global_var(598, 1)
    if fallout.metarule(22, 0) == 0 then
        if (fallout.map_var(0) == 0) and (((fallout.game_time() // 10) - fallout.global_var(270)) > (60 * 60)) then
            fallout.set_global_var(270, fallout.game_time() // 10)
            if fallout.map_var(1) == 0 then
                v0 = fallout.random(2, 3)
                fallout.set_map_var(1, v0)
                fallout.set_map_var(3, v0)
                PlaceCritter()
            else
                if fallout.map_var(1) == 1 then
                    v0 = fallout.random(1, 2)
                    fallout.set_map_var(1, v0 + 1)
                    fallout.set_map_var(3, v0)
                    PlaceCritter()
                else
                    if fallout.map_var(1) == 2 then
                        if fallout.random(0, 1) then
                            fallout.set_map_var(1, 3)
                            fallout.set_map_var(3, 1)
                            PlaceCritter()
                        end
                    end
                end
            end
        end
    end
    Lighting()
    fallout.override_map_start(96, 121, 0, 0)
    add_party()
end

function map_update_p_proc()
    if fallout.elevation(fallout.dude_obj()) == 1 then
        Darkness()
    else
        Lighting()
    end
    update_party()
end

function map_exit_p_proc()
    remove_party()
    if (fallout.map_var(0) == 1) and (fallout.map_var(1) == 0) and (fallout.map_var(2) == 0) then
        fallout.set_global_var(265, 9250)
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

function PlaceCritter()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    local v3 = 0
    v3 = fallout.map_var(3)
    while v3 > 0 do
        v2 = fallout.random(1, 7)
        if v2 == 1 then
            v1 = 16890
        else
            if v2 == 2 then
                v1 = 17269
            else
                if v2 == 3 then
                    v1 = 23492
                else
                    if v2 == 4 then
                        v1 = 15885
                    else
                        if v2 == 5 then
                            v1 = 12287
                        else
                            if v2 == 6 then
                                v1 = 17511
                            else
                                if v2 == 7 then
                                    v1 = 15475
                                end
                            end
                        end
                    end
                end
            end
        end
        v0 = fallout.create_object_sid(16777267, 0, 0, 922)
        fallout.critter_attempt_placement(v0, v1, 0)
        v3 = v3 - 1
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
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
