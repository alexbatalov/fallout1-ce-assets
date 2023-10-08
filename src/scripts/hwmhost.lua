local fallout = require("fallout")
local reaction = require("lib.reaction")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local HubWMHost00
local HubWMHost01
local HubWMHost02
local HubWMHost03
local HubWMHost04
local HubWMHost05

local hostile = 0
local Only_Once = 1

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 40)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 86)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(816, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    HubWMHost00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
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

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(816, 100))
end

function HubWMHost00()
    fallout.gsay_reply(816, 101)
    fallout.giq_option(4, 816, 102, HubWMHost02, 50)
    fallout.giq_option(4, 816, 103, HubWMHost05, 50)
    fallout.giq_option(-3, 816, 104, HubWMHost01, 50)
end

function HubWMHost01()
    fallout.gsay_message(816, 105, 50)
end

function HubWMHost02()
    fallout.gsay_reply(816, 106)
    fallout.giq_option(4, 816, 107, HubWMHost03, 50)
    fallout.giq_option(4, 816, 108, HubWMHost04, 50)
    fallout.giq_option(4, 816, 109, HubWMHost05, 50)
end

function HubWMHost03()
    fallout.gsay_reply(816, 110)
    fallout.giq_option(4, 816, 111, HubWMHost04, 50)
    fallout.giq_option(4, 816, 112, HubWMHost05, 50)
end

function HubWMHost04()
    fallout.gsay_reply(816, 113)
    fallout.giq_option(4, 816, 114, HubWMHost03, 50)
    fallout.giq_option(4, 816, 115, HubWMHost05, 50)
end

function HubWMHost05()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
