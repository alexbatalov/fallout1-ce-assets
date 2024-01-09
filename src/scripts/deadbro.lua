local fallout = require("fallout")

local start
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    local rndx = fallout.random(1, 4)
    if fallout.global_var(74) == 2 then
        if rndx == 1 then
            fallout.display_msg(fallout.message_str(294, 100))
        elseif rndx == 2 then
            fallout.display_msg(fallout.message_str(294, 101))
        elseif rndx == 3 then
            fallout.display_msg(fallout.message_str(294, 102))
        elseif rndx == 4 then
            fallout.display_msg(fallout.message_str(294, 103))
        end
    else
        if rndx == 1 then
            fallout.display_msg(fallout.message_str(294, 104))
        elseif rndx == 2 then
            fallout.display_msg(fallout.message_str(294, 105))
        elseif rndx == 3 then
            fallout.display_msg(fallout.message_str(294, 106))
        end
        -- FIXME: Missing 4.
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
return exports
