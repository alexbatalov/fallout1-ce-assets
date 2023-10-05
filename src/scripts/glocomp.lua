local fallout = require("fallout")

local start

function start()
    local v0 = 0
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        v0 = fallout.random(1, 4)
        if v0 == 1 then
            fallout.display_msg(fallout.message_str(299, 100))
        else
            if v0 == 2 then
                fallout.display_msg(fallout.message_str(299, 101))
            else
                if v0 == 3 then
                    fallout.display_msg(fallout.message_str(299, 102))
                else
                    if v0 == 4 then
                        fallout.display_msg(fallout.message_str(299, 103))
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
