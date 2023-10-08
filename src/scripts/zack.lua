local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local Start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local damage_p_proc
local destroy_p_proc
local critter_p_proc
local pickup_p_proc
local Zack00
local Zack01
local Zack02
local Zack03
local Zack04
local Zack05
local ZackYes
local ZackNo
local ZackBarter
local ZackEnd

local Initialize = 1
local BarterMod = -10
local DisplayMessage = 0

local exit_line = 0

function Start()
    if Initialize then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 48)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 28)
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(377, 100))
    else
        fallout.display_msg(fallout.message_str(377, 101))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(377, 100))
    else
        fallout.display_msg(fallout.message_str(377, 101))
    end
end

function talk_p_proc()
    if fallout.global_var(617) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        BarterMod = -10
        fallout.move_obj_inven_to_obj(fallout.external_var("Locker_Ptr"), fallout.self_obj())
        fallout.item_caps_adjust(fallout.self_obj(), 3000 + fallout.random(1, 1000))
        reaction.get_reaction()
        fallout.start_gdialog(377, fallout.self_obj(), -1, -1, -1)
        fallout.gsay_start()
        if fallout.local_var(5) == 2 then
            BarterMod = 15
        else
            if fallout.local_var(5) == 1 then
                BarterMod = 5
            else
                BarterMod = -10
            end
        end
        fallout.gdialog_set_barter_mod(BarterMod)
        if fallout.local_var(4) == 0 then
            Zack00()
        else
            Zack01()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
        fallout.item_caps_adjust(fallout.self_obj(), -fallout.item_caps_total(fallout.self_obj()))
        fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Locker_Ptr"))
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(617, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(617, 1)
        reputation.inc_good_critter()
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(617) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function pickup_p_proc()
    fallout.set_global_var(617, 1)
end

function Zack00()
    fallout.gsay_reply(377, 102)
    fallout.gsay_option(377, 104, ZackBarter, 50)
    fallout.gsay_option(377, 103, Zack02, 50)
    if fallout.local_var(5) == 0 then
        DisplayMessage = 117
        fallout.gsay_option(377, 105, Zack04, 50)
    else
        if fallout.local_var(5) == 1 then
            DisplayMessage = 123
            fallout.gsay_option(377, 122, Zack05, 50)
        end
    end
    fallout.gsay_option(377, 107, ZackEnd, 50)
end

function Zack01()
    fallout.gsay_reply(377, 106)
    fallout.gsay_option(377, 104, ZackBarter, 50)
    fallout.gsay_option(377, 103, Zack02, 50)
    if fallout.local_var(5) == 0 then
        DisplayMessage = 117
        fallout.gsay_option(377, 105, Zack04, 50)
    else
        if fallout.local_var(5) == 1 then
            DisplayMessage = 123
            fallout.gsay_option(377, 122, Zack05, 50)
        end
    end
    fallout.gsay_option(377, 107, ZackEnd, 50)
end

function Zack02()
    fallout.gsay_reply(377, 114)
    fallout.gsay_option(377, 115, Zack03, 50)
end

function Zack03()
    fallout.gsay_reply(377, 111)
    fallout.gsay_option(377, 113, ZackBarter, 50)
end

function Zack04()
    if fallout.global_var(265) == 9250 then
        BarterMod = 15
        fallout.set_local_var(5, 2)
        ZackYes()
    else
        if fallout.global_var(614) == 9201 then
            BarterMod = 5
            fallout.set_local_var(5, 1)
            ZackYes()
        else
            BarterMod = -10
            ZackNo()
        end
    end
end

function Zack05()
    if fallout.global_var(265) == 9250 then
        BarterMod = 0
        fallout.set_local_var(5, 2)
        ZackYes()
    else
        ZackNo()
    end
end

function ZackYes()
    fallout.gsay_reply(377, 116)
    fallout.gsay_option(377, 120, ZackBarter, 50)
    fallout.gsay_option(377, 121, ZackEnd, 50)
end

function ZackNo()
    fallout.gsay_reply(377, DisplayMessage)
    fallout.gsay_option(377, 119, ZackBarter, 50)
    fallout.gsay_option(377, 107, ZackEnd, 50)
end

function ZackBarter()
    fallout.gdialog_mod_barter(BarterMod)
    fallout.gsay_message(377, 108, 50)
end

function ZackEnd()
end

local exports = {}
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
