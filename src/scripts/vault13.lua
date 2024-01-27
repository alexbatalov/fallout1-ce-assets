local fallout = require("fallout")
local misc = require("lib.misc")
local party = require("lib.party")

local start
local map_enter_p_proc
local map_exit_p_proc
local map_update_p_proc

local party_elevation = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

fallout.set_external_var("Ian_ptr", nil)
fallout.set_external_var("Dog_ptr", nil)
fallout.set_external_var("Tycho_ptr", nil)
fallout.set_external_var("Katja_ptr", nil)
fallout.set_external_var("Tandi_ptr", nil)

fallout.create_external_var("recipient")
fallout.create_external_var("getting_ration")
fallout.create_external_var("armory_access")
fallout.create_external_var("revolting")
fallout.set_external_var("revolting", 1)
fallout.create_external_var("traitor")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("SecDoor_ptr")
fallout.create_external_var("Officer_ptr")
fallout.create_external_var("VaultBox_ptr")
fallout.create_external_var("WtrGrd_ptr")
fallout.create_external_var("WtrThief_ptr")

fallout.set_external_var("recipient", nil)
fallout.set_external_var("getting_ration", 0)
fallout.set_external_var("armory_access", 0)
fallout.set_external_var("traitor", 0)
fallout.set_external_var("removal_ptr", nil)
fallout.set_external_var("SecDoor_ptr", nil)
fallout.set_external_var("Officer_ptr", nil)
fallout.set_external_var("VaultBox_ptr", nil)
fallout.set_external_var("WtrGrd_ptr", nil)
fallout.set_external_var("WtrThief_ptr", nil)

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 16 then
        map_exit_p_proc()
    end
end

function map_enter_p_proc()
    if fallout.global_var(154) <= 0 then
        fallout.set_global_var(11, 1)
    end
    if fallout.global_var(18) ~= 0 and fallout.global_var(17) ~= 0 then
        fallout.load_map(35, 0)
    end
    if misc.map_first_run() then
        local officer_obj
        local item_obj
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            officer_obj = fallout.create_object_sid(16777271, 22093, 2, 178)
        else
            officer_obj = fallout.create_object_sid(16777272, 22093, 2, 178)
        end
        item_obj = fallout.create_object_sid(8, 0, 0, -1)
        fallout.add_obj_to_inven(officer_obj, item_obj)
        fallout.wield_obj_critter(officer_obj, item_obj)
        item_obj = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(officer_obj, item_obj)
        item_obj = fallout.create_object_sid(30, 0, 0, -1)
        fallout.add_obj_to_inven(officer_obj, item_obj)
        fallout.critter_attempt_placement(officer_obj, 22093, 2)
        fallout.anim(officer_obj, 1000, 2)
        fallout.set_external_var("Officer_ptr", officer_obj)
    end
    if fallout.global_var(32) == 1 then
        fallout.override_map_start(104, 70, 0, 2)
    elseif fallout.global_var(32) == 2 then
        fallout.override_map_start(104, 112, 1, 2)
    elseif fallout.global_var(32) == 3 then
        fallout.override_map_start(112, 86, 2, 2)
    else
        fallout.override_map_start(96, 82, 0, 5)
    end
    fallout.set_light_level(100)
    party_elevation = party.add_party()
    fallout.set_external_var("armory_access", fallout.map_var(1))
    fallout.set_external_var("revolting", fallout.map_var(2))
    fallout.set_external_var("traitor", fallout.map_var(3))
end

function map_exit_p_proc()
    if fallout.global_var(188) == 2 then
        local water_thief_obj = fallout.external_var("WtrThief_ptr")
        if water_thief_obj ~= nil then
            fallout.destroy_object(water_thief_obj)
        end
    end
    party.remove_party()
    fallout.set_map_var(1, fallout.external_var("armory_access"))
    fallout.set_map_var(2, fallout.external_var("revolting"))
    fallout.set_map_var(3, fallout.external_var("traitor"))
end

function map_update_p_proc()
    party_elevation = party.update_party(party_elevation)
    local removal_obj = fallout.external_var("removal_ptr")
    if removal_obj ~= nil then
        fallout.destroy_object(removal_obj)
        fallout.set_external_var("removal_ptr", nil)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
