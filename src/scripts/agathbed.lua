local fallout = require("fallout")

local start
local do_stuff
local look_at_p_proc
local description_p_proc
local use_p_proc

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    else
        if fallout.script_action() == 3 then
            description_p_proc()
        else
            if fallout.script_action() == 21 then
                look_at_p_proc()
            end
        end
    end
end

function do_stuff()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(0, 102))
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(0, 101))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(0, 100))
end

function use_p_proc()
    do_stuff()
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
return exports
