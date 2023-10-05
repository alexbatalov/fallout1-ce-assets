local fallout = require("fallout")

local start
local anger

function start()
    if fallout.script_action() == 22 then
        fallout.set_map_var(5, 0)
    else
        if fallout.script_action() == 6 then
            anger()
        else
            if fallout.script_action() == 8 then
                anger()
            else
                if fallout.script_action() == 7 then
                    anger()
                else
                    if fallout.script_action() == 4 then
                        anger()
                    end
                end
            end
        end
    end
end

function anger()
    fallout.set_map_var(5, 1)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 0)
end

local exports = {}
exports.start = start
return exports
