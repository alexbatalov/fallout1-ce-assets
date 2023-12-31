local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start

fallout.create_external_var("Master_Ptr")
fallout.create_external_var("Red_Door_Ptr")
fallout.create_external_var("Black_Door_Ptr")
fallout.create_external_var("Laura_Ptr")
fallout.create_external_var("Shop_Ptr")
fallout.create_external_var("Shopkepper_Ptr")

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

local Player_Elevation = 0
local cur_count = 0
local prev_count = 0

function start()
    if fallout.script_action() == 15 then
        light.lighting()
        fallout.set_global_var(77, 2)
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 110))
        end
        Player_Elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(32) == 0 then
            fallout.override_map_start(100, 102, 0, 5)
        else
            if fallout.global_var(32) == 2 then
                fallout.override_map_start(100, 86, 0, 2)
            else
                if fallout.global_var(32) == 1 then
                    fallout.override_map_start(99, 113, 1, 5)
                else
                    if fallout.global_var(32) == 3 then
                        fallout.override_map_start(96, 63, 1, 1)
                    else
                        if fallout.global_var(32) == 4 then
                            fallout.override_map_start(85, 63, 1, 4)
                        else
                            fallout.override_map_start(100, 102, 0, 5)
                        end
                    end
                end
            end
        end
        party_elevation = party.add_party()
    end
    if fallout.script_action() == 23 then
        light.lighting()
        if fallout.elevation(fallout.dude_obj()) == 1 then
            fallout.set_global_var(600, 1)
        end
        if fallout.global_var(55) ~= 0 then
            cur_count = 240 - (time.game_time_in_seconds() - fallout.global_var(55))
            if cur_count ~= prev_count then
                fallout.display_msg(fallout.message_str(447, 100) .. cur_count .. fallout.message_str(447, 101))
                prev_count = cur_count
            end
            if (time.game_time_in_seconds() - fallout.global_var(55)) > 240 then
                fallout.display_msg(fallout.message_str(444, 106))
                fallout.play_gmovie(4)
                fallout.metarule(13, 0)
            end
        end
        party_elevation = party.update_party(party_elevation)
    end
    if fallout.script_action() == 16 then
        party.remove_party()
    end
end

local exports = {}
exports.start = start
return exports
