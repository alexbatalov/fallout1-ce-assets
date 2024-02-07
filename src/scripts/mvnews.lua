local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(656, 100))
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(656, 101))
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
return exports
