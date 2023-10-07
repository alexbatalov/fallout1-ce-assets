local fallout = require("fallout")

local start
local do_dialogue
local alya00
local alya01
local alya02
local alya03
local alya04
local alya05
local alya06
local alya07
local alya08
local alya09
local alya10
local alyaend
local talk_p_proc
local combat
local Critter_Action
local damage_p_proc

local HOSTILE = 0
local initialized = 0

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
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 6)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 21)
        initialized = 1
    end
    if fallout.script_action() == 11 then
        talk_p_proc()
    else
        if fallout.script_action() == 22 then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
                combat()
            end
        else
            if fallout.script_action() == 4 then
                HOSTILE = 1
            else
                if fallout.script_action() == 12 then
                    Critter_Action()
                    if HOSTILE then
                        HOSTILE = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    end
                else
                    if fallout.script_action() == 21 then
                        fallout.script_overrides()
                        fallout.display_msg(fallout.message_str(143, 100))
                    else
                        if fallout.script_action() == 14 then
                            damage_p_proc()
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
                                fallout.set_global_var(254, 1)
                                fallout.set_global_var(611, 0)
                                fallout.set_global_var(115, fallout.global_var(115) - 1)
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    fallout.set_local_var(3, 1)
    get_reaction()
    fallout.start_gdialog(143, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 5 then
        alya10()
    else
        fallout.set_local_var(4, fallout.local_var(4) + 1)
        alya00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function alya00()
    fallout.gsay_reply(143, 101)
    if (fallout.global_var(103) == 1) and (fallout.global_var(218) == 1) then
        fallout.giq_option(4, 143, 102, alya01, 50)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(4, 143, 103, alya02, 50)
    end
    fallout.giq_option(4, 143, 104, alya03, 50)
    fallout.giq_option(4, 143, 105, alyaend, 50)
    fallout.giq_option(-3, 143, 106, alya05, 50)
end

function alya01()
    fallout.gsay_message(143, 107, 50)
end

function alya02()
    fallout.gsay_message(143, 108, 50)
    combat()
end

function alya03()
    fallout.gsay_reply(143, 109)
    fallout.giq_option(4, 143, 110, alya04, 50)
    fallout.giq_option(4, 143, 111, alya09, 50)
    fallout.giq_option(4, 143, 112, alyaend, 50)
end

function alya04()
    fallout.gsay_reply(143, 113)
    fallout.giq_option(4, 143, 114, alya06, 50)
    fallout.giq_option(4, 143, 115, alya08, 50)
    fallout.giq_option(4, 143, 116, alyaend, 50)
end

function alya05()
    fallout.gsay_message(143, 117, 50)
end

function alya06()
    fallout.gsay_reply(143, 118)
    fallout.giq_option(4, 143, 119, alya07, 50)
    fallout.giq_option(4, 143, 120, combat, 50)
    fallout.giq_option(4, 143, 121, alyaend, 50)
end

function alya07()
    fallout.gsay_message(143, 122, 50)
    combat()
end

function alya08()
    fallout.gsay_message(143, 123, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 1)
end

function alya09()
    fallout.gsay_message(143, 124, 50)
end

function alya10()
    fallout.gsay_message(143, 125, 50)
end

function alyaend()
end

function talk_p_proc()
    if fallout.global_var(116) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(102, 106)), 8)
    else
        do_dialogue()
    end
end

function combat()
    if fallout.global_var(116) == 1 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
    end
    HOSTILE = 1
end

function Critter_Action()
    local v0 = 0
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    else
        if fallout.global_var(116) then
            fallout.set_global_var(254, 0)
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 3 then
                v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), 3)
                if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), v0) > 2 then
                    if fallout.random(0, 9) == 0 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(102, 106)), 8)
                    end
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 0)
                end
            end
        else
            if fallout.global_var(213) then
                fallout.set_global_var(254, 1)
            end
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if fallout.global_var(214) then
                    fallout.set_global_var(254, 1)
                end
            end
            if fallout.map_var(2) == 1 then
                fallout.set_global_var(254, 1)
            end
        end
    end
    if fallout.global_var(254) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        HOSTILE = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        HOSTILE = 0
    end
end

function damage_p_proc()
    if fallout.global_var(116) == 0 then
        fallout.set_global_var(254, 1)
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
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
return exports
