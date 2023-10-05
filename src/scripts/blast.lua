local fallout = require("fallout")

local start

local test = 0
local damage = 0

function start()
    if fallout.script_action() == 7 then
        if fallout.obj_pid(fallout.obj_being_used_with()) == 85 then
            fallout.script_overrides()
            test = fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)
            if fallout.is_success(test) then
                fallout.display_msg(fallout.message_str(463, 100))
                fallout.give_exp_points(1)
                fallout.display_msg(fallout.message_str(463, 103))
            else
                if fallout.is_critical(test) then
                    fallout.display_msg(fallout.message_str(463, 101))
                    damage = fallout.random(10, 40)
                    fallout.critter_dmg(fallout.dude_obj(), damage, 0)
                else
                    fallout.display_msg(fallout.message_str(463, 102))
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
