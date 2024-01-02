local fallout = require("fallout")

local start
local use_skill_on_p_proc
local look_at_p_proc

local open = false
local unlocked = false

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function use_skill_on_p_proc()
    fallout.script_overrides()
    if not unlocked then
        fallout.display_msg(fallout.message_str(428, 101))
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) or fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)) then
            fallout.display_msg(fallout.message_str(429, 100))
            unlocked = true
        end
    else
        fallout.display_msg(fallout.message_str(429, 101))
        if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) then
            fallout.display_msg(fallout.message_str(429, 102))
        end
        if open then
            fallout.animate_stand_reverse_obj(fallout.self_obj())
            open = false
        else
            fallout.animate_stand_obj(fallout.self_obj())
            open = true
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(428, 100))
end

local exports = {}
exports.start = start
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
