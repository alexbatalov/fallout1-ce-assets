local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local use_p_proc
local Dealer00
local Dealer01
local Dealer02
local Dealer03
local Dealer04
local Dealer05
local Dealer06
local Dealer07
local CheckMoney00
local CheckMoney01
local CheckMoney02
local CheckMoney03
local CheckMoney04
local DealerEnd
local GetOdds

local initialized = false
local hostile = false
local bet = 0

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
    elseif script_action == 6 then
        use_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function map_enter_p_proc()
    if fallout.cur_map_index() == 11 then
        if fallout.global_var(38) == 1 or fallout.global_var(104) == 2 then
            fallout.destroy_object(fallout.self_obj())
        end
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
    fallout.display_msg(fallout.message_str(697, 169))
end

function use_p_proc()
    fallout.script_overrides()
    fallout.dialogue_system_enter()
end

function Dealer00()
    local reply = fallout.message_str(697, 202) ..
        fallout.item_caps_total(fallout.dude_obj()) .. fallout.message_str(697, 203)
    fallout.gsay_reply(697, reply)
    fallout.giq_option(4, 697, 190, CheckMoney00, 50)
    fallout.giq_option(4, 697, 191, CheckMoney01, 50)
    fallout.giq_option(4, 697, 192, CheckMoney02, 50)
    fallout.giq_option(4, 697, 193, CheckMoney03, 50)
    fallout.giq_option(4, 697, 194, CheckMoney04, 50)
    fallout.giq_option(4, 697, 195, DealerEnd, 50)
    fallout.giq_option(-3, 697, 107, Dealer01, 50)
end

function Dealer01()
    fallout.gsay_reply(697, fallout.message_str(697, 180) .. fallout.message_str(697, 181))
end

function Dealer02()
    fallout.gsay_reply(697, fallout.message_str(697, 182) .. fallout.message_str(697, 204))
    fallout.item_caps_adjust(fallout.dude_obj(), bet * -1)
    Dealer07()
end

function Dealer03()
    fallout.gsay_reply(697, fallout.message_str(697, 183) .. fallout.message_str(697, 204))
    Dealer07()
end

function Dealer04()
    fallout.gsay_reply(697, fallout.message_str(697, 184) .. fallout.message_str(697, 204))
    fallout.item_caps_adjust(fallout.dude_obj(), bet)
    Dealer07()
end

function Dealer05()
    fallout.gsay_reply(697, fallout.message_str(697, 185) .. fallout.message_str(697, 204))
    fallout.item_caps_adjust(fallout.dude_obj(), bet * 2)
    Dealer07()
end

function Dealer06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(697, 186, 50)
    else
        fallout.gsay_message(697, 187, 50)
    end
    Dealer00()
end

function Dealer07()
    fallout.giq_option(4, 697, 114, Dealer00, 50)
    fallout.giq_option(4, 697, 178, DealerEnd, 50)
end

function CheckMoney00()
    bet = 1
    if fallout.item_caps_total(fallout.dude_obj()) < bet then
        Dealer06()
    else
        GetOdds()
    end
end

function CheckMoney01()
    bet = 2
    if fallout.item_caps_total(fallout.dude_obj()) < bet then
        Dealer06()
    else
        GetOdds()
    end
end

function CheckMoney02()
    bet = 3
    if fallout.item_caps_total(fallout.dude_obj()) < bet then
        Dealer06()
    else
        GetOdds()
    end
end

function CheckMoney03()
    bet = 4
    if fallout.item_caps_total(fallout.dude_obj()) < bet then
        Dealer06()
    else
        GetOdds()
    end
end

function CheckMoney04()
    bet = 5
    if fallout.item_caps_total(fallout.dude_obj()) < bet then
        Dealer06()
    else
        GetOdds()
    end
end

function DealerEnd()
end

function GetOdds()
    local odds = fallout.random(1, 20) - 5
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 16, -15)
    if fallout.is_critical(roll) then
        if fallout.is_success(roll) then
            odds = odds + 10
        else
            odds = odds - 5
        end
    else
        if fallout.is_success(roll) then
            odds = odds + 5
        end
    end
    if fallout.do_check(fallout.dude_obj(), 6, 0) then
        odds = odds + 5
    end
    if odds < 10 then
        Dealer02()
    elseif odds < 20 then
        Dealer03()
    elseif odds < 30 then
        Dealer04()
    else
        Dealer05()
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_p_proc = use_p_proc
return exports
