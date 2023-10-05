local fallout = require("fallout")

local start
local use_p_proc
local look_at_p_proc
local description_p_proc

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    else
        if (fallout.script_action() == 3) or (fallout.script_action() == 21) then
        end
    end
end

function use_p_proc()
    fallout.add_obj_to_inven(fallout.dude_obj(), fallout.create_object_sid(21, 0, 0, -1))
    fallout.display_msg(fallout.message_str(123, 101))
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(123, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(123, 100))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
return exports
