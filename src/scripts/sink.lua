local fallout = require("fallout")

local start
local use_p_proc
local pickup_p_proc
local look_at_p_proc
local use_obj_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(739, 101))
end

function pickup_p_proc()
    use_p_proc()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(739, 100))
end

function use_obj_on_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(739, 102) ..
        fallout.proto_data(fallout.obj_pid(fallout.obj_being_used_with()), 1) .. fallout.message_str(739, 103))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
