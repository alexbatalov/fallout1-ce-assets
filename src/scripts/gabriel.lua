local fallout = require("fallout")
local reputation = require("lib.reputation")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 1
local g1 = 0

local Start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local damage_p_proc
local destroy_p_proc
local critter_p_proc
local pickup_p_proc
local Gab01
local Gab02
local Gab03
local Gab04
local Gab05
local Gab06
local Gab07
local Gab08
local Gab09
local Gab09a
local Gab11
local Gab12
local Gab13
local Gab14
local Gab15
local Gab16
local Gab17
local Gab18
local Gab19
local Gab20
local Gab21
local Gab22
local Gab23
local Gab24
local Gab25
local Gab26
local Gab27
local Gab28
local GabBarter
local GabEnd

-- ?import? variable JonPtr
-- ?import? variable Initialize

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

-- ?import? variable exit_line

function Start()
    if g0 then
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(50, 150))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 48)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 28)
        g0 = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(156, 101))
    else
        fallout.display_msg(fallout.message_str(156, 100))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(156, 101))
    else
        fallout.display_msg(fallout.message_str(156, 100))
    end
end

function talk_p_proc()
    if fallout.global_var(617) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        get_reaction()
        fallout.start_gdialog(156, fallout.self_obj(), -1, -1, -1)
        fallout.gsay_start()
        if fallout.local_var(4) == 0 then
            if fallout.global_var(265) == 9250 then
                Gab17()
            else
                Gab01()
            end
        else
            if fallout.local_var(5) == 1 then
                if (fallout.local_var(8) == 0) and (fallout.global_var(613) == 2) then
                    fallout.set_local_var(8, 1)
                    Gab25()
                else
                    Gab27()
                end
            else
                if (fallout.global_var(614) == 9201) and (fallout.global_var(265) == 9250) then
                    Gab20()
                else
                    if fallout.global_var(614) == 9201 then
                        Gab13()
                    else
                        if (fallout.local_var(6) == 1) or (fallout.local_var(7) == 1) then
                            Gab24()
                        else
                            Gab12()
                        end
                    end
                end
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(617, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(617, 1)
        reputation.inc_good_critter()
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(617) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function pickup_p_proc()
    fallout.set_global_var(617, 1)
end

function Gab01()
    fallout.gsay_reply(156, 102)
    fallout.gsay_option(156, 103, Gab02, 50)
    fallout.gsay_option(156, 104, Gab04, 50)
end

function Gab02()
    fallout.gsay_reply(156, 105)
    fallout.gsay_option(156, 106, Gab03, 50)
    fallout.set_local_var(4, 1)
end

function Gab03()
    fallout.gsay_reply(156, 107)
    fallout.gsay_option(156, 108, Gab08, 50)
end

function Gab04()
    fallout.gsay_reply(156, 109)
    fallout.gsay_option(156, 110, Gab05, 50)
end

function Gab05()
    fallout.gsay_reply(156, 111)
    fallout.gsay_option(156, 112, Gab06, 50)
end

function Gab06()
    fallout.gsay_reply(156, 113)
    if fallout.global_var(265) == 9250 then
        fallout.gsay_option(156, 114, Gab19, 50)
    else
        fallout.gsay_option(156, 114, Gab07, 50)
    end
    fallout.gsay_option(156, 115, Gab08, 50)
end

function Gab07()
    fallout.gsay_reply(156, 116)
    fallout.gsay_option(156, 117, Gab03, 50)
end

function Gab08()
    fallout.gsay_reply(156, 118)
    fallout.gsay_option(156, 119, Gab09, 50)
    if fallout.global_var(613) == 9101 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.gsay_option(156, 170, Gab11, 50)
        else
            fallout.gsay_option(156, 171, Gab11, 50)
        end
    end
end

function Gab09()
    fallout.gsay_reply(156, 121)
    fallout.gsay_option(156, 122, Gab09a, 50)
    fallout.gsay_option(156, 123, GabEnd, 50)
    fallout.gsay_option(156, 124, Gab11, 50)
end

function Gab09a()
    fallout.set_global_var(614, 9201)
end

function Gab11()
    fallout.gsay_reply(156, 125)
    fallout.gsay_option(156, 126, Gab09a, 50)
    fallout.gsay_option(156, 127, GabEnd, 50)
end

function Gab12()
    fallout.gsay_reply(156, 128)
    fallout.gsay_option(156, 129, Gab04, 50)
    fallout.gsay_option(156, 130, GabEnd, 50)
end

function Gab13()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(156, 172)
    else
        fallout.gsay_reply(156, 173)
    end
    fallout.gsay_option(156, 132, Gab15, 50)
    fallout.gsay_option(156, 133, Gab14, 50)
end

function Gab14()
    fallout.gsay_reply(156, 134)
    fallout.gsay_option(156, 135, GabEnd, 50)
end

function Gab15()
    fallout.gsay_reply(156, 136)
    fallout.gsay_option(156, 137, GabEnd, 50)
end

function Gab16()
    fallout.gsay_reply(156, 138)
    fallout.gsay_option(156, 139, GabEnd, 50)
end

function Gab17()
    fallout.gsay_reply(156, 140)
    fallout.gsay_option(156, 141, Gab18, 50)
    fallout.gsay_option(156, 142, Gab04, 50)
end

function Gab18()
    fallout.gsay_reply(156, 143)
    fallout.gsay_option(156, 144, Gab20, 50)
    fallout.set_local_var(4, 1)
end

function Gab19()
    fallout.gsay_reply(156, 145)
    fallout.gsay_option(156, 146, Gab20, 50)
end

function Gab20()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(156, 174)
    else
        fallout.gsay_reply(156, 175)
    end
    fallout.gsay_option(156, 148, Gab21, 50)
    if fallout.global_var(613) == 9101 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.gsay_option(156, 170, Gab22, 50)
        else
            fallout.gsay_option(156, 171, Gab22, 50)
        end
    end
    fallout.gsay_option(156, 150, Gab23, 50)
end

function Gab21()
    fallout.gsay_reply(156, 151)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_option(156, 176, GabEnd, 50)
    else
        fallout.gsay_option(156, 177, GabEnd, 50)
    end
    if fallout.global_var(265) ~= 2 then
        fallout.set_global_var(265, 2)
        fallout.set_global_var(155, fallout.global_var(155) + 1)
        fallout.give_exp_points(1000)
        fallout.display_msg(fallout.message_str(766, 103) .. 1000 .. fallout.message_str(766, 104))
        fallout.set_local_var(6, 1)
    end
end

function Gab22()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(156, 178)
    else
        fallout.gsay_reply(156, 179)
    end
    fallout.gsay_option(156, 154, GabEnd, 50)
    if fallout.global_var(614) ~= 9202 then
        fallout.set_global_var(614, 9202)
        fallout.set_global_var(155, fallout.global_var(155) + 1)
        fallout.give_exp_points(1000)
        fallout.display_msg(fallout.message_str(766, 103) .. 1000 .. fallout.message_str(766, 104))
        fallout.set_local_var(5, 1)
    end
end

function Gab23()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(156, 180)
    else
        fallout.gsay_reply(156, 181)
    end
    fallout.gsay_option(156, 156, GabEnd, 50)
    UpReactLevel()
end

function Gab24()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(156, 182, 50)
    else
        fallout.gsay_message(156, 183, 50)
    end
end

function Gab25()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(156, 184)
    else
        fallout.gsay_reply(156, 185)
    end
    fallout.gsay_option(156, 159, Gab26, 50)
    fallout.gsay_option(156, 160, GabBarter, 50)
    fallout.gsay_option(156, 161, GabEnd, 50)
end

function Gab26()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(156, 186)
    else
        fallout.gsay_reply(156, 187)
    end
    fallout.gsay_option(156, 163, GabBarter, 50)
    fallout.gsay_option(156, 164, GabEnd, 50)
end

function Gab27()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(156, 184)
    else
        fallout.gsay_reply(156, 185)
    end
    fallout.gsay_option(156, 166, GabBarter, 50)
    fallout.gsay_option(156, 167, GabEnd, 50)
end

function Gab28()
    fallout.gsay_message(156, 168, 50)
end

function GabBarter()
    fallout.gsay_message(156, 188, 50)
end

function GabEnd()
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
    g1 = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
