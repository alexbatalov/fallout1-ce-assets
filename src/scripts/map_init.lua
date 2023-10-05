local fallout = require("fallout")

local start

function start()
    local v0 = 0
    if fallout.script_action() == 15 then
        v0 = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
        v0 = fallout.create_object_sid(18, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
        v0 = fallout.create_object_sid(31, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
        v0 = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    else
        if fallout.script_action() == 16 then
        end
    end
end

local exports = {}
exports.start = start
return exports
