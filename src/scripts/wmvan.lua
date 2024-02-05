local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local caravan00
local caravan01
local caravan02
local caravan03
local caravan03a
local caravan03b
local caravan03c
local caravan03d
local caravan04

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 35)
        fallout.critter_add_trait(self_obj, 1, 5, 50)
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
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(767, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    caravan00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if fallout.global_var(159) % 7 == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(767, 101))
end

function caravan00()
    fallout.gsay_reply(767, 103)
    fallout.giq_option(0, 767, 104, caravan01, 50)
    fallout.giq_option(0, 767, 105, caravan02, 50)
end

function caravan01()
    fallout.gsay_reply(767, 106)
    fallout.giq_option(0, 767, 104, caravan03, 50)
    fallout.giq_option(0, 767, 105, caravan02, 50)
end

function caravan02()
    fallout.gsay_message(767, 107, 50)
end

function caravan03()
    fallout.gsay_reply(767, 110)
    fallout.giq_option(0, 767, 112, caravan03a, 50)
    fallout.giq_option(0, 767, 113, caravan03b, 50)
    fallout.giq_option(0, 767, 116, caravan04, 50)
end

function caravan03a()
    fallout.gsay_message(767, 117, 50)
    fallout.set_global_var(200, 1)
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 24 * 4))
    fallout.item_caps_adjust(fallout.dude_obj(), 200)
    if fallout.random(1, 4) < 3 then
        if fallout.random(1, 20) < 4 then
            fallout.load_map(56, 2)
        else
            fallout.load_map(56, 3)
        end
    else
        fallout.load_map(28, 1)
    end
end

function caravan03b()
    fallout.gsay_message(767, 117, 50)
    fallout.set_global_var(200, 1)
    fallout.game_time_advance(fallout.game_ticks(60 * 60 * 24 * 4))
    fallout.item_caps_adjust(fallout.dude_obj(), 200)
    if fallout.random(1, 4) < 4 then
        if fallout.random(1, 20) < 4 then
            fallout.load_map(58, 2)
        else
            fallout.load_map(58, 3)
        end
    else
        fallout.load_map(10, 1)
    end
end

function caravan03c()
    fallout.gsay_message(767, 117, 50)
    fallout.set_global_var(200, 1)
    if fallout.random(1, 4) < 4 then
        if fallout.random(1, 4) == 1 then
            if fallout.random(1, 10) == 1 then
                fallout.load_map(59, 1)
            else
                fallout.load_map(59, 2)
            end
        else
            fallout.load_map(59, 3)
        end
    end
end

function caravan03d()
    fallout.gsay_message(767, 117, 50)
    fallout.set_global_var(200, 1)
    if fallout.random(1, 4) < 4 then
        if fallout.random(1, 4) == 1 then
            if fallout.random(1, 10) == 1 then
                fallout.load_map(57, 1)
            else
                fallout.load_map(57, 2)
            end
        else
            fallout.load_map(57, 3)
        end
    end
end

function caravan04()
    fallout.gsay_message(767, 108, 50)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
