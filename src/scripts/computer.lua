local fallout = require("fallout")

local start
local pickup_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 4 then
        pickup_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    end
end

function pickup_p_proc()
    fallout.script_overrides()

    local dude_obj = fallout.dude_obj()
    local roll
    if fallout.has_skill(dude_obj, 12) > fallout.has_skill(dude_obj, 13) then
        roll = fallout.roll_vs_skill(dude_obj, 12, 0)
    else
        roll = fallout.roll_vs_skill(dude_obj, 13, 0)
    end
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(23, 101))
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(23, 102))
        end
    else
        fallout.display_msg(fallout.message_str(23, 103))
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(23, 104))
            fallout.critter_dmg(dude_obj, 1, 0)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(23, 100))
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
