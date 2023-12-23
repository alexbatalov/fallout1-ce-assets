local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc

local party_elevation = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

fallout.set_external_var("Ian_ptr", nil)
fallout.set_external_var("Dog_ptr", nil)
fallout.set_external_var("Tycho_ptr", nil)
fallout.set_external_var("Katja_ptr", nil)
fallout.set_external_var("Tandi_ptr", nil)

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 16 then
        map_exit_p_proc()
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
    elseif fallout.global_var(32) == 2 then
        fallout.override_map_start(115, 105, 0, 5)
    else
        fallout.override_map_start(117, 121, 0, 5)
    end
    if fallout.map_var(0) == 0 then
        fallout.set_map_var(0, 1)
        local luck = fallout.get_critter_stat(fallout.dude_obj(), 6)
        local roll = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
        if luck < 4 or roll < 8 then
            local scorp_obj = fallout.create_object_sid(16777227, 0, 0, 12)
            fallout.critter_attempt_placement(scorp_obj, 21515, 0)
            fallout.critter_add_trait(scorp_obj, 1, 6, 5)
        end
    end
    party_elevation = party.add_party()
end

function map_update_p_proc()
    light.lighting()
    -- FIXME: Probably missing `party.update_party`.
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
