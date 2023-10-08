local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start

fallout.create_external_var("Sid_Ptr")
fallout.create_external_var("Beth_Ptr")
fallout.create_external_var("Leon_Ptr")
fallout.create_external_var("Guido_Ptr")
fallout.create_external_var("Vault_Ptr")
fallout.create_external_var("Richie_Ptr")
fallout.create_external_var("Kane_Ptr")
fallout.create_external_var("Lorenzo_Safe_Ptr")
fallout.create_external_var("Decker_Ptr")
fallout.create_external_var("Justin_Ptr")
fallout.create_external_var("Beth_Box_Ptr")
fallout.create_external_var("Mitch_Box_Ptr")
fallout.create_external_var("Fry_Stub_Ptr")

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

function start()
    if fallout.script_action() == 15 then
        fallout.set_global_var(577, 1)
        if time.game_time_in_days() >= fallout.global_var(150) then
            fallout.set_global_var(14, 1)
        end
        if fallout.global_var(32) == 3 then
            fallout.override_map_start(99, 59, 0, 2)
        end
        party_elevation = party.add_party()
        light.lighting()
    else
        if fallout.script_action() == 23 then
            if fallout.elevation(fallout.dude_obj()) == 1 then
                light.darkness()
            else
                light.lighting()
            end
            party_elevation = party.update_party(party_elevation)
            if (fallout.combat_is_initialized() == 0) and (fallout.global_var(202) == 1) and (fallout.map_var(52) == 1) and (fallout.metarule(22, 0) == 0) then
                fallout.set_map_var(52, 0)
                fallout.set_map_var(53, 1)
                fallout.gfade_out(1000)
                fallout.set_obj_visibility(fallout.external_var("Fry_Stub_Ptr"), 1)
                if fallout.global_var(221) ~= 1 then
                    fallout.move_to(fallout.external_var("Justin_Ptr"), 24064, 0)
                    fallout.critter_add_trait(fallout.external_var("Justin_Ptr"), 1, 6, 67)
                end
                fallout.move_to(fallout.dude_obj(), 24267, 0)
                if fallout.global_var(221) ~= 1 then
                    fallout.anim(fallout.external_var("Justin_Ptr"), 1000, fallout.rotation_to_tile(fallout.tile_num(fallout.external_var("Justin_Ptr")), fallout.tile_num(fallout.dude_obj())))
                    fallout.anim(fallout.dude_obj(), 1000, fallout.rotation_to_tile(fallout.tile_num(fallout.dude_obj()), fallout.tile_num(fallout.external_var("Justin_Ptr"))))
                end
                fallout.gfade_in(1000)
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
