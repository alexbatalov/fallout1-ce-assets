local fallout = require("fallout")

local start
local use_p_proc
local look_at_p_proc
local description_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    end
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(116, 102))
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(116, 101))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(116, 100))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
return exports
