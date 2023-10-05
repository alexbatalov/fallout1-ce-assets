local fallout = require("fallout")

local start
local use_stuff

local open = 0
local unlocked = 0

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(428, 100))
    else
        if fallout.script_action() == 8 then
            use_stuff()
        end
    end
end

function use_stuff()
    fallout.script_overrides()
    if not(unlocked) then
        fallout.display_msg(fallout.message_str(428, 101))
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) or fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)) then
            fallout.display_msg(fallout.message_str(429, 100))
            unlocked = 1
        end
    else
        fallout.display_msg(fallout.message_str(429, 101))
        if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) then
            fallout.display_msg(fallout.message_str(429, 102))
        end
        if open then
            fallout.animate_stand_reverse_obj(fallout.self_obj())
            open = 0
        else
            fallout.animate_stand_obj(fallout.self_obj())
            open = 1
        end
    end
end

local exports = {}
exports.start = start
return exports
