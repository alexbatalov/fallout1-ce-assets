local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(364, 100))
end

function use_p_proc()
    if fallout.global_var(609) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(364, 101))
        fallout.set_global_var(262, 0)
        fallout.set_global_var(146, 2)
        fallout.set_global_var(609, 1)
        fallout.set_external_var("field_change", "off")
        if fallout.map_var(2) ~= 0 then
            fallout.use_obj(fallout.map_var(2))
        end
        fallout.use_obj(fallout.map_var(3))
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
return exports
