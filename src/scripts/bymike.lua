local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local damage_p_proc
local destroy_p_proc
local critter_p_proc
local pickup_p_proc
local BYMike02
local BYMike03
local BYMike04
local BYMike05
local BYMike06
local BYMike07
local BYMike08
local BYMikeEnd

local Initialize = 1
local DisplayMessage = 100

local exit_line = 0

function start()
    if Initialize then
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(10, 100))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 47)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 27)
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(923, 101))
    else
        fallout.display_msg(fallout.message_str(923, 100))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(923, 101))
    else
        fallout.display_msg(fallout.message_str(923, 100))
    end
end

function talk_p_proc()
    if fallout.global_var(253) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if fallout.local_var(5) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(923, 116), 0)
        else
            reaction.get_reaction()
            fallout.start_gdialog(923, fallout.self_obj(), -1, -1, -1)
            fallout.gsay_start()
            if fallout.global_var(613) == 2 then
                BYMike06()
            else
                if fallout.local_var(4) == 0 then
                    DisplayMessage = 102
                    BYMike02()
                else
                    DisplayMessage = 103
                    BYMike02()
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
        reputation.inc_good_critter()
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(253) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function pickup_p_proc()
    fallout.set_global_var(253, 1)
end

function BYMike02()
    fallout.gsay_reply(923, DisplayMessage)
    if fallout.local_var(4) == 0 then
        fallout.gsay_option(923, 105, BYMike04, 50)
    end
    fallout.gsay_option(923, 104, BYMike03, 50)
    fallout.gsay_option(923, 106, BYMike05, 50)
    fallout.gsay_option(923, 107, BYMikeEnd, 50)
end

function BYMike03()
    DisplayMessage = 108
    BYMike02()
end

function BYMike04()
    DisplayMessage = 109
    fallout.set_local_var(4, 1)
    BYMike02()
end

function BYMike05()
    DisplayMessage = 110
    BYMike02()
end

function BYMike06()
    fallout.gsay_reply(923, 111)
    fallout.gsay_option(923, 112, BYMike08, 50)
    fallout.gsay_option(923, 113, BYMike07, 50)
end

function BYMike07()
    fallout.gsay_message(923, 115, 50)
    fallout.set_global_var(155, fallout.global_var(155) + 1)
    BYMike08()
end

function BYMike08()
    local v0 = 0
    fallout.gsay_message(923, 115, 50)
    fallout.set_local_var(5, 1)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), v0, 4)
    fallout.item_caps_adjust(fallout.dude_obj(), fallout.random(10, 100))
end

function BYMikeEnd()
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
