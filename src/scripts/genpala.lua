local fallout = require("fallout")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local flee_dude

local hostile = 0
local initialized = 0
local round_counter = 0
local scared = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
        hostile = fallout.global_var(334)
        initialized = 1
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
            flee_dude()
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
        if fallout.source_obj() == fallout.dude_obj() then
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                fallout.set_global_var(156, 1)
                fallout.set_global_var(157, 0)
            end
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                fallout.set_global_var(157, 1)
                fallout.set_global_var(156, 0)
            end
            fallout.set_global_var(159, fallout.global_var(159) + 1)
            if (fallout.global_var(159) % 2) == 0 then
                fallout.set_global_var(155, fallout.global_var(155) - 1)
            end
        end
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
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
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
                if (fallout.global_var(155) < -20) or (((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1))) or (fallout.global_var(158) > 2) then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(758, 104), 2)
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(758, 103), 3)
                end
            end
        end
    end
end

function flee_dude()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    while v1 < 5 do
        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)) > v2 then
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)
            v2 = fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), v0)
        end
        v1 = v1 + 1
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 1)
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
