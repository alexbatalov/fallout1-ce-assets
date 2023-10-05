local fallout = require("fallout")

local start

local Shocked = 0

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(328, 100))
    else
        if fallout.script_action() == 6 then
            if (fallout.local_var(0) == 0) and (fallout.global_var(139) == 2) then
                fallout.script_overrides()
                fallout.set_local_var(1, fallout.local_var(1) + 1)
                Shocked = fallout.random(1, 6) - 4 + fallout.local_var(1)
                if Shocked <= 0 then
                    fallout.display_msg(fallout.message_str(328, 101))
                else
                    if Shocked == 1 then
                        fallout.display_msg(fallout.message_str(328, 102))
                        fallout.critter_dmg(fallout.dude_obj(), Shocked, 0)
                    else
                        fallout.display_msg(fallout.message_str(328, 103) + Shocked + fallout.message_str(328, 104))
                        fallout.critter_dmg(fallout.dude_obj(), Shocked, 0)
                    end
                end
            end
        else
            if fallout.script_action() == 7 then
                if fallout.obj_pid(fallout.obj_being_used_with()) == 97 then
                    fallout.set_local_var(0, 1)
                    fallout.display_msg(fallout.message_str(328, 105))
                else
                    fallout.display_msg(fallout.message_str(328, 106))
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
