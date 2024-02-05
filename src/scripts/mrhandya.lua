local fallout = require("fallout")
local misc = require("lib.misc")

local start
local critter_p_proc
local description_p_proc
local use_skill_on_p_proc
local Repair_Attempt

local hostile = false
local initialized = false

function start()
    local self_obj = fallout.self_obj()
    if not initialized then
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 71)
        initialized = true
    end
    if fallout.global_var(273) == 2 then
        misc.set_team(self_obj, 85)
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.global_var(275) == 0 then
        if fallout.critter_state(self_obj) & 64 == 0 then
            fallout.critter_injure(self_obj, 64)
        end
    end
    if fallout.global_var(274) ~= 0 then
        if fallout.critter_state(self_obj) & 4 == 0 then
            fallout.critter_injure(self_obj, 4)
        end
    end
    if fallout.global_var(274) == 2 then
        if fallout.critter_state(self_obj) & 8 == 0 then
            fallout.critter_injure(self_obj, 8)
        end
    end
    if fallout.global_var(146) == 1 then
        if fallout.global_var(273) == 0 then
            if fallout.obj_can_see_obj(self_obj, dude_obj) then
                hostile = true
            end
        elseif fallout.global_var(273) == 1 then
            local valid_target_obj = fallout.external_var("valid_target")
            if fallout.obj_can_see_obj(self_obj, valid_target_obj) then
                fallout.attack(valid_target_obj, 0, 1, 0, 0, 30000, 0, 0)
            end
        elseif fallout.global_var(273) == 2 then
            local valid_target_obj = fallout.external_var("valid_target")
            if fallout.obj_can_see_obj(self_obj, valid_target_obj) then
                fallout.attack(valid_target_obj, 0, 1, 0, 0, 30000, 0, 0)
            end
        elseif fallout.global_var(273) == 3 then
            if fallout.obj_can_see_obj(self_obj, dude_obj) then
                hostile = true
            else
                local valid_target_obj = fallout.external_var("valid_target")
                if fallout.obj_can_see_obj(self_obj, valid_target_obj) then
                    fallout.attack(valid_target_obj, 0, 1, 0, 0, 30000, 0, 0)
                end
            end
        end
        fallout.animate_move_obj_to_tile(self_obj,
            fallout.tile_num_in_direction(fallout.tile_num(self_obj), fallout.random(0, 5),
                fallout.random(1, 3)), 0)
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        fallout.display_msg(fallout.message_str(365, 100))
    else
        fallout.display_msg(fallout.message_str(365, 101))
    end
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    if skill == 13 then
        if fallout.local_var(0) == 0 then
            Repair_Attempt()
        end
    elseif skill == 10 then
        fallout.script_overrides()
    end
end

function Repair_Attempt()
    fallout.game_time_advance(fallout.game_ticks(1200))
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 13, 0)
    if fallout.local_var(1) == 0 and fallout.is_success(roll) then
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
