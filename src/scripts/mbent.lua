local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start

fallout.create_external_var("Team9_Count")
fallout.set_external_var("Team9_Count", 4)
fallout.create_external_var("radio_trick")
fallout.create_external_var("ignoring_dude")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("know_door_code")
fallout.create_external_var("comptroller_status")

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

local radio_kludge

function start()
    if fallout.script_action() == 15 then
        fallout.set_global_var(78, 2)
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 109))
        end
        fallout.set_external_var("radio_trick", fallout.map_var(0))
        fallout.set_external_var("know_door_code", fallout.map_var(1))
        light.lighting()
        if fallout.global_var(32) == 0 then
            fallout.override_map_start(133, 111, 0, 5)
        else
            if fallout.global_var(32) == 1 then
                fallout.override_map_start(73, 107, 0, 2)
            else
                fallout.override_map_start(133, 111, 0, 5)
            end
        end
        party_elevation = party.add_party()
    else
        if fallout.script_action() == 23 then
            light.lighting()
            if fallout.global_var(147) ~= 0 then
                fallout.display_msg(fallout.message_str(443, 103) .. (300 - (time.game_time_in_seconds() - fallout.global_var(147))) .. fallout.message_str(443, 104))
                if (time.game_time_in_seconds() - fallout.global_var(147)) >= 300 then
                    fallout.play_gmovie(3)
                    fallout.metarule(13, 0)
                end
            end
            if fallout.external_var("removal_ptr") ~= 0 then
                fallout.destroy_object(fallout.external_var("removal_ptr"))
                fallout.set_external_var("removal_ptr", 0)
            end
        else
            if fallout.script_action() == 16 then
                fallout.set_map_var(0, fallout.external_var("radio_trick"))
                party.remove_party()
            end
        end
    end
end

function radio_kludge()
    local v0 = 0
    local v1 = 0
    v0 = fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 100)
    if v0 > 0 then
        v1 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 100)
        v1 = fallout.destroy_mult_objs(v1, v0)
        v1 = fallout.create_object_sid(100, 0, 0, 361)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), v1, v0)
    end
end

local exports = {}
exports.start = start
return exports
