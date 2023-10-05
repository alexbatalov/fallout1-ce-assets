local fallout = require("fallout")

local start
local use_obj_on_p_proc
local use_skill_on_p_proc
local turn_field_off

function start()
    if fallout.script_action() == 7 then
        use_obj_on_p_proc()
    else
        if fallout.script_action() == 8 then
            use_skill_on_p_proc()
        end
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
        if fallout.elevation(fallout.self_obj()) == 0 then
            if fallout.tile_num(fallout.self_obj()) == 15581 then
                fallout.use_obj(fallout.map_var(4))
            else
                if fallout.tile_num(fallout.self_obj()) == 19124 then
                    fallout.use_obj(fallout.map_var(5))
                else
                    if fallout.tile_num(fallout.self_obj()) == 25098 then
                        fallout.use_obj(fallout.map_var(6))
                    end
                end
            end
        end
    else
        if fallout.cur_map_index() == 32 then
        end
    end
end

local exports = {}
exports.start = start
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
