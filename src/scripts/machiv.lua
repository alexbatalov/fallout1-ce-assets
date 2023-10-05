local fallout = require("fallout")

local start
local do_stuff

function start()
    if fallout.script_action() == 21 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(110, 100))
    else
        if fallout.script_action() == 6 then
            fallout.script_overrides()
            do_stuff()
        else
            if fallout.script_action() == 8 then
                if fallout.action_being_used() == 12 then
                    fallout.script_overrides()
                    do_stuff()
                end
            end
        end
    end
end

function do_stuff()
    local v0 = 0
    v0 = fallout.random(1, 4)
    if v0 == 1 then
        fallout.display_msg(fallout.message_str(110, 101))
    else
        if v0 == 2 then
            fallout.display_msg(fallout.message_str(110, 102))
        else
            if v0 == 3 then
                fallout.display_msg(fallout.message_str(110, 103))
            else
                if v0 == 4 then
                    fallout.display_msg(fallout.message_str(110, 104))
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
