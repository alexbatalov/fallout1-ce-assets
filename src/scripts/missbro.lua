local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Brother00
local Brother01
local Brother02
local Brother03
local Brother04
local Brother05
local Brother06
local Brother07
local Brother08
local Brother09
local Brother10
local Brother11
local Brother12
local BrotherEnd

local hostile = 0
local Only_Once = 1
local visible = 1

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
        if fallout.local_var(5) == 1 then
            visible = 0
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 62)
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
    if fallout.local_var(5) == 1 then
        if fallout.tile_num(fallout.self_obj()) ~= 17145 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 17145, 0)
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    get_reaction()
    if fallout.local_var(4) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(651, fallout.random(134, 136)), 2)
    else
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(651, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Brother00()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 17145, 0)
    fallout.set_local_var(5, 1)
end

function destroy_p_proc()
    fallout.set_global_var(109, 5)
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
    fallout.display_msg(fallout.message_str(651, 100))
end

function Brother00()
    fallout.gsay_reply(651, 101)
    if fallout.global_var(74) < 1 then
        fallout.giq_option(4, 651, 102, Brother01, 50)
    else
        if fallout.global_var(109) == 0 then
            fallout.giq_option(4, 651, 103, Brother03, 50)
            fallout.giq_option(4, 651, 104, Brother04, 50)
        else
            fallout.giq_option(4, 651, 105, Brother02, 50)
        end
    end
    fallout.giq_option(4, 651, 106, Brother03, 50)
    fallout.giq_option(-3, 651, 107, BrotherEnd, 50)
    fallout.set_global_var(109, 2)
end

function Brother01()
    fallout.gsay_reply(651, 108)
    if fallout.global_var(74) < 1 then
        fallout.set_global_var(74, 1)
    end
    Brother08()
end

function Brother02()
    fallout.gsay_reply(651, 109)
    fallout.giq_option(4, 651, 110, Brother05, 50)
    fallout.giq_option(4, 651, 111, Brother11, 50)
    fallout.giq_option(4, 651, 112, Brother12, 50)
end

function Brother03()
    fallout.gsay_message(651, 113, 50)
end

function Brother04()
    fallout.gsay_message(651, 114, 50)
end

function Brother05()
    fallout.gsay_reply(651, 115)
    fallout.giq_option(4, 651, 116, Brother07, 50)
    fallout.giq_option(4, 651, 117, Brother06, 50)
    fallout.giq_option(4, 651, 118, Brother10, 50)
    fallout.giq_option(4, 651, 119, Brother09, 50)
end

function Brother06()
    fallout.gsay_reply(651, 120)
    Brother08()
end

function Brother07()
    fallout.gsay_reply(651, 121)
    Brother08()
end

function Brother08()
    fallout.giq_option(4, 651, 122, Brother03, 50)
    fallout.giq_option(4, 651, 123, Brother04, 50)
end

function Brother09()
    fallout.gsay_message(651, 124, 50)
end

function Brother10()
    fallout.gsay_message(651, 125, 50)
end

function Brother11()
    fallout.gsay_reply(651, 126)
    fallout.giq_option(4, 651, 127, Brother05, 50)
    fallout.giq_option(4, 651, 128, Brother03, 50)
    fallout.giq_option(4, 651, 129, Brother04, 50)
end

function Brother12()
    fallout.gsay_reply(651, 130)
    fallout.giq_option(4, 651, 131, Brother05, 50)
    fallout.giq_option(4, 651, 132, Brother03, 50)
    fallout.giq_option(4, 651, 133, Brother04, 50)
end

function BrotherEnd()
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
