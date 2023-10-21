local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Merchant00
local Merchant01
local Merchant02
local Merchant03
local Merchant04
local Merchant05
local Get_Stuff
local Put_Stuff

local hostile = false
local initialized = false

local STUFF <const> = {
    [32] = 5,
    [14] = 5,
    [25] = 6,
    [11] = 2,
    [10] = 2,
    [23] = 1,
    [27] = 6,
    [13] = 1,
    [9] = 2,
    [143] = 1,
}

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 41)
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
    Get_Stuff()
    fallout.start_gdialog(782, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Merchant00()
    fallout.gsay_end()
    fallout.end_dialogue()
    Put_Stuff()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(782, 110))
end

function Merchant00()
    fallout.gsay_reply(782, 101)
    fallout.giq_option(4, 782, 102, Merchant01, 50)
    fallout.giq_option(4, 782, 103, Merchant02, 50)
    fallout.giq_option(4, 782, 104, Merchant03, 50)
    fallout.giq_option(-3, 782, 105, Merchant04, 50)
end

function Merchant01()
    fallout.gsay_message(782, 106, 50)
    fallout.gdialog_mod_barter(-10)
    Merchant05()
end

function Merchant02()
    fallout.gsay_message(782, 107, 50)
    fallout.gdialog_mod_barter(-10)
    Merchant05()
end

function Merchant03()
end

function Merchant04()
    fallout.gsay_message(782, 108, 50)
end

function Merchant05()
    fallout.gsay_message(782, 109, 50)
end

function Get_Stuff()
    local self_obj = fallout.self_obj()
    for pid, qty in ipairs(STUFF) do
        local item_obj = fallout.create_object_sid(pid, 0, 0, -1)
        fallout.add_mult_objs_to_inven(self_obj, item_obj, qty)
    end
end

function Put_Stuff()
    local self_obj = fallout.self_obj()
    for pid, qty in ipairs(STUFF) do
        local item_obj = fallout.obj_carrying_pid_obj(self_obj, pid)
        if item_obj ~= nil then
            fallout.rm_mult_objs_from_inven(self_obj, item_obj, qty)
            fallout.destroy_object(item_obj)
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
return exports
