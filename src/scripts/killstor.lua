local fallout = require("fallout")

local start
local map_enter_p_proc
local pickup_p_proc
local use_p_proc
local use_skill_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    if self_tile_num == 25880 then
        fallout.set_external_var("Killian_store1_ptr", fallout.self_obj())
    elseif self_tile_num == 25874 then
        fallout.set_external_var("Killian_store2_ptr", fallout.self_obj())
    elseif self_tile_num == 26874 then
        fallout.set_external_var("Killian_store3_ptr", fallout.self_obj())
    elseif self_tile_num == 27470 then
        fallout.set_external_var("Killian_store4_ptr", fallout.self_obj())
    end
end

function pickup_p_proc()
    if fallout.action_being_used() ~= 10 and fallout.global_var(37) == 0 then
        fallout.script_overrides()
    end
end

function use_p_proc()
    if fallout.global_var(37) == 0 then
        fallout.script_overrides()
        local self_tile_num = fallout.tile_num(fallout.self_obj())
        if self_tile_num == 25880 then
            fallout.set_external_var("Killian_barter_var", 1)
        elseif self_tile_num == 25874 then
            fallout.set_external_var("Killian_barter_var", 2)
        elseif self_tile_num == 26874 then
            fallout.set_external_var("Killian_barter_var", 3)
        elseif self_tile_num == 27470 then
            fallout.set_external_var("Killian_barter_var", 4)
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 and fallout.global_var(37) == 0 then
        if not fallout.is_success(fallout.roll_vs_skill(fallout.source_obj(), 10, -10)) then
            fallout.script_overrides()
            fallout.set_external_var("Killian_barter_var", -1)
        end
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
