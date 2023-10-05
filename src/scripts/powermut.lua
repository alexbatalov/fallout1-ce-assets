local fallout = require("fallout")

local start
local look_at_p_proc
local talk_p_proc

local initialized = 0

function start()
    if not(initialized) then
        initialized = 1
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 48)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 11 then
            talk_p_proc()
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(838, 101))
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(838, 100), 2)
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
