local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start
local combat_p_proc
local Tandi_Move

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

function start()
    if fallout.script_action() == 15 then
        fallout.set_global_var(568, 1)
        fallout.set_global_var(567, 1)
        if time.game_time_in_days() >= fallout.global_var(153) then
            fallout.set_global_var(12, 1)
        end
        light.lighting()
        if fallout.global_var(32) == 3 then
            fallout.override_map_start(76, 85, 0, 1)
        else
            if fallout.global_var(32) == 2 then
                fallout.override_map_start(104, 93, 0, 1)
            else
                fallout.override_map_start(104, 93, 0, 1)
            end
        end
        party_elevation = party.add_party()
    else
        if fallout.script_action() == 23 then
            light.lighting()
        else
            if fallout.script_action() == 16 then
                party.remove_party()
            else
                if fallout.script_action() == 13 then
                    combat_p_proc()
                end
            end
        end
    end
end

function combat_p_proc()
    fallout.script_overrides()
    fallout.gfade_out(600)
    fallout.load_map(26, 1)
    fallout.game_time_advance(fallout.game_ticks(1800))
    fallout.gfade_in(600)
end

function Tandi_Move()
    local v0 = 0
    v0 = fallout.game_time_hour()
    if v0 == 615 then
        fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
        fallout.move_to(fallout.external_var("Tandi_ptr"), 13565, 0)
    else
        if (v0 > 615) and (v0 <= 645) then
            fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
            fallout.move_to(fallout.external_var("Tandi_ptr"), 18492, 0)
        else
            if (v0 > 645) and (v0 <= 650) then
                fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                fallout.move_to(fallout.external_var("Tandi_ptr"), 13565, 0)
            else
                if v0 == 1305 then
                    fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                    fallout.move_to(fallout.external_var("Tandi_ptr"), 13565, 0)
                else
                    if (v0 > 1305) and (v0 <= 1600) then
                        fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                        fallout.move_to(fallout.external_var("Tandi_ptr"), 23701, 0)
                    else
                        if (v0 > 1600) and (v0 <= 1900) then
                            fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                            fallout.move_to(fallout.external_var("Tandi_ptr"), 17279, 0)
                        else
                            if (v0 > 1900) and (v0 <= 1905) then
                                fallout.set_external_var("Tandi_ptr", fallout.create_object_sid(16777256, 0, 0, 57))
                                fallout.move_to(fallout.external_var("Tandi_ptr"), 13565, 0)
                            end
                        end
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
return exports
