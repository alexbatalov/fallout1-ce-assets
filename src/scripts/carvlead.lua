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
local advance_day
local damage_p_proc
local CarvLead00
local CarvLead01
local CarvLead02
local CarvLead03
local CarvLead04
local CarvLead05
local CarvLead06
local CarvLead07
local CarvLead09
local CarvLead10
local CarvLead11
local CarvLead12

local hostile = 0
local initialized = false
local PaymentAmount = 0
local WaitForTwoHours = 0
local spawnDialogue = 0
local beenPaid = 1

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        misc.set_team(fallout.self_obj(), 64)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
        if fallout.local_var(5) == 1 then
            if (time.game_time_in_hours() - fallout.local_var(6)) < 2 then
                WaitForTwoHours = 1
                fallout.set_obj_visibility(fallout.self_obj(), 0)
            else
                WaitForTwoHours = 0
                fallout.set_obj_visibility(fallout.self_obj(), 1)
                fallout.set_local_var(5, 0)
            end
        else
            if fallout.global_var(205) == 1 then
                fallout.set_obj_visibility(fallout.self_obj(), 0)
                PaymentAmount = 200
                fallout.set_local_var(7, 0)
                fallout.set_global_var(205, 4)
                fallout.set_global_var(200, 4)
                fallout.set_local_var(5, 1)
                WaitForTwoHours = 1
                spawnDialogue = 1
                beenPaid = 0
            else
                if fallout.global_var(206) == 1 then
                    fallout.set_obj_visibility(fallout.self_obj(), 0)
                    PaymentAmount = 400
                    fallout.set_local_var(7, 2)
                    fallout.set_global_var(206, 4)
                    fallout.set_global_var(201, 4)
                    fallout.set_local_var(5, 1)
                    WaitForTwoHours = 1
                    spawnDialogue = 1
                    beenPaid = 0
                else
                    if fallout.global_var(204) == 1 then
                        fallout.set_obj_visibility(fallout.self_obj(), 0)
                        PaymentAmount = 600
                        fallout.set_local_var(7, 1)
                        fallout.set_global_var(204, 4)
                        fallout.set_global_var(199, 4)
                        fallout.set_local_var(5, 1)
                        WaitForTwoHours = 1
                        spawnDialogue = 1
                        beenPaid = 0
                    else
                        WaitForTwoHours = 0
                        fallout.set_local_var(5, 0)
                        fallout.set_obj_visibility(fallout.self_obj(), 1)
                    end
                end
            end
        end
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
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

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if spawnDialogue == 1 then
        spawnDialogue = 0
        fallout.set_local_var(6, time.game_time_in_hours())
        fallout.dialogue_system_enter()
    else
        if (WaitForTwoHours == 1) and ((time.game_time_in_hours() - fallout.local_var(6)) >= 2) then
            WaitForTwoHours = 0
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) >= 24 then
                fallout.set_obj_visibility(fallout.self_obj(), 1)
                fallout.set_local_var(5, 0)
                fallout.display_msg(fallout.message_str(817, 151))
            else
                fallout.gfade_out(1000)
                fallout.set_local_var(5, 0)
                fallout.set_obj_visibility(fallout.self_obj(), 1)
                fallout.gfade_in(1000)
                fallout.display_msg(fallout.message_str(817, 151))
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.cur_map_index() == 36 then
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(817, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        CarvLead09()
        fallout.gsay_end()
        fallout.end_dialogue()
        fallout.gfade_out(1000)
        fallout.set_local_var(5, 0)
        fallout.set_obj_visibility(fallout.self_obj(), 1)
        WaitForTwoHours = 0
        fallout.gfade_in(1000)
    else
        if fallout.local_var(4) == 0 then
            fallout.set_local_var(4, 1)
            fallout.start_gdialog(817, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            CarvLead00()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.start_gdialog(817, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            CarvLead07()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(817, 100))
end

function advance_day()
    local v0 = 0
    if fallout.global_var(205) == 1 then
        if fallout.cur_map_index() == 10 then
            v0 = 3
        else
            if fallout.cur_map_index() == 28 then
                v0 = 3
            else
                if fallout.cur_map_index() == 36 then
                    v0 = 3
                end
            end
        end
    else
        if fallout.global_var(204) == 1 then
            if fallout.cur_map_index() == 10 then
                v0 = 2
            else
                if fallout.cur_map_index() == 28 then
                    v0 = 2
                else
                    if fallout.cur_map_index() == 13 then
                        v0 = 4
                    else
                        if fallout.cur_map_index() == 4 then
                            v0 = 2
                        else
                            if fallout.cur_map_index() == 36 then
                                v0 = 2
                            end
                        end
                    end
                end
            end
        else
            if fallout.global_var(206) == 1 then
                if fallout.cur_map_index() == 10 then
                    v0 = 3
                else
                    if fallout.cur_map_index() == 28 then
                        v0 = 3
                    else
                        if fallout.cur_map_index() == 13 then
                            v0 = 5
                        else
                            if fallout.cur_map_index() == 36 then
                                v0 = 2
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 24 * v0))
end

