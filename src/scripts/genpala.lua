local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc

local hostile = 0
local initialized = false
local round_counter = 0
local scared = 0

function start()
    if not initialized then
        misc.set_team(fallout.self_obj(), 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
        hostile = fallout.global_var(334)
        initialized = true
    else
        if fallout.script_action() == 13 then
            combat_p_proc()
        else
            if fallout.script_action() == 12 then
                critter_p_proc()
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

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
        if fallout.get_critter_stat(fallout.self_obj(), 35) < 10 then
            scared = 1
        end
    end
end

function critter_p_proc()
    if scared then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
            behaviour.flee_dude(1)
        end
    else
        if hostile then
            hostile = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_external_var("random_seed_1", 1)
        reputation.inc_good_critter()
        fallout.set_global_var(250, 1)
    end
end

function pickup_p_proc()
    if not(scared) then
        hostile = 1
        fallout.set_global_var(334, 1)
    end
end

function talk_p_proc()
    if reputation.has_rep_berserker() then
        fallout.set_global_var(156, 1)
        fallout.set_global_var(157, 0)
    end
    if scared then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(758, 101), 2)
    else
        if (fallout.global_var(250) == 1) or (fallout.external_var("random_seed_1") == 1) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(758, 100), 2)
            fallout.set_global_var(334, 1)
            hostile = 1
        else
            if fallout.global_var(45) == 2 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(758, 102), 4)
            else
                if (fallout.global_var(155) < -20) or (reputation.has_rep_berserker()) or (fallout.global_var(158) > 2) then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(758, 104), 2)
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(758, 103), 3)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
