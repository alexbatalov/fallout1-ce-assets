local fallout = require("fallout")

local start
local description_p_proc
local look_at_p_proc
local spatial_p_proc
local use_skill_on_p_proc
local deallocate
local detonate
local plasma_death

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 2 then
        spatial_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    local message = fallout.message_str(611, 100)
    if fallout.local_var(0) == 0 then
        local dude_obj = fallout.dude_obj()
        if not fallout.is_success(fallout.do_check(dude_obj, 1, fallout.has_trait(0, dude_obj, 0))) then
            message = fallout.message_str(611, 101)
        else
            fallout.set_local_var(0, 1)
        end
    end
    fallout.display_msg(message)
end

function look_at_p_proc()
    if fallout.map_var(10) == 1 then
        fallout.script_overrides()
        deallocate()
    end
end

function spatial_p_proc()
    if fallout.map_var(10) == 1 then
        deallocate()
    else
        local dude_obj = fallout.dude_obj()
        if fallout.source_obj() == dude_obj then
            if fallout.map_var(7) == 1 then
                detonate()
            else
                if fallout.is_success(fallout.do_check(dude_obj, 1, fallout.has_trait(0, dude_obj, 0) - 3)) then
                    fallout.script_overrides()
                    local message = fallout.message_str(613, 100)
                    if fallout.is_success(fallout.roll_vs_skill(dude_obj, 11, 10)) then
                        message = message .. fallout.message_str(613, 101)
                    end
                    fallout.set_local_var(0, 1)
                    fallout.display_msg(message)
                end
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 11 then
        if fallout.local_var(0) ~= 0 then
            fallout.script_overrides()
            local roll = fallout.roll_vs_skill(fallout.dude_obj(), 11, 10)
            if fallout.is_success(roll) then
                fallout.display_msg(fallout.message_str(613, 102))
                local item_obj = fallout.create_object_sid(26, 0, 0, -1)
                fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
                deallocate()
            else
                if fallout.is_critical(roll) then
                    fallout.display_msg(fallout.message_str(613, 103))
                    detonate()
                else
                    fallout.display_msg(fallout.message_str(613, fallout.random(104, 106)))
                end
            end
        end
    end
end

function deallocate()
    local self_obj = fallout.self_obj()
    fallout.move_to(self_obj, 7000, 0)
    fallout.set_map_var(10, 1)
    fallout.set_external_var("removal_ptr", self_obj)
end

function detonate()
    local dude_obj = fallout.dude_obj()
    fallout.explosion(fallout.tile_num(dude_obj), fallout.elevation(dude_obj), fallout.random(10, 20))
    deallocate()
end

function plasma_death()
    local dude_obj = fallout.dude_obj()
    fallout.explosion(fallout.tile_num(dude_obj), fallout.elevation(dude_obj), 0)
    fallout.reg_anim_func(2, dude_obj)
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_animate(dude_obj, 32, -1)
    fallout.reg_anim_func(3, 0)
    fallout.game_ui_disable()
    fallout.add_timer_event(dude_obj, fallout.game_ticks(5), 8)
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.spatial_p_proc = spatial_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
