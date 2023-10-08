local fallout = require("fallout")
local time = require("lib.time")

local start
local description_p_proc
local use_p_proc

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        end
    end
end

function description_p_proc()
    fallout.display_msg(fallout.message_str(344, 103))
end

function use_p_proc()
    fallout.script_overrides()
    if time.game_time_in_days() == 0 then
        if fallout.local_var(0) then
            fallout.display_msg(fallout.message_str(344, 101))
            fallout.float_msg(fallout.self_obj(), fallout.message_str(344, 102), 0)
        else
            fallout.display_msg(fallout.message_str(344, 100))
            fallout.set_local_var(0, 1)
        end
        fallout.play_sfx("SLDOORSO")
    else
        fallout.use_obj(fallout.external_var("vault_door_ptr"))
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
return exports
