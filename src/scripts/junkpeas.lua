local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local initialized = false

function start()
    local v0 = 0
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 24)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            v0 = fallout.create_object_sid(41, 0, 0, -1)
            fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, fallout.random(0, 20))
        end
        if fallout.local_var(3) == 0 then
            fallout.set_local_var(3, fallout.tile_num(fallout.self_obj()))
        end
        sleep_tile = 7000
        wake_time = fallout.random(610, 650)
        sleep_time = fallout.random(1710, 1750)
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 14 then
                damage_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 11 then
                            talk_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.local_var(1) and fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) then
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
    if (fallout.local_var(1) == 1) or (fallout.global_var(247) == 1) then
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
