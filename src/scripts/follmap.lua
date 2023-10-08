local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

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

local Player_Elevation = 0
local dude_carrying_bomb = 0

fallout.create_external_var("removal_ptr")

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
        fallout.display_msg(fallout.message_str(194, 114))
    end
    if fallout.global_var(129) == 2 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) then
            fallout.display_msg(fallout.message_str(194, 118))
        else
            fallout.display_msg(fallout.message_str(194, 117))
        end
    end
    fallout.set_global_var(595, 1)
    light.lighting()
    if time.game_time_in_days() >= fallout.global_var(148) then
        fallout.set_global_var(7, 1)
    end
    fallout.override_map_start(82, 114, 0, 5)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 72) ~= 0 then
        dude_carrying_bomb = 1
    end
end

function map_update_p_proc()
    light.lighting()
    party_elevation = party.update_party(party_elevation)
    if fallout.external_var("removal_ptr") then
        fallout.destroy_object(fallout.external_var("removal_ptr"))
        fallout.set_external_var("removal_ptr", 0)
    end
end

function map_exit_p_proc()
    if dude_carrying_bomb == 1 then
        if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 72) == 0 then
            fallout.set_global_var(129, 2)
        end
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
