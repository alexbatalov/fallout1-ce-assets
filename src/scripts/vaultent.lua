local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

local Scorp_hex = 0
local Scorp_ptr = 0
local luck = 0
local roll = 0
local new_obj = 0

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        else
            if fallout.script_action() == 16 then
                map_exit_p_proc()
            end
        end
    end
end

function map_enter_p_proc()
    if fallout.metarule(14, 0) then
        fallout.display_msg(fallout.message_str(194, 102))
    end
    fallout.set_global_var(562, 1)
    light.lighting()
    if fallout.global_var(32) == 1 then
        fallout.override_map_start(113, 96, 0, 2)
    else
        if fallout.global_var(32) == 2 then
            fallout.override_map_start(115, 105, 0, 5)
        else
            fallout.override_map_start(117, 121, 0, 5)
        end
    end
    if fallout.map_var(0) == 0 then
        fallout.set_map_var(0, 1)
        luck = fallout.get_critter_stat(fallout.dude_obj(), 6)
        roll = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
        if (luck < 4) or (roll < 8) then
            Scorp_ptr = fallout.create_object_sid(16777227, 0, 0, 12)
            Scorp_hex = 21515
            fallout.critter_attempt_placement(Scorp_ptr, Scorp_hex, 0)
            fallout.critter_add_trait(Scorp_ptr, 1, 6, 5)
        end
    end
    party_elevation = party.add_party()
end

function map_update_p_proc()
    light.lighting()
end

function map_exit_p_proc()
    party.remove_party()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
