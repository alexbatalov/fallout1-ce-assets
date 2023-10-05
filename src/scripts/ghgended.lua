local fallout = require("fallout")

local start
local do_stuff

local rndx = 0

function start()
    local v0 = 0
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        do_stuff()
    end
end

function do_stuff()
    rndx = fallout.random(1, 5)
    if rndx == 1 then
        fallout.display_msg(fallout.message_str(71, 100))
    end
    if rndx == 2 then
        fallout.display_msg(fallout.message_str(71, 101))
    end
    if rndx == 3 then
        fallout.display_msg(fallout.message_str(71, 102))
    end
    if rndx == 4 then
        fallout.display_msg(fallout.message_str(71, 103))
    end
    if rndx == 5 then
        fallout.display_msg(fallout.message_str(71, 104))
    end
end

local exports = {}
exports.start = start
return exports
