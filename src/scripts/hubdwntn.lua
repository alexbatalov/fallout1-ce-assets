local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_exit_p_proc
local map_update_p_proc

fallout.create_external_var("Sid_Ptr")
fallout.create_external_var("Beth_Ptr")
fallout.create_external_var("Leon_Ptr")
fallout.create_external_var("Guido_Ptr")
fallout.create_external_var("Vault_Ptr")
fallout.create_external_var("Richie_Ptr")
fallout.create_external_var("Kane_Ptr")
fallout.create_external_var("Lorenzo_Safe_Ptr")
fallout.create_external_var("Decker_Ptr")
fallout.create_external_var("Justin_Ptr")
fallout.create_external_var("Beth_Box_Ptr")
fallout.create_external_var("Mitch_Box_Ptr")
fallout.create_external_var("Fry_Stub_Ptr")

fallout.set_external_var("Sid_Ptr", nil)
fallout.set_external_var("Beth_Ptr", nil)
fallout.set_external_var("Leon_Ptr", nil)
fallout.set_external_var("Guido_Ptr", nil)
fallout.set_external_var("Vault_Ptr", nil)
fallout.set_external_var("Richie_Ptr", nil)
fallout.set_external_var("Kane_Ptr", nil)
fallout.set_external_var("Lorenzo_Safe_Ptr", nil)
fallout.set_external_var("Decker_Ptr", nil)
fallout.set_external_var("Justin_Ptr", nil)
fallout.set_external_var("Beth_Box_Ptr", nil)
fallout.set_external_var("Mitch_Box_Ptr", nil)
fallout.set_external_var("Fry_Stub_Ptr", nil)

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
    fallout.set_global_var(577, 1)
    if time.game_time_in_days() >= fallout.global_var(150) then
        fallout.set_global_var(14, 1)
    end
    if fallout.global_var(32) == 3 then
        fallout.override_map_start(99, 59, 0, 2)
    end
    party_elevation = party.add_party()
    light.lighting()
end

function map_exit_p_proc()
    party.remove_party()
end

function map_update_p_proc()
    local dude_obj = fallout.dude_obj()
    if fallout.elevation(dude_obj) == 1 then
        light.darkness()
    else
        light.lighting()
    end
    party_elevation = party.update_party(party_elevation)
    if not fallout.combat_is_initialized()
        and fallout.global_var(202) == 1
        and fallout.map_var(52) == 1
        and not misc.is_loading_game() then
        fallout.set_map_var(52, 0)
        fallout.set_map_var(53, 1)
        fallout.gfade_out(1000)
        fallout.set_obj_visibility(fallout.external_var("Fry_Stub_Ptr"), true)
        local justin_obj = fallout.external_var("Justin_Ptr")
        if fallout.global_var(221) ~= 1 then
            fallout.move_to(justin_obj, 24064, 0)
            misc.set_team(justin_obj, 67)
        end
        fallout.move_to(dude_obj, 24267, 0)
        if fallout.global_var(221) ~= 1 then
            fallout.anim(justin_obj, 1000,
                fallout.rotation_to_tile(fallout.tile_num(justin_obj), fallout.tile_num(dude_obj)))
            fallout.anim(dude_obj, 1000,
                fallout.rotation_to_tile(fallout.tile_num(dude_obj), fallout.tile_num(justin_obj)))
        end
        fallout.gfade_in(1000)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
