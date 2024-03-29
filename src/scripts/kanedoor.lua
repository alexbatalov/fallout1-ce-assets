local fallout = require("fallout")

local start
local use_p_proc

local initialized = false

function start()
    if not initialized then
        fallout.obj_close(fallout.self_obj())
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    if fallout.map_var(49) == 0 then
        fallout.script_overrides()
        fallout.set_map_var(51, 1)
        fallout.display_msg(fallout.message_str(594, 465))
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
