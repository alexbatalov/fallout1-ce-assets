local fallout = require("fallout")

local start
local do_dialogue
local robot00
local robot01
local robot02
local robotend
local robotcbt

local HOSTILE = 0
local only_once = 1
local DISGUISED = 0
local again = 0
local rndx = 0

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
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 55)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 71)
    else
        if fallout.script_action() == 11 then
            do_dialogue()
        else
            if fallout.script_action() == 4 then
                HOSTILE = 1
            end
        end
    end
    if fallout.script_action() == 12 then
        if HOSTILE then
            HOSTILE = 0
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            DISGUISED = 0
            if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
                if fallout.metarule(16, 0) > 1 then
                    DISGUISED = 0
                else
                    DISGUISED = 1
                end
            end
            if (DISGUISED == 0) and (again == 0) then
                if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
                    again = 1
                    fallout.dialogue_system_enter()
                end
            end
        end
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
        else
            if fallout.script_action() == 18 then
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
            end
        end
    end
end

function do_dialogue()
    fallout.set_local_var(3, 1)
    get_reaction()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.metarule(16, 0) > 1 then
            DISGUISED = 0
        else
            DISGUISED = 1
        end
    end
    if DISGUISED then
        if fallout.local_var(1) > 1 then
            robot00()
        else
            robot02()
        end
    else
        robot01()
    end
end

function robot00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 100), 2)
end

function robot01()
    rndx = fallout.random(1, 4)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 101), 2)
    else
        if rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 102), 2)
        else
            if rndx == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 103), 2)
            else
                if rndx == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 104), 2)
                end
            end
        end
    end
    robotcbt()
end

function robot02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 105), 2)
    robotcbt()
end

function robotend()
end

function robotcbt()
    HOSTILE = 1
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
return exports
