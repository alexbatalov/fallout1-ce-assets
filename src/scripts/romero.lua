local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local destroy_p_proc
local look_at_p_proc
local description_p_proc
local talk_p_proc
local show_true_name
local show_false_name
local Romero00
local Romero01
local Romero02
local Romero03
local Romero04
local Romero05
local Romero06
local Romero07
local Romero08
local Romero09
local Romero10
local Romero11
local Romero12
local Romero13
local Romero14
local Romero15
local RomeroCombat
local RomeroEnd
local GiveLocket

local initialized = false

local damage_p_proc

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 47)
        fallout.critter_add_trait(self_obj, 1, 5, 27)
        initialized = true
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
        reputation.inc_good_critter()
    end
end

function look_at_p_proc()
    description_p_proc()
end

function description_p_proc()
    if fallout.global_var(613) == 9101 or fallout.global_var(613) == 2 then
        show_true_name()
    elseif fallout.get_critter_stat(fallout.dude_obj(), 6) > 6 or fallout.get_critter_stat(fallout.dude_obj(), 4) > 6 then
        show_true_name()
    elseif fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
        show_false_name()
    elseif fallout.random(0, 1) ~= 0 then
        show_true_name()
    else
        show_false_name()
    end
end

function talk_p_proc()
    if fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
        fallout.display_msg(fallout.message_str(766, 175))
    else
        fallout.start_gdialog(285, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        fallout.set_local_var(0, 1)
        if fallout.global_var(127) == 3 then
            Romero15()
        else
            if time.is_night() then
                Romero06()
            else
                if fallout.global_var(127) == 2 then
                    Romero13()
                else
                    if fallout.global_var(135) == 2 then
                        if fallout.local_var(1) == 0 then
                            Romero07()
                        else
                            Romero14()
                        end
                    else
                        Romero00()
                    end
                end
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function show_true_name()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        fallout.display_msg(fallout.message_str(285, 100))
    else
        fallout.display_msg(fallout.message_str(285, 103))
    end
end

function show_false_name()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(285, fallout.random(104, 110)))
    fallout.script_overrides()
end

function Romero00()
    fallout.gsay_reply(285, 111)
    fallout.giq_option(4, 285, 112, Romero01, 50)
    fallout.giq_option(4, 285, 113, RomeroCombat, 50)
    fallout.giq_option(4, 285, 114, Romero03, 50)
    fallout.giq_option(4, 285, 115, RomeroEnd, 50)
end

function Romero01()
    fallout.gsay_reply(285, 116)
    fallout.giq_option(4, 285, 117, Romero02, 50)
    fallout.giq_option(4, 285, 118, Romero03, 50)
    fallout.giq_option(4, 285, 119, Romero03, 50)
    fallout.giq_option(4, 285, 120, RomeroCombat, 50)
end

function Romero02()
    fallout.gsay_message(285, 121, 50)
end

function Romero03()
    fallout.gsay_reply(285, 122)
    fallout.giq_option(4, 285, 123, Romero04, 50)
    fallout.giq_option(4, 285, 124, RomeroCombat, 50)
    fallout.giq_option(4, 285, 125, RomeroEnd, 50)
end

function Romero04()
    fallout.gsay_reply(285, 126)
    fallout.giq_option(4, 285, 127, Romero05, 50)
    fallout.giq_option(4, 285, 128, RomeroEnd, 50)
end

function Romero05()
    fallout.gsay_message(285, 129, 50)
end

function Romero06()
    fallout.gsay_message(285, 130, 50)
end

function Romero07()
    fallout.set_local_var(1, 1)
    fallout.gsay_reply(285, 131)
    fallout.giq_option(4, 285, 132, Romero08, 50)
    fallout.giq_option(4, 285, 133, Romero09, 50)
    fallout.giq_option(4, 285, 134, Romero11, 50)
end

function Romero08()
    fallout.gsay_message(285, 135, 50)
    GiveLocket()
end

function Romero09()
    fallout.gsay_reply(285, 136)
    fallout.giq_option(4, 285, 137, Romero10, 50)
    fallout.giq_option(4, 285, 138, Romero12, 50)
    fallout.giq_option(4, 285, 139, Romero11, 50)
end

function Romero10()
    fallout.gsay_reply(285, 140)
    fallout.giq_option(4, 285, 141, GiveLocket, 50)
    fallout.giq_option(4, 285, 142, Romero11, 50)
end

function Romero11()
    fallout.gsay_message(285, 143, 50)
end

function Romero12()
    fallout.gsay_reply(285, 144)
    fallout.giq_option(4, 285, 145, Romero11, 50)
    fallout.giq_option(4, 285, 146, Romero08, 50)
end

function Romero13()
    fallout.gsay_message(285, 147, 50)
    fallout.set_global_var(127, 3)
end

function Romero14()
    fallout.gsay_message(285, 148, 50)
end

function Romero15()
    fallout.gsay_message(285, 149, 50)
end

function RomeroCombat()
    fallout.set_global_var(253, 1)
    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
end

function RomeroEnd()
end

function GiveLocket()
    fallout.set_global_var(127, 1)
    local item_obj = fallout.create_object_sid(99, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
    end
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
return exports
