local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc
local use_p_proc
local pickup_p_proc
local use_skill_on_p_proc

local Free_To_Steal = 0

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        else
            if fallout.script_action() == 6 then
                use_p_proc()
            else
                if fallout.script_action() == 4 then
                    pickup_p_proc()
                else
                    if fallout.script_action() == 8 then
                        use_skill_on_p_proc()
                    end
                end
            end
        end
    end
end

function map_enter_p_proc()
    fallout.set_external_var("Shop_Ptr", fallout.self_obj())
end

function map_update_p_proc()
    fallout.set_external_var("Shop_Ptr", fallout.self_obj())
end

function use_p_proc()
    if fallout.external_var("Shopkepper_Ptr") ~= 0 then
        fallout.script_overrides()
        fallout.add_timer_event(fallout.external_var("Shopkepper_Ptr"), 1, 1)
    end
end

function pickup_p_proc()
    if (fallout.external_var("Shopkepper_Ptr") ~= 0) and (Free_To_Steal == 0) then
        fallout.script_overrides()
        fallout.add_timer_event(fallout.external_var("Shopkepper_Ptr"), 1, 1)
    end
end

function use_skill_on_p_proc()
    if (fallout.action_being_used() == 10) and (fallout.external_var("Shopkepper_Ptr") ~= 0) then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 10, -10)) then
            Free_To_Steal = 1
        else
            fallout.script_overrides()
            fallout.add_timer_event(fallout.external_var("Shopkepper_Ptr"), 1, 2)
        end
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.use_p_proc = use_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