function damage_p_proc()
    local v0 = 0
    if fallout.cur_map_index() == 36 then
        v0 = fallout.obj_pid(fallout.source_obj())
        if fallout.party_member_obj(v0) ~= 0 then
            fallout.set_global_var(248, 1)
        end
    end
end

function CarvLead00()
    local v0 = 0
    local v1 = 0
    if PaymentAmount == 200 then
        v0 = 146
    else
        if PaymentAmount == 400 then
            v0 = 147
        else
            if PaymentAmount == 600 then
                v0 = 148
            end
        end
    end
    v1 = fallout.item_caps_adjust(fallout.dude_obj(), PaymentAmount)
    beenPaid = 1
    fallout.gsay_reply(817, fallout.message_str(817, 101) .. fallout.message_str(817, v0) .. fallout.message_str(817, 102) .. fallout.message_str(817, v0) .. fallout.message_str(817, 103))
    fallout.giq_option(-3, 817, 104, CarvLead01, 50)
    fallout.giq_option(4, 817, 105, CarvLead03, 50)
    if fallout.cur_map_index() == 10 then
        fallout.giq_option(4, 817, 106, CarvLead04, 50)
    else
        if fallout.cur_map_index() == 28 then
            fallout.giq_option(4, 817, 107, CarvLead05, 50)
        else
            if fallout.cur_map_index() == 13 then
                fallout.giq_option(4, 817, 108, CarvLead06, 50)
            end
        end
    end
end

function CarvLead01()
    fallout.gsay_reply(817, 109)
    fallout.giq_option(-3, 817, 110, CarvLead11, 50)
    fallout.giq_option(-3, 817, 111, CarvLead02, 50)
    fallout.giq_option(-3, 817, 112, CarvLead12, 50)
end

function CarvLead02()
    fallout.gsay_message(817, 113, 50)
end

function CarvLead03()
    fallout.gsay_reply(817, 114)
    fallout.giq_option(4, 817, 115, CarvLead11, 50)
    fallout.giq_option(4, 817, 116, CarvLead12, 50)
    if fallout.cur_map_index() == 10 then
        fallout.giq_option(4, 817, 117, CarvLead04, 50)
    else
        if fallout.cur_map_index() == 28 then
            fallout.giq_option(4, 817, 118, CarvLead05, 50)
        else
            if fallout.cur_map_index() == 13 then
                fallout.giq_option(4, 817, 119, CarvLead06, 50)
            end
        end
    end
end

function CarvLead04()
    fallout.gsay_reply(817, 120)
    fallout.giq_option(4, 817, 121, CarvLead03, 50)
    fallout.giq_option(4, 817, 122, CarvLead11, 50)
end

