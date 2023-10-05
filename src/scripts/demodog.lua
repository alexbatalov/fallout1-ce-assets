local fallout = require("fallout")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0
local g3 = 0

local start
local growl
local do_dialogue
local follow_player

-- ?import? variable known
-- ?import? variable hostile
-- ?import? variable initialized
-- ?import? variable waiting_to_follow
-- ?import? variable smartass

function start()
    if not(g2) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 6)
        g2 = 1
        fallout.set_external_var("dog_is_angry", 1)
    else
        if fallout.script_action() == 11 then
            do_dialogue()
        else
            if fallout.script_action() == 4 then
                fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            else
                if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                    fallout.script_overrides()
                    if fallout.global_var(5) then
                        fallout.display_msg(fallout.message_str(374, 100))
                    else
                        fallout.display_msg(fallout.message_str(374, 101))
                    end
                else
                    if fallout.script_action() == 12 then
                        if fallout.global_var(5) == 1 then
                            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 4 then
                                fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), 1), 1)
                            else
                                fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), 3), 0)
                            end
                        else
                            if fallout.external_var("Phil_approaches") then
                                if fallout.external_var("dog_is_angry") then
                                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(4), 1)
                                end
                                fallout.set_external_var("Phil_approaches", 0)
                            end
                        end
                    else
                        if fallout.script_action() == 18 then
                            fallout.set_external_var("dog_is_angry", 0)
                        else
                            if fallout.script_action() == 22 then
                                if fallout.fixed_param() == 1 then
                                    growl()
                                else
                                    if fallout.fixed_param() == 2 then
                                        follow_player()
                                    end
                                end
                            else
                                if fallout.script_action() == 7 then
                                    if fallout.obj_pid(fallout.obj_being_used_with()) == 103 then
                                        fallout.display_msg(fallout.message_str(374, 104))
                                        fallout.give_exp_points(200)
                                        fallout.set_global_var(5, 1)
                                        fallout.set_global_var(187, 2)
                                        fallout.set_global_var(186, 2)
                                        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
                                        fallout.set_external_var("dog_is_angry", 0)
                                        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 2)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function growl()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(374, 103), 0)
    fallout.set_external_var("growling", 1)
    fallout.set_external_var("smartass2", 1)
end

function do_dialogue()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(374, 102), 0)
end

function follow_player()
    local v0 = 0
    v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), 1)
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 0 | 16)
    else
        fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 1 | 16)
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 2)
end

local exports = {}
exports.start = start
return exports
