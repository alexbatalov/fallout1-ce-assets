local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local childend
local childcbt
local child_heal
local child_pois
local child00
local child01
local child02
local child03
local child04
local child04a
local child05
local child05a
local child06
local child07
local child08
local child09
local child09a
local child10
local child11
local child12
local child13
local child14
local child15
local child16

local initialized = false
local hostile = false
local max_hp = 0
local current_hp = 0
local hp_injured = 0
local cost = 0
local cheat = 0
local RADCOUNT = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 20)
        fallout.critter_add_trait(self_obj, 1, 5, 67)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    max_hp = fallout.get_critter_stat(fallout.dude_obj(), 7)
    current_hp = fallout.get_critter_stat(fallout.dude_obj(), 35)
    RADCOUNT = 0

    if fallout.local_var(5) == 0 then
        if fallout.local_var(4) ~= 0 then
            child16()
        else
            if fallout.global_var(35) > 0 then
                child15()
            else
                reaction.get_reaction()
                fallout.start_gdialog(41, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                child00()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    else
        childend()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function damage_p_proc()
    fallout.set_local_var(4, 1)
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(41, 100))
end

function childend()
end

function childcbt()
    hostile = true
end

function child_heal()
    fallout.game_time_advance(fallout.game_ticks(600 * hp_injured))
    fallout.critter_heal(fallout.dude_obj(), hp_injured)
    fallout.set_global_var(154, fallout.global_var(154) - 1)
end

function child_pois()
    fallout.game_time_advance(fallout.game_ticks(1800))
    fallout.poison(fallout.dude_obj(), -fallout.get_poison(fallout.dude_obj()))
    fallout.set_global_var(154, fallout.global_var(154) - 1)
end

function child00()
    fallout.gsay_reply(41, 101)
    fallout.giq_option(4, 41, 102, child04, 50)
    fallout.giq_option(5, 41, 103, child11, 50)
    fallout.giq_option(-3, 41, 104, child01, 50)
end

function child01()
    fallout.gsay_message(41, 105, 50)
    if current_hp < max_hp then
        hp_injured = max_hp - current_hp
        child_heal()
        child03()
    else
        child02()
    end
end

function child02()
    fallout.gsay_message(41, 106, 50)
    childend()
end

function child03()
    fallout.gsay_message(41, 107, 50)
    childend()
end

function child04()
    local healing_cost
    local pois_cost
    if fallout.local_var(1) >= 3 then
        healing_cost = 5
        pois_cost = 12
    elseif fallout.local_var(1) < 2 then
        healing_cost = 20
        pois_cost = 50
    else
        healing_cost = 10
        pois_cost = 25
    end
    hp_injured = max_hp - current_hp
    cost = (hp_injured * healing_cost) + pois_cost
    cheat = 3 * cost // 4
    if hp_injured > 0 then
        fallout.gsay_message(41, 108, 50)
    else
        fallout.gsay_message(41, 109, 50)
    end
    if fallout.get_poison(fallout.dude_obj()) then
        fallout.gsay_message(41, 110, 50)
    end
    if RADCOUNT > 50 then
        fallout.gsay_message(41, 111, 50)
    end
    if hp_injured > 0 or fallout.get_poison(fallout.dude_obj()) ~= 0 then
        fallout.gsay_reply(41, fallout.message_str(41, 113) .. cost .. fallout.message_str(41, 114))
        fallout.giq_option(3, 41, 115, child04a, 50)
        fallout.giq_option(3, 41, 116, childend, 50)
        fallout.giq_option(3, 41, 117, child09, 50)
        fallout.giq_option(3, 41, fallout.message_str(41, 118) .. cheat .. fallout.message_str(41, 119), child05, 50)
    end
end

function child04a()
    if cost > fallout.item_caps_total(fallout.dude_obj()) then
        child08()
    else
        child06()
    end
end

function child05()
    fallout.gsay_reply(41, 120)
    fallout.giq_option(3, 41, 121, child05a, 50)
    fallout.giq_option(3, 41, 122, childend, 50)
end

function child05a()
    fallout.set_local_var(5, 1)
    childend()
end

function child06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(41, 123, 50)
    else
        fallout.gsay_message(41, 124, 50)
    end
    fallout.item_caps_adjust(fallout.dude_obj(), -cost)
    fallout.gfade_out(400)
    fallout.gfade_in(400)
    if hp_injured > 0 then
        child_heal()
    end
    if fallout.get_poison(fallout.dude_obj()) ~= 0 then
        child_pois()
    end
    child07()
end

function child07()
    fallout.gsay_message(41, 125, 50)
    childend()
end

function child08()
    if cost > fallout.item_caps_total(fallout.dude_obj()) then
        cost = fallout.item_caps_total(fallout.dude_obj())
    end
    fallout.gsay_reply(41, 126)
    fallout.giq_option(3, 41, 127, child06, 50)
    fallout.giq_option(3, 41, 128, childend, 50)
end

function child09()
    fallout.gsay_reply(41, 129)
    fallout.giq_option(3, 41, 130, child09a, 50)
    fallout.giq_option(3, 41, 131, childend, 50)
end

function child09a()
    if fallout.item_caps_total(fallout.dude_obj()) >= cost then
        child10()
    else
        cost = fallout.item_caps_total(fallout.dude_obj())
        child06()
    end
end

function child10()
    fallout.gsay_message(41, 132, 50)
    child06()
end

function child11()
    fallout.gsay_reply(41, 133)
    fallout.giq_option(3, 41, 134, childend, 50)
    fallout.giq_option(3, 41, 135, child12, 50)
end

function child12()
    fallout.gsay_reply(41, 136)
    fallout.giq_option(3, 41, 137, child14, 50)
    fallout.giq_option(3, 41, 138, child13, 50)
end

function child13()
    fallout.gsay_message(41, 139, 50)
    childend()
end

function child14()
    fallout.gsay_reply(41, 140)
    fallout.giq_option(3, 41, 141, childend, 50)
end

function child15()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(41, 142), 7)
    childend()
end

function child16()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(41, 143), 7)
    childcbt()
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
