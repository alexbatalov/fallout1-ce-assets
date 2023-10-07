local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Jasmine00
local Jasmine01
local Jasmine02
local Jasmine03
local Jasmine04
local Jasmine05
local Jasmine06
local Jasmine07
local Jasmine08
local Jasmine09
local Jasmine10
local Jasmine11
local Jasmine12
local Jasmine13
local Jasmine14
local Jasmine15
local Jasmine16
local Jasmine17
local JasmineEnd

local hostile = 0
local Only_Once = 1

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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 39)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 52)
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
    if fallout.map_var(1) == 1 then
        Jasmine01()
    else
        if fallout.global_var(107) == 0 then
            Jasmine02()
        else
            if (fallout.global_var(107) == 1) and (fallout.local_var(6) == 0) then
                fallout.start_gdialog(592, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Jasmine03()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                if fallout.global_var(107) == 1 then
                    Jasmine05()
                else
                    if (fallout.map_var(3) == 1) and (fallout.local_var(5) == 0) then
                        fallout.start_gdialog(592, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Jasmine06()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    else
                        Jasmine07()
                    end
                end
            end
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
    fallout.display_msg(fallout.message_str(592, 100))
end

function Jasmine00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 102), 2)
    combat()
end

function Jasmine01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 103), 2)
end

function Jasmine02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 104), 2)
end

function Jasmine03()
    local v0 = 0
    v0 = fallout.create_object_sid(84, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(79, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), v0, 2)
    v0 = fallout.create_object_sid(106, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(592, 105)
    fallout.giq_option(4, 592, 106, Jasmine08, 50)
    fallout.giq_option(4, 592, 107, Jasmine09, 50)
    fallout.giq_option(4, 592, 109, Jasmine11, 50)
    fallout.giq_option(4, 592, 110, Jasmine12, 50)
    fallout.giq_option(4, 592, 111, Jasmine13, 50)
    fallout.giq_option(-3, 592, 112, Jasmine14, 50)
end

function Jasmine04()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 113), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 114), 2)
    end
end

function Jasmine05()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 117), 2)
end

function Jasmine06()
    local v0 = 0
    local v1 = 0
    fallout.set_local_var(5, 1)
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), 3000)
    v1 = fallout.create_object_sid(77, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(592, 118, 50)
    else
        fallout.gsay_message(592, 119, 50)
    end
    fallout.gsay_message(592, 121, 50)
    fallout.gsay_message(592, 135, 50)
end

function Jasmine07()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 122), 2)
end

function Jasmine08()
    fallout.gsay_message(592, 123, 50)
end

function Jasmine09()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(592, 124, 50)
    else
        fallout.gsay_message(592, 134, 50)
    end
end

function Jasmine10()
    fallout.gsay_message(592, 125, 50)
end

function Jasmine11()
    fallout.gsay_message(592, 126, 50)
end

function Jasmine12()
    fallout.gsay_message(592, 127, 50)
end

function Jasmine13()
    fallout.gsay_message(592, 128, 50)
end

function Jasmine14()
    fallout.gsay_message(592, 129, 50)
end

function Jasmine15()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 130), 2)
end

function Jasmine16()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 131), 2)
end

function Jasmine17()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 132), 2)
end

function JasmineEnd()
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
