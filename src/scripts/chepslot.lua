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
    fallout.display_msg(fallout.message_str(354, 100))
end

function map_enter_p_proc()
    if fallout.global_var(38) == 1 then
        fallout.destroy_object(fallout.self_obj())
    end
end

function use_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    fallout.script_overrides()
    if fallout.item_caps_total(dude_obj) < 10 then
        fallout.display_msg(fallout.message_str(354, 108))
    else
        fallout.display_msg(fallout.message_str(354, 101))
        fallout.item_caps_adjust(dude_obj, -10)
        local bonus = fallout.random(1, 50) - fallout.random(1, 50)
        local roll = fallout.roll_vs_skill(dude_obj, 16, bonus)
        if fallout.is_success(roll) then
            local money
            if fallout.is_critical(roll) then
                money = fallout.random(15, 30)
                fallout.float_msg(self_obj, fallout.message_str(354, 102), 0)
                fallout.display_msg(fallout.message_str(354, 103) .. money .. fallout.message_str(354, 104))
            else
                fallout.float_msg(self_obj, fallout.message_str(354, 105), 0)
                fallout.display_msg(fallout.message_str(354, 106))
                money = 15
            end
            fallout.item_caps_adjust(fallout.dude_obj(), money)
        else
            fallout.display_msg(fallout.message_str(354, 107))
        end
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.use_p_proc = use_p_proc
return exports
