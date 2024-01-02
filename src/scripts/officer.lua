local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local Officer00
local Officer01
local Officer02
local Officer03
local Officer04
local Officer05
local Officer06
local Officer07
local Officer08
local Officer09
local Officer10
local Officer11
local Officer12
local Officer13
local Officer14
local Officer15
local Officer15a
local Officer16
local Officer17
local Officer18
local Officer19
local Officer20
local Officer21
local Officer21a
local Officer22
local Officer23
local Officer24
local Officer25
local Officer26
local Officer27
local Officer28
local Officer29
local Officer30
local Officer31
local OfficerCombat
local OfficerEnd

local hostile = false

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        local self_obj = fallout.self_obj()
        local dude_obj = fallout.dude_obj()
        if fallout.global_var(261) ~= 0 then
            if fallout.obj_can_see_obj(self_obj, dude_obj) then
                fallout.dialogue_system_enter()
            end
        else
            local armory_access = fallout.external_var("armory_access")
            local sec_door_obj = fallout.external_var("SecDoor_ptr")
            if armory_access == 1 and not fallout.obj_is_open(sec_door_obj) then
                fallout.use_obj(sec_door_obj)
            elseif armory_access == 2 then
                fallout.anim(self_obj, 1000, 5)
                fallout.float_msg(self_obj, fallout.message_str(178, 159), 0)
                fallout.set_external_var("armory_access", 0)
            elseif armory_access == 0 and fallout.elevation(dude_obj) == fallout.elevation(self_obj) then
                if fallout.tile_distance(fallout.tile_num(dude_obj), 21292) < 2 then
                    hostile = true
                end
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(261, 1)
    end
end

function destroy_p_proc()
    fallout.set_external_var("Officer_ptr", nil)
    reputation.inc_good_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(261, 1)
    end
end

function map_enter_p_proc()
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 1)
    fallout.set_external_var("Officer_ptr", fallout.self_obj())
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(178, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.global_var(261) ~= 0 then
        Officer00()
    else
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
            Officer27()
        else
            if fallout.global_var(101) ~= 0 and fallout.global_var(101) ~= 1 then
                Officer01()
            else
                if fallout.local_var(1) > 1 then
                    if fallout.external_var("armory_access") ~= 0 then
                        Officer25()
                    else
                        Officer02()
                    end
                else
                    if fallout.external_var("armory_access") ~= 0 then
                        Officer26()
                    else
                        Officer18()
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Officer00()
    fallout.gsay_message(178, 100, 51)
    hostile = true
end

function Officer01()
    fallout.gsay_message(178, 101, 0)
end

function Officer02()
    fallout.gsay_reply(178, 102)
    fallout.giq_option(4, 178, 103, Officer04, 0)
    fallout.giq_option(5, 178, 104, Officer08, 0)
    fallout.giq_option(6, 178, 105, Officer11, 0)
    fallout.giq_option(-3, 178, 106, Officer03, 0)
end

function Officer03()
    fallout.gsay_reply(178, 107)
    fallout.giq_option(4, 178, 159, OfficerEnd, 0)
end

function Officer04()
    fallout.gsay_reply(178, 108)
    fallout.giq_option(4, 178, 109, OfficerEnd, 0)
    fallout.giq_option(5, 178, 110, Officer05, 0)
end

function Officer05()
    fallout.gsay_reply(178, 111)
    fallout.giq_option(5, 178, 112, Officer06, 0)
    fallout.giq_option(6, 178, 113, Officer07, 0)
end

function Officer06()
    fallout.gsay_reply(178, 114)
    fallout.giq_option(5, 178, 115, OfficerEnd, 0)
end

function Officer07()
    reaction.UpReact()
    fallout.gsay_message(178, 116, 10)
end

function Officer08()
    fallout.gsay_reply(178, 117)
    fallout.giq_option(4, 178, 118, Officer09, 0)
    fallout.giq_option(4, 178, 119, Officer10, 0)
end

function Officer09()
    reaction.DownReact()
    fallout.gsay_message(178, 120, -10)
end

function Officer10()
    fallout.gsay_message(178, 121, 0)
end

function Officer11()
    fallout.gsay_reply(178, 122)
    fallout.giq_option(5, 178, 123, Officer13, 0)
    fallout.giq_option(5, 178, 124, Officer12, 0)
end

function Officer12()
    fallout.gsay_message(178, 125, 0)
end

function Officer13()
    fallout.gsay_reply(178, 126)
    fallout.giq_option(5, 178, 127, Officer15, 0)
    fallout.giq_option(5, 178, 128, Officer14, 0)
end

function Officer14()
    fallout.gsay_message(178, 129, 0)
end

function Officer15()
    fallout.gsay_reply(178, 130)
    fallout.giq_option(5, 178, 131, Officer15a, 0)
end

function Officer15a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Officer17()
    else
        Officer16()
    end
end

function Officer16()
    fallout.gsay_message(178, 132, 0)
end

function Officer17()
    fallout.set_external_var("armory_access", 1)
    fallout.gsay_message(178, 133, 0)
end

function Officer18()
    fallout.gsay_reply(178,
        fallout.message_str(178, 134) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(178, 135))
    fallout.giq_option(4, 178, 136, Officer20, 0)
    fallout.giq_option(5, 178, 137, Officer21, 0)
    fallout.giq_option(-3, 178, 138, Officer19, 0)
end

function Officer19()
    fallout.gsay_message(178, 139, 0)
end

function Officer20()
    fallout.gsay_message(178, 140, 0)
end

function Officer21()
    fallout.gsay_reply(178, 141)
    fallout.giq_option(5, 178, 142, Officer22, 0)
    fallout.giq_option(5, 178, 143, Officer21a, 0)
end

function Officer21a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Officer23()
    else
        Officer24()
    end
end

function Officer22()
    fallout.gsay_reply(178, 144)
    fallout.giq_option(5, 178, 145, OfficerEnd, 0)
    fallout.giq_option(5, 178, 146, OfficerCombat, -10)
end

function Officer23()
    fallout.gsay_message(178, 147, 0)
end

function Officer24()
    fallout.gsay_message(178, 148, 0)
end

function Officer25()
    fallout.gsay_message(178, 149, 0)
end

function Officer26()
    fallout.gsay_message(178, 150, 0)
end

function Officer27()
    fallout.gsay_message(178, 151, 0)
end

function Officer28()
    fallout.gsay_reply(178, 152)
    fallout.giq_option(4, 178, 153, Officer30, 0)
    fallout.giq_option(5, 178, 154, Officer31, 0)
    fallout.giq_option(-3, 178, 155, Officer29, 0)
end

function Officer29()
    fallout.gsay_message(178, 156, 0)
end

function Officer30()
    fallout.gsay_message(178, 157, 0)
end

function Officer31()
    fallout.gsay_message(178, 158, 0)
end

function OfficerCombat()
    hostile = true
end

function OfficerEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
