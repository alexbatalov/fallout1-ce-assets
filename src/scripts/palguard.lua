local fallout = require("fallout")

local start
local do_dialogue
local PalGuard01
local PalGuard02

local line = 0
local Only_Once = 0

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
    if Only_Once == 0 then
        Only_Once = 1
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
    end
    if fallout.script_action() == 11 then
        do_dialogue()
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
                fallout.set_global_var(159, fallout.global_var(159) + 1)
                if (fallout.global_var(159) % 2) == 0 then
                    fallout.set_global_var(155, fallout.global_var(155) - 1)
                end
            end
        else
            if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(317, 100))
            else
                if fallout.script_action() == 22 then
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
            end
        end
    end
end

function do_dialogue()
    get_reaction()
    if fallout.local_var(1) < 2 then
        PalGuard01()
    else
        PalGuard02()
    end
end

function PalGuard01()
    if not(line) then
        line = fallout.random(1, 9)
    else
        line = line + 1
    end
    if line > 9 then
        line = 1
    end
    if line == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 101), 2)
    else
        if line == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 102), 2)
        else
            if line == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 103), 2)
            else
                if line == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 104), 2)
                else
                    if line == 5 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 105), 2)
                    else
                        if line == 6 then
                            if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 106), 2)
                            else
                                line = line + 1
                            end
                        else
                            if line == 7 then
                                if fallout.global_var(108) == 2 then
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 107), 2)
                                else
                                    line = line + 1
                                end
                            else
                                if line == 8 then
                                    if fallout.global_var(108) < 2 then
                                        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 108), 2)
                                    else
                                        line = line + 1
                                    end
                                else
                                    if line == 9 then
                                        if fallout.global_var(108) < 2 then
                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 109), 2)
                                        else
                                            line = 1
                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 110), 2)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function PalGuard02()
    if not(line) then
        line = fallout.random(1, 10)
    else
        line = line + 1
    end
    if line > 10 then
        line = 1
    end
    if line == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 111), 2)
    else
        if line == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 112), 2)
        else
            if line == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 113), 2)
            else
                if line == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 114), 2)
                else
                    if line == 5 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 115), 2)
                    else
                        if line == 7 then
                            if fallout.global_var(108) == 2 then
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 116), 2)
                            else
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 117), 2)
                            end
                        else
                            if line == 7 then
                                if fallout.global_var(108) == 2 then
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 118), 2)
                                else
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 119), 2)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
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
