local fallout = require("fallout")
local reaction = require("lib.reaction")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local dialog_end
local lucy00
local lucy01
local lucy02
local lucy03
local lucy04
local lucy05

local hostile = 0
local Only_Once = 1
local temp = 0

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 50)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 67)
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
    fallout.start_gdialog(671, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 0 then
        lucy00()
    else
        if fallout.local_var(4) == 1 then
            lucy04()
        else
            if fallout.local_var(4) > 1 then
                lucy05()
            end
        end
    end
    temp = fallout.local_var(4)
    if temp < 2 then
        fallout.set_local_var(4, temp + 1)
    end
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
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(671, 300))
end

function dialog_end()
end

function lucy00()
    fallout.gsay_reply(671, 302)
    fallout.giq_option(-3, 671, 303, lucy01, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 304, lucy02, 49 + fallout.random(0, 2))
    fallout.giq_option(6, 671, 305, lucy03, 49 + fallout.random(0, 2))
end

function lucy01()
    fallout.gsay_message(671, 306, 49 + fallout.random(0, 2))
    dialog_end()
end

function lucy02()
    fallout.gsay_message(671, 307, 49 + fallout.random(0, 2))
    dialog_end()
end

function lucy03()
    fallout.gsay_message(671, 308, 49 + fallout.random(0, 2))
    dialog_end()
end

function lucy04()
    fallout.gsay_message(671, 309, 49 + fallout.random(0, 2))
    dialog_end()
end

function lucy05()
    fallout.gsay_message(671, 310, 49 + fallout.random(0, 2))
    dialog_end()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
