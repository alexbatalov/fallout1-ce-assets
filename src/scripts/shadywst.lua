local fallout = require("fallout")
local time = require("lib.time")

local start
local combat_p_proc
local Lighting
local Tandi_Move
local Where_Is_Tandi
local Where_To_Start
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

local Darkness
local Invasion

function start()
    if fallout.script_action() == 15 then
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 101))
        end
        fallout.set_global_var(566, 1)
        if time.game_time_in_days() >= fallout.global_var(153) then
            fallout.set_global_var(12, 1)
        end
        if (fallout.days_since_visited() > 1) and (fallout.map_var(4) == 0) and (fallout.global_var(26) ~= 2) and (fallout.global_var(26) ~= 1) and (fallout.global_var(26) ~= 3) and (fallout.global_var(43) == 2) and (fallout.global_var(115) > 0) and (fallout.global_var(26) ~= 5) and (fallout.global_var(114) == 0) then
            fallout.set_global_var(26, 1)
            fallout.set_map_var(4, 1)
        else
            if fallout.global_var(26) == 5 then
                fallout.set_global_var(26, 2)
                if (fallout.map_var(1) == 0) and (fallout.map_var(3) == 0) then
                    fallout.set_map_var(3, 1)
                    fallout.set_map_var(1, 1)
                    fallout.display_msg(fallout.message_str(194, 100))
                    fallout.give_exp_points(400)
                end
            end
        end
        Lighting()
        Where_To_Start()
    else
        if fallout.script_action() == 23 then
            Lighting()
        else
            if fallout.script_action() == 16 then
            else
                if fallout.script_action() == 13 then
                    combat_p_proc()
                end
            end
        end
    end
end

function combat_p_proc()
    fallout.script_overrides()
    fallout.gfade_out(600)
    fallout.move_to(fallout.dude_obj(), 12107, 0)
    fallout.game_time_advance(fallout.game_ticks(1800))
    fallout.gfade_in(600)
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

function Tandi_Move()
    local v0 = 0
    v0 = fallout.game_time_hour()
    if (v0 > 2100) or (v0 <= 600) then
        fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
        fallout.move_to(fallout.external_var("Tandi_ptr"), 24678, 0)
    else
        if (v0 > 600) and (v0 <= 610) then
            fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
            fallout.move_to(fallout.external_var("Tandi_ptr"), 18709, 0)
        else
            if (v0 > 610) and (v0 <= 615) then
                fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                fallout.move_to(fallout.external_var("Tandi_ptr"), 23232, 0)
            else
                if v0 == 650 then
                    fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                    fallout.move_to(fallout.external_var("Tandi_ptr"), 23232, 0)
                else
                    if (v0 > 650) and (v0 <= 1000) then
                        fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                        fallout.move_to(fallout.external_var("Tandi_ptr"), 15683, 0)
                    else
                        if (v0 > 1000) and (v0 <= 1200) then
                            fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                            fallout.move_to(fallout.external_var("Tandi_ptr"), 18709, 0)
                        else
                            if (v0 > 1200) and (v0 <= 1300) then
                                fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                                fallout.move_to(fallout.external_var("Tandi_ptr"), 24678, 0)
                            else
                                if (v0 > 1300) and (v0 <= 1305) then
                                    fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                                    fallout.move_to(fallout.external_var("Tandi_ptr"), 23232, 0)
                                else
                                    if v0 == 1905 then
                                        fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                                        fallout.move_to(fallout.external_var("Tandi_ptr"), 23232, 0)
                                    else
                                        if (v0 > 1905) and (v0 <= 2100) then
                                            fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                                            fallout.move_to(fallout.external_var("Tandi_ptr"), 18709, 0)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Where_Is_Tandi()
    if fallout.global_var(26) == 1 then
    else
        if fallout.global_var(26) == 0 then
            Tandi_Move()
        else
            if fallout.global_var(26) == 2 then
                Tandi_Move()
            end
        end
    end
end

function Where_To_Start()
    if fallout.global_var(32) == 1 then
        fallout.override_map_start(107, 60, 0, 2)
    else
        if fallout.global_var(32) == 2 then
            fallout.override_map_start(65, 93, 0, 4)
        else
            if fallout.global_var(32) == 3 then
                fallout.override_map_start(107, 76, 0, 5)
            else
                fallout.override_map_start(107, 60, 0, 2)
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
exports.combat_p_proc = combat_p_proc
return exports
