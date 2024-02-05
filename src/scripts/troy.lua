local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Troy00
local Troy01
local Troy02
local Troy03
local Troy04
local Troy05
local Troy06
local Troy07
local Troy08

local hostile = false
local initialized = false
local TalkToPlayer = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 48)
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
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if TalkToPlayer and fallout.tile_distance_objs(self_obj, dude_obj) <= 3 then
        fallout.dialogue_system_enter()
    end
    if fallout.map_var(3) == 1 then
        fallout.set_map_var(3, 0)
        TalkToPlayer = true
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_obj(self_obj, dude_obj, -1)
        fallout.reg_anim_func(3, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if TalkToPlayer then
        fallout.start_gdialog(604, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Troy00()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        fallout.display_msg(fallout.message_str(604, 132))
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(604, 100))
end

function Troy00()
    fallout.gsay_reply(604, 101)
    fallout.giq_option(7, 604, 102, Troy01, 50)
    fallout.giq_option(4, 604, 103, Troy01, 50)
    fallout.giq_option(4, 604, 104, Troy02, 50)
    fallout.giq_option(4, 604, 105, Troy03, 51)
    fallout.giq_option(4, 604, 106, Troy04, 51)
    fallout.giq_option(-3, 604, 107, Troy05, 50)
end

function Troy01()
    fallout.gsay_reply(604, 108)
    fallout.giq_option(4, 604, 109, Troy06, 50)
    fallout.giq_option(4, 604, 110, Troy02, 50)
    fallout.giq_option(4, 604, 111, Troy03, 51)
    fallout.giq_option(4, 604, 112, Troy07, 51)
end

function Troy02()
    fallout.gsay_message(604, 113, 50)
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 24 * 14))
    fallout.set_global_var(57, 1)
    fallout.load_map(32, 5)
end

function Troy03()
    fallout.set_global_var(255, 1)
    fallout.gsay_message(604, 114, 50)
    combat()
end

function Troy04()
    fallout.gsay_reply(604, 115)
    fallout.giq_option(4, 604, 116, Troy02, 50)
    fallout.giq_option(4, 604, 117, Troy03, 51)
    fallout.giq_option(4, 604, 118, Troy08, 51)
    fallout.giq_option(4, 604, 119, Troy07, 51)
end

function Troy05()
    fallout.gsay_reply(604, 120)
    fallout.giq_option(4, 604, 121, Troy02, 50)
    fallout.giq_option(4, 604, 122, Troy03, 50)
end

function Troy06()
    fallout.gsay_reply(604, 123)
    fallout.giq_option(4, 604, 124, Troy02, 50)
    fallout.giq_option(4, 604, 125, Troy03, 51)
    fallout.giq_option(4, 604, 126, Troy07, 51)
end

function Troy07()
    fallout.set_global_var(255, 1)
    fallout.gsay_message(604, 127, 51)
    combat()
end

function Troy08()
    fallout.gsay_reply(604, 128)
    fallout.giq_option(4, 604, 129, Troy02, 50)
    fallout.giq_option(4, 604, 120, Troy03, 51)
    fallout.giq_option(4, 604, 121, Troy07, 51)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
