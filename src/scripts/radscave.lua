local fallout = require("fallout")
local misc = require("lib.misc")
local party = require("lib.party")

local start
local map_enter_p_proc
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
    elseif script_action == 16 then
        map_exit_p_proc()
    end
end

function map_enter_p_proc()
    if misc.map_first_run() then
        fallout.display_msg(fallout.message_str(766, 189))
    end
    fallout.set_light_level(40)
    if fallout.global_var(32) == 1 then
        fallout.override_map_start(156, 106, 0, 1)
    else
        fallout.override_map_start(156, 106, 0, 1)
    end
    party_elevation = party.add_party()
end

function map_exit_p_proc()
    fallout.game_time_advance(fallout.game_ticks(60 * 30))
    party.remove_party()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
