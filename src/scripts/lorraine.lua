local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local Lorri01
local Lorri02
local Lorri03
local Lorri04
local Lorri05
local Lorri06
local Lorri07
local Lorri08
local Lorri09
local Lorri10
local Lorri11
local Lorri12
local Lorri13
local Lorri14
local Lorri15
local Lorri16
local Lorri17
local Lorri18
local Lorri19
local Lorri20
local Lorri21
local Lorri22
local Lorri23
local Lorri24
local Lorri25
local Lorri26
local Lorri27

local hostile = 0
local initialized = false

function start()
    if not initialized then
        if (fallout.global_var(613) == 9103) or (fallout.global_var(613) == 9102) then
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        else
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        end
        initialized = true
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

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(251, 1)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(251, 1)
        reputation.inc_good_critter()
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        fallout.display_msg(fallout.message_str(253, 100))
    else
        fallout.display_msg(fallout.message_str(253, 101))
    end
end

function pickup_p_proc()
    fallout.set_global_var(251, 1)
end

function talk_p_proc()
    fallout.start_gdialog(253, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(0) ~= 0 then
        Lorri04()
    else
        Lorri01()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(251) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function Lorri01()
    fallout.gsay_reply(253, 102)
    fallout.giq_option(4, 253, 103, Lorri02, 50)
    fallout.giq_option(4, 253, fallout.message_str(253, 104) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(253, 105), Lorri03, 50)
    fallout.giq_option(-3, 253, 106, Lorri15, 50)
end

function Lorri02()
    fallout.gsay_reply(253, 107)
    if not(fallout.local_var(0)) then
        fallout.giq_option(4, 253, 108, Lorri03, 50)
    end
    fallout.giq_option(4, 253, 109, Lorri16, 50)
    fallout.giq_option(4, 253, 110, Lorri20, 50)
    fallout.giq_option(4, 253, 111, Lorri04, 50)
    fallout.giq_option(4, 253, 112, Lorri05, 50)
end

function Lorri03()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(253, 113)
    fallout.giq_option(4, 253, 114, Lorri02, 50)
end

function Lorri04()
    fallout.gsay_reply(253, 115)
    fallout.giq_option(4, 253, 116, Lorri06, 50)
    fallout.giq_option(4, 253, 117, Lorri07, 50)
    fallout.giq_option(4, 253, 118, Lorri02, 50)
end

function Lorri05()
    fallout.gsay_message(253, 119, 50)
end

function Lorri06()
    fallout.gsay_reply(253, 120)
    fallout.giq_option(4, 253, 121, Lorri08, 50)
    fallout.giq_option(4, 253, 122, Lorri10, 50)
    fallout.giq_option(4, 253, 123, Lorri02, 50)
    fallout.giq_option(4, 253, 124, Lorri05, 50)
end

function Lorri07()
    fallout.gsay_reply(253, 125)
    fallout.giq_option(4, 253, 126, Lorri02, 50)
    fallout.giq_option(4, 253, 127, Lorri05, 50)
end

function Lorri08()
    fallout.gsay_reply(253, fallout.message_str(253, 128))
    fallout.giq_option(4, 253, 131, Lorri02, 50)
    fallout.giq_option(4, 253, 132, Lorri05, 50)
end

function Lorri09()
    fallout.gsay_reply(253, 133)
    fallout.giq_option(4, 253, 134, Lorri12, 50)
    fallout.giq_option(4, 253, 135, Lorri02, 50)
    fallout.giq_option(4, 253, 136, Lorri05, 50)
end

function Lorri10()
    fallout.gsay_reply(253, 137)
    fallout.giq_option(4, 253, 138, Lorri11, 50)
    fallout.giq_option(4, 253, 139, Lorri06, 50)
    fallout.giq_option(4, 253, 140, Lorri02, 50)
    fallout.giq_option(4, 253, 141, Lorri05, 50)
end

function Lorri11()
    fallout.gsay_reply(253, 142)
    fallout.giq_option(4, 253, 143, Lorri13, 50)
    fallout.giq_option(4, 253, 144, Lorri14, 50)
    fallout.giq_option(4, 253, 145, Lorri02, 50)
    fallout.giq_option(4, 253, 146, Lorri05, 50)
end

function Lorri12()
    fallout.gsay_message(253, 147, 50)
end

function Lorri13()
    fallout.gsay_message(253, 148, 50)
end

function Lorri14()
    fallout.gsay_reply(253, 149)
    fallout.giq_option(4, 253, 150, Lorri02, 50)
    fallout.giq_option(4, 253, 151, Lorri05, 50)
end

function Lorri15()
    fallout.gsay_message(253, 152, 50)
end

function Lorri16()
    fallout.gsay_reply(253, 153)
    fallout.giq_option(4, 253, 154, Lorri17, 50)
    fallout.giq_option(4, 253, 155, Lorri05, 50)
end

function Lorri17()
    fallout.gsay_reply(253, fallout.message_str(253, 156) .. fallout.message_str(253, 157))
    fallout.giq_option(4, 253, 158, Lorri18, 50)
    fallout.giq_option(4, 253, 159, Lorri08, 50)
    fallout.giq_option(4, 253, 160, Lorri19, 50)
    fallout.giq_option(4, 253, 162, Lorri05, 50)
end

function Lorri18()
    fallout.gsay_reply(253, 163)
    fallout.giq_option(4, 253, 164, Lorri02, 50)
    fallout.giq_option(4, 253, 165, Lorri05, 50)
end

function Lorri19()
    fallout.gsay_reply(253, 166)
    fallout.giq_option(4, 253, 167, Lorri08, 50)
    fallout.giq_option(4, 253, 168, Lorri02, 50)
    fallout.giq_option(4, 253, 169, Lorri05, 50)
end

function Lorri20()
    fallout.gsay_reply(253, 170)
    fallout.giq_option(4, 253, 171, Lorri21, 50)
    fallout.giq_option(4, 253, 172, Lorri22, 50)
    fallout.giq_option(4, 253, 173, Lorri23, 50)
    fallout.giq_option(4, 253, 174, Lorri24, 50)
    fallout.giq_option(4, 253, 175, Lorri25, 50)
    fallout.giq_option(4, 253, 176, Lorri05, 50)
end

function Lorri21()
    fallout.gsay_reply(253, 177)
    Lorri26()
end

function Lorri22()
    fallout.gsay_reply(253, 178)
    Lorri26()
end

function Lorri23()
    fallout.gsay_reply(253, 179)
    Lorri26()
end

function Lorri24()
    fallout.gsay_reply(253, 180)
    Lorri26()
end

function Lorri25()
    fallout.gsay_reply(253, 181)
    Lorri26()
end

function Lorri26()
    fallout.giq_option(4, 253, 182, Lorri20, 50)
    fallout.giq_option(4, 253, 183, Lorri02, 50)
end

function Lorri27()
    fallout.gsay_message(253, 184, 50)
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
return exports
