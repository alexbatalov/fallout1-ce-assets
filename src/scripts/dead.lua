local fallout = require("fallout")

local start
local dead00

local success_level = 0

function start()
    local v0 = 0
    if fallout.script_action() == 3 then
        fallout.script_overrides()
        if success_level == 0 then
            success_level = fallout.do_check(fallout.dude_obj(), 4, 0)
        end
        dead00()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(24, 100))
        end
    end
end

function dead00()
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

local exports = {}
exports.start = start
return exports
