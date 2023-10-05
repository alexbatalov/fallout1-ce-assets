local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 21 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(301, 100))
    else
        if fallout.script_action() == 3 then
            fallout.script_overrides()
            if fallout.global_var(139) == 2 then
                fallout.display_msg(fallout.message_str(301, 101))
            else
                fallout.display_msg(fallout.message_str(301, 102))
            end
        else
            if fallout.script_action() == 8 then
                if fallout.action_being_used() == 13 then
                    fallout.script_overrides()
                    if fallout.has_skill(fallout.dude_obj(), 13) > 35 then
                        fallout.set_local_var(0, 0)
                    end
                    if fallout.global_var(139) == 2 then
                        fallout.display_msg(fallout.message_str(301, 103))
                    else
                        if fallout.local_var(0) == 0 then
                            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, -10)) then
                                fallout.display_msg(fallout.message_str(301, 104))
                                fallout.set_global_var(139, 2)
                                fallout.give_exp_points(1000)
                                fallout.display_msg(fallout.message_str(766, 103) + "1000" + fallout.message_str(766, 104))
                            else
                                if fallout.has_skill(fallout.dude_obj(), 13) < 35 then
                                    fallout.set_local_var(0, 1)
                                end
                                fallout.display_msg(fallout.message_str(301, 105))
                                fallout.game_time_advance(fallout.game_ticks(1200))
                            end
                        else
                            if fallout.local_var(0) == 1 then
                                fallout.display_msg(fallout.message_str(301, 106))
                            end
                        end
                    end
                end
            else
                if fallout.script_action() == 7 then
                    if fallout.obj_pid(fallout.obj_being_used_with()) == 75 then
                        fallout.script_overrides()
                        if fallout.has_skill(fallout.dude_obj(), 13) > 35 then
                            fallout.set_local_var(0, 0)
                        end
                        if fallout.global_var(139) == 2 then
                            fallout.display_msg(fallout.message_str(301, 103))
                        else
                            if fallout.local_var(0) == 0 then
                                if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, 10)) then
                                    fallout.display_msg(fallout.message_str(301, 104))
                                    fallout.set_global_var(139, 2)
                                    fallout.display_msg(fallout.message_str(766, 103) + "1000" + fallout.message_str(766, 104))
                                    fallout.give_exp_points(1000)
                                else
                                    if fallout.has_skill(fallout.dude_obj(), 13) < 35 then
                                        fallout.set_local_var(0, 1)
                                    end
                                    fallout.display_msg(fallout.message_str(301, 105))
                                    fallout.game_time_advance(fallout.game_ticks(1200))
                                end
                            else
                                if fallout.local_var(0) == 1 then
                                    fallout.display_msg(fallout.message_str(301, 106))
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
