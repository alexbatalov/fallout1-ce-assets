local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start

fallout.create_external_var("Front_Door_Ptr")

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

function start()
    if fallout.script_action() == 15 then
        fallout.set_global_var(578, 1)
        if time.game_time_in_days() >= fallout.global_var(150) then
            fallout.set_global_var(14, 1)
        end
        light.lighting()
        party_elevation = party.add_party()
        fallout.override_map_start(94, 88, 0, 2)
    else
        if fallout.script_action() == 23 then
            light.lighting()
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
