local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc

fallout.create_external_var("InBladePtr1")
fallout.create_external_var("InBladePtr2")
fallout.create_external_var("InBladePtr3")
fallout.create_external_var("InBladePtr4")
fallout.create_external_var("InBladePtr5")
fallout.create_external_var("RazorPtr")

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

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
    if misc.map_first_run() then
        fallout.display_msg(fallout.message_str(194, 113))
    end
    fallout.set_global_var(595, 1)
    if time.game_time_in_days() >= fallout.global_var(148) then
        fallout.set_global_var(7, 1)
    end
    light.lighting()
    party_elevation = party.add_party()
end

function map_update_p_proc()
    light.lighting()
    party_elevation = party.update_party(party_elevation)
    if fallout.global_var(613) == 9104 then
        fallout.kill_critter(fallout.external_var("RazorPtr"), 0)
        fallout.gfade_in(600)
    end
end

function map_exit_p_proc()
    party.remove_party()
    if (fallout.global_var(613) == 9103) or (fallout.global_var(613) == 9102) then
        fallout.kill_critter(fallout.external_var("RazorPtr"), 0)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