function CarvLead05()
    fallout.gsay_reply(817, 123)
    fallout.giq_option(4, 817, 125, CarvLead03, 50)
    fallout.giq_option(4, 817, 126, CarvLead11, 50)
end

function CarvLead06()
    fallout.gsay_reply(817, 127)
    fallout.giq_option(4, 817, 128, CarvLead03, 50)
    fallout.giq_option(4, 817, 129, CarvLead11, 50)
end

function CarvLead07()
    local v0 = 0
    if beenPaid == 0 then
        v0 = fallout.item_caps_adjust(fallout.dude_obj(), PaymentAmount)
        beenPaid = 1
    end
    fallout.gsay_reply(817, 130)
    fallout.giq_option(-3, 817, 131, CarvLead12, 50)
    fallout.giq_option(-3, 817, 111, CarvLead11, 50)
    fallout.giq_option(4, 817, 132, CarvLead11, 50)
    fallout.giq_option(4, 817, 133, CarvLead12, 50)
end

function CarvLead09()
    local v0 = 0
    local v1 = 0
    if PaymentAmount == 200 then
        v0 = 146
    else
        if PaymentAmount == 400 then
            v0 = 147
        else
            if PaymentAmount == 600 then
                v0 = 148
            end
        end
    end
    v1 = fallout.item_caps_adjust(fallout.dude_obj(), PaymentAmount)
    beenPaid = 1
    fallout.gsay_reply(817, fallout.message_str(817, 137) .. fallout.message_str(817, v0) .. fallout.message_str(817, 138))
    fallout.giq_option(-3, 817, 139, CarvLead11, 50)
    fallout.giq_option(4, 817, 140, CarvLead11, 50)
end

function CarvLead10()
    local v0 = 0
    v0 = fallout.random(1, 2)
    if v0 == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(817, 141), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(817, 142), 2)
    end
end

function CarvLead11()
end

function CarvLead12()
    local v0 = 0
    fallout.set_local_var(5, 0)
    if fallout.local_var(7) == 0 then
        fallout.set_global_var(205, 1)
        fallout.set_global_var(200, 1)
        if fallout.cur_map_index() == 10 then
            v0 = fallout.random(1, 4)
            if v0 < 4 then
                fallout.load_map(64, 3)
            else
                fallout.load_map(36, 1)
            end
        else
            if fallout.cur_map_index() == 28 then
                v0 = fallout.random(1, 4)
                if v0 < 3 then
                    fallout.load_map(63, 3)
                else
                    fallout.load_map(36, 1)
                end
            end
        end
    else
        if fallout.local_var(7) == 1 then
            fallout.set_global_var(204, 1)
            fallout.set_global_var(199, 1)
            if fallout.cur_map_index() == 13 then
                fallout.load_map(64, 3)
            else
                if fallout.cur_map_index() == 10 then
                    fallout.load_map(64, 3)
                else
                    if fallout.cur_map_index() == 4 then
                        fallout.load_map(63, 3)
                    else
                        if fallout.cur_map_index() == 28 then
                            fallout.load_map(63, 3)
                        end
                    end
                end
            end
        else
            if fallout.local_var(7) == 2 then
                fallout.set_global_var(206, 1)
                fallout.set_global_var(201, 1)
                if fallout.cur_map_index() == 10 then
                    v0 = fallout.random(1, 4)
                    if v0 < 4 then
                        fallout.load_map(64, 3)
                    else
                        fallout.load_map(36, 1)
                    end
                else
                    if fallout.cur_map_index() == 28 then
                        v0 = fallout.random(1, 4)
                        if v0 < 3 then
                            fallout.load_map(63, 3)
                        else
                            fallout.load_map(36, 1)
                        end
                    else
                        if fallout.cur_map_index() == 13 then
                            v0 = fallout.random(1, 4)
                            if v0 < 4 then
                                fallout.load_map(64, 3)
                            else
                                fallout.load_map(36, 1)
                            end
                        end
                    end
                end
            end
        end
    end
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
