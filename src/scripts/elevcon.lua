local fallout = require("fallout")

local start
local look_at_p_proc

local spot1 = 17140
local field1 = 0

function start()
    if fallout.script_action() == 15 then
        field1 = fallout.create_object_sid(33554921, spot1, 0, -1)
        fallout.set_obj_visibility(field1, fallout.local_var(0))
    end
    if fallout.script_action() == 6 then
        if fallout.local_var(0) then
            fallout.set_obj_visibility(field1, 0)
            fallout.set_local_var(0, 0)
        else
            if fallout.has_skill(fallout.dude_obj(), 8) > 50 then
                fallout.set_external_var("signal_mutants", 1)
            end
            fallout.set_obj_visibility(field1, 1)
            fallout.set_local_var(0, 1)
        end
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    end
    if fallout.script_action() == 16 then
        fallout.destroy_object(field1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
return exports
