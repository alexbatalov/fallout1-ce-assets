local fallout = require("fallout")

local start
local use_p_proc

local initialized = 0

function start()
    if not(initialized) then
        fallout.set_external_var("ladder_down", fallout.self_obj())
        initialized = 1
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        end
    end
end

function use_p_proc()
    fallout.move_to(fallout.source_obj(), 12498, 1)
    if fallout.combat_is_initialized() and (fallout.source_obj() ~= fallout.dude_obj()) then
        fallout.critter_stop_attacking(fallout.source_obj())
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
