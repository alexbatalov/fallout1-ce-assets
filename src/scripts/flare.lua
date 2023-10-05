local fallout = require("fallout")

local start

local lit = 0

function start()
    if fallout.script_action() == 7 then
        fallout.scr_return(0)
        if (lit ~= 1) and (lit ~= 2) then
            fallout.obj_set_light_level(fallout.self_obj(), 100, 7)
            fallout.display_msg(fallout.message_str(223, 100))
            lit = 1
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1800 * 3), 1)
        else
            fallout.display_msg(fallout.message_str(223, 101))
        end
    else
        if fallout.script_action() == 22 then
            if fallout.fixed_param() == 1 then
                fallout.obj_set_light_level(fallout.self_obj(), 80, 7)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(900 * 3), 2)
            else
                if fallout.fixed_param() == 2 then
                    fallout.obj_set_light_level(fallout.self_obj(), 60, 7)
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(450 * 3), 3)
                else
                    if fallout.fixed_param() == 3 then
                        fallout.obj_set_light_level(fallout.self_obj(), 0, 1)
                        lit = 2
                        fallout.display_msg(fallout.message_str(223, 102))
                    end
                end
            end
        else
            if fallout.script_action() == 21 then
                fallout.script_overrides()
                if lit == 1 then
                    fallout.display_msg(fallout.message_str(223, 103))
                else
                    if lit == 2 then
                        fallout.display_msg(fallout.message_str(223, 104))
                    else
                        fallout.display_msg(fallout.message_str(223, 105))
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
