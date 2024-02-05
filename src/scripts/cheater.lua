local fallout = require("fallout")
local misc = require("lib.misc")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 1
local g2 = 0

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Cheater00a
local Cheater00
local Cheater01
local Cheater02
local Cheater03
local Cheater04
local Cheater05
local Cheater06
local Cheater06a
local Cheater06b
local Cheater06c
local Cheater06d
local Cheater06e
local Cheater07
local Cheater08
local CheaterEnd

-- ?import? variable hostile
-- ?import? variable Only_Once
-- ?import? variable Sid_Ptr

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

function start()
    if g1 then
        g1 = 0
        misc.set_team(fallout.self_obj(), 84)
        misc.set_ai(fallout.self_obj(), 0)
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
    g0 = 1
end

function critter_p_proc()
    if g0 then
        g0 = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        g0 = 1
    end
end

function talk_p_proc()
    get_reaction()
    fallout.start_gdialog(621, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Cheater00a()
    fallout.gsay_end()
    fallout.end_dialogue()
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
    fallout.display_msg("You see a cheating person.")
end

function Cheater00a()
    fallout.gsay_reply(621, "How may I Cheat you today?")
    fallout.giq_option(1, 621, "Experience Points.", Cheater00, 50)
    fallout.giq_option(1, 621, "Damage.", Cheater06, 50)
    fallout.giq_option(1, 621, "Poison", Cheater07, 50)
    fallout.giq_option(1, 621, "Radiation", Cheater08, 50)
    fallout.giq_option(1, 621, "Nothing.", CheaterEnd, 50)
end

function Cheater00()
    fallout.gsay_reply(621, "How much Exp Points do you want?")
    fallout.giq_option(1, 621, "500", Cheater01, 50)
    fallout.giq_option(1, 621, "1000", Cheater02, 50)
    fallout.giq_option(1, 621, "5000", Cheater03, 50)
    fallout.giq_option(1, 621, "10000", Cheater04, 50)
    fallout.giq_option(1, 621, "20000", Cheater05, 50)
    fallout.giq_option(1, 621, "Nevermind", CheaterEnd, 50)
end

function Cheater01()
    fallout.give_exp_points(500)
    fallout.gsay_message(621, "Ok, you have them.", 50)
    Cheater00()
end

function Cheater02()
    fallout.give_exp_points(1000)
    fallout.gsay_message(621, "Ok, you have them.", 50)
    Cheater00()
end

function Cheater03()
    fallout.give_exp_points(5000)
    fallout.gsay_message(621, "Ok, you have them.", 50)
    Cheater00()
end

function Cheater04()
    fallout.give_exp_points(10000)
    fallout.gsay_message(621, "Ok, you have them.", 50)
    Cheater00()
end

function Cheater05()
    fallout.give_exp_points(20000)
    fallout.gsay_message(621, "Ok, you have them.", 50)
    Cheater00()
end

function Cheater06()
    fallout.gsay_reply(621, "How might I abuse you today?")
    fallout.giq_option(1, 621, "Cripple Left Leg", Cheater06a, 50)
    fallout.giq_option(1, 621, "Cripple Right Leg", Cheater06b, 50)
    fallout.giq_option(1, 621, "Cripple Left Arm", Cheater06c, 50)
    fallout.giq_option(1, 621, "Cripple Right Arm", Cheater06d, 50)
    fallout.giq_option(1, 621, "Blind Me ", Cheater06e, 50)
    fallout.giq_option(1, 621, "Don't hurt me.", Cheater00a, 50)
end

function Cheater06a()
    fallout.critter_injure(fallout.dude_obj(), 4)
    fallout.gsay_message(621, "[Grinning Visciously] I was happy to Help you", 50)
    Cheater00a()
end

function Cheater06b()
    fallout.critter_injure(fallout.dude_obj(), 8)
    fallout.gsay_message(621, "[Grinning Visciously] I was happy to Help you", 50)
    Cheater00a()
end

function Cheater06c()
    fallout.critter_injure(fallout.dude_obj(), 4)
    fallout.gsay_message(621, "[Grinning Visciously] I was happy to Help you", 50)
    Cheater00a()
end

function Cheater06d()
    fallout.critter_injure(fallout.dude_obj(), 16)
    fallout.gsay_message(621, "[Grinning Visciously] I was happy to Help you", 50)
    Cheater00a()
end

function Cheater06e()
    fallout.critter_injure(fallout.dude_obj(), 32)
    fallout.gsay_message(621, "[Grinning Visciously] I was happy to Help you", 50)
    Cheater00a()
end

function Cheater07()
    fallout.poison(fallout.dude_obj(), 10)
    fallout.gsay_message(621, "[Hands you a Burrito Supreme] Enjoy your Grade D Beef.", 50)
    Cheater00a()
end

function Cheater08()
    fallout.radiation_inc(fallout.dude_obj(), 50)
    fallout.gsay_message(621, "Now you glow like a 50 watt light bulb.", 50)
    Cheater00a()
end

function CheaterEnd()
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
    g2 = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
