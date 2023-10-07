local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local talk_p_proc
local Brenden01
local Brenden02
local Brenden03
local Brenden04
local Brenden05
local Brenden06
local Brenden07
local Brenden08
local Brenden09
local Brenden10
local Brenden11
local Brenden12
local BrendenEnd

local hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 62)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 11 then
                    talk_p_proc()
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.global_var(250) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
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

function talk_p_proc()
    fallout.start_gdialog(666, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Brenden01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Brenden01()
    if fallout.local_var(0) then
        fallout.gsay_reply(666, 112)
    else
        fallout.set_local_var(0, 1)
        fallout.gsay_reply(666, 102)
    end
    fallout.giq_option(-3, 666, 107, Brenden05, 50)
    fallout.giq_option(4, 666, 103, Brenden02, 50)
    fallout.giq_option(4, 666, 104, Brenden03, 50)
    fallout.giq_option(4, 666, 105, Brenden04, 50)
    if fallout.local_var(1) == 0 then
        fallout.giq_option(4, 666, 106, Brenden06, 50)
    end
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden02()
    fallout.gsay_reply(666, 109)
    fallout.giq_option(0, 634, 106, Brenden01, 50)
end

function Brenden03()
    fallout.gsay_reply(666, 110)
    fallout.giq_option(0, 634, 106, Brenden01, 50)
end

function Brenden04()
    fallout.gsay_reply(666, 111)
    fallout.giq_option(0, 634, 106, Brenden01, 50)
end

function Brenden05()
    fallout.gsay_message(666, 108, 50)
end

function Brenden06()
    fallout.set_local_var(1, 1)
    fallout.gsay_reply(666, 114)
    fallout.giq_option(4, 666, 115, Brenden07, 49)
    fallout.giq_option(4, 666, 116, Brenden12, 51)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden07()
    fallout.gsay_reply(666, 117)
    fallout.giq_option(6, 666, 118, Brenden08, 50)
    fallout.giq_option(4, 666, 119, Brenden11, 50)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden08()
    fallout.gsay_reply(666, 120)
    fallout.giq_option(6, 666, 121, Brenden09, 49)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden09()
    fallout.gsay_reply(666, 122)
    fallout.giq_option(6, 666, 123, Brenden10, 50)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden10()
    fallout.gsay_reply(666, 124)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden11()
    fallout.gsay_reply(666, 125)
    fallout.giq_option(4, 666, 126, Brenden09, 49)
    fallout.giq_option(4, 666, 113, BrendenEnd, 50)
end

function Brenden12()
    fallout.gsay_message(666, 127, 51)
end

function BrendenEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.talk_p_proc = talk_p_proc
return exports
