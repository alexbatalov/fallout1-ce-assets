local fallout = require("fallout")

local Times = 0

local start

function start()
    if fallout.script_action() == 12 then
        if fallout.global_var(13) == 0 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        else
            if (fallout.tile_num(fallout.self_obj()) ~= 16929) and (Times == 0) then
                Times = 1
                fallout.animate_move_obj_to_tile(fallout.self_obj(), 16929, 0)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60), 1)
            end
        end
    else
        if fallout.script_action() == 22 then
            if fallout.fixed_param() == 1 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), 10917, 0)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60), 2)
            else
                if fallout.fixed_param() == 2 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 16929, 0)
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60), 1)
                end
            end
        else
            if fallout.script_action() == 21 then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(0, 100))
            else
                if fallout.script_action() == 18 then
                    fallout.set_global_var(35, fallout.global_var(35) + 1)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
