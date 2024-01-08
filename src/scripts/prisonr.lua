local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local timed_event_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local prisonrcbt
local prisonrend
local prisonr00
local prisonr01
local prisonr02
local prisonr03
local prisonr04
local prisonr05
local prisonr06
local prisonr07
local prisonr08
local leave_map

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.local_var(3) > 9 then
            fallout.set_obj_visibility(self_obj, true)
        end
        fallout.critter_add_trait(self_obj, 1, 6, 30)
        fallout.critter_add_trait(self_obj, 1, 5, 40)
        initialized = true
    end

    -- FIXME: Get rid of this condition.
    if fallout.local_var(3) < 10 then
        local script_action = fallout.script_action()
        if script_action == 22 then
            timed_event_p_proc()
        elseif script_action == 11 then
            talk_p_proc()
        elseif script_action == 21 or script_action == 3 then
            look_at_p_proc()
        elseif script_action == 4 then
            pickup_p_proc()
        elseif script_action == 12 then
            critter_p_proc()
        elseif script_action == 18 then
            destroy_p_proc()
        end
    end
end

function pickup_p_proc()
    hostile = true
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        hostile = true
    end
end

function talk_p_proc()
    if fallout.local_var(1) == 0 then
        fallout.start_gdialog(89, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.map_var(6) ~= 0 then
            prisonr06()
        else
            if fallout.local_var(0) ~= 0 then
                prisonr05()
            else
                fallout.set_local_var(0, 1)
                prisonr00()
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(89, 126), 2)
    end
end

function critter_p_proc()
    if fallout.map_var(6) ~= 0 then
        if fallout.local_var(1) == 1 then
            leave_map()
        else
            local self_obj = fallout.self_obj()
            local dude_obj = fallout.dude_obj()
            if fallout.obj_can_see_obj(self_obj, dude_obj) and fallout.tile_distance_objs(self_obj, dude_obj) < 5 then
                fallout.dialogue_system_enter()
            end
        end
    else
        if hostile then
            hostile = false
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(89, 100))
end

function prisonrcbt()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 1)
end

function prisonrend()
end

function prisonr00()
    fallout.gsay_reply(89, 101)
    fallout.giq_option(4, 89, 102, prisonrend, 50)
    fallout.giq_option(-3, 89, 103, prisonr01, 50)
    fallout.giq_option(4, 89, 104, prisonr02, 50)
    fallout.giq_option(6, 89, 105, prisonr03, 50)
end

function prisonr01()
    fallout.gsay_message(89, 106, 50)
end

function prisonr02()
    fallout.gsay_message(89, 107, 50)
end

function prisonr03()
    fallout.gsay_reply(89, 108)
    fallout.giq_option(6, 89, 109, prisonr04, 50)
    fallout.giq_option(6, 89, 110, prisonr02, 50)
end

function prisonr04()
    fallout.gsay_reply(89, 111)
    fallout.giq_option(6, 89, 112, prisonr02, 50)
    fallout.giq_option(6, 89, 113, prisonrend, 50)
end

function prisonr05()
    fallout.gsay_message(89, 114, 50)
end

function prisonr06()
    fallout.set_local_var(2, 15863)
    fallout.set_local_var(3, 0)
    fallout.set_local_var(1, 1)
    fallout.give_exp_points(500)
    fallout.display_msg(fallout.message_str(89, 124) .. 500 .. fallout.message_str(89, 125))
    fallout.gsay_reply(89, 115)
    fallout.giq_option(4, 89, 116, prisonrend, 50)
    fallout.giq_option(5, 89, 117, prisonr07, 50)
    fallout.giq_option(-3, 89, 118, prisonrend, 50)
end

function prisonr07()
    fallout.gsay_reply(89, 119)
    fallout.giq_option(5, 89, 120, prisonr08, 50)
    fallout.giq_option(5, 89, 121, prisonrend, 50)
end

function prisonr08()
    fallout.gsay_reply(89, 122)
    fallout.giq_option(5, 89, 123, prisonrend, 50)
end

function leave_map()
    local self_obj = fallout.self_obj()
    if fallout.tile_num(self_obj) == fallout.local_var(2) then
        local cycle = fallout.local_var(3) + 1
        fallout.set_local_var(3, cycle)
        if cycle > 7 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
            fallout.set_local_var(3, 10)
            fallout.set_obj_visibility(self_obj, true)
            fallout.move_to(self_obj, 0, 0)
        else
            if cycle == 1 then
                fallout.set_local_var(2, 15863)
            elseif cycle == 2 then
                fallout.set_local_var(2, 13065)
            elseif cycle == 3 then
                fallout.set_local_var(2, 13081)
            elseif cycle == 4 then
                fallout.set_local_var(2, 14496)
            elseif cycle == 5 then
                fallout.set_local_var(2, 11900)
            elseif cycle == 6 then
                fallout.set_local_var(2, 8700)
            elseif cycle == 7 then
                fallout.set_local_var(2, 5900)
            end
            fallout.animate_move_obj_to_tile(self_obj, fallout.local_var(2), 0)
        end
    end
    fallout.animate_move_obj_to_tile(self_obj, fallout.local_var(2), 0)
end

local exports = {}
exports.start = start
return exports
