local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local damage_p_proc
local GizGuard00
local GizGuard01
local GizGuard02
local GizGuard03
local GizGuard04
local GizGuard05
local GizGuard06
local GizGuard07
local GizGuard08
local GizGuardEnd

local hostile = 0
local initialized = 0
local sneak_checked = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
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
                        if fallout.script_action() == 22 then
                            timed_event_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            hostile = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12 then
                if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and not(fallout.external_var("weapon_checked")) then
                    fallout.dialogue_system_enter()
                else
                    if fallout.using_skill(fallout.dude_obj(), 8) and not(sneak_checked) then
                        fallout.dialogue_system_enter()
                    end
                end
            end
        end
    end
    if fallout.global_var(347) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(347, 1)
        reputation.inc_evil_critter()
    end
end

function map_enter_p_proc()
    if not(fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41)) then
        fallout.item_caps_adjust(fallout.self_obj(), fallout.random(0, 10))
    end
    if fallout.global_var(32) == 4 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
    else
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 13)
    end
    if (fallout.global_var(38) == 1) or (fallout.global_var(104) == 2) then
        fallout.set_obj_visibility(fallout.self_obj(), 1)
        fallout.move_to(fallout.self_obj(), 7000, 0)
        fallout.set_external_var("removal_ptr", fallout.self_obj())
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        GizGuard00()
    else
        if fallout.using_skill(fallout.dude_obj(), 8) then
            GizGuard01()
        else
            if not(fallout.local_var(0)) then
                fallout.start_gdialog(639, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                GizGuard02()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                GizGuard07()
            end
        end
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(639, fallout.random(100, 103)), 2)
            hostile = 1
        else
            fallout.set_external_var("weapon_checked", 0)
        end
    else
        if fallout.fixed_param() == 2 then
            if fallout.using_skill(fallout.dude_obj(), 8) then
                hostile = 1
            else
                sneak_checked = 0
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(347, 1)
    end
end

function GizGuard00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(639, fallout.random(132, 133)), 2)
    fallout.set_external_var("weapon_checked", 1)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
end

function GizGuard01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(639, fallout.random(104, 106)), 2)
    sneak_checked = 1
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 2)
end

function GizGuard02()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(639, 107)
    fallout.giq_option(4, 639, 108, GizGuard03, 50)
    fallout.giq_option(4, 639, 109, GizGuard04, 50)
    fallout.giq_option(4, 639, 110, GizGuardEnd, 50)
    fallout.giq_option(-3, 639, 111, GizGuard08, 51)
end

function GizGuard03()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        fallout.gsay_reply(639, 112)
        fallout.giq_option(4, 639, 114, GizGuard05, 50)
        fallout.giq_option(4, 639, 115, GizGuard06, 50)
    else
        fallout.gsay_message(639, 113, 51)
    end
end

function GizGuard04()
    fallout.gsay_message(639, fallout.random(116, 119), 50)
end

function GizGuard05()
    fallout.gsay_message(639, 120, 50)
end

function GizGuard06()
    fallout.gsay_message(639, fallout.random(121, 124), 50)
end

function GizGuard07()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(639, fallout.random(125, 130)), 0)
end

function GizGuard08()
    fallout.gsay_message(639, 131, 50)
end

function GizGuardEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.damage_p_proc = damage_p_proc
return exports
