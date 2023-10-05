local fallout = require("fallout")

local start
local dead00

function start()
    local v0 = 0
    if fallout.script_action() == 3 then
        fallout.script_overrides()
        dead00()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(83, 100))
        end
    end
end

function dead00()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 0)) then
        fallout.display_msg(fallout.message_str(83, 101))
    end
end

local exports = {}
exports.start = start
return exports
