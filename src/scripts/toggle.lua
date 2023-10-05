local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    else
        if fallout.script_action() == 8 then
            use_skill_on_p_proc()
        end
    end
end

function use_p_proc()
    if fallout.cur_map_index() == 31 then
        fallout.set_external_var("field_change", "toggle")
        fallout.use_obj(fallout.map_var(0))
        fallout.use_obj(fallout.map_var(1))
        fallout.use_obj(fallout.map_var(2))
        fallout.use_obj(fallout.map_var(3))
        fallout.use_obj(fallout.map_var(4))
        fallout.use_obj(fallout.map_var(5))
        fallout.use_obj(fallout.map_var(6))
        fallout.use_obj(fallout.map_var(7))
    else
        if fallout.cur_map_index() == 32 then
            fallout.set_external_var("field_change", "toggle")
            fallout.use_obj(fallout.map_var(5))
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 13 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(864, 100))
    else
        if fallout.action_being_used() == 12 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(864, 101))
        end
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
