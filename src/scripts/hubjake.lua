local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local Jake01
local Jake02
local Jake03
local Jake04
local Jake05
local Jake06
local Jake07
local Jake08
local Jake09
local Jake10
local Jake11
local Jake12
local Jake13
local Jake14
local Jake15
local Jake16
local JakeEnd
local Barter
local Get_Stuff
local Put_Stuff

local hostile = false
local initialized = false

function start()
    fallout.gdialog_set_barter_mod(-15)
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 48)
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
    fallout.set_local_var(5, 1)
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
    Get_Stuff()
    reaction.get_reaction()
    if time.game_time_in_days() - fallout.local_var(6) >= 1 or fallout.local_var(6) == 0 then
        fallout.set_local_var(6, time.game_time_in_days())
        fallout.set_local_var(7, 2000 + fallout.random(0, 1000))
        fallout.item_caps_adjust(self_obj, fallout.local_var(7))
    else
        fallout.item_caps_adjust(self_obj, fallout.local_var(7))
    end
    if fallout.local_var(5) == 1 then
        combat()
    elseif fallout.global_var(248) == 1 then
        fallout.start_gdialog(589, self_obj, 4, -1, -1)
        fallout.gsay_start()
        Jake10()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(589, self_obj, 4, -1, -1)
        fallout.gsay_start()
        Jake01()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(1) == 1 then
        fallout.start_gdialog(589, self_obj, 4, -1, -1)
        fallout.gsay_start()
        Jake10()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        fallout.start_gdialog(589, self_obj, 4, -1, -1)
        fallout.gsay_start()
        Jake09()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
    fallout.item_caps_adjust(self_obj, -1 * fallout.item_caps_total(self_obj))
    Put_Stuff()
end

function destroy_p_proc()
    fallout.move_obj_inven_to_obj(fallout.external_var("Jake_Desk_Ptr"), fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(589, 100))
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function Jake01()
    fallout.gsay_reply(589, 101)
    fallout.giq_option(4, 589, 102, Barter, 50)
    fallout.giq_option(4, 589, 103, Jake02, 50)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 589, 104, Jake03, 50)
    end
    fallout.giq_option(4, 589, 105, Jake04, 50)
    fallout.giq_option(4, 589, 106, Jake13, 50)
    fallout.giq_option(-3, 589, 107, Barter, 50)
    fallout.giq_option(-3, 589, 108, Jake13, 50)
end

function Jake02()
    fallout.gsay_reply(589, 109)
    fallout.giq_option(4, 589, 110, Barter, 50)
    fallout.giq_option(4, 589, 111, Jake05, 50)
    fallout.giq_option(4, 589, 112, Jake06, 50)
    fallout.giq_option(4, 589, 113, Jake13, 50)
end

function Jake03()
    fallout.gsay_reply(589, 114)
    fallout.giq_option(4, 589, 115, Barter, 50)
    fallout.giq_option(4, 589, 116, Jake02, 50)
    fallout.giq_option(4, 589, 117, Jake04, 50)
end

function Jake04()
    fallout.gsay_message(589, 118, 50)
    fallout.gsay_reply(589, 162)
    fallout.giq_option(4, 589, 119, Barter, 50)
    fallout.giq_option(4, 589, 120, Jake02, 50)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 589, 121, Jake03, 50)
    end
    fallout.giq_option(4, 589, 122, Jake13, 50)
end

function Jake05()
    fallout.gsay_reply(589, 123)
    fallout.giq_option(4, 589, 124, Barter, 50)
    fallout.giq_option(4, 589, 125, Jake06, 50)
    fallout.giq_option(4, 589, 126, Jake13, 50)
end

function Jake06()
    fallout.gsay_reply(589, 127)
    fallout.giq_option(4, 589, 128, Barter, 50)
    fallout.giq_option(4, 589, 129, Jake07, 50)
    fallout.giq_option(4, 589, 130, Jake08, 50)
    fallout.giq_option(4, 589, 131, Jake14, 51)
end

function Jake07()
    fallout.gsay_reply(589, 132)
    fallout.giq_option(4, 589, 133, Barter, 50)
    fallout.giq_option(4, 589, 134, Jake08, 50)
    fallout.giq_option(4, 589, 135, Jake12, 50)
    fallout.giq_option(4, 589, 136, Jake04, 50)
    fallout.giq_option(4, 589, 137, Jake13, 50)
end

function Jake08()
    fallout.gsay_reply(589, 138)
    fallout.giq_option(4, 589, 139, Barter, 50)
    fallout.giq_option(4, 589, 140, Jake07, 50)
    fallout.giq_option(4, 589, 141, Jake14, 51)
    fallout.giq_option(4, 589, 142, Jake13, 50)
end

function Jake09()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(589, 163)
    else
        fallout.gsay_reply(589, 164)
    end
    fallout.giq_option(-3, 589, 144, Barter, 50)
    fallout.giq_option(-3, 589, 145, Jake13, 50)
    fallout.giq_option(4, 589, 146, Barter, 50)
    fallout.giq_option(4, 589, 165, Jake16, 50)
    fallout.giq_option(4, 589, 147, Jake13, 50)
end

function Jake10()
    fallout.gsay_reply(589, 148)
    fallout.giq_option(-3, 589, 149, Barter, 50)
    fallout.giq_option(-3, 589, 150, Jake13, 50)
    fallout.giq_option(4, 589, 151, Barter, 50)
    fallout.giq_option(4, 589, 165, Jake16, 50)
    fallout.giq_option(4, 589, 152, Jake15, 50)
    fallout.giq_option(4, 589, 153, Jake13, 50)
end

function Jake11()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(589, 154), 2)
    combat()
end

function Jake12()
    fallout.set_global_var(236, 1)
    fallout.gsay_reply(589, 155)
    fallout.giq_option(4, 589, 156, Jake08, 50)
    fallout.giq_option(4, 589, 157, Jake13, 50)
end

function Jake13()
end

function Jake14()
    reaction.BottomReact()
end

function Jake15()
    reaction.BottomReact()
    combat()
end

function Jake16()
    if fallout.global_var(74) == 0 then
        fallout.set_global_var(74, 1)
    end
    if fallout.global_var(75) == 0 then
        fallout.set_global_var(75, 1)
    end
    fallout.gsay_message(589, 166, 50)
end

function JakeEnd()
end

function Barter()
    fallout.gsay_message(589, 158, 50)
    fallout.gdialog_mod_barter(-15)
    fallout.gsay_reply(589, 159)
    fallout.giq_option(4, 589, 160, JakeEnd, 50)
    fallout.giq_option(-3, 589, 161, JakeEnd, 50)
end

function Get_Stuff()
    fallout.move_obj_inven_to_obj(fallout.external_var("Jake_Desk_Ptr"), fallout.self_obj())
end

function Put_Stuff()
    fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Jake_Desk_Ptr"))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.damage_p_proc = damage_p_proc
return exports
