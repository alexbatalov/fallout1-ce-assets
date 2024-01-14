local fallout = require("fallout")

local start
local use_obj_on_p_proc
local use_skill_on_p_proc
local turn_field_off

function start()
    local script_action = fallout.script_action()
    if script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 75 then
        fallout.script_overrides()
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, 0)) then
            turn_field_off()
        else
            fallout.display_msg(fallout.message_str(741, 100))
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 13 then
        fallout.script_overrides()
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, -20)) then
            turn_field_off()
        else
            fallout.display_msg(fallout.message_str(741, 100))
        end
    end
end

function turn_field_off()
    fallout.set_external_var("field_change", "off")
    fallout.display_msg(fallout.message_str(741, 101))
    if fallout.cur_map_index() == 31 then
        local self_obj = fallout.self_obj()
        local self_tile_num = fallout.tile_num(self_obj)
        if fallout.elevation(self_obj) == 0 then
            if self_tile_num == 15581 then
                fallout.use_obj(fallout.map_var(4))
            elseif self_tile_num == 19124 then
                fallout.use_obj(fallout.map_var(5))
            elseif self_tile_num == 25098 then
                fallout.use_obj(fallout.map_var(6))
            end
        end
    end
end

local exports = {}
exports.start = start
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
