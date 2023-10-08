local fallout = require("fallout")
local reaction = require("lib.reaction")

local Start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local damage_p_proc
local destroy_p_proc
local critter_p_proc
local pickup_p_proc
local BYChris01
local BYChris02
local BYChris03
local BYChris04
local BYChris05
local BYChris06
local BYChris07
local BYChrisEnd

local Initialize = 1
local DisplayMessage = 100

local exit_line = 0

function Start()
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
        fallout.display_msg(fallout.message_str(924, 101))
    else
        fallout.display_msg(fallout.message_str(924, 100))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(924, 101))
    else
        fallout.display_msg(fallout.message_str(924, 100))
    end
end

function talk_p_proc()
    if fallout.global_var(253) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if fallout.local_var(5) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(924, 116), 0)
        else
            reaction.get_reaction()
            fallout.start_gdialog(924, fallout.self_obj(), -1, -1, -1)
            fallout.gsay_start()
            DisplayMessage = 102
            BYChris01()
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
        if fallout.source_obj() == fallout.dude_obj() then
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                fallout.set_global_var(156, 1)
                fallout.set_global_var(157, 0)
            end
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                fallout.set_global_var(157, 1)
                fallout.set_global_var(156, 0)
            end
            fallout.set_global_var(159, fallout.global_var(159) + 1)
            if (fallout.global_var(159) % 2) == 0 then
                fallout.set_global_var(155, fallout.global_var(155) - 1)
            end
        end
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

function BYChris01()
    fallout.gsay_reply(924, DisplayMessage)
    fallout.giq_option(4, 924, 103, BYChris02, 50)
    if fallout.local_var(4) == 0 then
        fallout.giq_option(4, 924, 104, BYChris03, 50)
    end
    fallout.giq_option(4, 924, 105, BYChris04, 50)
    fallout.giq_option(7, 924, 111, BYChris05, 50)
    fallout.giq_option(4, 924, 106, BYChrisEnd, 50)
    fallout.giq_option(-3, 924, 107, BYChris07, 50)
end

function BYChris02()
    DisplayMessage = 108
    BYChris01()
end

function BYChris03()
    DisplayMessage = 109
    fallout.set_local_var(4, 1)
    BYChris01()
end

function BYChris04()
    DisplayMessage = 110
    BYChris01()
end

function BYChris05()
    fallout.gsay_reply(924, 112)
    fallout.gsay_option(924, 113, BYChris06, 50)
end

function BYChris06()
    fallout.gsay_reply(924, 114)
    DisplayMessage = 116
    fallout.gsay_option(924, 115, BYChris01, 50)
end

function BYChris07()
    fallout.gsay_message(924, 117, 50)
end

function BYChrisEnd()
end

local exports = {}
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
