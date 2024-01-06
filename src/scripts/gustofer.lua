local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local Gustofer00
local Gustofer00a
local Gustofer01
local Gustofer02
local Gustofer03
local Gustofer04
local Gustofer05
local Gustofer06
local Gustofer07
local Gustofer08
local Gustofer09
local Gustofer10
local Gustofer10a
local Gustofer11
local Gustofer12
local Gustofer13
local Gustofer14
local Gustofer15
local Gustofer16
local Gustofer17
local Gustofer18
local Gustofer19
local GustoferEnd
local GustoferWait
local GustoferBet1
local GustoferBet2
local destroy_challenger

local round_counter = 0
local robbed = false
local dude_bet = 0
local line148flag = false

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        round_counter = round_counter + 1
    end
    if round_counter > 3 then
        if fallout.global_var(247) == 0 then
            fallout.set_global_var(247, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(dude_obj, 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(dude_obj, 2)) == 3) and distance_self_to_dude < 8 and fallout.local_var(1) == 0 then
        behaviour.flee_dude(1)
    else
        if fallout.game_time_hour() == 1400 then
            if not line148flag and time.game_time_in_days() % 3 == 0 then
                line148flag = true
                fallout.set_external_var("fight", 1)
                fallout.float_msg(self_obj, fallout.message_str(529, 148), 0)
            end
        else
            line148flag = false
        end
        if fallout.external_var("Saul_wins") ~= 0 or fallout.external_var("Saul_loses") ~= 0 and fallout.external_var("shot_challenger") ~= 0 then
            destroy_challenger()
            if fallout.obj_can_see_obj(self_obj, dude_obj) and distance_self_to_dude < 12 then
                fallout.dialogue_system_enter()
            end
        else
            behaviour.sleeping(1, night_person, wake_time, sleep_time, home_tile, sleep_tile)
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.global_var(15) == 1 then
        fallout.destroy_object(self_obj)
    end
    if fallout.local_var(0) == 0 then
        fallout.set_local_var(0, fallout.tile_num(self_obj))
    end
    if fallout.obj_is_carrying_obj_pid(self_obj, 41) == 0 then
        fallout.item_caps_adjust(self_obj, fallout.random(0, 10))
    end
    fallout.critter_add_trait(self_obj, 1, 6, 25)
    sleep_time = 1920
    wake_time = 530
    home_tile = 17096
    sleep_tile = 7000
end

function pickup_p_proc()
    robbed = true
    fallout.dialogue_system_enter()
end

