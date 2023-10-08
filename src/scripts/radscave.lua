local fallout = require("fallout")
local party = require("lib.party")

local HEREBEFORE = 0
local time = 0

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
            fallout.display_msg(fallout.message_str(766, 189))
        end
        fallout.set_light_level(40)
        if fallout.global_var(32) == 1 then
            fallout.override_map_start(156, 106, 0, 1)
        else
            fallout.override_map_start(156, 106, 0, 1)
        end
        party_elevation = party.add_party()
    else
        if fallout.script_action() == 16 then
            fallout.game_time_advance(fallout.game_ticks(60 * 30))
            party.remove_party()
        end
    end
end

local exports = {}
exports.start = start
return exports
