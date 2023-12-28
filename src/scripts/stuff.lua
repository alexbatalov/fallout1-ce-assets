local fallout = require("fallout")

local start
local anger

function start()
    local script_action = fallout.script_action()
    if script_action == 22 then
        fallout.set_map_var(5, 0)
    elseif script_action == 6 then
        anger()
    elseif script_action == 8 then
        anger()
    elseif script_action == 7 then
        anger()
    elseif script_action == 4 then
        anger()
    end
end

function anger()
    fallout.set_map_var(5, 1)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 0)
end

local exports = {}
exports.start = start
return exports
