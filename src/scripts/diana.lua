local fallout = require("fallout")

local start
local do_dialogue
local Diana00
local Diana01
local Diana02
local Diana03
local Diana04
local Diana05
local Diana10
local Diana11
local Diana12
local Dianaend
local combat
local talk_p_proc
local Critter_Action
local damage_p_proc

local hostile = 0
local only_once = 1

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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 6)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 21)
    end
    if fallout.script_action() == 11 then
        talk_p_proc()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(142, 100))
        else
            if fallout.script_action() == 4 then
                hostile = 1
            else
                if fallout.script_action() == 12 then
                    Critter_Action()
                    if hostile then
                        hostile = 0
                        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    end
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

function do_dialogue()
    fallout.set_local_var(3, 1)
    get_reaction()
    fallout.start_gdialog(142, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) then
        Diana10()
    else
        if fallout.global_var(611) == 1 then
            Diana11()
        else
            fallout.set_local_var(4, 1)
            Diana00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Diana00()
    fallout.gsay_reply(142, 101)
    if (fallout.global_var(103) == 1) and (fallout.global_var(218) == 1) then
        fallout.giq_option(4, 142, 102, Diana01, 50)
    end
    fallout.giq_option(4, 142, 103, Dianaend, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(4, 142, 104, Diana02, 50)
    end
    fallout.giq_option(4, 142, 105, Diana04, 50)
    if fallout.local_var(5) == 0 then
        fallout.giq_option(7, 142, 106, Diana05, 50)
    end
    fallout.giq_option(-3, 142, 107, Diana10, 50)
end

function Diana01()
    fallout.gsay_reply(142, 108)
    fallout.giq_option(4, 142, 109, Dianaend, 50)
    fallout.giq_option(4, 142, 110, Diana03, 50)
end

function Diana02()
    fallout.gsay_message(142, 111, 50)
end

function Diana03()
    fallout.gsay_message(142, 112, 50)
end

function Diana04()
    fallout.gsay_reply(142, 113)
    fallout.giq_option(4, 142, 114, Diana03, 50)
    if fallout.local_var(5) == 0 then
        fallout.giq_option(7, 142, 115, Diana05, 50)
    end
end

function Diana05()
    fallout.gsay_reply(142, 116)
    fallout.set_local_var(5, 1)
    fallout.giq_option(4, 142, 117, Diana01, 50)
    fallout.giq_option(4, 142, 118, Diana03, 50)
end

function Diana10()
    fallout.gsay_message(142, 119, 50)
end

function Diana11()
    fallout.gsay_reply(142, 120)
    fallout.giq_option(4, 142, 104, Diana10, 50)
    fallout.giq_option(4, 142, 118, Diana12, 50)
    fallout.giq_option(-3, 142, 107, Diana10, 50)
end

function Diana12()
    fallout.gsay_message(142, 121, 50)
end

function Dianaend()
end

function combat()
    if fallout.global_var(116) == 1 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
    end
    hostile = 1
end

function talk_p_proc()
    if fallout.global_var(116) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(102, 106)), 8)
    else
        do_dialogue()
    end
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
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
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
