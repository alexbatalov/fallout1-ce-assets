local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local caravan00
local caravan01
local caravan02
local caravan03
local caravan03a
local caravan03b
local caravan03c
local caravan03d
local caravan04

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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 37)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
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
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    get_reaction()
    fallout.start_gdialog(767, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    caravan00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 7) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(767, 102))
end

function caravan00()
    fallout.gsay_reply(767, 103)
    fallout.giq_option(0, 767, 104, caravan01, 50)
    fallout.giq_option(0, 767, 105, caravan02, 50)
end

function caravan01()
    fallout.gsay_reply(767, 106)
    fallout.giq_option(0, 767, 104, caravan03, 50)
    fallout.giq_option(0, 767, 105, caravan02, 50)
end

function caravan02()
    fallout.gsay_message(767, 107, 50)
end

function caravan03()
    fallout.gsay_reply(767, 110)
    fallout.giq_option(0, 767, 112, caravan03a, 50)
    fallout.giq_option(0, 767, 113, caravan03b, 50)
    fallout.giq_option(0, 767, 114, caravan03c, 50)
    fallout.giq_option(0, 767, 116, caravan04, 50)
end

function caravan03a()
    local v0 = 0
    fallout.gsay_message(767, 117, 50)
    fallout.set_global_var(201, 1)
    v0 = fallout.random(1, 4)
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 24 * 4))
    fallout.item_caps_adjust(fallout.dude_obj(), 400)
    if v0 < 4 then
        v0 = fallout.random(1, 4)
        if v0 == 1 then
            v0 = fallout.random(1, 10)
            if v0 == 1 then
                fallout.load_map(56, 1)
            else
                fallout.load_map(56, 2)
            end
        else
            fallout.load_map(56, 3)
        end
    else
        fallout.load_map(28, 1)
    end
end

function caravan03b()
    local v0 = 0
    fallout.gsay_message(767, 117, 50)
    fallout.set_global_var(201, 1)
    v0 = fallout.random(1, 4)
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 24 * 4))
    fallout.item_caps_adjust(fallout.dude_obj(), 400)
    if v0 < 4 then
        v0 = fallout.random(1, 4)
        if v0 == 1 then
            v0 = fallout.random(1, 10)
            if v0 == 1 then
                fallout.load_map(58, 1)
            else
                fallout.load_map(58, 2)
            end
        else
            fallout.load_map(58, 3)
        end
    else
        fallout.load_map(10, 1)
    end
end

function caravan03c()
    local v0 = 0
    fallout.gsay_message(767, 117, 50)
    fallout.set_global_var(201, 1)
    v0 = fallout.random(1, 4)
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 24 * 6))
    fallout.item_caps_adjust(fallout.dude_obj(), 400)
    if v0 < 4 then
        v0 = fallout.random(1, 4)
        if v0 == 1 then
            v0 = fallout.random(1, 10)
            if v0 == 1 then
                fallout.load_map(59, 1)
            else
                fallout.load_map(59, 2)
            end
        else
            fallout.load_map(59, 3)
        end
    else
        fallout.load_map(13, 1)
    end
end

function caravan03d()
    local v0 = 0
    fallout.gsay_message(767, 117, 50)
    fallout.set_global_var(201, 1)
    v0 = fallout.random(1, 4)
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 24 * 4))
    fallout.item_caps_adjust(fallout.dude_obj(), 400)
    if v0 < 4 then
        v0 = fallout.random(1, 4)
        if v0 == 1 then
            v0 = fallout.random(1, 10)
            if v0 == 1 then
                fallout.load_map(57, 1)
            else
                fallout.load_map(57, 2)
            end
        else
            fallout.load_map(57, 3)
        end
    else
        fallout.load_map(4, 1)
    end
end

function caravan04()
    fallout.gsay_message(767, 108, 50)
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
        if (fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if (fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1) then
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
