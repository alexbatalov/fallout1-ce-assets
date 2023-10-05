local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local Command01
local use_all_fields_on
local use_all_fields_off

local skill_roll = 0
local stat_roll = 0
local initialized = 0

function start()
    if not(initialized) then
        if fallout.global_var(146) then
            fallout.set_local_var(0, 1)
        end
        initialized = 1
    else
        if fallout.script_action() == 3 then
            description_p_proc()
        else
            if fallout.script_action() == 6 then
                use_p_proc()
            else
                if fallout.script_action() == 7 then
                    use_obj_on_p_proc()
                else
                    if fallout.script_action() == 8 then
                        use_skill_on_p_proc()
                    end
                end
            end
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(432, 100))
    fallout.display_msg(fallout.message_str(432, 101))
    if fallout.local_var(0) and not(fallout.local_var(2)) then
        Command01()
    end
end

function use_p_proc()
    local v0 = 0
    if fallout.local_var(0) and not(fallout.local_var(1)) then
        fallout.script_overrides()
        v0 = fallout.roll_vs_skill(fallout.dude_obj(), 16, 0)
        if fallout.is_success(v0) then
            fallout.display_msg(fallout.message_str(432, 109))
            fallout.set_local_var(1, 1)
            fallout.display_msg(fallout.message_str(432, 116))
            fallout.give_exp_points(800)
        else
            fallout.display_msg(fallout.message_str(432, 110))
        end
        fallout.game_time_advance(fallout.game_ticks(1200))
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 100 then
        if not(fallout.global_var(610)) then
            fallout.script_overrides()
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, 0)) then
                fallout.display_msg(fallout.message_str(432, 117))
                fallout.set_global_var(610, 1)
            else
                fallout.display_msg(fallout.message_str(432, 118))
            end
            fallout.game_time_advance(fallout.game_ticks(600))
        end
    end
end

function use_skill_on_p_proc()
    local v0 = 0
    if fallout.action_being_used() == 12 then
        fallout.script_overrides()
        v0 = fallout.roll_vs_skill(fallout.dude_obj(), fallout.action_being_used(), 0)
        if not(fallout.local_var(0)) then
            if fallout.is_success(v0) then
                fallout.display_msg(fallout.message_str(432, 102))
                fallout.set_external_var("field_change", "on")
                use_all_fields_on()
                fallout.set_local_var(0, 1)
            else
                fallout.display_msg(fallout.message_str(432, 103))
            end
            fallout.game_time_advance(fallout.game_ticks(300))
        else
            if not(fallout.local_var(1)) then
                if fallout.is_success(v0) then
                    fallout.display_msg(fallout.message_str(432, 104))
                else
                    fallout.display_msg(fallout.message_str(432, 105))
                end
                fallout.game_time_advance(fallout.game_ticks(300))
                Command01()
            else
                if not(fallout.local_var(2)) then
                    if fallout.is_success(v0) then
                        if fallout.is_critical(v0) then
                            fallout.display_msg(fallout.message_str(432, 106))
                            fallout.set_external_var("field_change", "off")
                            use_all_fields_off()
                        else
                            fallout.display_msg(fallout.message_str(432, 107))
                            fallout.set_external_var("field_change", "off")
                            fallout.set_map_var(16, 0)
                            fallout.set_map_var(17, 0)
                            fallout.set_map_var(18, 0)
                            fallout.set_map_var(19, 0)
                            fallout.set_map_var(20, 0)
                            fallout.set_map_var(21, 0)
                        end
                    else
                        fallout.display_msg(fallout.message_str(432, 108))
                    end
                    fallout.game_time_advance(fallout.game_ticks(1800))
                    fallout.set_local_var(2, 1)
                end
            end
        end
    end
end

function Command01()
    stat_roll = fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0))
    if not(fallout.local_var(1)) then
        if fallout.is_success(stat_roll) then
            if fallout.is_critical(stat_roll) then
                fallout.display_msg(fallout.message_str(432, 111))
            else
                fallout.display_msg(fallout.message_str(432, 112))
            end
        else
            if fallout.is_critical(stat_roll) then
                fallout.display_msg(fallout.message_str(432, 113))
            else
                fallout.display_msg(fallout.message_str(432, 114))
            end
        end
    else
        fallout.display_msg(fallout.message_str(432, 115))
    end
end

function use_all_fields_on()
    fallout.set_map_var(16, 1)
    fallout.set_map_var(17, 1)
    fallout.set_map_var(18, 1)
    fallout.set_map_var(19, 1)
    fallout.set_map_var(20, 1)
    fallout.set_map_var(21, 1)
    fallout.set_map_var(22, 1)
    fallout.set_map_var(23, 1)
end

function use_all_fields_off()
    fallout.set_map_var(16, 0)
    fallout.set_map_var(17, 0)
    fallout.set_map_var(18, 0)
    fallout.set_map_var(19, 0)
    fallout.set_map_var(20, 0)
    fallout.set_map_var(21, 0)
    fallout.set_map_var(22, 0)
    fallout.set_map_var(23, 0)
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
