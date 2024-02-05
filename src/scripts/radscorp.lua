local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local timed_event_p_proc
local use_skill_on_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 5, 14)
        misc.set_team(self_obj, 5)
        fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 5)), 1)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 2 then
        if fallout.target_obj() == fallout.dude_obj() then
            if not fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, -1)) then
                fallout.poison(fallout.target_obj(), fallout.random(1, 6))
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if fallout.has_trait(0, fallout.dude_obj(), 44) == 0 then
                hostile = true
            end
        end
    end
end

function destroy_p_proc()
    if fallout.cur_map_index() == 83 then
        fallout.set_global_var(2, fallout.global_var(2) - 1)
        if fallout.global_var(2) < 0 then
            fallout.set_global_var(2, 0)
        end
    end
    local item_obj = fallout.create_object_sid(92, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.self_obj(), item_obj)
    reputation.inc_evil_critter()
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    if not fallout.combat_is_initialized() then
        local dest = fallout.tile_num_in_direction(fallout.tile_num(self_obj), fallout.random(0, 5), 3)
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, dest, -1)
        fallout.reg_anim_func(3, 0)
    end
    fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(3, 5)), 1)
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
