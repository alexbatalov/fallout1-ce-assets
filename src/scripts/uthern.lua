local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local uthern0
local uthern1
local uthern2
local uthern3
local uthern4
local uthern5
local uthern6
local uthern7
local uthern8
local uthern9
local uthern10
local uthern11
local uthern12
local uthern13
local uthern14
local uthernend
local combat

local hostile = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 49)
        initialized = true
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
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(273, 100))
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        uthern14()
    else
        fallout.set_local_var(0, 1)
        fallout.start_gdialog(273, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        uthern0()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function uthern0()
    fallout.gsay_reply(273, 101)
    fallout.giq_option(-3, 273, 102, uthern1, 50)
    fallout.giq_option(4, 273, 103, uthern2, 50)
    fallout.giq_option(4, 273, 104, combat, 50)
    fallout.giq_option(5, 273, 105, uthern7, 50)
    fallout.giq_option(8, 273, 106, uthern13, 50)
end

function uthern1()
    fallout.gsay_message(273, 107, 50)
    combat()
end

function uthern2()
    fallout.gsay_reply(273, 108)
    fallout.giq_option(4, 273, 109, uthern3, 50)
    fallout.giq_option(4, 273, 110, combat, 50)
    fallout.giq_option(6, 273, 111, uthern4, 50)
end

function uthern3()
    fallout.gsay_message(273, 112, 50)
    combat()
end

function uthern4()
    fallout.gsay_reply(273, 113)
    fallout.giq_option(6, 273, 114, uthern5, 50)
    fallout.giq_option(6, 273, 115, uthern6, 50)
    fallout.giq_option(6, 273, 116, combat, 50)
end

function uthern5()
    fallout.gsay_message(273, 117, 50)
    combat()
end

function uthern6()
    fallout.gsay_message(273, 118, 50)
    combat()
end

function uthern7()
    fallout.gsay_reply(273, 119)
    fallout.giq_option(5, 273, 120, uthern8, 50)
    fallout.giq_option(5, 273, 121, uthern12, 50)
    fallout.giq_option(5, 273, 122, combat, 50)
end

function uthern8()
    fallout.gsay_reply(273, 123)
    fallout.giq_option(5, 273, 124, uthern9, 50)
    fallout.giq_option(5, 273, 125, uthern10, 50)
    fallout.giq_option(5, 273, 126, uthern11, 50)
    fallout.giq_option(5, 273, 127, combat, 50)
end

function uthern9()
    fallout.gsay_message(273, 128, 50)
    combat()
end

function uthern10()
    fallout.gsay_message(273, 129, 50)
    combat()
end

function uthern11()
    fallout.gsay_message(273, 130, 50)
    combat()
end

function uthern12()
    fallout.gsay_reply(273, 131)
    fallout.giq_option(5, 273, 132, combat, 50)
    fallout.giq_option(5, 273, 133, combat, 50)
    fallout.giq_option(5, 273, 134, combat, 50)
end

function uthern13()
    fallout.gsay_message(273, 135, 50)
    combat()
end

function uthern14()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(273, 136), 0)
    combat()
end

function uthernend()
end

function combat()
    hostile = 1
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
