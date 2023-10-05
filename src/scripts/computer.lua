local fallout = require("fallout")

local start
local computer00

local test = 0

function start()
    if fallout.script_action() == 4 then
        fallout.script_overrides()
        computer00()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(23, 100))
        end
    end
end

function computer00()
    if fallout.has_skill(fallout.dude_obj(), 12) > fallout.has_skill(fallout.dude_obj(), 13) then
        test = fallout.roll_vs_skill(fallout.dude_obj(), 12, 0)
    else
        test = fallout.roll_vs_skill(fallout.dude_obj(), 13, 0)
    end
    if fallout.is_success(test) then
        fallout.display_msg(fallout.message_str(23, 101))
        if fallout.is_critical(test) then
            fallout.display_msg(fallout.message_str(23, 102))
        end
    else
        fallout.display_msg(fallout.message_str(23, 103))
        if fallout.is_critical(test) then
            fallout.display_msg(fallout.message_str(23, 104))
            fallout.critter_dmg(fallout.dude_obj(), 1, 0)
        end
    end
end

local exports = {}
exports.start = start
return exports
