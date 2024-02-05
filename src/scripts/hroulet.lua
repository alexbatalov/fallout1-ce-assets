local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Dealer00
local Dealer01
local Dealer02
local Dealer03
local Dealer04
local Dealer05
local Dealer06
local CheckMoney00
local CheckMoney01
local CheckMoney02
local CheckMoney03
local DealerEnd
local GetOdds

local hostile = false
local Bet = 0
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 38)
        misc.set_ai(self_obj, 50)
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

function combat()
    hostile = true
end

function critter_p_proc()
    if hostile then
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
    fallout.start_gdialog(697, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Dealer00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(697, 167))
end

function Dealer00()
    fallout.gsay_reply(697, 173)
    fallout.giq_option(4, 697, 174, CheckMoney00, 50)
    fallout.giq_option(4, 697, 175, CheckMoney01, 50)
    fallout.giq_option(4, 697, 176, CheckMoney02, 50)
    fallout.giq_option(4, 697, 177, CheckMoney03, 50)
    fallout.giq_option(4, 697, 178, DealerEnd, 50)
    fallout.giq_option(-3, 697, 179, Dealer01, 50)
end

function Dealer01()
    fallout.gsay_message(697, fallout.message_str(697, 180) .. fallout.message_str(697, 181), 50)
end

function Dealer02()
    fallout.gsay_message(697, 182, 50)
end

function Dealer03()
    fallout.gsay_message(697, 183, 50)
    fallout.item_caps_adjust(fallout.dude_obj(), Bet)
end

function Dealer04()
    fallout.gsay_message(697, 184, 50)
    fallout.item_caps_adjust(fallout.dude_obj(), Bet * 2)
end

function Dealer05()
    fallout.gsay_message(697, 185, 50)
    fallout.item_caps_adjust(fallout.dude_obj(), Bet * 3)
end

function Dealer06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(697, 186, 50)
    else
        fallout.gsay_message(697, 187, 50)
    end
end

function CheckMoney00()
    Bet = 5
    if fallout.item_caps_total(fallout.dude_obj()) < Bet then
        Dealer06()
    else
        GetOdds()
    end
end

function CheckMoney01()
    Bet = 15
    if fallout.item_caps_total(fallout.dude_obj()) < Bet then
        Dealer06()
    else
        GetOdds()
    end
end

function CheckMoney02()
    Bet = 25
    if fallout.item_caps_total(fallout.dude_obj()) < Bet then
        Dealer06()
    else
        GetOdds()
    end
end

function CheckMoney03()
    Bet = 50
    if fallout.item_caps_total(fallout.dude_obj()) < Bet then
        Dealer06()
    else
        GetOdds()
    end
end

function DealerEnd()
end

function GetOdds()
    local dice = fallout.random(1, 36) - 10
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 16, -15)
    if fallout.is_critical(roll) then
        if fallout.is_success(roll) then
            dice = dice + 10
        else
            dice = dice - 5
        end
    else
        if fallout.is_success(roll) then
            dice = dice + 5
        end
    end
    fallout.display_msg("dice == " .. dice)
    if dice < 10 then
        Dealer02()
    elseif dice < 20 then
        Dealer03()
    elseif dice < 30 then
        Dealer04()
    else
        Dealer05()
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
