local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local look_at_p_proc
local talk_p_proc
local timed_event_p_proc
local Gretch00
local Gretch00a
local Gretch00b
local Gretch01
local Gretch01a
local Gretch02
local Gretch02a
local Gretch03
local Gretch03a
local Gretch04
local Gretch05
local Gretch05a
local Gretch06
local Gretch07
local Gretch08
local Gretch09
local Gretch10
local GretchEnd
local GretchCombat

local hostile = 0
local initialized = 0
local warned_about_messing = 0

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

local damage_p_proc

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 19)
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
                        else
                            if fallout.script_action() == 22 then
                                timed_event_p_proc()
                            end
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
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.external_var("messing_with_Morbid_stuff") then
            if (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12) and (fallout.elevation(fallout.self_obj()) == fallout.elevation(fallout.dude_obj())) then
                if warned_about_messing then
                    hostile = 1
                else
                    warned_about_messing = 1
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(103, 141), 2)
                end
            end
            fallout.set_external_var("messing_with_Morbid_stuff", 0)
        end
        if fallout.external_var("Gretch_call") then
            fallout.set_external_var("Gretch_call", 0)
            hostile = 1
        end
    end
    if fallout.global_var(346) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(346, 1)
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
end

function pickup_p_proc()
    hostile = 1
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) == 0 then
        fallout.display_msg(fallout.message_str(103, 100))
    else
        fallout.display_msg(fallout.message_str(103, 101))
    end
end

function talk_p_proc()
    fallout.start_gdialog(103, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(0) == 1 then
        Gretch01()
    else
        Gretch00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function timed_event_p_proc()
end

function Gretch00()
    fallout.gsay_reply(103, 102)
    fallout.giq_option(-3, 103, 103, Gretch07, 50)
    fallout.giq_option(4, 103, 104, Gretch00a, 50)
    fallout.giq_option(4, 103, 105, Gretch00b, 51)
    fallout.giq_option(4, 103, 106, Gretch02, 50)
    fallout.giq_option(4, 103, 107, GretchEnd, 50)
end

function Gretch00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Gretch04()
    else
        Gretch02()
    end
end

function Gretch00b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Gretch02()
    else
        Gretch08()
    end
end

function Gretch01()
    fallout.gsay_reply(103, 108)
    fallout.giq_option(4, 103, 109, Gretch02, 50)
    fallout.giq_option(4, 103, 110, Gretch01a, 50)
    fallout.giq_option(4, 103, 111, GretchEnd, 50)
    fallout.giq_option(-3, 103, 103, Gretch07, 50)
end

function Gretch01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Gretch05()
    else
        Gretch02()
    end
end

function Gretch02()
    fallout.gsay_reply(103, 112)
    fallout.giq_option(4, 103, 113, Gretch04, 50)
    fallout.giq_option(4, 103, 114, Gretch03, 50)
    fallout.giq_option(4, 103, 115, Gretch02a, 50)
end

function Gretch02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Gretch03()
    else
        Gretch07()
    end
end

function Gretch03()
    fallout.gsay_reply(103, 116)
    fallout.giq_option(4, 103, 117, Gretch04, 50)
    fallout.giq_option(4, 103, 118, Gretch03a, 50)
    fallout.giq_option(4, 103, 119, GretchEnd, 50)
end

function Gretch03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Gretch05()
    else
        Gretch04()
    end
end

function Gretch04()
    fallout.gsay_reply(103, 120)
    fallout.giq_option(4, 103, 121, Gretch06, 50)
    fallout.giq_option(4, 103, 122, Gretch05, 50)
    fallout.giq_option(4, 103, 123, GretchEnd, 50)
end

function Gretch05()
    fallout.set_global_var(305, 1)
    fallout.gsay_reply(103, 124)
    fallout.giq_option(4, 103, 125, Gretch05a, 50)
    fallout.giq_option(4, 103, 126, GretchCombat, 51)
    fallout.giq_option(4, 103, 127, GretchEnd, 50)
end

function Gretch05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Gretch09()
    else
        Gretch06()
    end
end

function Gretch06()
    fallout.set_global_var(305, 1)
    fallout.gsay_reply(103, 128)
    fallout.giq_option(4, 103, 129, GretchEnd, 50)
    fallout.giq_option(4, 103, 130, Gretch09, 50)
    fallout.giq_option(4, 103, 131, Gretch07, 50)
end

function Gretch07()
    fallout.gsay_reply(103, 132)
    fallout.giq_option(4, 103, 133, GretchEnd, 50)
    fallout.giq_option(4, 103, 134, Gretch04, 50)
    fallout.giq_option(4, 103, 135, Gretch08, 51)
    fallout.giq_option(-3, 103, 136, Gretch10, 50)
end

function Gretch08()
    fallout.gsay_message(103, 137, 51)
end

function Gretch09()
    fallout.gsay_reply(103, 138)
    fallout.giq_option(4, 103, 139, GretchEnd, 50)
    fallout.giq_option(4, 103, 126, GretchCombat, 51)
end

function Gretch10()
    fallout.gsay_message(103, 140, 50)
end

function GretchEnd()
end

function GretchCombat()
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

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(346, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.damage_p_proc = damage_p_proc
return exports
