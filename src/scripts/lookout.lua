local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local spies
local guilt
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 31)
        misc.set_ai(self_obj, 41)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function spies()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(109, 101), 0)
end

function guilt()
    if fallout.random(0, 1) ~= 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(109, 200), 0)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(109, 201), 0)
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.global_var(30) == 1 and fallout.global_var(31) ~= 2 then
        guilt()
    else
        spies()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(0) == 0 then
            if fallout.global_var(30) == 1 and fallout.global_var(31) ~= 2 then
                local self_obj = fallout.self_obj()
                local dude_obj = fallout.dude_obj()
                if fallout.obj_can_see_obj(self_obj, dude_obj) and fallout.tile_distance_objs(self_obj, dude_obj) < 5 then
                    fallout.set_local_var(0, 1)
                    guilt()
                end
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(109, 100))
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
