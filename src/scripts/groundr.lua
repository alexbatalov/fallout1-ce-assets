local fallout = require("fallout")

local start
local do_dialogue
local groundr00
local groundr01
local Critter_Action
local timetomove

local Hostile = 0
local init = 0
local maxleash = 9
local noevent = 0
local loopcount = 0
local rndx = 0
local rndy = 0
local rndz = 0
local dist = 0
local sleep_tile = 0
local new_tile = 0

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

local set_sleep_tile

function start()
    if not(init) then
        if fallout.local_var(6) == 0 then
            fallout.set_local_var(6, fallout.tile_num(fallout.self_obj()))
            fallout.set_local_var(5, 1)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 31)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 40)
        init = 1
    end
    if fallout.script_action() == 22 then
        timetomove()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(77, 100))
        else
            if fallout.script_action() == 11 then
                do_dialogue()
            else
                if fallout.script_action() == 4 then
                    Hostile = 1
                else
                    if fallout.script_action() == 12 then
                        Critter_Action()
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
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    get_reaction()
    if fallout.local_var(1) < 2 then
        groundr01()
    else
        groundr00()
    end
end

function groundr00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(77, fallout.random(101, 104)), 0)
end

function groundr01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(77, fallout.random(105, 107)), 0)
end

function Critter_Action()
    if Hostile > 0 then
        Hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(5) then
            loopcount = loopcount + 1
            if loopcount > 40 then
                loopcount = 0
                if noevent == 0 then
                    noevent = 1
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(5, 13)), 0)
                end
            end
        end
    end
end

function timetomove()
    noevent = 0
    fallout.set_local_var(7, fallout.tile_num(fallout.self_obj()))
    new_tile = fallout.tile_num_in_direction(fallout.local_var(7), fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(6), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
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

function set_sleep_tile()
    if fallout.local_var(6) == 21943 then
        sleep_tile = 21143
    else
        if fallout.local_var(6) == 21541 then
            sleep_tile = 20537
        else
            if fallout.local_var(6) == 21740 then
                sleep_tile = 20735
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
