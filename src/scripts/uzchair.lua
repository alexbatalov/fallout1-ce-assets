local fallout = require("fallout")

local start

local gear = 0

function start()
    if fallout.script_action() == 6 then
        if fallout.local_var(0) == 0 then
            fallout.script_overrides()
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(464, 100))
            gear = fallout.create_object_sid(82, 0, 0, -1)
            fallout.add_obj_to_inven(fallout.dude_obj(), gear)
        end
    end
end

local exports = {}
exports.start = start
return exports
