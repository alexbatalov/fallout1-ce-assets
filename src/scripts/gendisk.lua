local fallout = require("fallout")

local start

local rndx = 0

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(295, 100))
    else
        if fallout.script_action() == 6 then
            fallout.script_overrides()
            rndx = fallout.random(1, 5)
            fallout.display_msg(fallout.message_str(295, 101))
            if rndx == 1 then
                fallout.display_msg(fallout.message_str(295, 102))
            else
                if rndx == 2 then
                    fallout.display_msg(fallout.message_str(295, 103))
                else
                    if rndx == 3 then
                        fallout.display_msg(fallout.message_str(295, 104))
                    else
                        if rndx == 4 then
                            fallout.display_msg(fallout.message_str(295, 105))
                        else
                            if rndx == 5 then
                                fallout.display_msg(fallout.message_str(295, 106))
                            end
                        end
                    end
                end
            end
            fallout.rm_obj_from_inven(fallout.dude_obj(), 4)
            fallout.display_msg(fallout.message_str(295, 107))
        end
    end
end

local exports = {}
exports.start = start
return exports
