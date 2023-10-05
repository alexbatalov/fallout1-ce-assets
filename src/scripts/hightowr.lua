local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local combat_p_proc
local Daren01
local Daren02
local Daren03
local Daren04
local Daren05
local Daren05a
local Daren06
local Daren07
local DarenCombat
local DarenEndLeon

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
        if fallout.global_var(111) == 5 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            visible = 0
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 42)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 5)
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
                        else
                            if fallout.script_action() == 13 then
                                combat_p_proc()
                            end
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
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.map_var(5) == 1 then
            if (fallout.obj_can_hear_obj(fallout.self_obj(), fallout.dude_obj()) == 1) or (fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) == 1) then
                combat()
            end
        else
            if (fallout.game_time_hour() >= 600) and (fallout.game_time_hour() < 700) or ((fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800)) then
                if fallout.tile_num(fallout.self_obj()) ~= 25125 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 25125, 0)
                else
                    if (fallout.tile_num(fallout.dude_obj()) == 24522) and (fallout.map_var(1) == 0) then
                        fallout.dialogue_system_enter()
                    end
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= 24708 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 24708, 0)
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
        fallout.float_msg(fallout.self_obj(), fallout.message_str(582, 127), 2)
        combat()
    else
        if fallout.global_var(248) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(582, 127), 2)
            combat()
        else
            if fallout.local_var(4) == 0 then
                fallout.set_local_var(4, 1)
                fallout.start_gdialog(582, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Daren01()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                fallout.float_msg(fallout.self_obj(), fallout.message_str(582, 127), 2)
                combat()
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
    fallout.set_map_var(0, fallout.map_var(0) + 1)
    if fallout.map_var(0) > 1 then
        fallout.set_global_var(111, 2)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(582, 100))
end

function damage_p_proc()
    fallout.set_map_var(5, 1)
    fallout.set_global_var(111, 5)
end

function combat_p_proc()
    fallout.critter_set_flee_state(fallout.self_obj(), 1)
end

function Daren01()
    fallout.gsay_reply(582, 101)
    fallout.giq_option(4, 582, 102, Daren02, 50)
    if fallout.global_var(111) == 1 then
        fallout.giq_option(4, 582, 103, Daren03, 50)
    end
    fallout.giq_option(4, 582, fallout.message_str(582, 104) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(582, 105), Daren04, 50)
    fallout.giq_option(4, 582, 106, Daren07, 50)
    fallout.giq_option(4, 582, 107, Daren06, 50)
    fallout.giq_option(-3, 582, 108, Daren06, 50)
end

function Daren02()
    fallout.gsay_reply(582, 109)
    if fallout.global_var(111) == 1 then
        fallout.giq_option(4, 582, 110, DarenCombat, 51)
    end
    fallout.giq_option(4, 582, 111, Daren05, 50)
    fallout.giq_option(4, 582, 112, Daren06, 50)
    fallout.giq_option(4, 582, 113, Daren06, 50)
end

function Daren03()
    fallout.gsay_reply(582, 114)
    fallout.giq_option(4, 582, 115, Daren06, 50)
    fallout.giq_option(4, 582, 116, Daren07, 50)
    fallout.giq_option(4, 582, 117, DarenCombat, 51)
    fallout.giq_option(4, 582, 118, Daren06, 50)
end

function Daren04()
    fallout.gsay_message(582, fallout.message_str(582, 119) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(582, 120), 51)
    DarenEndLeon()
end

function Daren05()
    fallout.gsay_reply(582, 121)
    fallout.giq_option(4, 582, 122, Daren07, 50)
    if fallout.item_caps_total(fallout.dude_obj()) >= 100 then
        fallout.giq_option(4, 582, 123, Daren05a, 50)
    end
    fallout.giq_option(4, 582, 124, Daren06, 50)
end

function Daren05a()
    local v0 = 0
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), -100)
    fallout.gsay_message(582, 125, 51)
    DarenEndLeon()
end

function Daren06()
    fallout.gsay_message(582, 126, 51)
    DarenEndLeon()
end

function Daren07()
    fallout.gsay_message(582, 127, 51)
    DarenCombat()
end

function DarenCombat()
    combat()
end

function DarenEndLeon()
    fallout.set_map_var(1, 1)
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
exports.combat_p_proc = combat_p_proc
return exports
