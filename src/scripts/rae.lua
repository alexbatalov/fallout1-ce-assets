local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local special_end
local raejoin
local raetym
local rae00
local rae00a
local rae00b
local rae01
local rae01a
local rae02
local rae03
local rae03a
local rae03b
local rae03c
local rae04
local rae04a
local rae04b
local rae04c
local rae05
local rae05a
local rae05b
local rae06
local rae06a
local rae06b
local rae06c
local rae07
local rae07a
local rae07b
local rae07c
local rae08
local rae08a
local rae08b
local rae08c
local rae09
local rae10
local rae10a
local rae11
local rae11a
local rae11b
local rae12
local rae13
local rae13a
local rae13b
local rae13c
local rae14
local dialog_end

local hostile = 0
local Only_Once = 1
local movie = 0

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
                if fallout.script_action() == 22 then
                    if fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < 6 then
                        combat()
                    end
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
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
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
    fallout.start_gdialog(671, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 0 then
        rae00()
    else
        rae01()
    end
    fallout.set_local_var(4, 1)
    fallout.gsay_end()
    fallout.end_dialogue()
    if movie == 1 then
        fallout.play_gmovie(4)
        fallout.metarule(13, 0)
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
    fallout.display_msg(fallout.message_str(671, 100))
end

function special_end()
    movie = 1
end

function raejoin()
end

function raetym()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 1)
end

function rae00()
    fallout.gsay_reply(671, 102)
    fallout.giq_option(7, 671, 103, rae02, 50)
    fallout.giq_option(4, 671, 104, rae00a, 50)
    fallout.giq_option(4, 671, 105, rae00b, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 671, 106, combat, 50)
    end
    fallout.giq_option(4, 671, 107, dialog_end, 50)
    fallout.giq_option(-3, 671, 108, dialog_end, 50)
end

function rae00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        rae08()
    else
        rae12()
    end
end

function rae00b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        rae02()
    else
        rae12()
    end
end

function rae01()
    fallout.gsay_reply(671, 109)
    fallout.giq_option(7, 671, 110, rae01a, 50)
    fallout.giq_option(4, 671, 111, dialog_end, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 671, 112, combat, 50)
    end
    fallout.giq_option(4, 671, 113, rae02, 50)
    fallout.giq_option(4, 671, 114, dialog_end, 50)
end

function rae01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        rae03()
    else
        rae05()
    end
end

function rae02()
    fallout.gsay_reply(671, 115)
    fallout.giq_option(8, 671, 116, rae03, 50)
    fallout.giq_option(7, 671, 117, rae03, 50)
    fallout.giq_option(4, 671, 118, rae04, 50)
    fallout.giq_option(4, 671, 119, rae08, 50)
    fallout.giq_option(4, 671, 120, rae05, 50)
end

function rae03()
    fallout.gsay_reply(671, 121)
    fallout.giq_option(8, 671, 122, rae04, 50)
    fallout.giq_option(7, 671, 123, rae03a, 50)
    fallout.giq_option(4, 671, 124, rae03b, 50)
    fallout.giq_option(4, 671, 125, rae03c, 50)
end

function rae03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        rae04()
    else
        rae08()
    end
end

function rae03b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        rae05()
    else
        rae08()
    end
end

function rae03c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        rae08()
    else
        rae12()
    end
end

function rae04()
    fallout.gsay_reply(671, 126)
    fallout.giq_option(8, 671, 127, rae04a, 50)
    fallout.giq_option(4, 671, 128, rae12, 50)
    fallout.giq_option(4, 671, 129, rae04b, 50)
    fallout.giq_option(4, 671, 130, rae04c, 50)
end

function rae04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        rae05()
    else
        rae08()
    end
end

function rae04b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        rae05()
    else
        rae08()
    end
end

function rae04c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        rae08()
    else
        rae12()
    end
end

