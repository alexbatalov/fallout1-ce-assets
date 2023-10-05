local fallout = require("fallout")

local start

local rndx = 0

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        rndx = fallout.random(1, 4)
        if fallout.global_var(74) == 2 then
            if rndx == 1 then
                fallout.display_msg(fallout.message_str(294, 100))
            else
                if rndx == 2 then
                    fallout.display_msg(fallout.message_str(294, 101))
                else
                    if rndx == 3 then
                        fallout.display_msg(fallout.message_str(294, 102))
                    else
                        if rndx == 4 then
                            fallout.display_msg(fallout.message_str(294, 103))
                        end
                    end
                end
            end
        else
            if rndx == 1 then
                fallout.display_msg(fallout.message_str(294, 104))
            else
                if rndx == 2 then
                    fallout.display_msg(fallout.message_str(294, 105))
                else
                    if rndx == 3 then
                        fallout.display_msg(fallout.message_str(294, 106))
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
