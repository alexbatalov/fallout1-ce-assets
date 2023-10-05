local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local map_enter_p_proc
local map_update_p_proc
local pickup_p_proc
local talk_p_proc
local ChildEnd
local child_heal
local child_pois
local Child00
local Child01
local Child02
local Child03
local Child04
local Child04a
local Child05
local Child05a
local Child05b
local Child06
local Child07
local Child08
local Child09
local Child09a
local Child10
local Child11
local Child12
local Child13
local Child14
local Child15
local Child16
local Child17
local flee_dude
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local initialized = 0
local scared = 0
local cost = 0
local hp_injured = 0
local healing_cost = 0
local poison_cost = 0

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
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 15 then
                map_enter_p_proc()
            else
                if fallout.script_action() == 4 then
                    pickup_p_proc()
                else
                    if fallout.script_action() == 11 then
                        talk_p_proc()
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if scared and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8) and (fallout.local_var(4) == 0) then
        flee_dude()
    else
        sleeping()
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
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function map_enter_p_proc()
    if fallout.global_var(15) == 1 then
        fallout.destroy_object(fallout.self_obj())
    end
    wake_time = 700
    sleep_time = 1900
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
    if fallout.local_var(6) == 0 then
        fallout.set_local_var(6, fallout.tile_num(fallout.self_obj()))
    end
    home_tile = fallout.local_var(6)
    sleep_tile = 15275
    if (fallout.game_time() // (10 * 60 * 60 * 24)) < 80 then
        fallout.set_obj_visibility(fallout.self_obj(), 1)
    else
        fallout.set_obj_visibility(fallout.self_obj(), 0)
    end
end

function map_update_p_proc()
    if (fallout.game_time() // (10 * 60 * 60 * 24)) < 80 then
        fallout.set_obj_visibility(fallout.self_obj(), 1)
    else
        fallout.set_obj_visibility(fallout.self_obj(), 0)
    end
end

function pickup_p_proc()
    scared = 1
end

function talk_p_proc()
    if scared then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(108, 145), 2)
    else
        if fallout.local_var(5) == 0 then
            fallout.start_gdialog(108, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Child00()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function ChildEnd()
end

function child_heal()
    fallout.game_time_advance(fallout.game_ticks(600 * hp_injured))
    fallout.critter_heal(fallout.dude_obj(), hp_injured)
    fallout.set_global_var(154, fallout.global_var(154) - 1)
end

function child_pois()
    if fallout.get_poison(fallout.dude_obj()) ~= 0 then
        fallout.game_time_advance(fallout.game_ticks(1800))
    end
    fallout.poison(fallout.dude_obj(), -fallout.get_poison(fallout.dude_obj()))
end

function Child00()
    fallout.gsay_reply(108, 100)
    fallout.giq_option(4, 108, 101, Child04, 50)
    fallout.giq_option(5, 108, 102, Child11, 50)
    if (fallout.map_var(2) == 1) and (fallout.local_var(7) == 0) then
        fallout.giq_option(5, 108, 103, Child15, 50)
    end
    fallout.giq_option(-3, 108, 104, Child01, 50)
end

function Child01()
    fallout.gsay_message(108, 105, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 35) < fallout.get_critter_stat(fallout.dude_obj(), 7) then
        child_heal()
        Child03()
    else
        Child02()
    end
end

function Child02()
    fallout.gsay_message(108, 106, 50)
end

function Child03()
    fallout.critter_heal(fallout.dude_obj(), fallout.get_critter_stat(fallout.dude_obj(), 7) - fallout.get_critter_stat(fallout.dude_obj(), 35))
    fallout.poison(fallout.dude_obj(), -fallout.get_poison(fallout.dude_obj()))
    fallout.gsay_message(108, 107, 50)
end

function Child04()
    if fallout.local_var(1) == 3 then
        healing_cost = 5
        poison_cost = 12
    else
        if fallout.local_var(1) == 1 then
            healing_cost = 20
            poison_cost = 50
        else
            healing_cost = 10
            poison_cost = 25
        end
    end
    hp_injured = fallout.get_critter_stat(fallout.dude_obj(), 7) - fallout.get_critter_stat(fallout.dude_obj(), 35)
    cost = hp_injured * healing_cost
    if fallout.get_poison(fallout.dude_obj()) ~= 0 then
        cost = cost + poison_cost
    end
    if hp_injured > 0 then
        fallout.gsay_message(108, 108, 50)
    end
    if fallout.get_poison(fallout.dude_obj()) ~= 0 then
        fallout.gsay_message(108, 109, 50)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 37) > 50 then
        fallout.gsay_message(108, 110, 50)
    end
    if cost > 0 then
        fallout.gsay_reply(108, fallout.message_str(108, 111) + cost + fallout.message_str(108, 112))
        fallout.giq_option(4, 108, 113, Child04a, 50)
        fallout.giq_option(4, 108, 114, ChildEnd, 50)
        fallout.giq_option(4, 108, 115, Child09, 50)
        fallout.giq_option(4, 108, fallout.message_str(108, 116) + (cost * 0.75000) + fallout.message_str(108, 117), Child05, 50)
    else
        fallout.gsay_message(108, 146, 50)
    end
end

function Child04a()
    if cost > fallout.item_caps_total(fallout.dude_obj()) then
        Child08()
    else
        Child06()
    end
end

function Child05()
    fallout.gsay_reply(108, 118)
    fallout.giq_option(4, 108, 119, Child05a, 50)
    fallout.giq_option(4, 108, 120, Child05b, 51)
end

function Child05a()
    if cost > fallout.item_caps_total(fallout.dude_obj()) then
        Child08()
    else
        Child06()
    end
end

function Child05b()
    fallout.set_local_var(5, 1)
    ChildEnd()
end

function Child06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(108, 121)
    else
        fallout.gsay_reply(108, 122)
    end
    fallout.giq_option(0, 634, 106, Child07, 50)
end

function Child07()
    fallout.gfade_out(600)
    fallout.item_caps_adjust(fallout.dude_obj(), -cost)
    child_heal()
    child_pois()
    fallout.gfade_in(600)
    fallout.gsay_message(108, 123, 50)
end

function Child08()
    fallout.gsay_reply(108, 124)
    cost = fallout.item_caps_total(fallout.dude_obj())
    fallout.giq_option(4, 108, 125, Child06, 50)
    fallout.giq_option(4, 108, 129, ChildEnd, 50)
end

function Child09()
    fallout.gsay_reply(108, 127)
    fallout.giq_option(4, 108, 128, Child09a, 50)
    fallout.giq_option(4, 108, 129, ChildEnd, 50)
end

function Child09a()
    if cost > fallout.item_caps_total(fallout.dude_obj()) then
        Child06()
    else
        Child10()
    end
end

function Child10()
    fallout.gsay_reply(108, 130)
    fallout.giq_option(0, 634, 106, Child06, 50)
end

function Child11()
    fallout.gsay_reply(108, 131)
    fallout.giq_option(4, 108, 132, ChildEnd, 50)
    fallout.giq_option(4, 108, 133, Child12, 50)
end

function Child12()
    fallout.gsay_reply(108, 134)
    fallout.giq_option(4, 108, 135, Child14, 50)
    fallout.giq_option(4, 108, 136, Child13, 50)
end

function Child13()
    fallout.gsay_message(108, 137, 51)
end

function Child14()
    fallout.gsay_reply(108, 138)
    fallout.giq_option(4, 108, 139, ChildEnd, 50)
end

function Child15()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(108, 140)
    fallout.giq_option(5, 108, 141, Child16, 50)
    fallout.giq_option(5, 108, 142, ChildEnd, 50)
end

function Child16()
    fallout.gsay_reply(108, 143)
    fallout.giq_option(5, 108, 144, ChildEnd, 50)
end

function Child17()
    scared = 1
    fallout.gsay_message(108, 145, 51)
end

function flee_dude()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    while v1 < 5 do
        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)) > v2 then
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)
            v2 = fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), v0)
        end
        v1 = v1 + 1
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 1)
end

function sleeping()
    if fallout.local_var(4) == 1 then
        if not(night_person) and (fallout.game_time_hour() >= wake_time) and (fallout.game_time_hour() < sleep_time) or (night_person and ((fallout.game_time_hour() >= wake_time) or (fallout.game_time_hour() < sleep_time))) then
            if ((fallout.game_time_hour() - wake_time) < 10) and ((fallout.game_time_hour() - wake_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                else
                    fallout.set_local_var(4, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), home_tile, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == home_tile then
                    fallout.set_local_var(4, 0)
                end
            end
        end
    else
        if night_person and (fallout.game_time_hour() >= sleep_time) and (fallout.game_time_hour() < wake_time) or (not(night_person) and ((fallout.game_time_hour() >= sleep_time) or (fallout.game_time_hour() < wake_time))) then
            if ((fallout.game_time_hour() - sleep_time) < 10) and ((fallout.game_time_hour() - sleep_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(4, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.move_to(fallout.self_obj(), sleep_tile, fallout.elevation(fallout.self_obj()))
                else
                    fallout.set_local_var(4, 1)
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
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
