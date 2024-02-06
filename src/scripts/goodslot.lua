local fallout = require("fallout")

local start
local look_at_p_proc
local map_enter_p_proc
local use_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(355, 100))
end

function map_enter_p_proc()
    if fallout.global_var(38) == 1 then
        fallout.destroy_object(fallout.self_obj())
    end
end

function use_p_proc()
    fallout.script_overrides()
    if fallout.item_caps_total(fallout.dude_obj()) < 20 then
        fallout.display_msg(fallout.message_str(355, 108))
    else
        fallout.display_msg(fallout.message_str(355, 101))
        fallout.item_caps_adjust(fallout.dude_obj(), -20)
        local bonus = fallout.random(1, 50) - fallout.random(20, 50)
        local roll = fallout.roll_vs_skill(fallout.dude_obj(), 16, bonus)
        if fallout.is_success(roll) then
            local amount
            if fallout.is_critical(roll) then
                amount = fallout.random(30, 40)
                fallout.float_msg(fallout.self_obj(), fallout.message_str(355, 102), 0)
                fallout.display_msg(fallout.message_str(355, 103) .. amount .. fallout.message_str(355, 104))
            else
                fallout.float_msg(fallout.self_obj(), fallout.message_str(355, 105), 0)
                fallout.display_msg(fallout.message_str(355, 106))
                amount = 30
            end
            fallout.item_caps_adjust(fallout.dude_obj(), amount)
        else
            fallout.display_msg(fallout.message_str(355, 107))
        end
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.use_p_proc = use_p_proc
return exports
