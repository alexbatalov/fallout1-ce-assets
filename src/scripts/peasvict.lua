local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc

local initialized = false

function start()
    if not initialized and fallout.metarule(14, 0) ~= 0 then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 5, fallout.global_var(288))
        fallout.critter_add_trait(self_obj, 1, 6, 2)
        initialized = true
        fallout.float_msg(self_obj, fallout.message_str(352, fallout.random(128, 129)), 0)
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
    local dude_enemy = fallout.global_var(291)
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if dude_enemy >= 3 and fallout.tile_distance_objs(self_obj, dude_obj) < 8 then
        behaviour.flee_dude(1)
    else
        if fallout.global_var(289) <= 0 and dude_enemy < 3 and fallout.global_var(290) > 0 then
            fallout.terminate_combat()
            if fallout.global_var(292) == 0 then
                local cap_count = fallout.random(80, 120)
                if fallout.random(0, 1) ~= 0 then
                    fallout.float_msg(self_obj,
                        fallout.message_str(352, 130) .. cap_count .. fallout.message_str(352, 131), 0)
                else
                    fallout.float_msg(self_obj,
                        fallout.message_str(352, 132) .. cap_count .. fallout.message_str(352, 133), 0)
                end
                fallout.add_mult_objs_to_inven(dude_obj, fallout.create_object_sid(41, 0, 0, -1), cap_count)
                fallout.set_global_var(292, 1)
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        local dude_enemy = fallout.global_var(291)
        dude_enemy = dude_enemy + 1
        fallout.set_global_var(291, dude_enemy)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        reputation.inc_good_critter()
    end
end

function pickup_p_proc()
    local dude_enemy = fallout.global_var(291)
    dude_enemy = dude_enemy + 1
    fallout.set_global_var(291, dude_enemy)
end

function talk_p_proc()
    local dude_enemy = fallout.global_var(291)
    if dude_enemy >= 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 0)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(352, 127), 0)
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
