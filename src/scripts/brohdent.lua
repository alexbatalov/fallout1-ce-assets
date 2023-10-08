local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local HEREBEFORE = 0

fallout.create_external_var("Door_ptr")
fallout.create_external_var("Cabbot_ptr")

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
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 107))
        end
        fallout.set_global_var(582, 1)
        if time.game_time_in_days() >= fallout.global_var(151) then
            fallout.set_global_var(16, 1)
        end
        light.lighting()
        party_elevation = party.add_party()
    end
    if fallout.script_action() == 23 then
        light.lighting()
        party_elevation = party.update_party(party_elevation)
    else
        if fallout.script_action() == 16 then
            party.remove_party()
        end
    end
end

local exports = {}
exports.start = start
return exports
