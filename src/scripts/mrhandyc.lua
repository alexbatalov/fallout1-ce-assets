local fallout = require("fallout")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0

local start
local combat_p_proc
local critter_p_proc
local description_p_proc
local talk_p_proc
local use_skill_on_p_proc
local MrHandyC00
local MrHandyC01
local MrHandyC02
local MrHandyC03

-- ?import? variable initialized
-- ?import? variable removal_ptr
-- ?import? variable FieldH_Ptr

function start()
    if not(g0) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 71)
        g0 = 1
    end
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 13 then
            combat_p_proc()
        else
            if fallout.script_action() == 3 then
                description_p_proc()
            else
                if fallout.script_action() == 11 then
                    talk_p_proc()
                else
                    if fallout.script_action() == 8 then
                        use_skill_on_p_proc()
                    end
                end
            end
        end
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        if (fallout.local_var(0) == 0) or (fallout.local_var(1) == 0) then
            fallout.script_overrides()
        end
    end
end

function critter_p_proc()
    if fallout.local_var(0) and fallout.local_var(1) and (fallout.local_var(2) == 0) and (fallout.local_var(3) == 0) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12) then
        fallout.set_local_var(2, 1)
        fallout.dialogue_system_enter()
    end
    if fallout.local_var(3) == 1 then
        if fallout.tile_num(fallout.self_obj()) ~= 20530 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 20530, 0)
        else
            fallout.set_external_var("field_change", "off")
            fallout.explosion(fallout.tile_num(fallout.self_obj()), fallout.elevation(fallout.self_obj()), 0)
            fallout.explosion(fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), 5, 1), fallout.elevation(fallout.self_obj()), 0)
            fallout.explosion(fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), 0, 1), fallout.elevation(fallout.self_obj()), 0)
            fallout.explosion(fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), 5, 2), fallout.elevation(fallout.self_obj()), 0)
            fallout.explosion(fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), 0, 2), fallout.elevation(fallout.self_obj()), 0)
            fallout.display_msg(fallout.message_str(631, 117))
            fallout.give_exp_points(1000)
            fallout.critter_dmg(fallout.self_obj(), 250, 6)
            fallout.set_local_var(3, 2)
        end
    end
end

function description_p_proc()
    if not(fallout.local_var(0)) then
        fallout.display_msg(fallout.message_str(631, 100))
    else
        if not(fallout.local_var(1)) then
            fallout.display_msg(fallout.message_str(631, 101))
            if fallout.get_critter_stat(fallout.dude_obj(), 4) > (fallout.get_critter_stat(fallout.dude_obj(), 1) + fallout.has_trait(0, fallout.dude_obj(), 0)) then
                if fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 0)) then
                    fallout.display_msg(fallout.message_str(631, 102))
                end
            else
                if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0))) then
                    fallout.display_msg(fallout.message_str(631, 102))
                end
            end
        end
    end
end

function talk_p_proc()
    if fallout.local_var(0) and fallout.local_var(1) then
        fallout.start_gdialog(631, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        MrHandyC00()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
    end
    if fallout.action_being_used() == 12 then
        if not(fallout.local_var(0)) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(631, 103))
        else
            if not(fallout.local_var(1)) then
                fallout.script_overrides()
                fallout.game_time_advance(fallout.game_ticks(300))
                if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, 0)) then
                    fallout.display_msg(fallout.message_str(631, 105))
                    fallout.set_local_var(1, 1)
                else
                    fallout.display_msg(fallout.message_str(631, 106))
                end
            end
        end
    else
        if fallout.action_being_used() == 13 then
            if not(fallout.local_var(0)) then
                fallout.script_overrides()
                fallout.game_time_advance(fallout.game_ticks(12000))
                if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, 0)) then
                    fallout.display_msg(fallout.message_str(631, 101))
                    fallout.set_local_var(0, 1)
                else
                    fallout.display_msg(fallout.message_str(631, 104))
                end
            end
        end
    end
end

function MrHandyC00()
    fallout.gsay_reply(631, 107)
    fallout.giq_option(-3, 631, 108, MrHandyC01, 0)
    fallout.giq_option(4, 631, 109, MrHandyC02, 0)
    fallout.giq_option(4, 631, 110, MrHandyC01, 0)
end

function MrHandyC01()
    fallout.gsay_message(631, 111, 0)
    fallout.set_local_var(3, 1)
end

function MrHandyC02()
    fallout.gsay_reply(631, 112)
    fallout.giq_option(4, 631, 113, MrHandyC01, 0)
    fallout.giq_option(6, 631, 114, MrHandyC03, 0)
end

function MrHandyC03()
    fallout.gsay_reply(631, 115)
    fallout.giq_option(6, 631, 116, MrHandyC01, 0)
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
