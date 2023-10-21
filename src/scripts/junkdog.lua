local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local use_obj_on_p_proc
local dog_joins_dude

local hostile = 0
local waiting_to_follow = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 21 then
                look_at_p_proc()
            else
                if fallout.script_action() == 15 then
                    map_enter_p_proc()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 11 then
                            talk_p_proc()
                        else
                            if fallout.script_action() == 22 then
                                timed_event_p_proc()
                            else
                                if fallout.script_action() == 7 then
                                    use_obj_on_p_proc()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 74 then
            if not(fallout.global_var(5)) then
                fallout.display_msg(fallout.message_str(353, 106))
                dog_joins_dude()
            end
        end
    end
    if fallout.global_var(5) == 1 then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 4 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), 1), 1)
        else
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), 3), 0)
        end
    else
        if fallout.map_var(8) then
            if fallout.map_var(5) then
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(6), 1)
            end
            fallout.set_map_var(8, 0)
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(5, 0)
    fallout.set_global_var(186, 2)
    fallout.set_global_var(187, 2)
    fallout.party_remove(fallout.self_obj())
    fallout.set_map_var(5, 0)
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.global_var(5) ~= 0 then
        fallout.display_msg(fallout.message_str(353, 100))
    else
        fallout.display_msg(fallout.message_str(353, 101))
    end
end

function map_enter_p_proc()
    if fallout.global_var(5) == 1 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
    else
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 6)
    end
    if (fallout.cur_map_index() == 11) and (fallout.global_var(5) == 0) then
        fallout.set_map_var(5, 1)
    end
end

function pickup_p_proc()
    fallout.script_overrides()
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(353, 102), 0)
    if fallout.external_var("Katja_ptr") ~= 0 then
        fallout.float_msg(fallout.external_var("Katja_ptr"), fallout.message_str(623, 175), 5)
    end
end

function timed_event_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(353, 103), 0)
    fallout.set_map_var(9, 1)
    fallout.set_map_var(7, 1)
end

function use_obj_on_p_proc()
    if (fallout.obj_pid(fallout.obj_being_used_with()) == 103) or (fallout.obj_pid(fallout.obj_being_used_with()) == 81) then
        if not(fallout.global_var(5)) then
            fallout.display_msg(fallout.message_str(353, 105))
            dog_joins_dude()
        end
    end
end

function dog_joins_dude()
    fallout.display_msg(fallout.message_str(353, 104))
    fallout.give_exp_points(100)
    fallout.set_global_var(5, 1)
    fallout.set_global_var(187, 2)
    fallout.set_global_var(186, 2)
    fallout.party_add(fallout.self_obj())
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
    fallout.set_map_var(5, 0)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
