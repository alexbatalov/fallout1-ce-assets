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

local hostile = false
local initialized = false
local PaymentAmount = 0
local WaitForTwoHours = false
local spawnDialogue = false
local beenPaid = true

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 64)
        misc.set_ai(self_obj, 50)
        if fallout.local_var(5) == 1 then
            if time.game_time_in_hours() - fallout.local_var(6) < 2 then
                WaitForTwoHours = true
                fallout.set_obj_visibility(self_obj, false)
            else
                WaitForTwoHours = false
                fallout.set_obj_visibility(self_obj, true)
                fallout.set_local_var(5, 0)
            end
        elseif fallout.global_var(205) == 1 then
            fallout.set_obj_visibility(self_obj, false)
            PaymentAmount = 200
            fallout.set_local_var(7, 0)
            fallout.set_global_var(205, 4)
            fallout.set_global_var(200, 4)
            fallout.set_local_var(5, 1)
            WaitForTwoHours = true
            spawnDialogue = true
            beenPaid = true
        elseif fallout.global_var(206) == 1 then
            fallout.set_obj_visibility(self_obj, false)
            PaymentAmount = 400
            fallout.set_local_var(7, 2)
            fallout.set_global_var(206, 4)
            fallout.set_global_var(201, 4)
            fallout.set_local_var(5, 1)
            WaitForTwoHours = true
            spawnDialogue = true
            beenPaid = true
        elseif fallout.global_var(204) == 1 then
            fallout.set_obj_visibility(self_obj, false)
            PaymentAmount = 600
            fallout.set_local_var(7, 1)
            fallout.set_global_var(204, 4)
            fallout.set_global_var(199, 4)
            fallout.set_local_var(5, 1)
            WaitForTwoHours = true
            spawnDialogue = true
            beenPaid = true
        else
            WaitForTwoHours = false
            fallout.set_local_var(5, 0)
            fallout.set_obj_visibility(self_obj, true)
        end
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
    if spawnDialogue then
        spawnDialogue = false
        fallout.set_local_var(6, time.game_time_in_hours())
        fallout.dialogue_system_enter()
    else
        if WaitForTwoHours and time.game_time_in_hours() - fallout.local_var(6) >= 2 then
            WaitForTwoHours = false

            local self_obj = fallout.self_obj()
            if fallout.tile_distance_objs(self_obj, fallout.dude_obj()) >= 24 then
                fallout.set_obj_visibility(self_obj, true)
                fallout.set_local_var(5, 0)
                fallout.display_msg(fallout.message_str(817, 151))
            else
                fallout.gfade_out(1000)
                fallout.set_local_var(5, 0)
                fallout.set_obj_visibility(self_obj, true)
                fallout.gfade_in(1000)
                fallout.display_msg(fallout.message_str(817, 151))
            end
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
    if fallout.cur_map_index() == 36 then
        local self_obj = fallout.self_obj()
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(817, self_obj, 4, -1, -1)
        fallout.gsay_start()
        CarvLead09()
        fallout.gsay_end()
        fallout.end_dialogue()
        fallout.gfade_out(1000)
        fallout.set_local_var(5, 0)
        fallout.set_obj_visibility(self_obj, true)
        WaitForTwoHours = false
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
    local days = 0
    local cur_map_index = fallout.cur_map_index()
    if fallout.global_var(205) == 1 then
        if cur_map_index == 10 then
            days = 3
        elseif cur_map_index == 28 then
            days = 3
        elseif cur_map_index == 36 then
            days = 3
        end
    elseif fallout.global_var(204) == 1 then
        if cur_map_index == 10 then
            days = 2
        elseif cur_map_index == 28 then
            days = 2
        elseif cur_map_index == 13 then
            days = 4
        elseif cur_map_index == 4 then
            days = 2
        elseif cur_map_index == 36 then
            days = 2
        end
    elseif fallout.global_var(206) == 1 then
        if cur_map_index == 10 then
            days = 3
        elseif cur_map_index == 28 then
            days = 3
        elseif cur_map_index == 13 then
            days = 5
        elseif cur_map_index == 36 then
            days = 2
        end
    end
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 24 * days))
end

function damage_p_proc()
    if fallout.cur_map_index() == 36 then
        local pid = fallout.obj_pid(fallout.source_obj())
        if fallout.party_member_obj(pid) ~= nil then
            fallout.set_global_var(248, 1)
        end
    end
