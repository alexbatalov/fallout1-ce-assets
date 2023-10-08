local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc
local Darkness
local cheat_mode
local cheat2
local TagInven
local NamedInven
local base_inventory
local endgame_part1
local endgame_part2
local endgame_part3

local endgame_running = 0

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
fallout.create_external_var("vault_door_ptr")

local new_obj = 0
local Overseer_ptr = 0

local Lighting
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
    if fallout.metarule(14, 0) then
        fallout.override_map_start(90, 88, 0, 2)
        base_inventory()
        TagInven()
        Darkness()
    else
        if fallout.global_var(18) and fallout.global_var(17) and (endgame_running == 0) then
            endgame_part1()
        else
            fallout.override_map_start(136, 129, 0, 1)
            if fallout.global_var(154) <= 0 then
                fallout.set_global_var(11, 1)
            end
            Darkness()
        end
    end
    add_party()
end

function map_update_p_proc()
    if endgame_running == 1 then
        endgame_part2()
    else
        if endgame_running == 2 then
            endgame_part3()
        end
    end
end

function map_exit_p_proc()
    remove_party()
end

function Darkness()
    fallout.set_light_level(40)
end

function cheat_mode()
    new_obj = fallout.create_object_sid(3, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(12, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(36, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(36, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(36, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(54, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(30, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    fallout.override_map_start(90, 88, 0, 2)
end

function cheat2()
    new_obj = fallout.create_object_sid(117, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(3, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(116, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(9, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(36, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(36, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(36, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(38, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(38, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(109, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(109, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(77, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(84, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(120, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(162, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(163, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(163, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(87, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(87, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(25, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(25, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(25, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(26, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(26, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(26, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(7, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(51, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), new_obj, 5)
    new_obj = fallout.create_object_sid(41, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), new_obj, 5000)
end

function TagInven()
    if ((fallout.has_skill(fallout.dude_obj(), 9) - ((fallout.get_critter_stat(fallout.dude_obj(), 1) + fallout.get_critter_stat(fallout.dude_obj(), 5)) // 2) - 20 + (fallout.has_trait(2, fallout.dude_obj(), 15) * 10)) >= 20) or ((fallout.has_skill(fallout.dude_obj(), 10) - fallout.get_critter_stat(fallout.dude_obj(), 5) - 20 + (fallout.has_trait(2, fallout.dude_obj(), 15) * 10)) >= 20) then
        new_obj = fallout.create_object_sid(84, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    end
    if (fallout.has_skill(fallout.dude_obj(), 3) - ((fallout.get_critter_stat(fallout.dude_obj(), 5) + fallout.get_critter_stat(fallout.dude_obj(), 0)) // 2) - 65 + (fallout.has_trait(2, fallout.dude_obj(), 15) * 10) + (fallout.has_trait(2, fallout.dude_obj(), 10) * 10)) >= 20 then
        new_obj = fallout.create_object_sid(21, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    end
    if (fallout.has_skill(fallout.dude_obj(), 6) - ((fallout.get_critter_stat(fallout.dude_obj(), 1) + fallout.get_critter_stat(fallout.dude_obj(), 4)) // 2) - 30 - (fallout.has_trait(2, fallout.dude_obj(), 10) * 20) + (fallout.has_trait(2, fallout.dude_obj(), 15) * 10) - (fallout.has_trait(2, fallout.dude_obj(), 10) * 15)) >= 20 then
        new_obj = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), new_obj, 2)
    end
    if (fallout.has_skill(fallout.dude_obj(), 7) - ((fallout.get_critter_stat(fallout.dude_obj(), 1) + fallout.get_critter_stat(fallout.dude_obj(), 4)) // 2) - 15 - (fallout.has_trait(2, fallout.dude_obj(), 10) * 20) + (fallout.has_trait(2, fallout.dude_obj(), 15) * 10) - (fallout.has_trait(2, fallout.dude_obj(), 10) * 15)) >= 20 then
        new_obj = fallout.create_object_sid(47, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    end
    if (fallout.has_skill(fallout.dude_obj(), 0) - fallout.get_critter_stat(fallout.dude_obj(), 5) - 35 + (fallout.has_trait(2, fallout.dude_obj(), 10) * 10) + (fallout.has_trait(2, fallout.dude_obj(), 15) * 10)) >= 20 then
        new_obj = fallout.create_object_sid(29, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    end
    if (fallout.has_skill(fallout.dude_obj(), 5) - fallout.get_critter_stat(fallout.dude_obj(), 5) - 40 + (fallout.has_trait(2, fallout.dude_obj(), 10) * 10) + (fallout.has_trait(2, fallout.dude_obj(), 15) * 10)) >= 20 then
        new_obj = fallout.create_object_sid(45, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), new_obj, 2)
    end
    if (fallout.has_skill(fallout.dude_obj(), 13) - fallout.get_critter_stat(fallout.dude_obj(), 4) - 20 + (fallout.has_trait(2, fallout.dude_obj(), 15) * 10)) >= 20 then
        new_obj = fallout.create_object_sid(75, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    end
    if (fallout.has_skill(fallout.dude_obj(), 17) - ((fallout.get_critter_stat(fallout.dude_obj(), 4) + fallout.get_critter_stat(fallout.dude_obj(), 2)) // 2) - 5 + (fallout.has_trait(2, fallout.dude_obj(), 15) * 10)) >= 20 then
        new_obj = fallout.create_object_sid(126, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), new_obj, 3)
    end
    if (fallout.has_skill(fallout.dude_obj(), 12) - (2 * fallout.get_critter_stat(fallout.dude_obj(), 4)) - 25 - (fallout.has_trait(2, fallout.dude_obj(), 15) * 10)) >= 20 then
        new_obj = fallout.create_object_sid(53, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), new_obj, 2)
        new_obj = fallout.create_object_sid(87, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), new_obj, 2)
    end
end

function NamedInven()
    if fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) == "Max Stone" then
        new_obj = fallout.create_object_sid(30, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
        new_obj = fallout.create_object_sid(21, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    end
    if fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) == "Natalia" then
        new_obj = fallout.create_object_sid(45, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
        new_obj = fallout.create_object_sid(84, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    end
    if fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) == "Albert" then
        new_obj = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
        new_obj = fallout.create_object_sid(53, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    end
end

function base_inventory()
    new_obj = fallout.create_object_sid(4, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(8, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(29, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(29, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(79, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
    new_obj = fallout.create_object_sid(79, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), new_obj)
end

function endgame_part1()
    fallout.kill_critter_type(16777264, 0)
    fallout.set_light_level(100)
    fallout.override_map_start(90, 96, 0, 5)
    fallout.set_global_var(299, 1)
    fallout.endgame_slideshow()
    fallout.gfade_out(1)
    endgame_running = 2
end

function endgame_part2()
    endgame_running = 2
end

function endgame_part3()
    local v0 = 0
    if fallout.global_var(299) == 0 then
        v0 = fallout.create_object_sid(16777263, 0, 0, 55)
        fallout.set_map_var(0, v0)
        fallout.anim(v0, 1000, 2)
        fallout.critter_attempt_placement(v0, 18290, fallout.elevation(fallout.dude_obj()))
        fallout.add_timer_event(fallout.dude_obj(), 10, 5)
        endgame_running = 3
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
