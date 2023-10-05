local fallout = require("fallout")

local start

local test = 0

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            if fallout.local_var(0) == 0 then
                fallout.set_local_var(0, 1)
                test = fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0) - 2)
                if fallout.is_success(test) then
                    if fallout.is_critical(test) then
                        fallout.display_msg(fallout.message_str(150, 100))
                    else
                        fallout.display_msg(fallout.message_str(150, 101))
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
