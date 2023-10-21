local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local boslori00
local boslori01
local boslori02
local boslori03
local boslori04
local boslori05
local boslori06
local boslori07
local boslori08
local boslori09
local boslori10
local boslori11
local boslori12
local boslori13
local boslori14
local boslori15
local boslori16
local boslori17
local boslori18
local boslori19
local boslori20
local Dumb02
local Dumb03
local Dumb04
local Dumb05
local Dumb06
local Dumb06a
local raisiq
local boslori22
local bosloriend
local sorry
local do_dialog

local hostile = false
local initialized = false
local heal = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 63)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(675, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    do_dialog()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(675, 100))
end

function boslori00()
    heal = fallout.get_critter_stat(fallout.dude_obj(), 7) - fallout.get_critter_stat(fallout.dude_obj(), 35)
    fallout.gsay_reply(675, 102)
    if heal > 0 then
        fallout.giq_option(4, 675, 103, boslori04, 50)
    end
    fallout.giq_option(5, 675, 104, boslori05, 50)
    if fallout.local_var(5) ~= 1 then
        fallout.giq_option(4, 675, 105, boslori07, 50)
    else
        fallout.giq_option(4, 675, 106, boslori09, 50)
    end
    if fallout.local_var(11) == 1 then
        fallout.giq_option(-3, 675, 107, boslori01, 50)
    else
        fallout.giq_option(-3, 675, 107, Dumb02, 50)
    end
end

function boslori01()
    fallout.gsay_message(675, 108, 50)
    if heal > 0 then
        boslori02()
    else
        boslori03()
    end
end

function boslori02()
    fallout.critter_heal(fallout.dude_obj(), heal)
    fallout.gsay_message(675, 109, 50)
end

function boslori03()
    fallout.gsay_message(675, 110, 50)
end

function boslori04()
    fallout.critter_heal(fallout.dude_obj(), heal)
    fallout.gsay_message(675, fallout.random(112, 116), 50)
end

function boslori05()
    fallout.gsay_message(675, 117, 50)
    fallout.gfade_out(600)
    fallout.radiation_dec(fallout.dude_obj(), fallout.get_critter_stat(fallout.dude_obj(), 37))
    fallout.game_time_advance(fallout.game_ticks(86400))
    fallout.gfade_in(600)
    fallout.gsay_message(675, 146, 50)
end

function boslori06()
    fallout.gsay_message(675, 118, 50)
end

function boslori07()
    fallout.gsay_reply(675, 119)
    fallout.giq_option(4, 675, 120, boslori08, 50)
    fallout.giq_option(4, 675, 121, bosloriend, 50)
end

function boslori08()
    fallout.set_local_var(5, 1)
    fallout.gsay_message(675, 122, 50)
    boslori10()
end

function boslori09()
    fallout.gsay_reply(675, 126)
    boslori10()
end

function boslori10()
    if fallout.local_var(6) ~= 1 then
        fallout.giq_option(4, 675, 127, boslori11, 50)
    end
    if fallout.local_var(7) ~= 1 then
        fallout.giq_option(4, 675, 128, boslori12, 50)
    end
    if fallout.local_var(8) ~= 1 then
        fallout.giq_option(4, 675, 129, boslori13, 50)
    end
    if fallout.local_var(9) ~= 1 then
        fallout.giq_option(4, 675, 130, boslori14, 50)
    end
    if fallout.local_var(10) ~= 1 then
        fallout.giq_option(4, 675, 131, boslori15, 50)
    end
    fallout.giq_option(4, 675, 132, bosloriend, 50)
end

function boslori11()
    local strength = fallout.get_critter_stat(fallout.dude_obj(), 0)
    if strength > 9 then
        sorry()
    else
        fallout.gsay_reply(675, 133)
        fallout.giq_option(4, 675, 135, boslori18, 50)
        fallout.giq_option(4, 675, 136, boslori17, 50)
    end
end

function boslori12()
    local perception = fallout.get_critter_stat(fallout.dude_obj(), 1)
    if perception > 9 then
        sorry()
    else
        fallout.gsay_reply(675, 137)
        fallout.giq_option(4, 675, 135, boslori19, 50)
        fallout.giq_option(4, 675, 136, boslori17, 50)
    end
end

function boslori13()
    local endurance = fallout.get_critter_stat(fallout.dude_obj(), 2)
    if endurance > 9 then
        sorry()
    else
        fallout.gsay_reply(675, 139)
        fallout.giq_option(4, 675, 135, boslori20, 50)
        fallout.giq_option(4, 675, 136, boslori17, 50)
    end
end

function boslori14()
    local intelligence = fallout.get_critter_stat(fallout.dude_obj(), 4)
    if intelligence > 9 then
        sorry()
    else
        fallout.gsay_reply(675, 141)
        fallout.giq_option(4, 675, 135, raisiq, 50)
        fallout.giq_option(4, 675, 136, boslori17, 50)
    end
end

function boslori15()
    local agility = fallout.get_critter_stat(fallout.dude_obj(), 5)
    if agility > 9 then
        sorry()
    else
        fallout.gsay_reply(675, 143)
        fallout.giq_option(4, 675, 135, boslori22, 50)
        fallout.giq_option(4, 675, 136, boslori17, 50)
    end
end

function boslori16()
    fallout.gsay_message(675, fallout.random(147, 149), 50)
