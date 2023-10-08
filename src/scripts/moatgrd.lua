local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local Start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local timed_event_p_proc
local map_enter_p_proc
local pickup_p_proc
local Moat00
local Moat01
local Moat02
local Moat03
local Moat04
local Moat05
local MoatCombat
local MoatEnd

local Initialize = 1
local DestTile = 0

local exit_line = 0

function Start()
    if Initialize then
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(2, 20))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 48)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 28)
        if fallout.local_var(4) == 0 then
            DestTile = fallout.tile_num(fallout.self_obj())
            fallout.set_local_var(4, DestTile)
        end
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(6, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(6, 100))
end

function talk_p_proc()
    if fallout.global_var(617) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        reaction.get_reaction()
        fallout.start_gdialog(6, fallout.self_obj(), -1, -1, -1)
        fallout.gsay_start()
        Moat00()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function critter_p_proc()
    if fallout.tile_num(fallout.self_obj()) ~= DestTile then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), DestTile, 0)
    else
        fallout.anim(fallout.self_obj(), 1000, 2)
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(253) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
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

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 5 then
            fallout.set_global_var(617, 1)
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function map_enter_p_proc()
    fallout.move_to(fallout.self_obj(), fallout.local_var(4), 0)
    fallout.anim(fallout.self_obj(), 1000, 2)
end

function pickup_p_proc()
    fallout.set_global_var(617, 1)
end

function Moat00()
    fallout.gsay_reply(6, 101)
    fallout.giq_option(4, 6, 103, Moat02, 50)
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 6, 104, Moat05, 50)
        fallout.giq_option(4, 6, 115, Moat03, 50)
    else
        fallout.giq_option(4, 6, 119, Moat04, 50)
        fallout.giq_option(4, 6, 118, Moat04, 50)
    end
    fallout.giq_option(4, 6, 111, MoatCombat, 51)
    fallout.giq_option(-3, 6, 102, Moat01, 50)
end

function Moat01()
    fallout.gsay_message(6, 107, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
    reaction.BottomReact()
end

function Moat02()
    fallout.gsay_message(6, 107, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10 * 2), 1)
    reaction.BottomReact()
end

function Moat03()
    fallout.gsay_message(6, 116, 50)
    DestTile = 26299
    fallout.set_local_var(5, 1)
end

function Moat04()
    fallout.gsay_message(6, 117, 50)
    DestTile = 26299
end

function Moat05()
    fallout.gsay_message(6, 113, 50)
    DestTile = 26299
    fallout.set_local_var(5, 1)
end

function MoatCombat()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
    reaction.BottomReact()
end

function MoatEnd()
end

local exports = {}
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
