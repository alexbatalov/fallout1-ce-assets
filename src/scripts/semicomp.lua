local fallout = require("fallout")

local start
local look_at_p_proc
local use_skill_on_p_proc

function start()
    if fallout.local_var(0) == 0 then
        fallout.set_local_var(0, fallout.random(1, 9))
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 3 then
        fallout.display_msg(fallout.message_str(418, 100))
    else
        local msg = fallout.local_var(0)
        if msg == 1 then
            fallout.display_msg(fallout.message_str(418, 102))
        elseif msg == 2 then
            fallout.display_msg(fallout.message_str(418, 103))
        elseif msg == 3 then
            fallout.display_msg(fallout.message_str(418, 104))
        elseif msg == 4 then
            fallout.display_msg(fallout.message_str(418, 105))
        elseif msg == 5 then
            fallout.display_msg(fallout.message_str(418, 106))
        elseif msg == 6 then
            fallout.display_msg(fallout.message_str(418, 107))
        elseif msg == 7 then
            fallout.display_msg(fallout.message_str(418, 108))
        elseif msg == 8 then
            fallout.display_msg(fallout.message_str(418, 109))
        elseif msg == 9 then
            fallout.display_msg(fallout.message_str(418, 111))
        end
    end
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    fallout.script_overrides()
    if skill == 13 or skill == 12 then
        fallout.display_msg(fallout.message_str(418, 101))
    else
        fallout.display_msg(fallout.message_str(418, 102))
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
