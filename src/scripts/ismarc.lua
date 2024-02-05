local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Ismarc01
local Ismarc02
local Ismarc03
local Ismarc04
local Ismarc05
local Ismarc06
local Ismarc07
local Ismarc08
local Ismarc09
local Ismarc10
local Ismarc11
local Ismarc12
local IsmarcEnd

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = false
local singing = false
local song_line_base = 0
local song_line_offset = 0
local line05flag = false
local line06flag = false
local line07flag = false
local line08flag = false
local line11flag = false
local line12flag = false

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(4) == 0 then
            if fallout.tile_num(self_obj) ~= home_tile then
                fallout.animate_move_obj_to_tile(self_obj, home_tile, 0)
            else
                if fallout.has_trait(1, self_obj, 10) ~= 2 then
                    fallout.anim(self_obj, 1000, 2)
                end
            end
        end
        local game_time_hour = fallout.game_time_hour()
        if game_time_hour >= 1500 and game_time_hour <= 1900 and not singing then
            fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(30, 60)), 1)
            singing = true
        end
        behaviour.sleeping(4, night_person, wake_time, sleep_time, home_tile, sleep_tile)
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.global_var(15) == 1 then
        fallout.destroy_object(self_obj)
    end
    misc.set_team(self_obj, 26)
    if fallout.obj_is_carrying_obj_pid(self_obj, 41) == 0 then
        fallout.item_caps_adjust(self_obj, fallout.random(20, 50))
    end
    sleep_tile = 7000
    home_tile = 19089
    sleep_time = 2210
    wake_time = 1420
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(668, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Ismarc01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        if song_line_base == 0 then
            song_line_base = (fallout.random(0, 2) * 4) + 127
        end
        local self_obj = fallout.self_obj()
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(self_obj, 13, -1)
        fallout.reg_anim_animate(self_obj, 15, 3)
        fallout.reg_anim_animate(self_obj, 14, 3)
        fallout.reg_anim_animate(self_obj, 13, 3)
        fallout.reg_anim_animate(self_obj, 0, 3)
        fallout.reg_anim_func(3, 0)
        fallout.float_msg(self_obj, fallout.message_str(668, song_line_base + song_line_offset), 0)
        song_line_offset = song_line_offset + 1
        if song_line_offset < 4 then
            fallout.add_timer_event(self_obj, fallout.game_ticks(5), 1)
        else
            fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1800, 3600)), 2)
        end
    elseif event == 2 then
        singing = false
        song_line_offset = 0
        song_line_base = 0
    end
end

function Ismarc01()
    if fallout.local_var(1) < 2 then
        fallout.gsay_reply(668, 102)
    else
        fallout.gsay_reply(668, 103)
    end
    fallout.giq_option(4, 668, 104, Ismarc02, 49)
    fallout.giq_option(4, 668, 105, Ismarc03, 51)
    fallout.giq_option(4, 668, 106, IsmarcEnd, 50)
    fallout.giq_option(-3, 668, 107, Ismarc04, 51)
end

function Ismarc02()
    reaction.UpReact()
    if fallout.local_var(1) == 1 then
        Ismarc03()
    else
        fallout.gsay_reply(668, 109)
        Ismarc10()
    end
end

function Ismarc03()
    fallout.gsay_message(668, 108, 51)
end

function Ismarc04()
    fallout.gsay_message(668, 114, 51)
end

function Ismarc05()
    line05flag = true
    fallout.gsay_reply(668, 115)
    Ismarc09()
end

function Ismarc06()
    line06flag = true
    if fallout.global_var(73) < 1 then
        fallout.set_global_var(73, 1)
    end
    fallout.gsay_reply(668, 120)
    Ismarc09()
end

function Ismarc07()
    line07flag = true
    if fallout.global_var(74) < 1 then
        fallout.set_global_var(74, 1)
    end
    fallout.gsay_reply(668, 121)
    Ismarc09()
end

function Ismarc08()
    line08flag = true
    if fallout.global_var(75) < 1 then
        fallout.set_global_var(75, 1)
    end
    fallout.gsay_reply(668, 122)
    Ismarc09()
end

function Ismarc09()
    if not line06flag then
        fallout.giq_option(4, 668, 116, Ismarc06, 50)
    end
    if not line07flag then
        fallout.giq_option(4, 668, 117, Ismarc07, 50)
    end
    if not line08flag then
        fallout.giq_option(4, 668, 118, Ismarc08, 50)
    end
    fallout.giq_option(4, 668, 119, IsmarcEnd, 50)
end

function Ismarc10()
    if not line05flag then
        fallout.giq_option(4, 668, 110, Ismarc05, 50)
    end
    if not line11flag then
        fallout.giq_option(4, 668, 111, Ismarc11, 49)
    end
    if not line12flag then
        fallout.giq_option(4, 668, 112, Ismarc12, 50)
    end
    fallout.giq_option(4, 668, 113, IsmarcEnd, 50)
end

function Ismarc11()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 5 then
        reaction.UpReact()
        fallout.rm_mult_objs_from_inven(dude_obj, fallout.obj_carrying_pid_obj(dude_obj, 41), 5)
        local item_obj = fallout.create_object_sid(41, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.self_obj(), item_obj, 5)
        fallout.gsay_reply(668, 123)
        fallout.giq_option(0, 634, 106, Ismarc10, 49)
    else
        fallout.gsay_reply(668, 124)
        Ismarc10()
    end
end

function Ismarc12()
    fallout.gsay_reply(668, 125)
    Ismarc10()
end

function IsmarcEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
