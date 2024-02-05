local fallout = require("fallout")
local misc = require("lib.misc")

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

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 71)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 13 then
        combat_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        if fallout.local_var(0) == 0 or fallout.local_var(1) == 0 then
            fallout.script_overrides()
        end
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.local_var(0) ~= 0
        and fallout.local_var(1) ~= 0
        and fallout.local_var(2) == 0
        and fallout.local_var(3) == 0
        and fallout.tile_distance_objs(self_obj, fallout.dude_obj()) < 12 then
        fallout.set_local_var(2, 1)
        fallout.dialogue_system_enter()
    end
    if fallout.local_var(3) == 1 then
        if fallout.tile_num(self_obj) ~= 20530 then
            fallout.animate_move_obj_to_tile(self_obj, 20530, 0)
        else
            local self_tile_num = fallout.tile_num(self_obj)
            local self_elevation = fallout.elevation(self_obj)
            fallout.set_external_var("field_change", "off")
            fallout.explosion(self_tile_num, fallout.elevation(self_obj), 0)
            fallout.explosion(fallout.tile_num_in_direction(self_tile_num, 5, 1), self_elevation, 0)
            fallout.explosion(fallout.tile_num_in_direction(self_tile_num, 0, 1), self_elevation, 0)
            fallout.explosion(fallout.tile_num_in_direction(self_tile_num, 5, 2), self_elevation, 0)
            fallout.explosion(fallout.tile_num_in_direction(self_tile_num, 0, 2), self_elevation, 0)
            fallout.display_msg(fallout.message_str(631, 117))
            fallout.give_exp_points(1000)
            fallout.critter_dmg(self_obj, 250, 6)
            fallout.set_local_var(3, 2)
        end
    end
end

function description_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.display_msg(fallout.message_str(631, 100))
    elseif fallout.local_var(1) == 0 then
        fallout.display_msg(fallout.message_str(631, 101))
        local dude_obj = fallout.dude_obj()
        if fallout.get_critter_stat(dude_obj, 4) > fallout.get_critter_stat(dude_obj, 1) + fallout.has_trait(0, dude_obj, 0) then
            if fallout.is_success(fallout.do_check(dude_obj, 4, 0)) then
                fallout.display_msg(fallout.message_str(631, 102))
            end
        else
            if fallout.is_success(fallout.do_check(dude_obj, 1, fallout.has_trait(0, dude_obj, 0))) then
                fallout.display_msg(fallout.message_str(631, 102))
            end
        end
    end
end

function talk_p_proc()
    if fallout.local_var(0) ~= 0 and fallout.local_var(1) ~= 0 then
        fallout.start_gdialog(631, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        MrHandyC00()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    if skill == 10 then
        fallout.script_overrides()
    elseif skill == 12 then
        if fallout.local_var(0) == 0 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(631, 103))
        elseif fallout.local_var(1) == 0 then
            fallout.script_overrides()
            fallout.game_time_advance(fallout.game_ticks(300))
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, 0)) then
                fallout.display_msg(fallout.message_str(631, 105))
                fallout.set_local_var(1, 1)
            else
                fallout.display_msg(fallout.message_str(631, 106))
            end
        end
    elseif skill == 13 then
        if fallout.local_var(0) == 0 then
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
