local fallout = require("fallout")
local party = require("lib.party")
local time = require("lib.time")

local HEREBEFORE = 0
local Player_Elevation = 0

fallout.create_external_var("term1_ptr")
fallout.create_external_var("term2_ptr")
fallout.create_external_var("term3_ptr")
fallout.create_external_var("term4_ptr")
fallout.create_external_var("term5_ptr")
fallout.create_external_var("term6_ptr")
fallout.create_external_var("term7_ptr")
fallout.create_external_var("term8_ptr")
fallout.create_external_var("Vree_ptr")
fallout.create_external_var("table_ptr")

local start

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

function start()
    if fallout.script_action() == 15 then
        if time.game_time_in_days() >= fallout.global_var(151) then
            fallout.set_global_var(16, 1)
        end
        Player_Elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(32) == 4 then
            fallout.override_map_start(138, 108, 0, 5)
        else
            if fallout.global_var(32) == 5 then
                fallout.override_map_start(140, 107, 1, 5)
            else
                fallout.override_map_start(138, 108, 0, 5)
            end
        end
        party_elevation = party.add_party()
    else
        if fallout.script_action() == 23 then
            if fallout.elevation(fallout.dude_obj()) == 0 then
                fallout.set_global_var(585, 1)
            else
                fallout.set_global_var(586, 1)
            end
            party_elevation = party.update_party(party_elevation)
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
