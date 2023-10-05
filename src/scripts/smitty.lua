local fallout = require("fallout")

local Start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local Smitty01
local Smitty02
local Smitty03
local Smitty04
local Smitty05
local Smitty06
local Smitty07
local Smitty08
local Smitty09
local Smitty10
local Smitty11
local Smitty12
local Smitty14
local Smitty14a
local Smitty15
local SmittyEnd

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
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(500, 750))
        end
        if (fallout.global_var(613) == 9103) or (fallout.global_var(613) == 9102) then
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        else
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(250, 100))
    else
        fallout.display_msg(fallout.message_str(250, 101))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(250, 100))
    else
        fallout.display_msg(fallout.message_str(250, 101))
    end
end

function talk_p_proc()
    if fallout.global_var(251) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if (fallout.local_var(4) == 1) and (fallout.get_critter_stat(fallout.dude_obj(), 4) < 4) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(250, 117), 0)
        else
            if fallout.local_var(5) == 2 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(250, 131), 0)
            else
                get_reaction()
                fallout.start_gdialog(250, fallout.self_obj(), -1, -1, -1)
                fallout.gsay_start()
                if fallout.global_var(138) == 9303 then
                    Smitty11()
                else
                    if fallout.global_var(138) == 9304 then
                        if fallout.local_var(5) == 0 then
                            Smitty12()
                        else
                            if fallout.local_var(5) == 9307 then
                                if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 15) then
                                    Smitty14()
                                else
                                    Smitty15()
                                end
                            end
                        end
                    else
                        if fallout.local_var(1) < 2 then
                            DisplayMessage = 103
                            Smitty01()
                        else
                            DisplayMessage = 102
                            Smitty01()
                        end
                    end
                end
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(251, 1)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(251, 1)
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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    end
end

function pickup_p_proc()
    fallout.set_global_var(251, 1)
end

function Smitty01()
    fallout.gsay_reply(250, DisplayMessage)
    DisplayMessage = 112
    if fallout.local_var(4) == 0 then
        fallout.giq_option(4, 250, 104, Smitty03, 50)
    end
    if (fallout.global_var(138) < 9303) and (fallout.global_var(138) > 2) then
        fallout.giq_option(4, 250, 105, Smitty10, 50)
    end
    fallout.giq_option(4, 250, 106, Smitty02, 50)
    fallout.giq_option(4, 250, 107, Smitty04, 50)
    fallout.giq_option(4, 250, 108, Smitty06, 50)
    fallout.giq_option(-3, 250, 109, Smitty05, 50)
end

function Smitty02()
    DisplayMessage = 110
    Smitty01()
end

function Smitty03()
    fallout.set_local_var(4, 1)
    DisplayMessage = 111
    Smitty01()
end

function Smitty04()
    fallout.gsay_reply(250, DisplayMessage)
    fallout.gsay_option(250, 113, Smitty07, 50)
    fallout.gsay_option(250, 114, Smitty08, 50)
    fallout.gsay_option(250, 115, Smitty09, 50)
    fallout.gsay_option(250, 116, Smitty06, 50)
end

function Smitty05()
    fallout.set_local_var(4, 1)
    fallout.gsay_message(250, 117, 50)
end

function Smitty06()
    fallout.gsay_message(250, 118, 50)
end

function Smitty07()
    DisplayMessage = 119
    Smitty04()
end

function Smitty08()
    DisplayMessage = 120
    Smitty04()
end

function Smitty09()
    DisplayMessage = 121
    Smitty04()
end

function Smitty10()
    fallout.gsay_message(250, 122, 50)
    fallout.gfade_out(600)
    fallout.game_time_advance(10 * 60 * 60)
    fallout.gfade_in(600)
    fallout.set_global_var(138, 9303)
    fallout.gsay_message(250, 123, 50)
end

function Smitty11()
    fallout.gsay_message(250, 124, 50)
end

function Smitty12()
    fallout.gsay_message(250, 125, 50)
    fallout.set_local_var(5, 9307)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 15) then
        Smitty14()
    end
end

function Smitty14()
    fallout.gsay_reply(250, 127)
    fallout.gsay_option(250, 126, Smitty14a, 50)
end

function Smitty14a()
    local v0 = 0
    local v1 = 0
    fallout.gsay_message(250, 128, 50)
    v1 = fallout.create_object_sid(42, 0, 0, -1)
    fallout.move_obj_inven_to_obj(fallout.dude_obj(), v1)
    fallout.move_obj_inven_to_obj(v1, fallout.dude_obj())
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 15)
    fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
    fallout.destroy_object(v0)
    fallout.destroy_object(v1)
    fallout.gfade_out(600)
    fallout.game_time_advance(10 * 60 * 60 * 2)
    fallout.gfade_in(600)
    fallout.gsay_message(250, 129, 50)
    v0 = fallout.create_object_sid(233, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.set_local_var(5, 2)
end

function Smitty15()
    fallout.gsay_message(250, 130, 50)
end

function SmittyEnd()
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
exports.pickup_p_proc = pickup_p_proc
return exports
