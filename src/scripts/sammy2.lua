local fallout = require("fallout")

local start
local do_dialogue

function start()
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 3 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(14, 100))
        else
            if fallout.script_action() == 18 then
                fallout.set_global_var(6, 1)
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(-1, 14, fallout.self_obj(), -1, -1)
    fallout.sayMessage(0, fallout.message_str(14, 101))
    fallout.end_dialogue()
end

local exports = {}
exports.start = start
return exports