function rae05()
    fallout.gsay_reply(671, 131)
    fallout.giq_option(9, 671, 132, rae06, 50)
    fallout.giq_option(8, 671, 133, rae05a, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 671, 134, combat, 50)
    end
    fallout.giq_option(4, 671, 135, rae05b, 50)
    fallout.giq_option(4, 671, 136, rae07, 50)
    fallout.giq_option(4, 671, 137, dialog_end, 50)
end

function rae05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        rae08()
    else
        rae12()
    end
end

function rae05b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -25)) then
        rae06()
    else
        rae12()
    end
end

function rae06()
    fallout.gsay_reply(671, 138)
    fallout.giq_option(9, 671, 139, rae07, 50)
    fallout.giq_option(7, 671, 140, rae06a, 50)
    fallout.giq_option(4, 671, 141, rae06b, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 671, 142, rae06c, 50)
    end
end

function rae06a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        rae11()
    else
        rae12()
    end
end

function rae06b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        rae11()
    else
        rae08()
    end
end

function rae06c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -25)) then
        rae09()
    else
        rae12()
    end
end

function rae07()
    fallout.gsay_reply(671, 143)
    fallout.giq_option(9, 671, 144, rae11, 50)
    fallout.giq_option(7, 671, 145, rae08, 50)
    fallout.giq_option(4, 671, 146, rae07a, 50)
    fallout.giq_option(4, 671, 147, rae07b, 50)
    fallout.giq_option(4, 671, 148, rae07c, 50)
end

function rae07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        rae08()
    else
        rae12()
    end
end

function rae07b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        rae10()
    else
        rae12()
    end
end

function rae07c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        dialog_end()
    else
        rae12()
    end
end

function rae08()
    fallout.gsay_reply(671, 149)
    fallout.giq_option(8, 671, 150, rae13, 50)
    fallout.giq_option(7, 671, 151, rae08a, 50)
    fallout.giq_option(4, 671, 152, rae08b, 50)
    fallout.giq_option(4, 671, 153, rae08c, 50)
    fallout.giq_option(4, 671, 154, dialog_end, 50)
end

function rae08a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        rae09()
    else
        rae10()
    end
end

function rae08b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        rae11()
    else
        rae12()
    end
end

function rae08c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        rae13()
    else
        rae12()
    end
end

function rae09()
    fallout.gsay_message(671, 155, 50)
    raejoin()
end

function rae10()
    fallout.gsay_reply(671, 156)
    fallout.giq_option(4, 671, 157, dialog_end, 50)
    fallout.giq_option(4, 671, 158, rae10a, 50)
    fallout.giq_option(4, 671, 159, rae11, 50)
end

function rae10a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        rae09()
    else
        rae12()
    end
end

function rae11()
    fallout.gsay_reply(671, 160)
    fallout.giq_option(9, 671, 161, rae13, 50)
    fallout.giq_option(7, 671, 162, rae11a, 50)
    fallout.giq_option(4, 671, 163, rae11b, 50)
    fallout.giq_option(4, 671, 164, dialog_end, 50)
end

function rae11a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        rae13()
    else
        rae08()
    end
end

function rae11b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        rae13()
    else
        rae12()
    end
end

function rae12()
    fallout.gsay_message(671, 165, 50)
    raetym()
end

function rae13()
    fallout.gsay_reply(671, 166)
    fallout.giq_option(9, 671, 167, rae14, 50)
    fallout.giq_option(7, 671, 168, rae13a, 50)
    fallout.giq_option(4, 671, 169, rae13b, 50)
    fallout.giq_option(4, 671, 170, dialog_end, 50)
    fallout.giq_option(4, 671, 171, rae13c, 50)
end

function rae13a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        rae14()
    else
        rae09()
    end
end

function rae13b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        rae09()
    else
        rae12()
    end
end

function rae13c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        rae14()
    else
        rae12()
    end
end

function rae14()
    fallout.gsay_reply(671, 172)
    fallout.giq_option(4, 671, 173, special_end, 50)
    fallout.giq_option(4, 671, 174, rae09, 50)
end

function dialog_end()
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
