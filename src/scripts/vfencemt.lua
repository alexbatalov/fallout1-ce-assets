local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local VFenceMt00
local VFenceMt03
local VFenceMt03a
local VFenceMt03b
local VFenceMt04
local VFenceMt05
local VFenceMt06
local VFenceMt07
local VFenceMt08
local VFenceMtAlert
local VFenceMtxx

local initialized = false
local hostile = false
local round_count = 0
local fence_tile_1 = 16706
local fence_tile_2 = 25705
local waypoint = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 34)
        fallout.add_timer_event(self_obj, fallout.game_ticks(30), 1)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_count = round_count + 1
    end
    if round_count > 2 then
        VFenceMtAlert()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        if hostile then
            hostile = false
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.global_var(146) ~= 0 then
                hostile = true
            else
                if fallout.external_var("ignoring_dude") == 0 then
                    if fallout.tile_distance_objs(self_obj, dude_obj) < 12 then
                        fallout.dialogue_system_enter()
                    end
                end
            end
        end
    end
    if fallout.map_var(0) ~= 0 then
        if waypoint == 0 then
            if fallout.tile_num(self_obj) ~= 22312 then
                fallout.animate_move_obj_to_tile(self_obj, 22312, 0)
            else
                waypoint = 1
            end
        elseif waypoint == 1 then
            if fallout.tile_num(self_obj) ~= 26317 then
                fallout.animate_move_obj_to_tile(self_obj, 26317, 0)
            else
                waypoint = 2
            end
        elseif waypoint == 2 then
            if fallout.tile_num(self_obj) ~= 31517 then
                fallout.animate_move_obj_to_tile(self_obj, 32319, 0)
            else
                waypoint = 3
            end
        elseif waypoint == 3 then
            fallout.set_external_var("removal_ptr", self_obj)
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.global_var(54) ~= 0 then
        VFenceMt08()
    else
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and not hostile then
            if fallout.random(0, 5) == 5 then
                VFenceMt00()
            else
                hostile = true
            end
        else
            fallout.start_gdialog(433, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            VFenceMt03()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function timed_event_p_proc()
    if fallout.map_var(0) == 0 then
        local self_obj = fallout.self_obj()
        if fallout.tile_num(self_obj) == fence_tile_1 then
            fallout.animate_move_obj_to_tile(self_obj, fence_tile_2, 0)
        else
            fallout.animate_move_obj_to_tile(self_obj, fence_tile_1, 0)
        end
        fallout.add_timer_event(self_obj, fallout.game_ticks(60), 1)
    end
end

function VFenceMt00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(101, 103)), 2)
    hostile = true
end

function VFenceMt03()
    fallout.gsay_reply(433, fallout.random(104, 106))
    fallout.giq_option(-3, 433, 107, VFenceMt04, 51)
    fallout.giq_option(4, 433, 108, VFenceMt04, 51)
    fallout.giq_option(5, 433, 109, VFenceMt05, 50)
    fallout.giq_option(6, 433, 110, VFenceMt03a, 50)
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        fallout.giq_option(6, 433, 111, VFenceMt03b, 50)
    end
end

function VFenceMt03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        VFenceMt07()
    else
        VFenceMt06()
    end
end

function VFenceMt03b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 25)) then
        VFenceMt07()
    else
        VFenceMt06()
    end
end

function VFenceMt04()
    hostile = true
    fallout.gsay_message(433, fallout.random(112, 114), 51)
end

function VFenceMt05()
    fallout.gsay_reply(433, 115)
    fallout.giq_option(5, 433, 116, VFenceMtxx, 50)
    fallout.giq_option(5, 433, 117, VFenceMtAlert, 51)
end

function VFenceMt06()
    hostile = true
    fallout.gsay_message(433, fallout.random(118, 120), 51)
end

function VFenceMt07()
    fallout.set_external_var("ignoring_dude", 1)
    fallout.gsay_message(433, fallout.random(121, 123), 50)
end

function VFenceMt08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(124, 127)), 2)
    hostile = true
end

function VFenceMtAlert()
    fallout.set_global_var(146, 1)
    hostile = true
end

function VFenceMtxx()
    fallout.set_global_var(57, 2)
    fallout.load_map(32, 5)
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
