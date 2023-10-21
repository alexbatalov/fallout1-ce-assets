local fallout = require("fallout")

local start
local look_at_p_proc

local initialized = false
local spot1 = 27096
local spot2 = 27104
local spot3 = 26312
local spot4 = 26320
local field1 = 0
local field2 = 0
local field3 = 0
local field4 = 0
local swtch = 0
local temp = 0

function start()
    if fallout.script_action() == 15 then
    end
    if fallout.script_action() == 6 then
        fallout.display_msg(fallout.message_str(766, 187))
        if fallout.local_var(0) ~= 0 then
            fallout.set_local_var(0, 0)
            fallout.set_map_var(7, 0)
        else
            fallout.set_local_var(0, 1)
            if fallout.local_var(1) == 0 then
                fallout.set_local_var(1, 1)
                temp = 2000
                fallout.display_msg(fallout.message_str(682, 301) .. temp .. fallout.message_str(682, 302))
                fallout.give_exp_points(temp)
            end
            fallout.set_map_var(7, 1)
        end
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    end
    if fallout.script_action() == 16 then
    end
end

function look_at_p_proc()
    fallout.script_overrides()
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
return exports
