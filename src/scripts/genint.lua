local fallout = require("fallout")

local start
local do_dialogue

local rndx = 0

function start()
    local v0 = 0
    if fallout.script_action() == 11 then
        do_dialogue()
        detach()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg("You see one of the acrolytes of the Children of the Cathedral.")
            detach()
        else
            if fallout.script_action() == 12 then
                detach()
            else
                if fallout.script_action() == 13 then
                    detach()
                end
            end
        end
    end
end

function do_dialogue()
    rndx = fallout.random(1, 3)
    fallout.start_gdialog(107, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if rndx == 1 then
        fallout.gsay_message(107, "Peace be with you. Please talk to Laura.", 50)
    end
    if rndx == 2 then
        fallout.gsay_message(107, "Laura taught me that we are all one people and should look to the good in them. She is very wise.", 50)
    end
    if rndx == 3 then
        fallout.gsay_message(107, "Laura is a wise and wonderful person.", 50)
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

local exports = {}
exports.start = start
return exports
