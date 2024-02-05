local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local destroy_p_proc
local look_at_p_proc

local initialized = false

function start()
    local self_obj = fallout.self_obj()
    if not initialized then
        misc.set_team(self_obj, 55)
        fallout.critter_add_trait(self_obj, 1, 5, 66)
        fallout.move_to(self_obj, 0, 0)
        initialized = true
    end
    if fallout.local_var(0) == 0 then
        if fallout.map_var(4) ~= 0 then
            fallout.set_map_var(4, 0)
            fallout.set_local_var(0, 1)
            fallout.critter_attempt_placement(self_obj, 18859, 0)
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    else
        local script_action = fallout.script_action()
        if script_action == 21 then
            look_at_p_proc()
        elseif script_action == 18 then
            destroy_p_proc()
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
