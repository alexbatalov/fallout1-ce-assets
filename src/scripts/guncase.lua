local fallout = require("fallout")

local start
local use_p_proc
local pickup_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    end
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(766, 176))
end

function pickup_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(766, 176))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
