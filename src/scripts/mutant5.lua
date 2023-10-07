local fallout = require("fallout")

local Hostile = 0
local init_teams = 0
local Times = 0

local start

function start()
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        init_teams = 1
    else
        if fallout.script_action() == 4 then
            Hostile = 1
        end
    end
    if fallout.script_action() == 12 then
        if fallout.global_var(13) == 0 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        else
            if Hostile then
                Hostile = 0
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
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
                fallout.display_msg(fallout.message_str(234, 100))
            else
                if fallout.script_action() == 18 then
                    fallout.set_global_var(35, fallout.global_var(35) + 1)
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
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