function talk_p_proc()
    if not robbed and fallout.local_var(2) == 1 and time.game_time_in_days() % 3 ~= 0 then
        Gustofer05()
    else
        fallout.start_gdialog(529, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.external_var("Saul_wins") ~= 0 then
            if dude_bet == 1 then
                Gustofer16()
            else
                Gustofer07()
            end
        elseif fallout.external_var("Saul_loses") ~= 0 then
            if dude_bet == 2 then
                Gustofer16()
            else
                Gustofer07()
            end
        elseif robbed then
            Gustofer13()
        elseif time.game_time_in_days() % 3 == 0 then
            if fallout.game_time_hour() < 1400 then
                if dude_bet == 0 then
                    Gustofer06()
                else
                    fallout.gsay_message(529, 152, 50)
                end
            else
                if fallout.external_var("challenger_ptr") ~= nil then
                    Gustofer19()
                else
                    Gustofer18()
                    dude_bet = 0
                end
            end
        else
            Gustofer00()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function Gustofer00()
    fallout.set_local_var(2, 1)
    fallout.gsay_reply(529, 100)
    fallout.giq_option(-3, 529, 101, Gustofer01, 50)
    fallout.giq_option(4, 529, 102, GustoferEnd, 50)
    fallout.giq_option(6, 529, 103, Gustofer00a, 50)
end

function Gustofer00a()
    if time.game_time_in_days() % 3 == 1 then
        Gustofer03()
    else
        Gustofer02()
    end
end

function Gustofer01()
    fallout.gsay_message(529, 104, 50)
end

function Gustofer02()
    fallout.gsay_reply(529, 105)
    fallout.giq_option(4, 529, 107, GustoferEnd, 50)
    fallout.giq_option(4, 529, 108, Gustofer04, 50)
end

function Gustofer03()
    fallout.gsay_reply(529, 106)
    fallout.giq_option(4, 529, 107, GustoferEnd, 50)
    fallout.giq_option(4, 529, 108, Gustofer04, 50)
end

function Gustofer04()
    fallout.gsay_message(529, 109, 50)
end

function Gustofer05()
    local msg = fallout.message_str(529, 110)
    if time.game_time_in_days() % 3 == 1 then
        msg = msg .. fallout.message_str(529, 112)
    elseif time.game_time_in_days() % 3 == 2 then
        msg = msg .. fallout.message_str(529, 111)
    end
    fallout.float_msg(fallout.self_obj(), msg, 0)
end

function Gustofer06()
    fallout.gsay_reply(529, 113)
    fallout.giq_option(-3, 529, 101, Gustofer01, 50)
    fallout.giq_option(4, 529, 114, GustoferEnd, 50)
    fallout.giq_option(4, 529, 115, Gustofer08, 50)
    fallout.giq_option(4, 529, 116, Gustofer09, 50)
end

function Gustofer07()
    fallout.set_external_var("Saul_wins", 0)
    fallout.set_external_var("Saul_loses", 0)
    dude_bet = 0
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(529, 150, 50)
    else
        fallout.gsay_message(529, 151, 50)
    end
end

function Gustofer08()
    fallout.gsay_reply(529, 120)
    fallout.giq_option(4, 529, 121, GustoferBet1, 50)
    fallout.giq_option(4, 529, 122, GustoferBet2, 50)
end

function Gustofer09()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        fallout.gsay_reply(529, 123)
        if fallout.global_var(169) < 1 then
            fallout.giq_option(4, 529, 124, Gustofer10, 50)
        end
        fallout.giq_option(4, 529, 125, Gustofer11, 50)
        fallout.giq_option(4, 529, 126, GustoferEnd, 50)
    else
        fallout.gsay_message(529, 127, 50)
    end
end

function Gustofer10()
    fallout.gsay_reply(529, 128)
    fallout.giq_option(0, 634, 106, Gustofer10a, 50)
end

function Gustofer10a()
    fallout.gsay_reply(529, 129)
    fallout.giq_option(4, 529, 130, Gustofer11, 50)
    fallout.giq_option(4, 529, 131, GustoferEnd, 50)
end

function Gustofer11()
    fallout.gsay_reply(529, 132)
    fallout.giq_option(4, 529, 133, Gustofer12, 50)
    fallout.giq_option(4, 529, 134, GustoferEnd, 50)
end

function Gustofer12()
    fallout.gsay_reply(529, 135)
    fallout.giq_option(4, 529, 136, GustoferEnd, 50)
end

function Gustofer13()
    robbed = false
    fallout.gsay_reply(529, 137)
    fallout.giq_option(4, 529, 138, Gustofer14, 51)
    fallout.giq_option(4, 529, 139, Gustofer15, 51)
    fallout.giq_option(-3, 529, 101, Gustofer15, 51)
end

function Gustofer14()
    fallout.gsay_message(529, 140, 51)
end

function Gustofer15()
    fallout.gsay_message(529, 141, 51)
end

function Gustofer16()
    dude_bet = 0
    if fallout.external_var("Saul_wins") ~= 0 then
        fallout.item_caps_adjust(fallout.dude_obj(), 50)
    else
        fallout.item_caps_adjust(fallout.dude_obj(), 100)
    end
    fallout.set_external_var("Saul_wins", 0)
    fallout.set_external_var("Saul_loses", 0)
    fallout.gsay_message(529, 142, 50)
    destroy_challenger()
end

function Gustofer17()
    fallout.gsay_message(529, 147, 50)
end

function Gustofer18()
    fallout.gsay_reply(529, 118)
    fallout.giq_option(4, 529, 119, GustoferEnd, 50)
    fallout.giq_option(-3, 529, 101, GustoferEnd, 50)
end

function Gustofer19()
    fallout.gsay_message(529, 149, 50)
end

function GustoferEnd()
end

function GustoferWait()
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks((3600 * (13 - (fallout.game_time_hour() // 100))) +
        (60 * (60 - (fallout.game_time_hour() % 100)))))
    fallout.gfade_in(600)
end

function GustoferBet1()
    if fallout.item_caps_total(fallout.dude_obj()) >= 25 then
        fallout.item_caps_adjust(fallout.dude_obj(), -25)
        dude_bet = 1
        fallout.gsay_reply(529, 144)
        fallout.giq_option(4, 529, 145, GustoferWait, 50)
        fallout.giq_option(4, 529, 146, Gustofer17, 50)
    else
        fallout.gsay_message(529, 143, 50)
    end
end

function GustoferBet2()
    if fallout.item_caps_total(fallout.dude_obj()) >= 25 then
        fallout.item_caps_adjust(fallout.dude_obj(), -25)
        dude_bet = 2
        fallout.gsay_reply(529, 144)
        fallout.giq_option(4, 529, 145, GustoferWait, 50)
        fallout.giq_option(4, 529, 146, Gustofer17, 50)
    else
        fallout.gsay_message(529, 143, 50)
    end
end

function destroy_challenger()
    fallout.destroy_object(fallout.external_var("challenger_ptr"))
    fallout.set_external_var("shot_challenger", 0)
    fallout.set_external_var("challenger_ptr", 0)
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
