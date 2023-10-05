local fallout = require("fallout")

local start
local chairend
local look_at_p_proc
local description_p_proc

function start()
    local v0 = 0
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 3 then
            description_p_proc()
        end
    end
end

function chairend()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(121, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(121, 101))
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
return exports
