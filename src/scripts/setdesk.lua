local fallout = require("fallout")

local start
local do_stuff

function start()
    local v0 = 0
    if fallout.script_action() == 6 then
        do_stuff()
    end
end

function do_stuff()
    if fallout.local_var(0) == 1 then
        fallout.display_msg(fallout.message_str(93, 100))
    else
        fallout.display_msg(fallout.message_str(93, 101))
        fallout.set_local_var(0, 1)
    end
end

local exports = {}
exports.start = start
return exports
