local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc
local use_p_proc
local pickup_p_proc
local use_skill_on_p_proc

local Free_To_Steal = false

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function map_enter_p_proc()
    fallout.set_external_var("Shop_Ptr", fallout.self_obj())
end

function map_update_p_proc()
    fallout.set_external_var("Shop_Ptr", fallout.self_obj())
end

function use_p_proc()
    local shopkeeper_obj = fallout.external_var("Shopkepper_Ptr")
    if shopkeeper_obj ~= nil then
        fallout.script_overrides()
        fallout.add_timer_event(shopkeeper_obj, 1, 1)
    end
end

function pickup_p_proc()
    local shopkeeper_obj = fallout.external_var("Shopkepper_Ptr")
    if shopkeeper_obj ~= nil and not Free_To_Steal then
        fallout.script_overrides()
        fallout.add_timer_event(shopkeeper_obj, 1, 1)
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        local shopkeeper_obj = fallout.external_var("Shopkepper_Ptr")
        if shopkeeper_obj ~= nil then
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 10, -10)) then
                Free_To_Steal = true
            else
                fallout.script_overrides()
                fallout.add_timer_event(shopkeeper_obj, 1, 2)
            end
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
