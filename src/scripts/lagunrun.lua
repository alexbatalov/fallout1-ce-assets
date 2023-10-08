local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")
fallout.create_external_var("get_Gabriel")
fallout.create_external_var("peaceful")
fallout.create_external_var("Locker_Ptr")
fallout.create_external_var("Being_Looted")

function start()
    if fallout.script_action() == 15 then
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 111))
        end
        fallout.set_global_var(597, 1)
        fallout.override_map_start(99, 143, 0, 5)
        if time.game_time_in_days() >= fallout.global_var(148) then
            fallout.set_global_var(7, 1)
        end
        light.lighting()
        party_elevation = party.add_party()
    else
        if fallout.script_action() == 23 then
            light.lighting()
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
