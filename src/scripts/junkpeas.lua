local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 24)
        fallout.critter_add_trait(self_obj, 1, 5, 6)
        if fallout.obj_is_carrying_obj_pid(self_obj, 41) == 0 then
            local item_obj = fallout.create_object_sid(41, 0, 0, -1)
            fallout.add_mult_objs_to_inven(self_obj, item_obj, fallout.random(0, 20))
        end
        if fallout.local_var(3) == 0 then
            fallout.set_local_var(3, fallout.tile_num(self_obj))
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if fallout.local_var(1) ~= 0 and fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) ~= 0 then
        behaviour.flee_dude(1)
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        fallout.set_local_var(1, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        if fallout.global_var(247) == 0 then
            fallout.set_global_var(247, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
end

function pickup_p_proc()
    fallout.set_local_var(1, 1)
    fallout.set_global_var(247, 1)
end

function talk_p_proc()
    if fallout.local_var(1) == 1 or fallout.global_var(247) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, fallout.random(101, 104))
        end
        fallout.float_msg(fallout.self_obj(), fallout.message_str(715, fallout.local_var(0)), 0)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
