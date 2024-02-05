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
local timed_event_p_proc
local BarterGuy00
local BarterGuy00a
local BarterGuy01
local BarterGuy02
local BarterGuy02a
local BarterGuy03
local BarterGuy04
local BarterGuy05
local BarterGuy06
local BarterGuy07
local BarterGuy08
local BarterGuy09
local BarterGuy10
local BarterGuy11
local BarterGuy12
local BarterGuy13
local BarterGuy14
local BarterGuyEnd

local hostile = false
local initialized = false
local Caught_Stealing = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 20)
        fallout.critter_add_trait(self_obj, 1, 5, 69)
        fallout.set_external_var("Shopkepper_Ptr", self_obj)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
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
    local self_obj = fallout.self_obj()
    reaction.get_reaction()
    local item_obj = fallout.obj_carrying_pid_obj(self_obj, 113)
    fallout.rm_obj_from_inven(self_obj, item_obj)
    local shop_obj = fallout.external_var("Shop_Ptr")
    fallout.move_obj_inven_to_obj(shop_obj, self_obj)
    fallout.start_gdialog(843, self_obj, 4, -1, -1)
    fallout.gsay_start()
    if Caught_Stealing then
        BarterGuy00()
    else
        if misc.is_armed(fallout.dude_obj()) or (fallout.global_var(195) == 1) then
            BarterGuy02()
        elseif misc.is_wearing_coc_robe(fallout.dude_obj()) then
            BarterGuy07()
        else
            BarterGuy10()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    fallout.move_obj_inven_to_obj(self_obj, shop_obj)
    fallout.add_obj_to_inven(self_obj, item_obj)
    fallout.wield_obj_critter(self_obj, item_obj)
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(843, 100))
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        fallout.dialogue_system_enter()
    elseif fallout.fixed_param() == 2 then
        Caught_Stealing = true
        fallout.dialogue_system_enter()
    end
end

function BarterGuy00()
    fallout.gsay_reply(843, 101)
    fallout.giq_option(-3, 843, 102, BarterGuy01, 50)
    fallout.giq_option(4, 843, 103, BarterGuy01, 50)
    fallout.giq_option(5, 843, 104, BarterGuy00a, 50)
end

function BarterGuy00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        combat()
    else
        BarterGuy01()
    end
end

function BarterGuy01()
    fallout.gsay_message(843, 105, 51)
    combat()
end

function BarterGuy02()
    fallout.gsay_reply(843, 106)
    fallout.giq_option(-3, 843, 107, BarterGuyEnd, 50)
    fallout.giq_option(4, 843, 108, BarterGuy03, 50)
    fallout.giq_option(6, 843, 109, BarterGuy02a, 50)
end

function BarterGuy02a()
    if fallout.global_var(195) == 1 then
        BarterGuy04()
    else
        BarterGuy05()
    end
end

function BarterGuy03()
    fallout.gsay_message(843, 110, 50)
end

function BarterGuy04()
    fallout.gsay_reply(843, 111)
    fallout.giq_option(6, 843, 112, BarterGuy01, 50)
    fallout.giq_option(6, 843, 113, BarterGuyEnd, 50)
end

function BarterGuy05()
    fallout.gsay_reply(843, 114)
    fallout.giq_option(6, 843, 115, BarterGuy00a, 50)
    fallout.giq_option(6, 843, 116, BarterGuy06, 50)
end

function BarterGuy06()
    fallout.gsay_message(843, 117, 50)
end

function BarterGuy07()
    fallout.gsay_reply(843, 118)
    fallout.giq_option(-3, 843, 119, BarterGuy08, 50)
    fallout.giq_option(4, 843, 120, BarterGuy12, 50)
    fallout.giq_option(4, 843, 121, BarterGuy09, 50)
end

function BarterGuy08()
    fallout.gsay_reply(843, 122)
    fallout.giq_option(-3, 843, 123, BarterGuyEnd, 50)
end

function BarterGuy09()
    fallout.gsay_message(843, 124, 50)
end

function BarterGuy10()
    fallout.gsay_reply(843, 125)
    fallout.giq_option(-3, 843, 126, BarterGuy08, 50)
    fallout.giq_option(4, 843, 127, BarterGuy13, 50)
    fallout.giq_option(5, 843, 128, BarterGuy11, 50)
end

function BarterGuy11()
    fallout.gsay_reply(843, 129)
    fallout.giq_option(4, 843, 130, BarterGuyEnd, 50)
    fallout.giq_option(4, 843, 131, BarterGuy01, 50)
    fallout.giq_option(4, 843, 132, BarterGuy13, 50)
end

function BarterGuy12()
    fallout.gsay_reply(843, 133)
    fallout.giq_option(4, 843, 134, BarterGuyEnd, 50)
end

function BarterGuy13()
    fallout.gsay_reply(843, 135)
    fallout.giq_option(4, 843, 136, BarterGuy14, 50)
end

function BarterGuy14()
    fallout.gdialog_mod_barter(-10)
    fallout.gsay_message(843, 137, 50)
end

function BarterGuyEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
