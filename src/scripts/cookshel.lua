local fallout = require("fallout")

local start
local pickup_p_proc
local look_at_p_proc
local description_p_proc

function start()
    if fallout.script_action() == 4 then
        pickup_p_proc()
    else
        if (fallout.script_action() == 3) or (fallout.script_action() == 21) then
            look_at_p_proc()
        end
    end
end

function pickup_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(125, 101))
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(125, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(125, 100))
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
return exports
