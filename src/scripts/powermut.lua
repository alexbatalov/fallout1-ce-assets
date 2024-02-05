local fallout = require("fallout")
local misc = require("lib.misc")

local start
local look_at_p_proc
local talk_p_proc

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 48)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
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
