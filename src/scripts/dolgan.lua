local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local show_true_name
local show_false_name
local Dolgan00
local Dolgan01
local Dolgan02
local Dolgan03
local Dolgan04
local Dolgan05
local Dolgan06
local Dolgan07
local Train
local DolganEnd

local hostile = 0
local initialized = 0

local DolganCombat

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 47)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 27)
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
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.global_var(136) < 41) then
        hostile = 1
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    fallout.set_global_var(136, fallout.global_var(136) - 1)
    reputation.inc_good_critter()
end

function look_at_p_proc()
    if (fallout.global_var(135) == 2) or (fallout.get_critter_stat(fallout.dude_obj(), 6) > 6) then
        show_true_name()
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 6) < 4 then
            show_false_name()
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 4) < 5 then
                show_false_name()
            else
                if fallout.random(0, 1) then
                    show_false_name()
                else
                    show_true_name()
                end
            end
        end
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    fallout.start_gdialog(282, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.set_local_var(0, 1)
    if fallout.global_var(135) == 2 then
        Dolgan03()
    else
        if (fallout.global_var(135) == 1) and (fallout.local_var(1) == 0) then
            Dolgan01()
        else
            Dolgan00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function show_true_name()
    fallout.script_overrides()
    if fallout.local_var(0) then
        if time.is_night() then
            fallout.display_msg(fallout.message_str(282, 100))
        else
            fallout.display_msg(fallout.message_str(282, 101))
        end
    else
        fallout.display_msg(fallout.message_str(282, 104))
    end
end

function show_false_name()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(282, fallout.random(105, 111)))
end

function Dolgan00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(282, 112), 2)
end

function Dolgan01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(282, 113), 2)
    fallout.set_local_var(1, 1)
    fallout.critter_mod_skill(fallout.dude_obj(), 4, 7)
    fallout.game_time_advance(fallout.game_ticks(14400))
    Dolgan02()
end

function Dolgan02()
    fallout.gsay_message(282, 114, 50)
end

function Dolgan03()
    fallout.gsay_reply(282, 115)
    if fallout.local_var(1) ~= 2 then
        fallout.giq_option(5, 282, 116, Dolgan04, 50)
    end
    fallout.giq_option(5, 282, 117, Dolgan07, 50)
    fallout.giq_option(5, 282, 118, DolganEnd, 50)
end

function Dolgan04()
    fallout.gsay_reply(282, 119)
    if fallout.local_var(1) ~= 2 then
        fallout.giq_option(4, 282, 120, Train, 50)
    end
    fallout.giq_option(4, 282, 121, DolganEnd, 50)
end

function Dolgan05()
    fallout.gsay_message(282, 122, 50)
end

function Dolgan06()
    fallout.gsay_message(282, 123, 50)
end

function Dolgan07()
    fallout.gsay_reply(282, 124)
    fallout.giq_option(5, 282, 125, DolganEnd, 50)
end

function Train()
    fallout.game_time_advance(fallout.game_ticks(21600))
    fallout.set_local_var(1, 2)
    fallout.critter_mod_skill(fallout.dude_obj(), 4, 7)
    Dolgan05()
end

function DolganEnd()
end

function DolganCombat()
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
