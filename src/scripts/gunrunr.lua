local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local Jon01
local Jon02
local Jon03
local Jon04
local Jon05
local Jon06
local Jon07
local Jon08
local Jon09
local Jon10
local Jon11
local Jon12
local Jon13
local Jon14
local Jon15
local Jon16
local Jon17
local JonQuest
local JonCombat
local JonEnd

local dinner = 0
local hostile = 0
local initialized = 0
local item = 0
local taking_outside = 0

local get_reaction
local ReactToLevel
local LevelToReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

local exit_line = 0

local description_p_proc

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 39)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 11 then
                            talk_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if fallout.local_var(4) == 0 then
                fallout.dialogue_system_enter()
            end
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 7) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) then
        fallout.display_msg(fallout.message_str(288, 100))
    else
        fallout.display_msg(fallout.message_str(288, 101))
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    get_reaction()
    fallout.start_gdialog(288, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if (fallout.global_var(138) == 2) and not(fallout.local_var(5)) then
        Jon12()
    else
        if fallout.global_var(126) == 1 then
            Jon14()
        else
            if fallout.global_var(128) == 1 then
                Jon09()
            else
                if (fallout.global_var(128) == 2) and (fallout.local_var(8) == 0) then
                    Jon16()
                else
                    if fallout.local_var(4) then
                        Jon13()
                    else
                        if fallout.local_var(1) < 2 then
                            Jon08()
                        else
                            Jon01()
                        end
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if taking_outside then
        fallout.gfade_out(600)
        fallout.move_to(fallout.dude_obj(), 10700, 0)
        fallout.gfade_in(600)
        taking_outside = 0
    end
    if fallout.local_var(8) == 1 then
        fallout.set_local_var(8, 2)
        fallout.gfade_out(600)
        fallout.game_time_advance(fallout.game_ticks(3600 * (1800 - fallout.game_time_hour())))
        fallout.critter_heal(fallout.dude_obj(), 5)
        fallout.display_msg(fallout.message_str(288, 151))
        fallout.gfade_in(600)
    end
end

function Jon01()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(288, 103)
    fallout.giq_option(4, 288, 104, Jon04, 50)
    fallout.giq_option(4, 288, 105, Jon03, 50)
    fallout.giq_option(4, 288, 106, Jon02, 50)
    fallout.giq_option(5, 288, 107, Jon06, 50)
    fallout.giq_option(4, 288, 108, Jon05, 50)
    fallout.giq_option(-3, 288, 109, Jon07, 50)
end

function Jon02()
    fallout.gsay_reply(288, 110)
    fallout.giq_option(4, 288, 111, Jon04, 50)
    fallout.giq_option(4, 288, 112, Jon03, 50)
    fallout.giq_option(4, 288, 113, Jon05, 50)
end

function Jon03()
    fallout.gsay_reply(288, 114)
    fallout.giq_option(4, 288, 115, Jon04, 50)
    fallout.giq_option(4, 288, 116, Jon05, 50)
end

function Jon04()
    fallout.gsay_message(288, 117, 50)
    fallout.gsay_message(288, 118, 50)
    JonQuest()
end

function Jon05()
    fallout.gsay_message(288, 119, 50)
    JonQuest()
end

function Jon06()
    fallout.gsay_reply(288, 120)
    DownReact()
    fallout.giq_option(4, 288, 121, Jon02, 50)
    fallout.giq_option(4, 288, 122, Jon05, 50)
end

function Jon07()
    fallout.gsay_reply(288, 123)
    fallout.giq_option(-3, 288, 124, JonQuest, 50)
    fallout.giq_option(-3, 288, 125, Jon05, 50)
end

function Jon08()
    fallout.gsay_reply(288, 126)
    fallout.giq_option(4, 288, 127, Jon02, 50)
    fallout.giq_option(4, 288, 128, Jon05, 50)
    fallout.giq_option(4, 288, 129, JonCombat, 50)
end

function Jon09()
    fallout.gsay_reply(288, 130)
    if fallout.local_var(7) == 0 then
        fallout.giq_option(4, 288, 131, Jon10, 50)
    end
    fallout.giq_option(4, 288, 132, Jon11, 50)
    if fallout.local_var(7) == 0 then
        fallout.giq_option(-3, 288, 133, Jon10, 50)
    end
    fallout.giq_option(-3, 288, 134, Jon11, 50)
end

function Jon10()
    local v0 = 0
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 116) and fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 114) then
        fallout.set_local_var(7, 1)
        v0 = fallout.create_object_sid(23, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
        v0 = fallout.create_object_sid(36, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), v0, 3)
        fallout.gsay_message(288, 135, 50)
        UpReact()
    else
        fallout.gsay_message(288, 136, 50)
    end
