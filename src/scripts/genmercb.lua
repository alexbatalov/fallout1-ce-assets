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

local dude_attacked_guards = false
local dude_attacked_raiders = false
local initialized = false
local raiders_left = 0
local rewarded = false
local scared = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 35)
        misc.set_ai(self_obj, 50)
        scared = fallout.global_var(334) ~= 0
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
    if scared and (fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < 8) then
        behaviour.flee_dude(1)
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        scared = true
        fallout.set_global_var(334, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function pickup_p_proc()
    scared = true
    fallout.set_global_var(334, 1)
end

function talk_p_proc()
    raiders_left = fallout.external_var("random_seed_1")
    dude_attacked_raiders = fallout.external_var("random_seed_2") ~= 0
    dude_attacked_guards = fallout.external_var("random_seed_3") ~= 0
    if scared then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(753, 104), 2)
    else
        if raiders_left == 0 and dude_attacked_raiders then
            if rewarded then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(753, 101), 4)
            else
                if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(753, 106), 4)
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(753, 107), 4)
                end
                rewarded = true
                fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.dude_obj())
                fallout.set_global_var(155, fallout.global_var(155) + 3)
                fallout.give_exp_points(50)
                fallout.display_msg(fallout.message_str(753, 106))
            end
        else
            if dude_attacked_guards then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(753, 103), 2)
            else
                if raiders_left ~= 0 then
                    if fallout.random(0, 1) then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(753, 105), 3)
                    else
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(753, 102), 3)
                    end
                end
            end
        end
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
