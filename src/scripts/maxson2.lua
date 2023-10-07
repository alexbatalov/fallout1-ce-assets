local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Maxson01
local Maxson02
local Maxson02a
local Maxson03
local Maxson04
local Maxson04a
local Maxson05
local Maxson06
local Maxson07
local Maxson08
local Maxson08a
local Maxson09
local Maxson09a
local Maxson10
local Maxson11
local Maxson12
local Maxson13
local Maxson14
local Maxson15
local Maxson16
local Maxson17
local Maxson18
local Maxson19
local Maxson20
local Maxson21
local Maxson22
local Maxson23
local Maxson24
local Maxson25
local Maxson26
local Maxson27
local Maxson28
local Maxson29
local Maxson30
local Maxson31
local Maxson32
local Maxson33
local Maxson34
local MaxsonEnd
local Remove_Player

local hostile = 0
local Only_Once = 1
local Denounce_Player = 0

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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 80)
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
    if fallout.global_var(250) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
    if hostile then
        fallout.set_global_var(250, 1)
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
    fallout.start_gdialog(52, fallout.self_obj(), 4, 12, 5)
    fallout.gsay_start()
    if (fallout.global_var(223) == 1) or (fallout.global_var(223) == 2) then
        Maxson34()
    else
        if fallout.local_var(5) == 1 then
            Maxson22()
        else
            if fallout.global_var(78) == 2 then
                Maxson20()
            else
                if fallout.local_var(4) == 0 then
                    fallout.set_local_var(4, 1)
                    Maxson01()
                else
                    if fallout.local_var(1) == 1 then
                        Maxson21()
                    else
                        Maxson19()
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if Denounce_Player == 1 then
        Remove_Player()
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
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
        if (fallout.global_var(159) % 5) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(52, 100))
end

function Maxson01()
    fallout.gsay_reply(52, 106)
    fallout.giq_option(-3, 52, 333, Maxson32, 50)
    if fallout.global_var(106) == 2 then
        fallout.giq_option(4, 52, 300, Maxson14, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 52, 301, Maxson06, 50)
    end
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson02()
    fallout.gsay_reply(52, 162)
    fallout.giq_option(4, 52, 302, Maxson04, 50)
    fallout.giq_option(4, 52, 303, Maxson09, 50)
    fallout.giq_option(4, 52, 304, Maxson02a, 51)
    fallout.giq_option(4, 52, 305, Maxson08, 50)
end

function Maxson02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, 0)) then
        Maxson09()
    else
        Maxson12()
    end
end

function Maxson03()
end

function Maxson04()
    fallout.gsay_reply(52, 133)
    fallout.giq_option(4, 52, 306, Maxson04a, 50)
    fallout.giq_option(4, 52, 307, Maxson27, 50)
    fallout.giq_option(4, 52, 308, MaxsonEnd, 50)
end

function Maxson04a()
    fallout.set_map_var(20, 1)
    Maxson05()
end

function Maxson05()
    fallout.gsay_reply(52, 276)
    fallout.giq_option(4, 52, 309, MaxsonEnd, 50)
end

function Maxson06()
    fallout.gsay_reply(52, 122)
    fallout.giq_option(4, 52, 310, Maxson07, 50)
    fallout.giq_option(4, 52, 311, Maxson02, 50)
end

function Maxson07()
    fallout.gsay_reply(52, 128)
    fallout.giq_option(4, 52, 312, Maxson14, 50)
    fallout.giq_option(4, 52, 313, Maxson13, 50)
end

function Maxson08()
    fallout.gsay_reply(52, 184)
    fallout.giq_option(4, 52, 314, Maxson18, 50)
    fallout.giq_option(4, 52, 315, Maxson04a, 50)
    fallout.giq_option(4, 52, 316, Maxson08a, 50)
end

function Maxson08a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, -20)) then
        Maxson04()
    else
        Maxson10()
    end
end

function Maxson09()
    fallout.gsay_reply(52, 223)
    fallout.giq_option(4, 52, 317, Maxson09a, 51)
    fallout.giq_option(4, 52, 318, Maxson18, 50)
    fallout.giq_option(4, 52, 319, MaxsonEnd, 50)
end

function Maxson09a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, -10)) then
        Maxson10()
    else
        Maxson11()
    end
end

function Maxson10()
    DownReact()
    fallout.gsay_reply(52, 226)
    fallout.giq_option(4, 52, 320, MaxsonEnd, 51)
end

function Maxson11()
    fallout.gsay_message(52, 229, 51)
    Denounce_Player = 1
