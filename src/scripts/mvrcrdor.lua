local fallout = require("fallout")

local start
local use_p_proc
local use_obj_on_p_proc
local look_at_p_proc

local unlocked = false

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function use_p_proc()
    if not unlocked then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(431, 101))
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 77 then
        fallout.script_overrides()
        if unlocked then
            fallout.display_msg(fallout.message_str(431, 102))
        else
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, -20)) then
                fallout.display_msg(fallout.message_str(431, 103))
                unlocked = true
            else
                fallout.display_msg(fallout.message_str(431, 104))
            end
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(431, 100))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
