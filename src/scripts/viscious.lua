local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local moveme
local goto00
local goto00a
local goto01
local goto02
local goto03
local goto03a
local goto04
local goto05
local goto06
local goto07
local goto07a
local goto08
local gotoend
local gotocbt
local gotoret

local hostile = false
local initialized = false
local disguised = false
local armed = false
local moving = true
local home_tile = 0
local smoke_tile = 0
local indlog = false

function start()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.set_local_var(5, 1)
        fallout.set_local_var(6, 0)
        fallout.set_local_var(7, 22091)
    end
    if not initialized then
        home_tile = 23488
        smoke_tile = 21299
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 49)
        if fallout.local_var(0) == 1 then
            fallout.set_obj_visibility(self_obj, true)
            moving = false
        end
        initialized = true
    else
        if fallout.local_var(0) ~= 1 then
            local script_action = fallout.script_action()
            if script_action == 14 then
                damage_p_proc()
            elseif script_action == 11 then
                talk_p_proc()
            elseif script_action == 22 then
                timed_event_p_proc()
            elseif script_action == 4 then
                pickup_p_proc()
            elseif script_action == 12 then
                critter_p_proc()
            elseif script_action == 21 then
                look_at_p_proc()
            elseif script_action == 18 then
                destroy_p_proc()
            end
        end
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.start_gdialog(811, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    indlog = true
    armed = false
    disguised = false
    if misc.is_armed(fallout.dude_obj()) then
        armed = true
    end
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        if misc.party_member_count() > 1 then
            disguised = false
        else
            disguised = true
        end
    end
    if not disguised or armed then
        goto01()
    else
        if fallout.local_var(2) == 1 then
            goto08()
        else
            fallout.set_local_var(2, 1)
            goto00()
        end
    end
    indlog = false
    fallout.gsay_end()
    fallout.end_dialogue()
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if moving then
            moveme()
        end
    end
end

function damage_p_proc()
    if fallout.global_var(245) == 0 then
        fallout.set_global_var(245, 1)
    end
end

function destroy_p_proc()
    fallout.set_local_var(0, 1)
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(3) ~= 0 then
        fallout.display_msg(fallout.message_str(811, 302))
    else
        fallout.display_msg(fallout.message_str(811, 200))
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        moving = true
    end
end

function moveme()
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    if self_tile_num == fallout.local_var(7) then
        fallout.set_local_var(3, 0)
        if fallout.local_var(5) ~= 0 then
            fallout.set_local_var(6, fallout.local_var(6) + 1)
        else
            fallout.set_local_var(6, fallout.local_var(6) - 1)
        end
        if fallout.local_var(6) > 2 then
            fallout.set_local_var(3, 1)
            moving = false
            fallout.set_local_var(6, 1)
            fallout.set_local_var(5, 0)
            fallout.add_timer_event(self_obj, fallout.game_ticks(180), 1)
        elseif fallout.local_var(6) < 0 then
            moving = false
            fallout.set_local_var(6, 1)
            fallout.set_local_var(5, 1)
            fallout.add_timer_event(self_obj, fallout.game_ticks(600), 1)
        end
        if fallout.local_var(6) == 0 then
            fallout.set_local_var(7, home_tile)
        elseif fallout.local_var(6) == 1 then
            fallout.set_local_var(7, 22091)
        elseif fallout.local_var(6) == 2 then
            fallout.set_local_var(7, smoke_tile)
        end
    else
        fallout.animate_move_obj_to_tile(self_obj, fallout.local_var(7), 0)
    end
    if fallout.obj_can_see_obj(self_obj, fallout.dude_obj()) then
        armed = false
        disguised = false
        if misc.is_armed(fallout.dude_obj()) then
            armed = true
        end
        if misc.is_wearing_coc_robe(fallout.dude_obj()) then
            if misc.party_member_count() > 1 then
                disguised = false
            else
                disguised = true
            end
        end
        if not disguised or armed then
            if fallout.tile_distance_objs(self_obj, fallout.dude_obj()) < 6 then
                if fallout.local_var(1) < 1 then
                    fallout.set_local_var(1, 1)
                    fallout.add_timer_event(self_obj, fallout.game_ticks(15), 2)
                    fallout.dialogue_system_enter()
                end
            end
        end
    end
end

function goto00()
    fallout.gsay_reply(811, 202)
    fallout.giq_option(-3, 811, 203, goto01, 51)
    fallout.giq_option(4, 811, 204, goto02, 51)
    fallout.giq_option(7, 811, 205, goto00a, 50)
    fallout.giq_option(4, 811, 206, gotocbt, 51)
end

function goto00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        goto04()
    else
        goto03()
    end
end

function goto01()
    if indlog then
        fallout.gsay_message(811, 207, 51)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(811, 207), 2)
    end
    gotocbt()
end

function goto02()
    fallout.gsay_message(811, 208, 51)
    gotocbt()
end

function goto03()
    fallout.gsay_reply(811, 209)
    fallout.giq_option(4, 811, 210, gotocbt, 51)
    fallout.giq_option(7, 811, 211, goto03a, 50)
end

function goto03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        goto04()
    else
        goto02()
    end
end

function goto04()
    fallout.gsay_reply(811, 212)
    fallout.giq_option(7, 811, 213, gotoend, 50)
    fallout.giq_option(7, 811, 214, goto05, 50)
end

function goto05()
    fallout.gsay_reply(811, 215)
    fallout.giq_option(7, 811, 216, goto06, 50)
    fallout.giq_option(8, 811, 217, goto07, 51)
end

function goto06()
    fallout.gsay_message(811, 218, 50)
end

function goto07()
    fallout.gsay_reply(811, 219)
    fallout.giq_option(4, 811, 220, goto07a, 50)
    fallout.giq_option(4, 811, 221, gotocbt, 51)
end

function goto07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        goto06()
    else
        goto01()
    end
end

function goto08()
    if indlog then
        fallout.gsay_message(811, 222, 50)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(811, 222), 2)
    end
end

function gotoend()
end

function gotocbt()
    hostile = true
end

function gotoret()
end

local exports = {}
exports.start = start
return exports
