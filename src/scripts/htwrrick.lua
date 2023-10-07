local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local Rick01
local Rick02
local Rick03
local Rick04
local Rick05
local Rick06
local Rick07
local Rick08
local Rick09
local Rick10
local RickEnd
local RickCombat

local hostile = 0
local Only_Once = 1
local nightWarned = 0
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
        if fallout.global_var(111) == 5 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            visible = 0
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 42)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 16)
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
                    else
                        if fallout.script_action() == 14 then
                            damage_p_proc()
                        end
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
    if visible == 0 then
        fallout.script_overrides()
    else
        if hostile then
            hostile = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.map_var(5) == 1 then
            if (fallout.obj_can_hear_obj(fallout.self_obj(), fallout.dude_obj()) == 1) or (fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) == 1) then
                combat()
            end
        else
            if (fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600) then
                if (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 7) and (nightWarned == 0) then
                    nightWarned = 1
                    fallout.dialogue_system_enter()
                end
                if fallout.tile_num(fallout.self_obj()) ~= 19713 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 19713, 0)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= 17892 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 17892, 0)
                end
            end
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
    if (fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600) then
        fallout.start_gdialog(871, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rick09()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        fallout.start_gdialog(871, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rick01()
        fallout.gsay_end()
        fallout.end_dialogue()
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
    fallout.display_msg(fallout.message_str(871, 100))
end

function damage_p_proc()
    fallout.set_map_var(5, 1)
end

function Rick01()
    fallout.gsay_reply(871, 101)
    fallout.giq_option(4, 871, 103, Rick03, 50)
    fallout.giq_option(4, 871, 104, Rick04, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 871, 105, Rick08, 51)
    end
    fallout.giq_option(-3, 871, 102, Rick02, 50)
end

function Rick02()
    fallout.gsay_reply(871, 106)
    fallout.giq_option(-3, 871, 107, Rick10, 50)
    fallout.giq_option(-3, 871, 108, RickEnd, 50)
end

function Rick03()
    fallout.gsay_reply(871, 109)
    fallout.giq_option(4, 871, 110, Rick05, 50)
    fallout.giq_option(4, 871, 111, Rick06, 50)
    fallout.giq_option(4, 871, 112, RickEnd, 50)
end

function Rick04()
    fallout.gsay_reply(871, 113)
    fallout.giq_option(4, 871, 114, RickCombat, 51)
    fallout.giq_option(4, 871, 115, Rick08, 50)
end

function Rick05()
    fallout.gsay_reply(871, 116)
    fallout.giq_option(4, 871, 117, Rick06, 50)
    fallout.giq_option(4, 871, 118, Rick07, 50)
    fallout.giq_option(4, 871, 119, RickEnd, 50)
end

function Rick06()
    fallout.gsay_reply(871, 120)
    fallout.giq_option(4, 871, 121, RickCombat, 51)
    fallout.giq_option(4, 871, 122, Rick05, 50)
    fallout.giq_option(4, 871, 123, RickEnd, 50)
end

function Rick07()
    fallout.gsay_message(871, 124, 51)
end

function Rick08()
    fallout.gsay_reply(871, 125)
    fallout.giq_option(4, 871, 126, RickEnd, 50)
    fallout.giq_option(4, 871, 127, RickCombat, 51)
end

function Rick09()
    fallout.gsay_reply(871, 128)
    fallout.giq_option(4, 871, 131, RickCombat, 51)
    fallout.giq_option(4, 871, 132, RickEnd, 50)
    fallout.giq_option(-3, 871, 129, RickEnd, 50)
    fallout.giq_option(-3, 871, 130, RickCombat, 51)
end

function Rick10()
    fallout.gsay_message(871, 133, 51)
end

function RickEnd()
end

function RickCombat()
    combat()
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
exports.damage_p_proc = damage_p_proc
return exports
