local fallout = require("fallout")

local start
local do_dialogue
local pre_dialogue
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

local init_teams = 0
local hostile = 0
local max_hp = 0
local current_hp = 0
local cur_pois = 0
local hp_injured = 0
local cost = 0
local pois_cost = 0
local cheat = 0
local RADCOUNT = 0

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
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 67)
        init_teams = 1
    end
    max_hp = fallout.get_critter_stat(fallout.dude_obj(), 7)
    current_hp = fallout.get_critter_stat(fallout.dude_obj(), 35)
    RADCOUNT = 0
    if fallout.script_action() == 11 then
        if fallout.local_var(5) == 0 then
            pre_dialogue()
        else
            childend()
        end
    else
        if fallout.script_action() == 14 then
            fallout.set_local_var(4, 1)
        else
            if fallout.script_action() == 21 then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(41, 100))
            else
                if fallout.script_action() == 4 then
                    hostile = 1
                else
                    if fallout.script_action() == 12 then
                        if hostile then
                            hostile = 0
                            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                        end
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
                                fallout.set_global_var(159, fallout.global_var(159) + 1)
                                if (fallout.global_var(159) % 2) == 0 then
                                    fallout.set_global_var(155, fallout.global_var(155) - 1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    get_reaction()
    fallout.start_gdialog(41, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    child00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function pre_dialogue()
    if fallout.local_var(4) then
        child16()
    else
        if fallout.global_var(35) > 0 then
            child15()
        else
            do_dialogue()
        end
    end
end

function childend()
end

function childcbt()
    hostile = 1
end

function child_heal()
    fallout.game_time_advance(fallout.game_ticks(600 * hp_injured))
    fallout.critter_heal(fallout.dude_obj(), hp_injured)
    fallout.set_global_var(154, fallout.global_var(154) - 1)
end

function child_pois()
    fallout.game_time_advance(fallout.game_ticks(1800))
    cur_pois = fallout.get_poison(fallout.dude_obj())
    fallout.poison(fallout.dude_obj(), -cur_pois)
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
    local v0 = 0
    if fallout.local_var(1) >= 3 then
        v0 = 5
        pois_cost = 12
    else
        if fallout.local_var(1) < 2 then
            v0 = 20
            pois_cost = 50
        else
            v0 = 10
            pois_cost = 25
        end
    end
    hp_injured = max_hp - current_hp
    cost = (hp_injured * v0) + pois_cost
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
    if (hp_injured > 0) or fallout.get_poison(fallout.dude_obj()) then
        fallout.gsay_reply(41, fallout.message_str(41, 113) + cost + fallout.message_str(41, 114))
        fallout.giq_option(3, 41, 115, child04a, 50)
        fallout.giq_option(3, 41, 116, childend, 50)
        fallout.giq_option(3, 41, 117, child09, 50)
        fallout.giq_option(3, 41, fallout.message_str(41, 118) + cheat + fallout.message_str(41, 119), child05, 50)
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
    if fallout.get_poison(fallout.dude_obj()) then
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
return exports