end

function boslori17()
    fallout.gsay_message(675, 153, 50)
    boslori10()
end

function boslori18()
    local cost = 2000
    if fallout.item_caps_total(fallout.dude_obj()) >= cost then
        local bag_ptr = fallout.create_object_sid(16777262, 0, 0, 860)
        fallout.move_to(bag_ptr, 0, 0)
        local armor = fallout.critter_inven_obj(fallout.dude_obj(), 0)
        if armor ~= nil then
            fallout.move_obj_inven_to_obj(fallout.dude_obj(), bag_ptr)
            fallout.move_obj_inven_to_obj(bag_ptr, fallout.dude_obj())
            fallout.destroy_object(bag_ptr)
        end
        fallout.set_local_var(6, 1)
        fallout.item_caps_adjust(fallout.dude_obj(), -cost)
        fallout.gsay_message(675, 154, 50)
        fallout.gfade_out(600)
        fallout.game_time_advance(fallout.game_ticks(3 * 604800))
        fallout.gfade_in(600)
        fallout.set_critter_stat(fallout.dude_obj(), 0, 1)
        fallout.gsay_message(675, 156, 50)
    else
        boslori16()
    end
end

function boslori19()
    local cost = 4000
    if fallout.item_caps_total(fallout.dude_obj()) >= cost then
        fallout.set_local_var(7, 1)
        fallout.item_caps_adjust(fallout.dude_obj(), -cost)
        fallout.gsay_message(675, 159, 50)
        fallout.gfade_out(600)
        fallout.game_time_advance(fallout.game_ticks(604800))
        fallout.gfade_in(600)
        fallout.set_critter_stat(fallout.dude_obj(), 1, 1)
        fallout.gsay_message(675, 161, 50)
    else
        boslori16()
    end
end

function boslori20()
    local cost = 3000
    if fallout.item_caps_total(fallout.dude_obj()) >= cost then
        fallout.set_local_var(8, 1)
        fallout.item_caps_adjust(fallout.dude_obj(), -cost)
        fallout.gsay_message(675, 164, 50)
        fallout.gfade_out(600)
        fallout.game_time_advance(fallout.game_ticks(604800))
        fallout.gfade_in(600)
        fallout.set_critter_stat(fallout.dude_obj(), 2, 1)
        fallout.gsay_message(675, 166, 50)
    else
        boslori16()
    end
end

function Dumb02()
    fallout.gsay_reply(675, 400)
    fallout.giq_option(-3, 675, 401, Dumb04, 50)
    fallout.giq_option(-3, 675, 402, Dumb03, 50)
end

function Dumb03()
    fallout.gsay_reply(675, 403)
    fallout.giq_option(-3, 675, 404, Dumb06a, 50)
    fallout.giq_option(-3, 675, 405, boslori05, 50)
    fallout.giq_option(-3, 675, 406, bosloriend, 50)
end

function Dumb04()
    local cost = 3000
    if fallout.item_caps_total(fallout.dude_obj()) >= cost then
        fallout.set_local_var(9, 1)
        fallout.set_local_var(11, 1)
        fallout.item_caps_adjust(fallout.dude_obj(), -cost)
        fallout.gsay_message(675, 164, 50)
        fallout.gfade_out(600)
        fallout.game_time_advance(fallout.game_ticks(604800))
        fallout.gfade_in(600)
        fallout.set_critter_stat(fallout.dude_obj(), 4, 1)
        fallout.gsay_reply(675, 407)
        fallout.giq_option(4, 675, 409, Dumb06, 50)
        fallout.giq_option(-3, 675, 408, Dumb05, 50)
    else
        boslori16()
    end
end

function Dumb05()
    fallout.gsay_message(675, 410, 50)
end

function Dumb06()
    fallout.gsay_reply(675, 411)
    fallout.giq_option(4, 675, 412, bosloriend, 50)
end

function Dumb06a()
    local dude_obj = fallout.dude_obj()
    local hurting = fallout.get_critter_stat(dude_obj, 7) - fallout.get_critter_stat(dude_obj, 35)
    fallout.critter_heal(dude_obj, hurting)
    fallout.gsay_message(675, 413, 50)
end

function raisiq()
    local cost = 6000
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= cost then
        fallout.set_local_var(9, 1)
        fallout.item_caps_adjust(dude_obj, -cost)
        fallout.gsay_message(675, 168, 50)
        fallout.gfade_out(600)
        fallout.game_time_advance(fallout.game_ticks(3 * 604800))
        fallout.gfade_in(600)
        fallout.set_critter_stat(dude_obj, 4, 1)
        fallout.gsay_message(675, 170, 50)
    else
        boslori16()
    end
end

function boslori22()
    local cost = 5000
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= cost then
        fallout.set_local_var(10, 1)
        fallout.item_caps_adjust(dude_obj, -cost)
        fallout.gsay_message(675, 174, 50)
        fallout.gfade_out(600)
        fallout.game_time_advance(fallout.game_ticks(3 * 604800))
        fallout.gfade_in(600)
        fallout.set_critter_stat(dude_obj, 5, 1)
        fallout.gsay_message(675, 176, 50)
    else
        boslori16()
    end
end

function bosloriend()
end

function sorry()
    fallout.gsay_message(675, 300, 50)
end

function do_dialog()
    boslori00()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