end

function CarvLead00()
    local msg = 0
    if PaymentAmount == 200 then
        msg = 146
    elseif PaymentAmount == 400 then
        msg = 147
    elseif PaymentAmount == 600 then
        msg = 148
    end
    fallout.item_caps_adjust(fallout.dude_obj(), PaymentAmount)
    beenPaid = true
    fallout.gsay_reply(817,
        fallout.message_str(817, 101) ..
        fallout.message_str(817, msg) ..
        fallout.message_str(817, 102) .. fallout.message_str(817, msg) .. fallout.message_str(817, 103))
    fallout.giq_option(-3, 817, 104, CarvLead01, 50)
    fallout.giq_option(4, 817, 105, CarvLead03, 50)

    local cur_map_index = fallout.cur_map_index()
    if cur_map_index == 10 then
        fallout.giq_option(4, 817, 106, CarvLead04, 50)
    elseif cur_map_index == 28 then
        fallout.giq_option(4, 817, 107, CarvLead05, 50)
    elseif cur_map_index == 13 then
        fallout.giq_option(4, 817, 108, CarvLead06, 50)
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
    elseif fallout.cur_map_index() == 28 then
        fallout.giq_option(4, 817, 118, CarvLead05, 50)
    elseif fallout.cur_map_index() == 13 then
        fallout.giq_option(4, 817, 119, CarvLead06, 50)
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
    if not beenPaid then
        fallout.item_caps_adjust(fallout.dude_obj(), PaymentAmount)
        beenPaid = true
    end
    fallout.gsay_reply(817, 130)
    fallout.giq_option(-3, 817, 131, CarvLead12, 50)
    fallout.giq_option(-3, 817, 111, CarvLead11, 50)
    fallout.giq_option(4, 817, 132, CarvLead11, 50)
    fallout.giq_option(4, 817, 133, CarvLead12, 50)
end

function CarvLead09()
    local msg = 0
    if PaymentAmount == 200 then
        msg = 146
    elseif PaymentAmount == 400 then
        msg = 147
    elseif PaymentAmount == 600 then
        msg = 148
    end
    fallout.item_caps_adjust(fallout.dude_obj(), PaymentAmount)
    beenPaid = true
    fallout.gsay_reply(817,
        fallout.message_str(817, 137) .. fallout.message_str(817, msg) .. fallout.message_str(817, 138))
    fallout.giq_option(-3, 817, 139, CarvLead11, 50)
    fallout.giq_option(4, 817, 140, CarvLead11, 50)
end

function CarvLead10()
    if fallout.random(1, 2) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(817, 141), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(817, 142), 2)
    end
end

function CarvLead11()
end

function CarvLead12()
    local cur_map_index = fallout.cur_map_index()
    fallout.set_local_var(5, 0)
    if fallout.local_var(7) == 0 then
        fallout.set_global_var(205, 1)
        fallout.set_global_var(200, 1)
        if cur_map_index == 10 then
            if fallout.random(1, 4) < 4 then
                fallout.load_map(64, 3)
            else
                fallout.load_map(36, 1)
            end
        elseif cur_map_index == 28 then
            if fallout.random(1, 4) < 3 then
                fallout.load_map(63, 3)
            else
                fallout.load_map(36, 1)
            end
        end
    elseif fallout.local_var(7) == 1 then
        fallout.set_global_var(204, 1)
        fallout.set_global_var(199, 1)
        if cur_map_index == 13 then
            fallout.load_map(64, 3)
        elseif cur_map_index == 10 then
            fallout.load_map(64, 3)
        elseif cur_map_index == 4 then
            fallout.load_map(63, 3)
        elseif cur_map_index == 28 then
            fallout.load_map(63, 3)
        end
    elseif fallout.local_var(7) == 2 then
        fallout.set_global_var(206, 1)
        fallout.set_global_var(201, 1)
        if cur_map_index == 10 then
            if fallout.random(1, 4) < 4 then
                fallout.load_map(64, 3)
            else
                fallout.load_map(36, 1)
            end
        elseif cur_map_index == 28 then
            if fallout.random(1, 4) < 3 then
                fallout.load_map(63, 3)
            else
                fallout.load_map(36, 1)
            end
        elseif cur_map_index == 13 then
            if fallout.random(1, 4) < 4 then
                fallout.load_map(64, 3)
            else
                fallout.load_map(36, 1)
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
