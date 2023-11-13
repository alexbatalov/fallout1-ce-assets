local fallout = require("fallout")

local start
local use_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 and script_action == 3 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    local dude_obj = fallout.dude_obj()
    local strength = fallout.get_critter_stat(dude_obj, 0)
    local agility = fallout.get_critter_stat(dude_obj, 5)
    if strength < 7 and strength + agility < 12 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(300, 101))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(300, 100))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
