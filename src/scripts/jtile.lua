local fallout = require("fallout")

local start
local use_p_proc

local ready = 1

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            if ready then
                use_p_proc()
            end
        end
    else
        if fallout.script_action() == 22 then
            ready = 1
        end
    end
end

function use_p_proc()
    fallout.use_obj(fallout.external_var("J_Door_Ptr"))
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(4), 1)
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
