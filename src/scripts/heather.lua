local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local heather0
local heather0a
local heather0b
local heather1
local heather1a
local heather2
local heather3
local heather3a
local heather3b
local heather3c
local heather4
local heather5
local heather5a
local heather6
local heather7
local heather8
local heather9
local heather10
local heather11
local heather12
local heather13
local heather14
local heather15
local heather16
local heather17
local heather18
local heather19
local heather20
local heather21
local heather22
local heather22a
local heather23
local heather24
local heather25
local heather26
local heather27
local heather28
local HeatherEnd
local combat

local hostile = 0
local initialized = 0

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
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
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
    if fallout.global_var(129) == 2 then
        fallout.kill_critter(fallout.self_obj(), 57)
    else
        if hostile then
            hostile = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
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
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
    fallout.set_global_var(133, 2)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(266, 100))
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    fallout.script_overrides()
    get_reaction()
    if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800) then
        fallout.start_gdialog(266, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        heather0()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        heather28()
    end
end

function heather0()
    fallout.gsay_reply(266, 101)
    fallout.giq_option(-3, 266, 102, combat, 50)
    fallout.giq_option(-3, 266, 103, HeatherEnd, 50)
    fallout.giq_option(4, 266, 104, heather0a, 50)
    fallout.giq_option(4, 266, 105, combat, 50)
    fallout.giq_option(6, 266, 106, heather0b, 50)
end

function heather0a()
    if fallout.local_var(1) < 2 then
        heather19()
    else
        heather1()
    end
end

function heather0b()
    if fallout.local_var(1) < 2 then
        heather27()
    else
        heather21()
    end
end

function heather1()
    fallout.gsay_reply(266, 107)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(4, 266, 108, heather2, 50)
    end
    if fallout.global_var(133) == 1 then
        fallout.giq_option(4, 266, 109, heather1a, 50)
    end
    fallout.giq_option(4, 266, 110, heather19, 50)
    fallout.giq_option(4, 266, 111, heather20, 50)
end

function heather1a()
    BigDownReact()
    heather3()
end

function heather2()
    fallout.gsay_message(266, 112, 50)
end

function heather3()
    fallout.gsay_reply(266, 113)
    fallout.giq_option(5, 266, 114, heather3a, 50)
    fallout.giq_option(4, 266, 115, heather3b, 50)
    fallout.giq_option(4, 266, 116, heather3c, 50)
    fallout.giq_option(4, 266, 117, HeatherEnd, 50)
end

function heather3a()
    DownReact()
    heather4()
end

function heather3b()
    UpReact()
    heather10()
end

function heather3c()
    BigDownReact()
    heather8()
end

function heather4()
    fallout.gsay_reply(266, 118)
    fallout.giq_option(5, 266, 119, heather5, 50)
    fallout.giq_option(6, 266, 120, heather10, 50)
    fallout.giq_option(7, 266, 121, heather17, 50)
end

function heather5()
    fallout.gsay_reply(266, 122)
    fallout.giq_option(5, 266, 123, heather5a, 50)
    fallout.giq_option(5, 266, 124, heather7, 50)
    fallout.giq_option(6, 266, 125, heather9, 50)
end

function heather5a()
    BigUpReact()
    heather6()
end

function heather6()
    fallout.gsay_message(266, 126, 50)
end

function heather7()
    fallout.gsay_reply(266, 127)
    fallout.giq_option(4, 266, 128, heather6, 50)
    fallout.giq_option(4, 266, 129, heather8, 50)
end

function heather8()
    fallout.gsay_message(266, 130, 50)
    combat()
end

function heather9()
    fallout.gsay_reply(266, 131)
    fallout.giq_option(4, 266, 132, heather6, 50)
    fallout.giq_option(4, 266, 133, heather8, 50)
end

function heather10()
    fallout.gsay_reply(266, 134)
    fallout.giq_option(4, 266, 135, heather11, 50)
    fallout.giq_option(5, 266, 136, heather12, 50)
    fallout.giq_option(4, 266, 137, HeatherEnd, 50)
end

function heather11()
    fallout.gsay_reply(266, 138)
    fallout.giq_option(4, 266, 139, HeatherEnd, 50)
end

function heather12()
    fallout.gsay_reply(266, 140)
    fallout.giq_option(4, 266, 141, heather6, 50)
    fallout.giq_option(4, 266, 142, heather13, 50)
    fallout.giq_option(4, 266, 143, HeatherEnd, 50)
end

function heather13()
    fallout.gsay_reply(266, 144)
    fallout.giq_option(4, 266, 145, heather14, 50)
    fallout.giq_option(4, 266, 146, heather15, 50)
    fallout.giq_option(4, 266, 147, heather16, 50)
end

function heather14()
    fallout.gsay_reply(266, 148)
    fallout.giq_option(4, 266, 149, heather6, 50)
    fallout.giq_option(4, 266, 150, heather8, 50)
end

function heather15()
    fallout.gsay_reply(266, 151)
    fallout.giq_option(4, 266, 152, heather8, 50)
    fallout.giq_option(4, 266, 153, combat, 50)
end

function heather16()
    fallout.gsay_message(266, 154, 50)
end

function heather17()
    fallout.gsay_reply(266, 155)
    fallout.giq_option(4, 266, 156, heather8, 50)
    fallout.giq_option(4, 266, 157, heather18, 50)
end

function heather18()
    fallout.gsay_reply(266, 158)
    fallout.giq_option(4, 266, 159, heather8, 50)
    fallout.giq_option(4, 266, 160, heather6, 50)
end

function heather19()
    fallout.gsay_message(266, 161, 50)
end

function heather20()
    fallout.gsay_message(266, 162, 50)
end

function heather21()
    fallout.gsay_reply(266, 163)
    fallout.giq_option(6, 266, 164, heather22, 50)
    fallout.giq_option(6, 266, 165, heather26, 50)
    fallout.giq_option(6, 266, 166, heather25, 50)
end

function heather22()
    fallout.gsay_reply(266, 167)
    fallout.giq_option(6, 266, 168, heather22a, 50)
    fallout.giq_option(6, 266, 169, heather25, 50)
end

function heather22a()
    local v0 = 0
    if fallout.item_caps_total(fallout.dude_obj()) >= 300 then
        fallout.item_caps_adjust(fallout.dude_obj(), -300)
        fallout.item_caps_adjust(fallout.self_obj(), 300)
        heather23()
    else
        heather24()
    end
end

function heather23()
    fallout.gsay_message(266, 170, 50)
end

function heather24()
    fallout.gsay_message(266, 171, 50)
    combat()
end

function heather25()
    fallout.gsay_message(266, 172, 50)
end

function heather26()
    fallout.gsay_reply(266, 173)
    fallout.giq_option(6, 266, 174, heather22a, 50)
    fallout.giq_option(6, 266, 175, heather25, 50)
end

function heather27()
    fallout.gsay_message(266, 176, 50)
end

function heather28()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(266, 177), 0)
end

function HeatherEnd()
end

function combat()
    hostile = 1
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
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
