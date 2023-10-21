local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local Merchant00
local Merchant01
local Merchant02
local Merchant03
local Merchant04
local Merchant05
local Get_Stuff
local Put_Stuff

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 41)
        fallout.critter_add_trait(self_obj, 1, 5, 50)
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
    if ((time.game_time_in_days() - fallout.local_var(4)) >= 1) or (fallout.local_var(4) == 0) then
        fallout.set_local_var(4, time.game_time_in_days())
        fallout.set_local_var(5, 1000 + fallout.random(0, 500))
        fallout.item_caps_adjust(self_obj, fallout.local_var(5))
    else
        fallout.item_caps_adjust(self_obj, fallout.local_var(5))
    end
    fallout.start_gdialog(782, self_obj, 4, -1, -1)
    fallout.gsay_start()
    Merchant00()
    fallout.gsay_end()
    fallout.end_dialogue()
    fallout.item_caps_adjust(self_obj, -1 * fallout.item_caps_total(self_obj))
    Put_Stuff()
end

function destroy_p_proc()
    fallout.move_obj_inven_to_obj(fallout.external_var("Mitch_Box_Ptr"), fallout.self_obj())
    reputation.inc_good_critter()
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(782, 100))
end

function Merchant00()
    fallout.gsay_reply(782, 101)
    fallout.giq_option(4, 782, 102, Merchant01, 50)
    fallout.giq_option(4, 782, 103, Merchant02, 50)
    fallout.giq_option(4, 782, 104, Merchant03, 50)
    fallout.giq_option(-3, 782, 105, Merchant04, 50)
end

function Merchant01()
    fallout.gsay_message(782, 106, 50)
    fallout.gdialog_mod_barter(0)
    Merchant05()
end

function Merchant02()
    fallout.gsay_message(782, 107, 50)
    fallout.gdialog_mod_barter(0)
    Merchant05()
end

function Merchant03()
end

function Merchant04()
    fallout.gsay_message(782, 108, 50)
end

function Merchant05()
    fallout.gsay_message(782, 109, 50)
end

function Get_Stuff()
    fallout.move_obj_inven_to_obj(fallout.external_var("Mitch_Box_Ptr"), fallout.self_obj())
end

function Put_Stuff()
    fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Mitch_Box_Ptr"))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
