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

function start()
    if fallout.script_action() == 15 then
        fallout.override_map_start(129, 70, 0, 0)
        light.darkness()
        party_elevation = party.add_party()
    else
        if fallout.script_action() == 16 then
            party.remove_party()
        end
    end
end

local exports = {}
exports.start = start
return exports
