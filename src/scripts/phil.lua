local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local run_away
local go_forward
local Phil00
local Phil01
local Phil02
local Phil03
local Phil04
local Phil05
local Phil06
local Phil07
local Phil08
local Phil09
local PhilEnd

local hostile = 0
local home_tile = 28684

local exit_line = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 21 then
                look_at_p_proc()
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
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.map_var(9) == 1 then
        run_away()
    end
    if fallout.map_var(6) == 1 then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 2)
        fallout.set_map_var(6, 0)
    end
    if fallout.map_var(5) == 0 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(352, 100))
    else
        fallout.display_msg(fallout.message_str(352, 101))
    end
end

function map_enter_p_proc()
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 5)
    if fallout.map_var(5) == 1 then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.global_var(5) ~= 0 then
        Phil01()
    else
        if not(fallout.map_var(5)) then
            Phil09()
        else
            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                Phil00()
            else
                if fallout.local_var(4) == 0 then
                    fallout.start_gdialog(352, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Phil02()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    Phil08()
                end
            end
        end
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(352, 102), 0)
    else
        if fallout.map_var(5) ~= 0 then
            go_forward()
        end
    end
end

function run_away()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 31096, 1)
    fallout.set_map_var(9, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(10, 30)), 1)
end

function go_forward()
    fallout.set_map_var(8, 1)
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 30889, 0)
end

function Phil00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(352, 103), 0)
end

function Phil01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(352, 104), 0)
end

function Phil02()
    local v0 = 0
    fallout.set_local_var(4, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        v0 = fallout.message_str(352, 105)
    else
        v0 = fallout.message_str(352, 106)
    end
    fallout.gsay_reply(352, v0 .. fallout.message_str(352, 107))
    fallout.giq_option(4, 352, 108, Phil04, 50)
    fallout.giq_option(4, 352, 109, PhilEnd, 50)
    fallout.giq_option(6, 352, 110, Phil05, 50)
    fallout.giq_option(-3, 352, 111, Phil03, 50)
end

function Phil03()
    fallout.gsay_message(352, 112, 50)
end

function Phil04()
    fallout.gsay_reply(352, 113)
    fallout.giq_option(4, 352, 114, PhilEnd, 50)
    fallout.giq_option(4, 352, 115, Phil05, 50)
end

function Phil05()
    fallout.gsay_reply(352, 116)
    fallout.giq_option(4, 352, 117, PhilEnd, 50)
    fallout.giq_option(5, 352, 118, Phil06, 50)
    fallout.giq_option(6, 352, 119, Phil07, 50)
end

function Phil06()
    fallout.gsay_message(352, 120, 50)
    fallout.gsay_reply(352, 121)
    exit_line = reaction.Goodbyes()
    fallout.giq_option(7, 352, 122, Phil07, 50)
    fallout.giq_option(4, 634, exit_line, PhilEnd, 50)
end

function Phil07()
    fallout.gsay_message(352, 123, 50)
    fallout.gsay_reply(352, 124)
    fallout.giq_option(4, 352, 125, PhilEnd, 50)
end

function Phil08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(352, 126), 0)
end

function Phil09()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(352, 127), 0)
end

function PhilEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
