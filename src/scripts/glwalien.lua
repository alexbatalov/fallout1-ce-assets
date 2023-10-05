local fallout = require("fallout")

local start
local dead00

local success_level = 0

function start()
    if fallout.script_action() == 3 then
        fallout.script_overrides()
        if success_level == 0 then
            success_level = fallout.roll_vs_skill(fallout.dude_obj(), 7, 0)
        end
        dead00()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(313, 100))
        end
    end
end

function dead00()
    if fallout.is_success(success_level) then
        if fallout.is_critical(success_level) then
            fallout.display_msg(fallout.message_str(313, 101))
        else
            fallout.display_msg(fallout.message_str(313, 102))
        end
    else
        if fallout.is_critical(success_level) then
            fallout.display_msg(fallout.message_str(313, 103))
        else
            fallout.display_msg(fallout.message_str(313, 104))
        end
    end
end

local exports = {}
exports.start = start
return exports
