local fallout = require("fallout")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local timed_event_p_proc
local use_skill_on_p_proc

local critter_tile = 0
local hostile = 0
local initialized = 0

function start()
    if fallout.script_action() == 13 then
        combat_p_proc()
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 8 then
                    use_skill_on_p_proc()
                end
            end
        end
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 2 then
        if fallout.target_obj() == fallout.dude_obj() then
            if not(fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, -1))) then
                fallout.poison(fallout.target_obj(), fallout.random(1, 6))
            end
        end
    end
end

function critter_p_proc()
    local v0 = 0
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 14)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 5)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 5)), 1)
        initialized = 1
    else
        if hostile then
            hostile = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) <= 2 then
                if fallout.has_trait(0, fallout.dude_obj(), 44) == 0 then
                    hostile = 1
                end
            end
        end
    end
end

function destroy_p_proc()
    local v0 = 0
    if fallout.cur_map_index() == 83 then
        fallout.set_global_var(2, fallout.global_var(2) - 1)
        if fallout.global_var(2) < 0 then
            fallout.set_global_var(2, 0)
        end
    end
    v0 = fallout.create_object_sid(92, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.self_obj(), v0)
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function timed_event_p_proc()
    if not(fallout.combat_is_initialized()) then
        critter_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), 3)
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), critter_tile, -1)
        fallout.reg_anim_func(3, 0)
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
    end
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
