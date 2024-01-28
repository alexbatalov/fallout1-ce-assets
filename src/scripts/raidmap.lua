local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")

fallout.create_external_var("women_killed")
fallout.create_external_var("signal_women")
fallout.create_external_var("killing_women")
fallout.create_external_var("Garls_Inven_Ptr")
fallout.create_external_var("Cell_Door_Ptr")

fallout.set_external_var("women_killed", 0)
fallout.set_external_var("signal_women", 0)
fallout.set_external_var("killing_women", 0)
fallout.set_external_var("Garls_Inven_Ptr", nil)
fallout.set_external_var("Cell_Door_Ptr", nil)

local start
local map_enter_p_proc
local map_exit_p_proc
local map_update_p_proc

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
    light.lighting()
    fallout.set_global_var(69, 2)
    if misc.map_first_run() then
        fallout.display_msg(fallout.message_str(194, 103))
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            if fallout.get_critter_stat(fallout.dude_obj(), 6) > 8 and fallout.random(0, 1) ~= 0 then
                fallout.set_global_var(116, 1)
            end
        end
    end
    if not misc.is_loading_game() then
        if fallout.global_var(114) == 1 and fallout.global_var(115) <= 12 or fallout.global_var(115) <= 6 then
            fallout.kill_critter_type(16777254, 0)
            fallout.kill_critter_type(16777235, 0)
            fallout.kill_critter_type(16777233, 0)
            fallout.kill_critter_type(16777248, 0)
            fallout.kill_critter_type(16777249, 0)
            fallout.kill_critter_type(16777243, 0)
            fallout.kill_critter_type(16777236, 0)
            fallout.kill_critter_type(16777247, 0)
            fallout.kill_critter_type(16777238, 0)
            fallout.kill_critter_type(16777253, 0)
            fallout.kill_critter_type(16777218, 0)
            fallout.kill_critter_type(16777248, 0)
        end
    end
    if fallout.global_var(32) == 1 then
        fallout.override_map_start(96, 133, 0, 5)
    else
        fallout.override_map_start(96, 133, 0, 5)
    end
    party_elevation = party.add_party()
end

function map_exit_p_proc()
    if fallout.global_var(26) == 5 and fallout.map_var(1) ~= 1 then
        fallout.set_map_var(1, 1)
        fallout.set_global_var(26, 5)
        fallout.set_global_var(103, 2)
        local temp = (16 - fallout.global_var(115)) * 50
        if temp < 500 then
            temp = 500 - temp
            fallout.display_msg(fallout.message_str(238, 100) .. temp .. fallout.message_str(238, 101))
            fallout.set_global_var(155, fallout.global_var(155) + 1)
            fallout.give_exp_points(temp)
        else
            temp = 0
            fallout.set_global_var(155, fallout.global_var(155) + 1)
            fallout.display_msg(fallout.message_str(238, 100) .. temp .. fallout.message_str(238, 101))
        end
    end
    if fallout.global_var(114) == 1 and fallout.global_var(115) <= 8 or fallout.global_var(115) <= 4 then
        fallout.kill_critter_type(16777254, 0)
        fallout.kill_critter_type(16777235, 0)
        fallout.kill_critter_type(16777233, 0)
        fallout.kill_critter_type(16777248, 0)
        fallout.kill_critter_type(16777249, 0)
        fallout.kill_critter_type(16777243, 0)
        fallout.kill_critter_type(16777236, 0)
        fallout.kill_critter_type(16777247, 0)
        fallout.kill_critter_type(16777238, 0)
        fallout.kill_critter_type(16777253, 0)
        fallout.kill_critter_type(16777218, 0)
    end
end

function map_update_p_proc()
    light.lighting()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
