local fallout = require("fallout")

local start
local talk_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    end
end

function talk_p_proc()
    fallout.start_gdialog(7, fallout.self_obj(), 4, -1, -1)
    local rndx = fallout.random(0, 6)
    if rndx == 0 then
        fallout.sayMessage(0, fallout.message_str(7, 102))
    elseif rndx == 1 then
        fallout.sayMessage(0, fallout.message_str(7, 103))
    elseif rndx == 2 then
        fallout.sayMessage(0, fallout.message_str(7, 104))
    elseif rndx == 3 then
        fallout.sayMessage(0, fallout.message_str(7, 105))
    elseif rndx == 4 then
        fallout.sayMessage(0, fallout.message_str(7, 106))
    elseif rndx == 5 then
        fallout.sayMessage(0, fallout.message_str(7, 107))
    elseif rndx == 6 then
        fallout.sayMessage(0, fallout.message_str(7, 108))
    end
    fallout.end_dialogue()
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
return exports
