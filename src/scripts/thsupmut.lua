local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local goto0
local goto1
local goto2
local goto3
local goto4
local goto5
local goto6
local goto7
local combat
local gotoend

local rndx = 0
local Hostile = 0
local ONLY_ONCE = 1

function start()
    if ONLY_ONCE then
        ONLY_ONCE = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 49)
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
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

function critter_p_proc()
    if Hostile then
        Hostile = 0
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
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if rndx == 0 then
        rndx = fallout.random(100, 109)
    end
    fallout.display_msg(fallout.message_str(265, rndx))
end

function pickup_p_proc()
    Hostile = 1
end

function talk_p_proc()
    fallout.script_overrides()
    fallout.start_gdialog(265, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(0) then
        goto7()
    else
        goto0()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function goto0()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(265, 110)
    fallout.giq_option(-3, 265, 111, goto1, 50)
    fallout.giq_option(4, 265, 112, combat, 50)
    fallout.giq_option(4, 265, 113, goto2, 50)
    fallout.giq_option(6, 265, 114, goto3, 50)
end

function goto1()
    fallout.gsay_message(265, 115, 50)
    combat()
end

function goto2()
    fallout.gsay_message(265, 116, 50)
    combat()
end

function goto3()
    fallout.gsay_reply(265, 117)
    fallout.giq_option(6, 265, 118, goto4, 50)
    fallout.giq_option(6, 265, 119, goto6, 50)
end

function goto4()
    fallout.gsay_reply(265, 120)
    fallout.giq_option(6, 265, 121, combat, 50)
    fallout.giq_option(6, 265, 122, combat, 50)
    fallout.giq_option(8, 265, 123, goto5, 50)
end

function goto5()
    fallout.gsay_reply(265, 124)
    fallout.giq_option(8, 265, 125, combat, 50)
    fallout.giq_option(8, 265, 126, combat, 50)
end

function goto6()
    fallout.gsay_message(265, 127, 50)
    combat()
end

function goto7()
    fallout.gsay_message(265, 128, 50)
    combat()
end

function combat()
    Hostile = 1
end

function gotoend()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
