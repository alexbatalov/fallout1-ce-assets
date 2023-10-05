local fallout = require("fallout")

local start
local do_stuff

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        do_stuff()
    end
end

function do_stuff()
    fallout.display_msg(fallout.message_str(62, 100))
end

local exports = {}
exports.start = start
return exports
