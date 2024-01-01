local fallout = require("fallout")

local start
local use_p_proc

local initialized = false

function start()
    if not initialized then
        fallout.set_external_var("ladder_down", fallout.self_obj())
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    local source_obj = fallout.source_obj()
    fallout.move_to(source_obj, 12498, 1)
    if fallout.combat_is_initialized() and source_obj ~= fallout.dude_obj() then
        fallout.critter_stop_attacking(source_obj)
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
