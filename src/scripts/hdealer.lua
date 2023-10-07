local fallout = require("fallout")

local start
local combat
local critter_p_proc
local map_enter_p_proc
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
local Dealer07
local CheckMoney00
local CheckMoney01
local CheckMoney02
local CheckMoney03
local DealerEnd
local GetOdds

local hostile = 0
local Bet = 0
local Only_Once = 1

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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 38)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 15 then
            map_enter_p_proc()
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
    if fallout.cur_map_index() == 11 then
        if (fallout.global_var(104) == 2) or (fallout.global_var(38) == 1) then
            fallout.destroy_object(fallout.self_obj())
        end
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function map_enter_p_proc()
    if fallout.cur_map_index() == 11 then
        if (fallout.global_var(104) == 2) or (fallout.global_var(38) == 1) then
            fallout.destroy_object(fallout.self_obj())
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
    fallout.start_gdialog(697, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Dealer00()
    fallout.gsay_end()
    fallout.end_dialogue()
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

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(697, 168))
end

function Dealer00()
    local v0 = 0
    v0 = fallout.message_str(697, 173) + fallout.message_str(697, 202) + fallout.item_caps_total(fallout.dude_obj()) + fallout.message_str(697, 203)
    fallout.gsay_reply(697, v0)
    fallout.giq_option(4, 697, 174, CheckMoney00, 50)
    fallout.giq_option(4, 697, 175, CheckMoney01, 50)
    fallout.giq_option(4, 697, 176, CheckMoney02, 50)
    fallout.giq_option(4, 697, 177, CheckMoney03, 50)
    fallout.giq_option(4, 697, 178, DealerEnd, 50)
    fallout.giq_option(-3, 697, 179, Dealer01, 50)
end

function Dealer01()
    fallout.gsay_reply(697, fallout.message_str(697, 180) + fallout.message_str(697, 181))
end

function Dealer02()
    fallout.gsay_reply(697, fallout.message_str(697, 182) + fallout.message_str(697, 204))
    fallout.item_caps_adjust(fallout.dude_obj(), Bet * -1)
    Dealer07()
end

function Dealer03()
    fallout.gsay_reply(697, fallout.message_str(697, 183) + fallout.message_str(697, 204))
    Dealer07()
end

function Dealer04()
    fallout.gsay_reply(697, fallout.message_str(697, 184) + fallout.message_str(697, 204))
    fallout.item_caps_adjust(fallout.dude_obj(), Bet)
    Dealer07()
end

function Dealer05()
    fallout.gsay_reply(697, fallout.message_str(697, 185) + fallout.message_str(697, 204))
    fallout.item_caps_adjust(fallout.dude_obj(), Bet * 2)
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
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 36) - 10
    v1 = fallout.roll_vs_skill(fallout.dude_obj(), 16, -15)
    if fallout.is_critical(v1) then
        if fallout.is_success(v1) then
            v0 = v0 + 10
        else
            v0 = v0 - 5
        end
    else
        if fallout.is_success(v1) then
            v0 = v0 + 5
        end
    end
    if fallout.do_check(fallout.dude_obj(), 6, 0) then
        v0 = v0 + 5
    end
    if v0 < 10 then
        Dealer02()
    else
        if v0 < 20 then
            Dealer03()
        else
            if v0 < 30 then
                Dealer04()
            else
                Dealer05()
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
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
