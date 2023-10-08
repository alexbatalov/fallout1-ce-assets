local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local timed_event_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local flee_dude

local hostile = 0
local initialized = 0
local scared = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 55)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 8)
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, fallout.tile_num(fallout.self_obj()))
        end
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 5)), 1)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 22 then
                    timed_event_p_proc()
                else
                    if fallout.script_action() == 7 then
                        use_obj_on_p_proc()
                    else
                        if fallout.script_action() == 8 then
                            use_skill_on_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        scared = 1
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
                if scared then
                    flee_dude()
                else
                    hostile = 1
                end
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function timed_event_p_proc()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.local_var(0), fallout.random(0, 5), fallout.random(1, 3)), 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 5)), 0)
end

function use_obj_on_p_proc()
    if (fallout.obj_pid(fallout.obj_being_used_with()) == 124) or (fallout.obj_pid(fallout.obj_being_used_with()) == 106) then
        fallout.script_overrides()
        fallout.rm_obj_from_inven(fallout.source_obj(), fallout.obj_being_used_with())
        fallout.destroy_object(fallout.obj_being_used_with())
        fallout.critter_dmg(fallout.self_obj(), fallout.get_critter_stat(fallout.self_obj(), 35) + 10, 6)
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
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
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
