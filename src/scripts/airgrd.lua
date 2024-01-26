local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local dialog
local airgrd00
local airgrd01
local airgrd02
local airgrd03
local airgrd03a
local airgrd04
local airgrd04a
local airgrd04b
local airgrd05
local airgrd06
local airgrd07
local airgrd08
local airgrd09
local airgrd10
local airgrd11
local airgrd12
local airgrd13
local airgrd14
local airgrd15
local bluff_end
local dialog_end
local airgrdtim
local combat

local hostile = false
local initialized = false
local Weapons = false
local disguised = false
local again = false
local first = false
local jumpcode = 0
local indialog = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 46)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 14 then
        damage_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if misc.party_member_count() > 1 then
            disguised = false
        else
            disguised = true
        end
    end
    if fallout.map_var(1) == 1 and fallout.global_var(231) == 1 then
        airgrd00()
    else
        if disguised then
            if Weapons then
                jumpcode = 1
                dialog()
            elseif not first then
                first = true
                jumpcode = 2
                dialog()
            elseif first then
                airgrd08()
            end
        else
            if Weapons then
                airgrd15()
            else
                jumpcode = 3
                dialog()
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6) then
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
            if not Weapons then
                Weapons = true
                again = true
                fallout.dialogue_system_enter()
            end
        end
        disguised = false
        if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
            if misc.party_member_count() > 1 then
                disguised = false
            else
                disguised = true
            end
        end
        if not disguised then
            again = true
            fallout.dialogue_system_enter()
        end
        if not again then
            again = true
            fallout.dialogue_system_enter()
        end
    end
end

function damage_p_proc()
    if fallout.global_var(245) == 0 then
        fallout.set_global_var(245, 1)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
end

function timed_event_p_proc()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        combat()
    end
end

function dialog()
    fallout.set_local_var(3, 1)
    reaction.get_reaction()
    fallout.start_gdialog(673, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    indialog = true
    if jumpcode < 2 then
        airgrd01()
    elseif jumpcode == 2 then
        airgrd03()
    elseif jumpcode > 2 then
        airgrd09()
    end
    indialog = false
    fallout.gsay_end()
    fallout.end_dialogue()
end

function airgrd00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(673, fallout.random(102, 104)), 2)
end

function airgrd01()
    fallout.gsay_reply(673, 105)
    fallout.giq_option(-3, 673, 106, airgrd02, 51)
    fallout.giq_option(4, 673, 107, airgrdtim, 50)
    fallout.giq_option(4, 673, 108, airgrd02, 51)
    fallout.giq_option(4, 673, 109, airgrdtim, 50)
end

function airgrd02()
    fallout.gsay_message(673, 110, 51)
    combat()
end

function airgrd03()
    fallout.gsay_reply(673, 111)
    fallout.giq_option(-3, 673, 112, airgrd02, 51)
    fallout.giq_option(4, 673, 113, airgrd04, 50)
    fallout.giq_option(4, 673, 114, airgrd03a, 50)
    fallout.giq_option(4, 673, 115, airgrd02, 51)
end

function airgrd03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        airgrd06()
    else
        airgrd08()
    end
end

function airgrd04()
    fallout.gsay_reply(673, 116)
    fallout.giq_option(4, 673, 117, airgrd04a, 50)
    fallout.giq_option(6, 673, 118, airgrd04b, 50)
end

function airgrd04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        airgrd06()
    else
        airgrd05()
    end
end

function airgrd04b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -15)) then
        airgrd06()
    else
        airgrd05()
    end
end

function airgrd05()
    fallout.gsay_message(673, 119, 51)
    combat()
end

function airgrd06()
    fallout.gsay_reply(673, 120)
    fallout.giq_option(4, 673, 121, bluff_end, 50)
    fallout.giq_option(4, 673, 122, airgrd07, 51)
    fallout.giq_option(4, 673, 123, bluff_end, 50)
end

function airgrd07()
    fallout.gsay_message(673, 124, 51)
    combat()
end

function airgrd08()
    if indialog then
        fallout.gsay_message(673, fallout.random(125, 127), 50)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(673, fallout.random(125, 127)), 2)
    end
    bluff_end()
end

function airgrd09()
    fallout.gsay_reply(673, 128)
    fallout.giq_option(-3, 673, 129, airgrd10, 51)
    fallout.giq_option(4, 673, 130, airgrd10, 51)
    fallout.giq_option(4, 673, 131, airgrd11, 51)
    fallout.giq_option(4, 673, 132, airgrd02, 51)
end

function airgrd10()
    fallout.gsay_message(673, 133, 51)
    combat()
end

function airgrd11()
    fallout.gsay_reply(673, 134)
    fallout.giq_option(4, 673, 135, airgrd02, 51)
    fallout.giq_option(4, 673, 136, airgrd12, 51)
end

function airgrd12()
    fallout.gsay_reply(673, 137)
    fallout.giq_option(4, 673, 138, airgrd13, 51)
    fallout.giq_option(6, 673, 139, airgrd14, 51)
end

function airgrd13()
    fallout.gsay_message(673, 140, 51)
    combat()
end

function airgrd14()
    fallout.gsay_message(673, 141, 51)
    combat()
end

function airgrd15()
    fallout.gsay_message(673, 142, 51)
    combat()
end

function bluff_end()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        local xp = 750
        fallout.display_msg(fallout.message_str(673, 200) .. xp .. fallout.message_str(673, 201))
        fallout.give_exp_points(xp)
    end
end

function dialog_end()
end

function airgrdtim()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
end

function combat()
    hostile = true
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
