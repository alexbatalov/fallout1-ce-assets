local fallout = require("fallout")

local start
local map_update_p_proc
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

local gear = 0

fallout.create_external_var("local recipient")
fallout.create_external_var("local getting_ration")
fallout.create_external_var("local armory_access")
fallout.create_external_var("local revolting")
fallout.set_external_var("revolting", 1)
fallout.create_external_var("local traitor")
fallout.create_external_var("local removal_ptr")
fallout.create_external_var("local SecDoor_ptr")
fallout.create_external_var("local Officer_ptr")
fallout.create_external_var("local VaultBox_ptr")
fallout.create_external_var("local WtrGrd_ptr")
fallout.create_external_var("local WtrThief_ptr")

function start()
    if fallout.script_action() == 15 then
        if fallout.global_var(154) <= 0 then
            fallout.set_global_var(11, 1)
        end
        if fallout.global_var(18) and fallout.global_var(17) then
            fallout.load_map(35, 0)
        end
        if fallout.metarule(14, 0) then
            if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                fallout.set_external_var("Officer_ptr", fallout.create_object_sid(16777271, 22093, 2, 178))
            else
                fallout.set_external_var("Officer_ptr", fallout.create_object_sid(16777272, 22093, 2, 178))
            end
            gear = fallout.create_object_sid(8, 0, 0, -1)
            fallout.add_obj_to_inven(fallout.external_var("Officer_ptr"), gear)
            fallout.wield_obj_critter(fallout.external_var("Officer_ptr"), gear)
            gear = fallout.create_object_sid(40, 0, 0, -1)
            fallout.add_obj_to_inven(fallout.external_var("Officer_ptr"), gear)
            gear = fallout.create_object_sid(30, 0, 0, -1)
            fallout.add_obj_to_inven(fallout.external_var("Officer_ptr"), gear)
            fallout.critter_attempt_placement(fallout.external_var("Officer_ptr"), 22093, 2)
            fallout.anim(fallout.external_var("Officer_ptr"), 1000, 2)
        end
        if fallout.global_var(32) == 1 then
            fallout.override_map_start(104, 70, 0, 2)
        else
            if fallout.global_var(32) == 2 then
                fallout.override_map_start(104, 112, 1, 2)
            else
                if fallout.global_var(32) == 3 then
                    fallout.override_map_start(112, 86, 2, 2)
                else
                    fallout.override_map_start(96, 82, 0, 5)
                end
            end
        end
        fallout.set_light_level(100)
        add_party()
        fallout.set_external_var("armory_access", fallout.map_var(1))
        fallout.set_external_var("revolting", fallout.map_var(2))
        fallout.set_external_var("traitor", fallout.map_var(3))
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        else
            if fallout.script_action() == 16 then
                if fallout.global_var(188) == 2 then
                    if fallout.external_var("WtrThief_ptr") then
                        fallout.destroy_object(fallout.external_var("WtrThief_ptr"))
                    end
                end
                remove_party()
                fallout.set_map_var(1, fallout.external_var("armory_access"))
                fallout.set_map_var(2, fallout.external_var("revolting"))
                fallout.set_map_var(3, fallout.external_var("traitor"))
            end
        end
    end
end

function map_update_p_proc()
    update_party()
    if fallout.external_var("removal_ptr") ~= 0 then
        fallout.destroy_object(fallout.external_var("removal_ptr"))
        fallout.set_external_var("removal_ptr", 0)
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

local exports = {}
exports.start = start
exports.map_update_p_proc = map_update_p_proc
return exports
