local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local LoneRaid00
local LoneRaid01
local LoneRaid02
local LoneRaid03
local LoneRaid03a
local LoneRaid04
local LoneRaid04a
local LoneRaid05
local LoneRaid06
local LoneRaid07
local LoneRaid08
local LoneRaid09
local LoneRaid10
local LoneRaid11
local LoneRaid12
local LoneRaid13
local LoneRaid14
local LoneRaid15
local LoneRaid16
local LoneRaid17
local LoneRaid18
local LoneRaid19
local LoneRaid20
local LoneRaid21
local LoneRaid22
local LoneRaidCombat
local LoneRaidEnd
local LoneRaidLoot
local flee_dude

local hostile = 0
local initialized = 0
local known = 0
local broken = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 6)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 20)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
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
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 8) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 24) then
            flee_dude()
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if broken then
        LoneRaid01()
    else
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
            LoneRaid00()
        else
            if known then
                LoneRaid02()
            else
                fallout.start_gdialog(700, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                known = 1
                if fallout.global_var(12) then
                    LoneRaid06()
                else
                    if (fallout.global_var(26) == 2) or fallout.global_var(254) then
                        LoneRaid05()
                    else
                        if fallout.global_var(611) then
                            LoneRaid04()
                        else
                            LoneRaid03()
                        end
                    end
                end
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
end

function LoneRaid00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(700, 100), 0)
end

function LoneRaid01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(700, 101), 0)
end

function LoneRaid02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(700, 102), 0)
end

function LoneRaid03()
    fallout.gsay_reply(700, 103)
    fallout.giq_option(7, 700, 104, LoneRaid07, 50)
    fallout.giq_option(4, 700, 105, LoneRaid03a, 51)
    fallout.giq_option(4, 700, 106, LoneRaid09, 50)
    fallout.giq_option(4, 700, 107, LoneRaid10, 51)
    fallout.giq_option(-3, 700, 108, LoneRaid11, 51)
    fallout.giq_option(-3, 700, 109, LoneRaid12, 50)
end

function LoneRaid03a()
    if (fallout.get_critter_stat(fallout.dude_obj(), 0) + fallout.get_critter_stat(fallout.dude_obj(), 2)) > 13 then
        LoneRaid08()
    else
        LoneRaidCombat()
    end
end

function LoneRaid04()
    fallout.gsay_reply(700, 110 + (fallout.get_critter_stat(fallout.dude_obj(), 34) == 1))
    fallout.giq_option(7, 700, 112, LoneRaid13, 49)
    fallout.giq_option(4, 700, 113, LoneRaid04a, 50)
    fallout.giq_option(4, 700, 114, LoneRaid16, 50)
    fallout.giq_option(4, 700, 115, LoneRaid17, 50)
    fallout.giq_option(-3, 700, 109, LoneRaid12, 50)
end

function LoneRaid04a()
    if fallout.get_critter_stat(fallout.dude_obj(), 6) < 5 then
        LoneRaid14()
    else
        LoneRaid15()
    end
end

function LoneRaid05()
    fallout.gsay_reply(700, 116)
    if (fallout.global_var(103) == 1) and (fallout.global_var(26) == 1) then
        fallout.giq_option(7, 700, 117, LoneRaid18, 50)
    end
    fallout.giq_option(4, 700, 118, LoneRaid03a, 51)
    fallout.giq_option(4, 700, 119, LoneRaid09, 50)
    fallout.giq_option(4, 700, 120, LoneRaid10, 51)
    fallout.giq_option(-3, 700, 108, LoneRaid11, 51)
    fallout.giq_option(-3, 700, 109, LoneRaid12, 50)
end

function LoneRaid06()
    fallout.gsay_reply(700, 121)
    fallout.giq_option(7, 700, 122, LoneRaid18, 50)
    fallout.giq_option(4, 700, 123, LoneRaid19, 51)
    fallout.giq_option(4, 700, 124, LoneRaid20, 50)
    fallout.giq_option(4, 700, 125, LoneRaid21, 50)
    fallout.giq_option(-3, 700, 109, LoneRaid12, 50)
end

function LoneRaid07()
    fallout.gsay_reply(700, 126)
    fallout.giq_option(4, 700, 127, LoneRaid03a, 50)
    fallout.giq_option(4, 700, 128, LoneRaid09, 50)
    fallout.giq_option(4, 700, 129, LoneRaid22, 51)
end

function LoneRaid08()
    broken = 1
    fallout.gsay_reply(700, 130)
    fallout.giq_option(0, 634, 106, LoneRaidLoot, 50)
end

function LoneRaid09()
    fallout.gsay_message(700, 131, 50)
end

function LoneRaid10()
    fallout.gsay_message(700, 132, 51)
end

function LoneRaid11()
    fallout.gsay_message(700, 133, 51)
end

function LoneRaid12()
    fallout.gsay_message(700, 135, 50)
end

function LoneRaid13()
    fallout.gsay_message(700, 135 + (fallout.get_critter_stat(fallout.dude_obj(), 34) == 1), 49)
end

function LoneRaid14()
    fallout.gsay_message(700, 137, 51)
    hostile = 1
end

function LoneRaid15()
    fallout.gsay_message(700, 138 + (fallout.get_critter_stat(fallout.dude_obj(), 34) == 1), 50)
end

function LoneRaid16()
    fallout.gsay_message(700, 140, 50)
end

function LoneRaid17()
    fallout.gsay_message(700, 141 + (fallout.get_critter_stat(fallout.dude_obj(), 34) == 1), 49)
end

function LoneRaid18()
    fallout.gsay_message(700, 143, 50)
end

function LoneRaid19()
    fallout.gsay_message(700, 144, 51)
    hostile = 1
end

function LoneRaid20()
    fallout.gsay_message(700, 145, 50)
end

function LoneRaid21()
    fallout.gsay_message(700, 146, 49)
end

function LoneRaid22()
    fallout.gsay_message(700, 147, 51)
    hostile = 1
end

function LoneRaidCombat()
    hostile = 1
end

function LoneRaidEnd()
end

function LoneRaidLoot()
    fallout.gdialog_mod_barter(0)
    fallout.giq_option(0, 634, 103, LoneRaidEnd, 51)
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
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 0)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
