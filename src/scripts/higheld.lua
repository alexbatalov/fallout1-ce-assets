local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Meeting01
local Meeting02
local Meeting02a
local Meeting03
local Meeting04
local Meeting05
local Meeting05a
local Meeting06
local Meeting07
local Meeting08
local Meeting09
local Meeting10
local Meeting11
local Meeting12
local Meeting13
local Elder01
local Elder02
local Elder03
local Elder04
local Elder05
local Elder06
local Elder07
local Elder07a
local Elder08
local Elder09
local Elder10
local Elder11
local Elder12
local ElderEnd

local hostile = 0
local Only_Once = 1
local awardex = 0
local temp = 0

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
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 3) then
        if (fallout.map_var(19) == 1) and (fallout.local_var(5) == 0) then
            fallout.dialogue_system_enter()
        end
    end
    if fallout.global_var(250) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    get_reaction()
    if fallout.global_var(17) == 1 then
        fallout.start_gdialog(942, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Elder10()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        if fallout.local_var(1) == 1 then
            Elder12()
        else
            if fallout.local_var(5) == 1 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(942, 165), 2)
            else
                if (fallout.map_var(19) == 1) and (fallout.local_var(5) == 0) then
                    fallout.set_local_var(5, 1)
                    fallout.start_gdialog(942, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Meeting01()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    if fallout.local_var(4) == 0 then
                        fallout.set_local_var(4, 1)
                        fallout.start_gdialog(942, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Elder01()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    else
                        fallout.start_gdialog(942, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Elder04()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    end
                end
            end
        end
    end
    if awardex then
        if fallout.local_var(6) == 0 then
            fallout.set_local_var(6, 1)
            temp = 1500
            fallout.display_msg(fallout.message_str(942, 166) + temp + fallout.message_str(942, 167))
            fallout.give_exp_points(temp)
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
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(942, 100))
end

function Meeting01()
    fallout.gsay_reply(942, fallout.message_str(942, 134) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(942, 135) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(942, 136))
    fallout.giq_option(4, 942, 137, Meeting02, 50)
    fallout.giq_option(-3, 942, 138, Meeting13, 51)
end

function Meeting02()
    fallout.gsay_reply(942, 139)
    fallout.giq_option(6, 942, 140, Meeting02a, 50)
    fallout.giq_option(4, 942, 141, Meeting04, 50)
end

function Meeting02a()
    if fallout.global_var(166) == 1 then
        Meeting03()
    else
        Meeting04()
    end
end

function Meeting03()
    fallout.gsay_reply(942, 142)
    fallout.giq_option(6, 942, 143, Meeting04, 50)
end

function Meeting04()
    fallout.gsay_reply(942, 144)
    fallout.giq_option(4, 942, 145, Meeting05, 50)
    fallout.giq_option(-3, 942, 138, Meeting13, 51)
end

function Meeting05()
    fallout.gsay_reply(942, 146)
    if (fallout.global_var(149) < (fallout.game_time() // (10 * 60 * 60 * 24))) and (fallout.global_var(72) == 2) then
        fallout.giq_option(4, 942, 147, Meeting06, 50)
    end
    fallout.giq_option(4, 942, 148, Meeting05a, 50)
end

function Meeting05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Meeting06()
    else
        Meeting07()
    end
end

function Meeting06()
    fallout.gsay_reply(942, 149)
    fallout.giq_option(4, 942, 150, Meeting08, 50)
end

function Meeting07()
    fallout.gsay_reply(942, 151)
    fallout.giq_option(4, 942, fallout.message_str(942, 152) + fallout.message_str(942, 153), Meeting08, 50)
end

function Meeting08()
    fallout.gsay_reply(942, 154)
    fallout.giq_option(4, 942, 155, Meeting09, 50)
    if fallout.global_var(50) == 1 then
        fallout.giq_option(4, 942, 156, Meeting10, 50)
    end
end

function Meeting09()
    awardex = 1
    fallout.set_global_var(223, 2)
    fallout.gsay_message(942, 157, 50)
end

function Meeting10()
    fallout.gsay_reply(942, fallout.message_str(942, 158) + fallout.message_str(942, 159))
    fallout.giq_option(4, 942, 160, Meeting09, 50)
    fallout.giq_option(4, 942, 161, Meeting11, 50)
    fallout.giq_option(-3, 942, 138, Meeting13, 51)
end

function Meeting11()
    fallout.set_global_var(223, 1)
    fallout.gsay_message(942, 162, 50)
end

function Meeting12()
    fallout.set_global_var(223, 2)
end

function Meeting13()
    fallout.gsay_message(942, 164, 51)
end

function Elder01()
    fallout.gsay_reply(942, 101)
    fallout.giq_option(4, 942, 102, Elder02, 50)
    fallout.giq_option(4, 942, 103, Elder08, 50)
    fallout.giq_option(-3, 942, 104, Elder11, 51)
end

function Elder02()
    fallout.gsay_reply(942, fallout.message_str(942, 105) + fallout.message_str(942, 106) + fallout.message_str(942, 107))
    fallout.giq_option(4, 942, 108, Elder03, 50)
    fallout.giq_option(4, 942, 109, Elder09, 50)
    if fallout.global_var(78) == 2 then
        fallout.giq_option(4, 942, 110, Elder07, 50)
    end
end

function Elder03()
    fallout.gsay_reply(942, 111)
    fallout.giq_option(4, 942, 112, ElderEnd, 50)
end

function Elder04()
    fallout.gsay_reply(942, 113)
    if fallout.global_var(78) == 2 then
        fallout.giq_option(4, 942, 114, Elder05, 50)
    else
        fallout.giq_option(4, 942, 115, Elder06, 50)
    end
end

function Elder05()
    fallout.gsay_reply(942, 116)
    fallout.giq_option(4, 942, 117, Elder07, 50)
end

function Elder06()
    fallout.gsay_reply(942, 118)
    fallout.giq_option(4, 942, 119, ElderEnd, 50)
end

function Elder07()
    fallout.gsay_reply(942, 120)
    fallout.giq_option(4, 942, 121, ElderEnd, 50)
end

function Elder07a()
    fallout.set_local_var(1, 1)
end

function Elder08()
    fallout.gsay_reply(942, 122)
    fallout.giq_option(4, 942, 123, Elder02, 50)
    fallout.giq_option(4, 942, 124, Elder07a, 51)
    fallout.giq_option(4, 942, 125, Elder07a, 51)
end

function Elder09()
    fallout.gsay_reply(942, 126)
    fallout.giq_option(4, 942, 127, ElderEnd, 50)
end

function Elder10()
    fallout.gsay_reply(942, 128)
    fallout.giq_option(4, 942, 129, ElderEnd, 50)
    fallout.giq_option(-3, 942, 104, Elder11, 51)
end

function Elder11()
    fallout.gsay_message(942, 130, 51)
end

function Elder12()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(942, fallout.random(131, 133)), 2)
end

function ElderEnd()
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
