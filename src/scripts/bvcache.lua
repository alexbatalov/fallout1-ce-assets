local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            if fallout.local_var(0) == 0 then
                fallout.set_local_var(0, 1)
                if fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 2)) then
                    fallout.display_msg(fallout.message_str(191, 100))
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
