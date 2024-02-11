local fallout = require("fallout")

local start
local description_p_proc
local look_at_p_proc

local success_level = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    if success_level == 0 then
        success_level = fallout.do_check(fallout.dude_obj(), 4, 0)
    end
    if fallout.is_success(success_level) then
        if fallout.is_critical(success_level) then
            fallout.display_msg(fallout.message_str(24, 101))
        else
            fallout.display_msg(fallout.message_str(24, 102))
        end
    else
        if fallout.is_critical(success_level) then
            fallout.display_msg(fallout.message_str(24, 103))
        else
            fallout.display_msg(fallout.message_str(24, 104))
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(24, 100))
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
return exports
