local fallout = require("fallout")

fallout.create_external_var("women_killed")
fallout.create_external_var("signal_women")
fallout.create_external_var("killing_women")
fallout.create_external_var("Garls_Inven_Ptr")
fallout.create_external_var("Cell_Door_Ptr")

local rndx = 0
local Tandi_hex = 0
local temp = 0

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

local Darkness
local Invasion

function start()
    if fallout.script_action() == 15 then
        Lighting()
        fallout.set_global_var(69, 2)
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 103))
            if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                if (fallout.get_critter_stat(fallout.dude_obj(), 6) > 8) and fallout.random(0, 1) then
                    fallout.set_global_var(116, 1)
                end
            end
        end
        if fallout.metarule(22, 0) == 0 then
            if (fallout.global_var(114) == 1) and (fallout.global_var(115) <= 12) or (fallout.global_var(115) <= 6) then
                fallout.kill_critter_type(16777254, 0)
                fallout.kill_critter_type(16777235, 0)
                fallout.kill_critter_type(16777233, 0)
                fallout.kill_critter_type(16777248, 0)
                fallout.kill_critter_type(16777249, 0)
                fallout.kill_critter_type(16777243, 0)
                fallout.kill_critter_type(16777236, 0)
                fallout.kill_critter_type(16777247, 0)
                fallout.kill_critter_type(16777238, 0)
                fallout.kill_critter_type(16777253, 0)
                fallout.kill_critter_type(16777218, 0)
                fallout.kill_critter_type(16777248, 0)
            end
        end
        if fallout.global_var(32) == 1 then
            fallout.override_map_start(96, 133, 0, 5)
        else
            fallout.override_map_start(96, 133, 0, 5)
        end
        add_party()
    else
        if fallout.script_action() == 23 then
            Lighting()
        else
            if fallout.script_action() == 16 then
                if (fallout.global_var(26) == 5) and (fallout.map_var(1) ~= 1) then
                    fallout.set_map_var(1, 1)
                    fallout.set_global_var(26, 5)
                    fallout.set_global_var(103, 2)
                    temp = (16 - fallout.global_var(115)) * 50
                    if temp < 500 then
                        temp = 500 - temp
                        fallout.display_msg(fallout.message_str(238, 100) .. temp .. fallout.message_str(238, 101))
                        fallout.set_global_var(155, fallout.global_var(155) + 1)
                        fallout.give_exp_points(temp)
                    else
                        temp = 0
                        fallout.set_global_var(155, fallout.global_var(155) + 1)
                        fallout.display_msg(fallout.message_str(238, 100) .. temp .. fallout.message_str(238, 101))
                    end
                end
                if (fallout.global_var(114) == 1) and (fallout.global_var(115) <= 8) or (fallout.global_var(115) <= 4) then
                    fallout.kill_critter_type(16777254, 0)
                    fallout.kill_critter_type(16777235, 0)
                    fallout.kill_critter_type(16777233, 0)
                    fallout.kill_critter_type(16777248, 0)
                    fallout.kill_critter_type(16777249, 0)
                    fallout.kill_critter_type(16777243, 0)
                    fallout.kill_critter_type(16777236, 0)
                    fallout.kill_critter_type(16777247, 0)
                    fallout.kill_critter_type(16777238, 0)
                    fallout.kill_critter_type(16777253, 0)
                    fallout.kill_critter_type(16777218, 0)
                end
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
