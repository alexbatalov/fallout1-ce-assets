local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc
local use_skill_on_p_proc

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        else
            if fallout.script_action() == 8 then
                use_skill_on_p_proc()
            end
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(134, 100))
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(134, 105))
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 12 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(134, 101))
        if fallout.local_var(0) ~= 0 then
            fallout.display_msg(fallout.message_str(134, 102))
            fallout.game_time_advance(fallout.game_ticks(3600))
        else
            if fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 0)) then
                fallout.gfade_out(600)
                fallout.display_msg(fallout.message_str(134, 103))
                fallout.game_time_advance(fallout.game_ticks(21600))
                fallout.give_exp_points(350)
                fallout.set_local_var(0, 1)
                fallout.gfade_in(600)
            else
                fallout.gfade_out(600)
                fallout.display_msg(fallout.message_str(134, 104))
                fallout.game_time_advance(fallout.game_ticks(21600))
                fallout.set_local_var(0, 1)
                fallout.gfade_in(600)
            end
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
