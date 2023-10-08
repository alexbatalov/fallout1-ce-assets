local fallout = require("fallout")
local reaction = require("lib.reaction")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local ValtCupl00
local ValtCupl00a
local ValtCupl01
local ValtCupl02
local ValtCupl03
local ValtCupl04
local ValtCupl05
local ValtCupl06
local ValtCupl07
local ValtCuplEnd

local rndx = 0
local initialized = 0
local hostile = 0

local exit_line = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 1)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 11 then
                            talk_p_proc()
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
    fallout.display_msg(fallout.message_str(209, 100))
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(-1, 209, fallout.self_obj(), -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) then
        if fallout.local_var(1) < 2 then
            ValtCupl07()
        else
            ValtCupl06()
        end
    else
        ValtCupl00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function ValtCupl00()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(209, 101)
    fallout.giq_option(4, 209, 102, ValtCupl02, 50)
    fallout.giq_option(4, 209, 103, ValtCupl03, 50)
    fallout.giq_option(5, 209, 104, ValtCupl00a, 50)
    fallout.giq_option(-3, 209, 105, ValtCupl01, 50)
end

function ValtCupl00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        ValtCupl04()
    else
        ValtCupl01()
    end
end

function ValtCupl01()
    reaction.BigDownReact()
    fallout.gsay_message(209, 106, 51)
end

function ValtCupl02()
    fallout.gsay_reply(209, 107)
    fallout.giq_option(4, 209, 108, ValtCupl01, 50)
    fallout.giq_option(4, 209, 109, ValtCupl03, 50)
end

function ValtCupl03()
    reaction.BigUpReact()
    fallout.gsay_message(209, 110, 49)
end

function ValtCupl04()
    fallout.gsay_reply(209, 111)
    fallout.giq_option(5, 209, 112, ValtCupl03, 50)
    fallout.giq_option(5, 209, 113, ValtCupl05, 50)
end

function ValtCupl05()
    fallout.gsay_message(209, 114, 50)
end

function ValtCupl06()
    fallout.gsay_message(209, 115, 50)
end

function ValtCupl07()
    fallout.gsay_message(209, 116, 50)
end

function ValtCuplEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