end

function Maxson12()
    fallout.gsay_message(52, 229, 51)
    Denounce_Player = 1
end

function Maxson13()
    fallout.gsay_message(52, 231, 51)
    Denounce_Player = 1
end

function Maxson14()
    fallout.gsay_reply(52, 146)
    fallout.giq_option(4, 52, 321, Maxson02, 50)
end

function Maxson15()
    fallout.gsay_reply(52, 141)
    fallout.giq_option(4, 52, 322, Maxson02, 50)
    fallout.giq_option(4, 52, 323, Maxson16, 50)
end

function Maxson16()
    fallout.gsay_reply(52, 223)
    fallout.giq_option(4, 52, 324, Maxson17, 50)
    fallout.giq_option(4, 52, 325, Maxson18, 50)
    fallout.giq_option(4, 52, 326, Maxson17, 50)
end

function Maxson17()
    fallout.gsay_reply(52, 168)
    fallout.giq_option(4, 52, 327, MaxsonEnd, 51)
end

function Maxson18()
    fallout.gsay_message(52, 222, 50)
end

function Maxson19()
    fallout.gsay_reply(52, 201)
    fallout.giq_option(-3, 52, 333, Maxson32, 50)
    fallout.giq_option(4, 52, 329, Maxson14, 50)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 52, 330, Maxson06, 50)
    end
    fallout.giq_option(4, 52, 332, Maxson27, 50)
    fallout.giq_option(4, 52, 331, Maxson18, 50)
end

function Maxson20()
    fallout.gsay_reply(52, 193)
    fallout.giq_option(-3, 52, 333, Maxson32, 50)
    fallout.giq_option(4, 52, 334, Maxson22, 50)
    fallout.giq_option(4, 52, 335, Maxson27, 50)
    fallout.giq_option(4, 52, 336, Maxson18, 50)
end

function Maxson21()
    fallout.gsay_reply(52, 201)
    fallout.giq_option(-3, 52, 333, Maxson32, 50)
    fallout.giq_option(4, 52, 334, Maxson22, 50)
    fallout.giq_option(4, 52, 335, Maxson27, 50)
    fallout.giq_option(4, 52, 336, Maxson18, 50)
end

function Maxson22()
    fallout.gsay_reply(52, 205)
    if fallout.global_var(78) ~= 2 then
        fallout.giq_option(4, 52, 337, Maxson18, 50)
    else
        if fallout.global_var(18) == 1 then
            fallout.giq_option(4, 52, 338, Maxson23, 50)
        else
            fallout.giq_option(4, 52, 339, Maxson06, 50)
        end
    end
end

function Maxson23()
    fallout.gsay_reply(52, 213)
    fallout.giq_option(4, 52, 340, Maxson24, 50)
end

function Maxson24()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(52, 219)
    fallout.giq_option(4, 52, 341, Maxson25, 50)
    fallout.giq_option(4, 52, 342, Maxson33, 50)
end

function Maxson25()
    fallout.set_map_var(19, 1)
    fallout.gsay_message(52, 221, 50)
end

function Maxson26()
    fallout.gsay_reply(52, 210)
    fallout.giq_option(4, 52, 343, Maxson23, 50)
end

function Maxson27()
    fallout.gsay_reply(52, fallout.random(138, 140))
    if fallout.local_var(6) == 0 then
        fallout.giq_option(4, 52, 344, Maxson28, 50)
    end
    fallout.giq_option(4, 52, 345, Maxson29, 50)
    fallout.giq_option(4, 52, 346, Maxson30, 50)
    fallout.giq_option(4, 52, 347, Maxson31, 50)
    fallout.giq_option(4, 52, 348, Maxson18, 50)
end

function Maxson28()
    local v0 = 0
    fallout.set_local_var(6, 1)
    v0 = fallout.create_object_sid(216, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_reply(52, 186)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson29()
    fallout.gsay_reply(52, 172)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson30()
    fallout.gsay_reply(52, 244)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson31()
    fallout.gsay_reply(52, 262)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson32()
    fallout.gsay_reply(52, 275)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson33()
    fallout.gsay_reply(52, 156)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson34()
    fallout.gsay_reply(52, 193)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function MaxsonEnd()
end

function Remove_Player()
    fallout.set_global_var(108, 5)
    fallout.set_global_var(583, 0)
    fallout.set_global_var(584, 0)
    fallout.set_global_var(585, 0)
    fallout.set_global_var(586, 0)
    fallout.world_map()
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
