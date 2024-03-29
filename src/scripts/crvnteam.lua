local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc

local initialized = false

function start()
    if not initialized then
        misc.set_team(fallout.self_obj(), 0)
        misc.set_ai(fallout.self_obj(), 1)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
end

function destroy_p_proc()
    if fallout.obj_pid(fallout.self_obj()) == 16777420 then
        fallout.set_global_var(216, fallout.global_var(216) - 1)
    else
        fallout.set_global_var(215, 0)
    end
    reputation.inc_good_critter()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
