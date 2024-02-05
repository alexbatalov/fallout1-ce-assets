local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local timed_event_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc

local hostile = false
local initialized = false
local scared = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 55)
        fallout.critter_add_trait(self_obj, 1, 5, 8)
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, fallout.tile_num(self_obj))
        end
        fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 5)), 1)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        scared = true
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        local self_obj = fallout.self_obj()
        local dude_obj = fallout.dude_obj()
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            if fallout.tile_distance_objs(self_obj, dude_obj) < 6 then
                if scared then
                    behaviour.flee_dude(1)
                else
                    hostile = true
                end
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    local rotation = fallout.random(0, 5)
    local distance = fallout.random(1, 3)
    fallout.animate_move_obj_to_tile(self_obj,
        fallout.tile_num_in_direction(fallout.local_var(0), rotation, distance), 0)
    fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 5)), 0)
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    local item_pid = fallout.obj_pid(item_obj)
    if item_pid == 124 or item_pid == 106 then
        fallout.script_overrides()
        fallout.rm_obj_from_inven(fallout.source_obj(), item_obj)
        fallout.destroy_object(item_obj)
        local self_obj = fallout.self_obj()
        fallout.critter_dmg(self_obj, fallout.get_critter_stat(self_obj, 35) + 10, 6)
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
