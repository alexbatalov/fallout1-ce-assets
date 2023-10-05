local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local Prisoner01
local Prisoner02
local Prisoner03
local PrisonerEnd

local hostile = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 21 then
                look_at_p_proc()
            else
                if fallout.script_action() == 11 then
                    talk_p_proc()
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
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
    fallout.display_msg(fallout.message_str(289, 100))
end

function talk_p_proc()
    fallout.start_gdialog(289, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Prisoner01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Prisoner01()
    fallout.gsay_reply(289, 101)
    fallout.giq_option(3, 289, 102, Prisoner02, 50)
    fallout.giq_option(3, 289, 103, Prisoner02, 50)
    fallout.giq_option(3, 289, 104, Prisoner03, 50)
end

function Prisoner02()
    hostile = 1
end

function Prisoner03()
    fallout.gsay_reply(289, 105)
    fallout.giq_option(3, 289, 106, PrisonerEnd, 50)
end

function PrisonerEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