end

function Jon11()
    fallout.gsay_message(288, 137, 50)
end

function Jon12()
    fallout.item_caps_adjust(fallout.dude_obj(), 500)
    fallout.set_local_var(5, 1)
    fallout.gsay_message(288, fallout.message_str(288, 138) .. " " .. fallout.message_str(288, 139), 50)
    UpReact()
end

function Jon13()
    if fallout.local_var(1) == 1 then
        fallout.gsay_reply(288, 140)
    else
        fallout.gsay_reply(288, 141)
    end
    fallout.giq_option(-3, 288, 142, JonEnd, 50)
    if fallout.local_var(6) == 0 then
        fallout.giq_option(4, 288, 144, Jon15, 50)
    end
    fallout.giq_option(4, 288, 145, Jon16, 50)
    fallout.giq_option(4, 288, 146, JonEnd, 50)
end

function Jon14()
    fallout.gsay_message(288, 143, 50)
end

function Jon15()
    fallout.set_local_var(6, 1)
    if fallout.local_var(1) == 1 then
        fallout.gsay_message(288, 148, 50)
    else
        item = fallout.create_object_sid(35, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), item, 2)
        item = fallout.create_object_sid(29, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), item, 2)
        item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), item, 2)
        item = fallout.create_object_sid(125, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), item)
        fallout.gsay_message(288, 147, 49)
    end
end

function Jon16()
    if fallout.local_var(1) == 3 then
        fallout.gsay_reply(288, 150)
        fallout.giq_option(0, 634, 152, Jon17, 49)
    else
        fallout.gsay_message(288, 149, 50)
    end
end

function Jon17()
    fallout.set_local_var(8, 1)
end

function JonQuest()
    fallout.set_global_var(128, 1)
    taking_outside = 1
end

function JonCombat()
    hostile = 1
end

function JonEnd()
end

function get_reaction()
    if fallout.local_var(2) == 0 then
        fallout.set_local_var(0, 50)
        fallout.set_local_var(1, 2)
        fallout.set_local_var(2, 1)
        fallout.set_local_var(0, fallout.local_var(0) + (5 * fallout.get_critter_stat(fallout.dude_obj(), 3)) - 25)
        fallout.set_local_var(0, fallout.local_var(0) + (10 * fallout.has_trait(0, fallout.dude_obj(), 10)))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            end
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            end
        end
        if fallout.global_var(158) > 2 then
            fallout.set_local_var(0, fallout.local_var(0) - 30)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) > 34) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) > 34) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) - 20)
        end
        ReactToLevel()
    end
end

function ReactToLevel()
    if fallout.local_var(0) <= 25 then
        fallout.set_local_var(1, 1)
    else
        if fallout.local_var(0) <= 75 then
            fallout.set_local_var(1, 2)
        else
            fallout.set_local_var(1, 3)
        end
    end
end

function LevelToReact()
    if fallout.local_var(1) == 1 then
        fallout.set_local_var(0, fallout.random(1, 25))
    else
        if fallout.local_var(1) == 2 then
            fallout.set_local_var(0, fallout.random(26, 75))
        else
            fallout.set_local_var(0, fallout.random(76, 100))
        end
    end
end

function UpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 10)
    ReactToLevel()
end

function DownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 10)
    ReactToLevel()
end

function BottomReact()
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function TopReact()
    fallout.set_local_var(0, 100)
    fallout.set_local_var(1, 3)
end

function BigUpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 25)
    ReactToLevel()
end

function BigDownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 25)
    ReactToLevel()
end

function UpReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(1, 3)
    end
    LevelToReact()
end

function DownReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) - 1)
    if fallout.local_var(1) < 1 then
        fallout.set_local_var(1, 1)
    end
    LevelToReact()
end

function Goodbyes()
    exit_line = fallout.message_str(634, fallout.random(100, 105))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(288, 102))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.description_p_proc = description_p_proc
return exports
