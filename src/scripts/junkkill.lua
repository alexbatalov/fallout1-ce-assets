local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")

local start

local party_elevation = 0
local dude_start_hex = 0

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

local item = 0
local Kenji_ptr = 0

function start()
    local v0 = 0
    if fallout.script_action() == 15 then
        fallout.set_global_var(570, 1)
        light.lighting()
        fallout.override_map_start(99, 113, 0, 0)
        party_elevation = party.add_party()
        if fallout.map_var(7) == 1 then
            fallout.display_msg(fallout.message_str(338, fallout.random(139, 140)))
        end
    else
        if fallout.script_action() == 23 then
            light.lighting()
            if fallout.external_var("award") and not(fallout.map_var(4)) and (fallout.global_var(143) == 2) then
                fallout.display_msg(fallout.message_str(338, 175) .. fallout.external_var("award") .. fallout.message_str(338, 176))
                fallout.give_exp_points(fallout.external_var("award"))
                fallout.set_map_var(4, 1)
            end
            if (fallout.global_var(37) == 1) and (fallout.global_var(349) == 0) then
                fallout.display_msg(fallout.message_str(47, 269))
                fallout.give_exp_points(600)
                fallout.set_global_var(155, fallout.global_var(155) - 5)
                fallout.set_global_var(349, 1)
            end
            if fallout.external_var("removal_ptr") then
                fallout.destroy_object(fallout.external_var("removal_ptr"))
                fallout.set_external_var("removal_ptr", 0)
            end
        else
            if fallout.script_action() == 16 then
                party.remove_party()
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
