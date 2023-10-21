local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 23 then
        map_update_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    end
end

function map_enter_p_proc()
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_animate_forever(fallout.self_obj(), 0)
    fallout.reg_anim_func(3, 0)
end

function map_update_p_proc()
    if fallout.combat_is_initialized() then
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate_forever(fallout.self_obj(), 0)
        fallout.reg_anim_func(3, 0)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
