local fallout = require("fallout")

local start
local do_stuff
local deskend

function start()
    local v0 = 0
    if fallout.script_action() == 4 then
        do_stuff()
    end
end

function do_stuff()
    fallout.display_msg(fallout.message_str(25, 100))
end

function deskend()
end

local exports = {}
exports.start = start
return exports
