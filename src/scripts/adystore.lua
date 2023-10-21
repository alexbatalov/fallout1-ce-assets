local fallout = require("fallout")

local start
local map_update_p_proc
local map_enter_p_proc
local use_p_proc
local use_skill_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 23 then
        map_update_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function map_update_p_proc()
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    if self_tile_num == 12315 then
        fallout.set_external_var("AdyStor1_ptr", self_obj)
    elseif self_tile_num == 13115 then
        fallout.set_external_var("AdyStor2_ptr", self_obj)
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    if self_tile_num == 12315 then
        fallout.set_external_var("AdyStor1_ptr", self_obj)
    elseif self_tile_num == 13115 then
        fallout.set_external_var("AdyStor2_ptr", self_obj)
    end
end

function use_p_proc()
    fallout.script_overrides()

    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    if self_tile_num == 12315 then
        fallout.set_external_var("Tine_barter", 1)
    elseif self_tile_num == 13115 then
        fallout.set_external_var("Tine_barter", 2)
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        if not fallout.is_success(fallout.roll_vs_skill(fallout.source_obj(), fallout.action_being_used(), 0)) then
            fallout.script_overrides()
            fallout.set_external_var("Tine_barter", -1)
        end
    end
end

local exports = {}
exports.start = start
exports.map_update_p_proc = map_update_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
