local fallout = require("fallout")

local start
local critter_p_proc
local description_p_proc
local use_skill_on_p_proc
local Repair_Attempt

local hostile = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 71)
        initialized = true
    end
    if fallout.global_var(273) == 2 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 85)
    end
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 3 then
            description_p_proc()
        else
            if fallout.script_action() == 8 then
                use_skill_on_p_proc()
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.global_var(275) == 0 then
        if (fallout.critter_state(fallout.self_obj()) & 64) == 0 then
            fallout.critter_injure(fallout.self_obj(), 64)
        end
    end
    if fallout.global_var(274) ~= 0 then
        if (fallout.critter_state(fallout.self_obj()) & 4) == 0 then
            fallout.critter_injure(fallout.self_obj(), 4)
        end
    end
    if fallout.global_var(274) == 2 then
        if (fallout.critter_state(fallout.self_obj()) & 8) == 0 then
            fallout.critter_injure(fallout.self_obj(), 8)
        end
    end
    if fallout.global_var(146) == 1 then
        if fallout.global_var(273) == 0 then
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                hostile = 1
            end
        else
            if fallout.global_var(273) == 1 then
                if fallout.obj_can_see_obj(fallout.self_obj(), fallout.external_var("valid_target")) then
                    fallout.attack(fallout.external_var("valid_target"), 0, 1, 0, 0, 30000, 0, 0)
                end
            else
                if fallout.global_var(273) == 2 then
                    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.external_var("valid_target")) then
                        fallout.attack(fallout.external_var("valid_target"), 0, 1, 0, 0, 30000, 0, 0)
                    end
                else
                    if fallout.global_var(273) == 3 then
                        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                            hostile = 1
                        else
                            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.external_var("valid_target")) then
                                fallout.attack(fallout.external_var("valid_target"), 0, 1, 0, 0, 30000, 0, 0)
                            end
                        end
                    end
                end
            end
        end
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(1, 3)), 0)
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) then
        fallout.display_msg(fallout.message_str(365, 100))
    else
        fallout.display_msg(fallout.message_str(365, 101))
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 13 then
        if fallout.local_var(0) == 0 then
            Repair_Attempt()
        end
    else
        if fallout.action_being_used() == 10 then
            fallout.script_overrides()
        end
    end
end

function Repair_Attempt()
    local v0 = 0
    fallout.game_time_advance(fallout.game_ticks(1200))
    v0 = fallout.roll_vs_skill(fallout.dude_obj(), 13, 0)
    if not(fallout.local_var(1)) and fallout.is_success(v0) then
        fallout.display_msg(fallout.message_str(365, 102))
        fallout.set_local_var(0, 1)
    else
        fallout.display_msg(fallout.message_str(365, 103))
        fallout.set_local_var(1, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
