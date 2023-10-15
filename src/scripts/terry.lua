local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local do_dialogue
local terrycbt
local terryend
local terry00
local terry01
local terry02
local terry03
local terry04
local Critter_Action

local rndx = 0
local rndy = 0
local rndz = 0
local Hostile = 0
local initialized = false
local noevent = 0
local loopcount = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 79)
        fallout.set_local_var(1, 0)
        initialized = true
    end
    if (fallout.script_action() == 11) and (fallout.global_var(35) < 1) then
        if fallout.global_var(306) == 0 then
            do_dialogue()
        else
            fallout.display_msg(fallout.message_str(101, 109))
        end
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(101, 100))
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    Critter_Action()
                else
                    if fallout.script_action() == 18 then
                        fallout.set_global_var(35, fallout.global_var(35) + 1)
                        if fallout.global_var(35) > fallout.global_var(551) then
                            fallout.set_global_var(155, fallout.global_var(155) + 3)
                            fallout.set_global_var(29, 2)
                            fallout.set_global_var(225, time.game_time_in_days())
                        end
                        reputation.inc_evil_critter()
                    end
                end
            end
        end
    end
end

function do_dialogue()
    terry03()
end

function terrycbt()
    Hostile = 1
end

function terryend()
end

function terry00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(101, 101), 3)
    terrycbt()
end

function terry01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(101, 105), 3)
    terrycbt()
end

function terry02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(101, 106), 3)
    terrycbt()
end

function terry03()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(101, 107), 3)
end

function terry04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(101, 108), 3)
    terryend()
end

function Critter_Action()
    if (fallout.global_var(35) > 0) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        Hostile = 1
    end
    if Hostile > 0 then
        Hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if (fallout.global_var(306) == 1) and (fallout.tile_num(fallout.self_obj()) ~= 15507) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 15507, 0)
        else
            if (fallout.global_var(306) == 1) and (fallout.tile_num(fallout.self_obj()) == 15507) then
                fallout.set_global_var(306, 2)
            else
                if (fallout.global_var(306) == 2) and (fallout.tile_num(fallout.self_obj()) ~= 12536) then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 12536, 0)
                else
                    if (fallout.tile_num(fallout.self_obj()) == 12536) and (fallout.global_var(306) == 2) then
                        fallout.set_obj_visibility(fallout.self_obj(), 1)
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
