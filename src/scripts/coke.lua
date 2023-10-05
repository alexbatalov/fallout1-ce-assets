local fallout = require("fallout")

local start
local use_p_proc
local Coke00
local Coke01

local caps = 0

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) == 1 then
        Coke00()
    else
        Coke01()
    end
end

function Coke00()
    fallout.display_msg(fallout.message_str(22, 100))
end

function Coke01()
    fallout.set_local_var(0, 1)
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, 0)) then
        fallout.display_msg(fallout.message_str(22, 101))
        caps = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
        fallout.item_caps_adjust(fallout.dude_obj(), caps)
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
