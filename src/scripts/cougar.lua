local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local Cougar00
local Cougar01
local Cougar02
local Cougar03
local Cougar04

local hostile = false

local damage_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 18 then
        destroy_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.external_var("fetch_dude") ~= 0 then
            hostile = true
            fallout.set_external_var("fetch_dude", 0)
        end
    end
    if fallout.global_var(346) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function map_enter_p_proc()
    local script_action = fallout.script_action()
    if fallout.global_var(15) == 1 then
        fallout.kill_critter(script_action, 48)
    end
    fallout.critter_add_trait(script_action, 1, 6, 19)
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.local_var(0) ~= 0 then
        Cougar04()
    else
        fallout.start_gdialog(35, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Cougar00()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(346, 1)
        reputation.inc_good_critter()
    end
end

function Cougar00()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(35, 101)
    fallout.giq_option(4, 35, 102, Cougar01, 50)
    fallout.giq_option(5, 35, 103, Cougar02, 50)
    fallout.giq_option(-3, 35, 104, Cougar03, 50)
end

function Cougar01()
    fallout.gsay_reply(35, 105)
    fallout.giq_option(4, 35, 106, Cougar02, 50)
end

function Cougar02()
    fallout.gsay_message(35, 107, 50)
end

function Cougar03()
    fallout.gsay_message(35, 108, 50)
end

function Cougar04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(35, 109), 50)
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(346, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(35, 100))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
