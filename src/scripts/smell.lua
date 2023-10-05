local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            if fallout.local_var(0) ~= 1 then
                if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) then
                    fallout.display_msg(fallout.message_str(97, 100))
                end
                fallout.set_local_var(0, 1)
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
