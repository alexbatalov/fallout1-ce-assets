local fallout = require("fallout")
local light = require("lib.light")
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
fallout.create_external_var("raider_dead")
fallout.create_external_var("Sinthia_dead")
fallout.create_external_var("award")
fallout.create_external_var("assassin_seed")
fallout.create_external_var("KillSafe_ptr")
fallout.create_external_var("Killian_store1_ptr")
fallout.create_external_var("Killian_store2_ptr")
fallout.create_external_var("Killian_store3_ptr")
fallout.create_external_var("Killian_store4_ptr")
fallout.create_external_var("Killian_barter_var")
fallout.create_external_var("jail_door_ptr")
fallout.create_external_var("messing_with_fridge")
fallout.create_external_var("weapon_checked")
fallout.create_external_var("sneak_checked")
fallout.create_external_var("times_caught_sneaking")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("JTRaider_ptr")
fallout.create_external_var("Killian_ptr")
fallout.create_external_var("Neal_ptr")
fallout.create_external_var("Sinthia_ptr")
fallout.create_external_var("Trish_ptr")

fallout.set_external_var("Ian_ptr", nil)
fallout.set_external_var("Dog_ptr", nil)
fallout.set_external_var("Tycho_ptr", nil)
fallout.set_external_var("Katja_ptr", nil)
fallout.set_external_var("Tandi_ptr", nil)
fallout.set_external_var("raider_dead", 0)
fallout.set_external_var("Sinthia_dead", 0)
fallout.set_external_var("award", 0)
fallout.set_external_var("assassin_seed", 0)
fallout.set_external_var("KillSafe_ptr", nil)
fallout.set_external_var("Killian_store1_ptr", nil)
fallout.set_external_var("Killian_store2_ptr", nil)
fallout.set_external_var("Killian_store3_ptr", nil)
fallout.set_external_var("Killian_store4_ptr", nil)
fallout.set_external_var("Killian_barter_var", 0)
fallout.set_external_var("jail_door_ptr", nil)
fallout.set_external_var("messing_with_fridge", 0)
fallout.set_external_var("weapon_checked", 0)
fallout.set_external_var("sneak_checked", 0)
fallout.set_external_var("times_caught_sneaking", 0)
fallout.set_external_var("removal_ptr", nil)
fallout.set_external_var("JTRaider_ptr", nil)
fallout.set_external_var("Killian_ptr", nil)
fallout.set_external_var("Neal_ptr", nil)
fallout.set_external_var("Sinthia_ptr", nil)
fallout.set_external_var("Trish_ptr", nil)

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
    fallout.set_global_var(570, 1)
    light.lighting()
    fallout.override_map_start(99, 113, 0, 0)
    party_elevation = party.add_party()
    if fallout.map_var(7) == 1 then
        fallout.display_msg(fallout.message_str(338, fallout.random(139, 140)))
    end
end

function map_exit_p_proc()
    party.remove_party()
end

function map_update_p_proc()
    light.lighting()
    local award = fallout.external_var("award")
    if award ~= 0 and fallout.map_var(4) == 0 and fallout.global_var(143) == 2 then
        fallout.display_msg(fallout.message_str(338, 175) .. award .. fallout.message_str(338, 176))
        fallout.give_exp_points(award)
        fallout.set_map_var(4, 1)
    end
    if fallout.global_var(37) == 1 and fallout.global_var(349) == 0 then
        fallout.display_msg(fallout.message_str(47, 269))
        fallout.give_exp_points(600)
        fallout.set_global_var(155, fallout.global_var(155) - 5)
        fallout.set_global_var(349, 1)
    end
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
