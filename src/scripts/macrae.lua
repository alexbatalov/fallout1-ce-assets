local fallout = require("fallout")

local Start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local damage_p_proc
local destroy_p_proc
local critter_p_proc
local pickup_p_proc
local MacRae01
local MacRae02
local MacRae03
local MacRae04
local MacRae05
local MacRae06
local MacRae07
local MacRae08
local MacRae09
local MacRae10
local MacRae11
local MacRae12
local MacRae13
local MacRae14
local MacRae15
local MacRae16
local MacRaeEnd

local Initialize = 1
local DisplayMessage = 100

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

function Start()
    if Initialize then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 47)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 27)
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(918, 101))
    else
        fallout.display_msg(fallout.message_str(918, 100))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(918, 101))
    else
        fallout.display_msg(fallout.message_str(918, 100))
    end
end

function talk_p_proc()
    if fallout.global_var(253) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if fallout.local_var(5) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(918, 141), 0)
        else
            get_reaction()
            fallout.start_gdialog(918, fallout.self_obj(), -1, -1, -1)
            fallout.gsay_start()
            if fallout.global_var(613) == 2 then
                MacRae12()
            else
                if fallout.local_var(4) == 0 then
                    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                        DisplayMessage = 102
                    else
                        DisplayMessage = 103
                    end
                    MacRae02()
                else
                    DisplayMessage = 104
                    MacRae02()
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
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

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(253) == 1 then
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function pickup_p_proc()
    fallout.set_global_var(253, 1)
end

function MacRae01()
    DisplayMessage = 104
    MacRae02()
end

function MacRae02()
    fallout.gsay_reply(918, DisplayMessage)
    if fallout.local_var(4) == 0 then
        fallout.giq_option(4, 918, 105, MacRae03, 50)
    end
    fallout.giq_option(4, 918, 106, MacRae11, 50)
    fallout.giq_option(4, 918, 107, MacRaeEnd, 50)
    fallout.giq_option(-3, 918, 141, MacRaeEnd, 50)
end

function MacRae03()
    fallout.gsay_reply(918, 108)
    fallout.gsay_option(918, 109, MacRae04, 50)
    fallout.gsay_option(918, 110, MacRae08, 50)
    fallout.gsay_option(918, 111, MacRae09, 50)
    fallout.gsay_option(918, 112, MacRae01, 50)
end

function MacRae04()
    fallout.gsay_reply(918, 113)
    fallout.gsay_option(918, 114, MacRae05, 50)
    fallout.gsay_option(918, 115, MacRae06, 50)
    fallout.gsay_option(918, 116, MacRae01, 50)
end

function MacRae05()
    fallout.gsay_message(918, 117, 50)
    DownReactLevel()
end

function MacRae06()
    DisplayMessage = 118
    fallout.set_local_var(5, 1)
    MacRae07()
end

function MacRae07()
    fallout.gsay_reply(918, DisplayMessage)
    fallout.gsay_option(918, 119, MacRae01, 50)
    fallout.gsay_option(918, 120, MacRaeEnd, 50)
end

function MacRae08()
    DisplayMessage = 121
    MacRae07()
end

function MacRae09()
    fallout.gsay_reply(918, 122)
    fallout.gsay_option(918, 123, MacRae10, 50)
    fallout.gsay_option(918, 124, MacRae01, 50)
    fallout.gsay_option(918, 125, MacRaeEnd, 50)
end

function MacRae10()
    DisplayMessage = 126
    MacRae07()
end

function MacRae11()
    DisplayMessage = 127
    MacRae07()
end

function MacRae12()
    fallout.gsay_reply(918, 128)
    if fallout.local_var(5 == 1) then
        fallout.gsay_option(918, 129, MacRae15, 50)
    end
    if fallout.local_var(4) == 1 then
        fallout.gsay_option(918, 130, MacRae13, 50)
    else
        fallout.gsay_option(918, 131, MacRae16, 50)
    end
    fallout.gsay_option(918, 132, MacRaeEnd, 50)
end

function MacRae13()
    fallout.gsay_reply(918, 133)
    fallout.gsay_option(918, 134, MacRae14, 50)
    fallout.gsay_option(918, 135, MacRaeEnd, 50)
end

function MacRae14()
    fallout.gsay_reply(918, 113)
    fallout.gsay_option(918, 136, MacRae15, 50)
    fallout.gsay_option(918, 137, MacRaeEnd, 50)
end

function MacRae15()
    local v0 = 0
    fallout.gsay_message(918, 138, 50)
    v0 = fallout.get_critter_stat(fallout.dude_obj(), 24)
    fallout.set_critter_stat(fallout.dude_obj(), 24, 5)
    v0 = fallout.get_critter_stat(fallout.dude_obj(), 11)
    fallout.set_critter_stat(fallout.dude_obj(), 11, 1)
    fallout.gfade_out(600)
    fallout.game_time_advance(10 * 60 * 60 * 24)
    fallout.gfade_in(600)
    fallout.set_local_var(5, 2)
    fallout.gsay_message(918, 139, 50)
end

function MacRae16()
    fallout.gsay_reply(918, 140)
    fallout.gsay_option(918, 109, MacRae15, 50)
    fallout.gsay_option(918, 137, MacRaeEnd, 50)
end

function MacRaeEnd()
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
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
