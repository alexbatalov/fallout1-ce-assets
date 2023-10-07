local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Falcon00
local Falcon01
local Falcon02
local Falcon03
local Falcon04
local Falcon05
local Falcon05a
local Falcon06
local Falcon06a
local Falcon07
local Falcon07a
local Falcon09
local Falcon11
local Falcon14
local Falcon15
local Falcon16
local FalconEnd

local hostile = 0
local Only_Once = 1
local First_Water = 0
local Money_Pack = 0
local Money_Count = 0
local item = 0

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

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 38)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    get_reaction()
    fallout.start_gdialog(697, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Falcon00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(697, 100))
end

function Falcon00()
    fallout.gsay_reply(697, 101)
    fallout.giq_option(4, 697, 102, Falcon05, 50)
    fallout.giq_option(4, 697, 103, Falcon06, 50)
    fallout.giq_option(4, 697, 104, Falcon07, 50)
    fallout.giq_option(4, 697, 106, Falcon04, 50)
    fallout.giq_option(-3, 697, 107, Falcon03, 50)
end

function Falcon01()
    fallout.gsay_message(697, 108, 50)
end

function Falcon02()
    fallout.gsay_message(697, 109, 50)
end

function Falcon03()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(697, 110, 50)
    else
        fallout.gsay_message(697, 111, 50)
    end
end

function Falcon04()
    fallout.gsay_message(697, 112, 50)
end

function Falcon05()
    fallout.gsay_reply(697, 113)
    fallout.giq_option(4, 697, 114, Falcon05a, 50)
    fallout.giq_option(4, 697, 115, Falcon11, 50)
end

function Falcon05a()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 41) >= 2 then
        Falcon09()
    else
        Falcon01()
    end
end

function Falcon06()
    fallout.gsay_reply(697, 116)
    fallout.giq_option(4, 697, 117, Falcon06a, 50)
    fallout.giq_option(4, 697, 115, Falcon11, 50)
end

function Falcon06a()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 41) < 5 then
        Falcon01()
    else
        Falcon14()
    end
end

function Falcon07()
    fallout.gsay_reply(697, 118)
    fallout.giq_option(4, 697, 117, Falcon07a, 50)
    fallout.giq_option(4, 697, 115, Falcon11, 50)
end

function Falcon07a()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 41) < 10 then
        Falcon01()
    else
        Falcon16()
    end
end

function Falcon09()
    if First_Water then
        fallout.gsay_reply(697, fallout.message_str(697, 139) .. fallout.message_str(697, 140) .. fallout.message_str(697, 141))
    else
        fallout.gsay_reply(697, fallout.message_str(697, 136) .. fallout.message_str(697, 137) .. fallout.message_str(697, 138))
    end
    Money_Pack = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 41)
    Money_Count = fallout.rm_mult_objs_from_inven(fallout.dude_obj(), Money_Pack, 2)
    fallout.destroy_object(Money_Pack)
    First_Water = 1
    Falcon15()
end

function Falcon11()
    if fallout.random(0, 1) then
        fallout.gsay_message(697, fallout.message_str(697, 151) .. fallout.message_str(697, 152), 50)
    else
        fallout.gsay_message(697, fallout.message_str(697, 153) .. fallout.message_str(697, 154), 50)
    end
end

function Falcon14()
    Money_Pack = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 41)
    Money_Count = fallout.rm_mult_objs_from_inven(fallout.dude_obj(), Money_Pack, 5)
    fallout.destroy_object(Money_Pack)
    item = fallout.create_object_sid(124, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    fallout.gsay_reply(697, fallout.message_str(697, 160) .. fallout.message_str(697, 161))
    Falcon15()
end

function Falcon15()
    fallout.giq_option(4, 697, 102, Falcon05, 50)
    fallout.giq_option(4, 697, 103, Falcon06, 50)
    fallout.giq_option(4, 697, 104, Falcon07, 50)
    fallout.giq_option(4, 697, 106, Falcon04, 50)
    fallout.giq_option(-3, 697, 107, Falcon03, 50)
end

function Falcon16()
    Money_Pack = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 41)
    Money_Count = fallout.rm_mult_objs_from_inven(fallout.dude_obj(), Money_Pack, 10)
    fallout.destroy_object(Money_Pack)
    item = fallout.create_object_sid(125, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    fallout.gsay_reply(697, fallout.message_str(697, 163) .. fallout.message_str(697, 164))
    Falcon15()
end

function FalconEnd()
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
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
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

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
