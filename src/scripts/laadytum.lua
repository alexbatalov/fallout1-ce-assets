local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc
local AddInBlades

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")
fallout.create_external_var("warned")
fallout.create_external_var("AdyStor1_ptr")
fallout.create_external_var("AdyStor2_ptr")
fallout.create_external_var("Tine_barter")
fallout.create_external_var("JonPtr")
fallout.create_external_var("InBladePtr1")
fallout.create_external_var("InBladePtr2")
fallout.create_external_var("InBladePtr3")
fallout.create_external_var("InBladePtr4")
fallout.create_external_var("InBladePtr5")
fallout.create_external_var("InBladePtr6")
fallout.create_external_var("InBladePtr7")
fallout.create_external_var("InBladePtr8")
fallout.create_external_var("RazorPtr")
fallout.create_external_var("RegGuard1")
fallout.create_external_var("RegGuard2")

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
        fallout.display_msg(fallout.message_str(194, 115))
    end
    fallout.set_global_var(594, 1)
    light.lighting()
    fallout.override_map_start(100, 53, 0, 2)
    party_elevation = party.add_party()
end

function map_update_p_proc()
    if fallout.elevation(fallout.dude_obj()) == 1 then
        light.darkness()
    else
        light.lighting()
    end
    party_elevation = party.add_party()
    if (fallout.global_var(613) == 9103) and (fallout.map_var(2) == 0) and (fallout.global_var(266) == 1) then
        AddInBlades()
        fallout.gfade_in(600)
    else
        if (fallout.global_var(613) == 9104) and (fallout.map_var(2) == 0) then
            fallout.set_map_var(2, 1)
            fallout.kill_critter(fallout.external_var("JonPtr"), 0)
            fallout.kill_critter_type(16777216 + 3, 0)
            fallout.kill_critter_type(16777216 + 27, 0)
            fallout.kill_critter_type(16777216 + 36, 0)
            fallout.kill_critter_type(16777216 + 112, 0)
            fallout.kill_critter_type(16777216 + 215, 0)
            fallout.kill_critter_type(16777216 + 244, 0)
            fallout.kill_critter_type(16777216 + 245, 0)
            fallout.kill_critter_type(16777216 + 246, 0)
            fallout.kill_critter_type(16777216 + 247, 0)
            fallout.kill_critter_type(16777216 + 248, 0)
            fallout.kill_critter_type(16777216 + 249, 0)
            fallout.kill_critter_type(16777216 + 250, 0)
            fallout.kill_critter_type(16777216 + 251, 0)
            fallout.kill_critter_type(16777216 + 252, 0)
            fallout.kill_critter_type(16777216 + 253, 0)
            fallout.kill_critter_type(16777216 + 254, 0)
            fallout.kill_critter_type(16777216 + 255, 0)
            fallout.kill_critter_type(16777216 + 256, 0)
            fallout.kill_critter_type(16777216 + 257, 0)
            fallout.kill_critter_type(16777216 + 258, 0)
            fallout.kill_critter_type(16777216 + 259, 0)
            fallout.kill_critter_type(16777216 + 260, 0)
            fallout.kill_critter_type(16777216 + 261, 0)
            fallout.kill_critter_type(16777216 + 262, 0)
            fallout.kill_critter_type(16777216 + 263, 0)
            fallout.critter_attempt_placement(fallout.external_var("RazorPtr"), 12700, 0)
            fallout.set_global_var(613, 2)
            fallout.set_global_var(155, fallout.global_var(155) + 2)
            fallout.display_msg(fallout.message_str(766, 103) .. 2000 .. fallout.message_str(766, 104))
            fallout.give_exp_points(2000)
        else
            if (fallout.map_var(1) == 0) and (fallout.global_var(613) == 9103) then
                fallout.gfade_out(600)
                fallout.kill_critter_type(16777216 + 268, 0)
                fallout.critter_attempt_placement(fallout.external_var("RazorPtr"), 12700, 0)
                fallout.set_global_var(613, 2)
                fallout.set_global_var(352, 1)
                fallout.set_global_var(155, fallout.global_var(155) + 2)
                fallout.display_msg(fallout.message_str(766, 103) .. 2000 .. fallout.message_str(766, 104))
                fallout.give_exp_points(2000)
                fallout.gfade_in(600)
            else
                if (fallout.map_var(1) == 0) and (fallout.global_var(613) ~= 2) and (fallout.global_var(351) == 1) then
                    fallout.set_global_var(613, 2)
                    fallout.set_global_var(350, 1)
                end
            end
        end
    end
end

function map_exit_p_proc()
    party.remove_party()
end

function AddInBlades()
    fallout.set_map_var(2, 1)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr1"), 9702, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr2"), 9700, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr3"), 9698, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr4"), 9895, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr5"), 9696, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr6"), 26717, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr7"), 26711, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr8"), 24492, 0)
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
