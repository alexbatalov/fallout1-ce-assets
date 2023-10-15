local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Mathia01
local Mathia02
local Mathia03
local Mathia04
local Mathia05
local Mathia06
local Mathia07
local Mathia08
local Mathia08a
local Mathia08b
local Mathia08c
local Mathia08d
local Mathia08e
local Mathia09
local Mathia10
local Mathia11
local MathiaEnd

local hostile = 0
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
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
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if (fallout.map_var(20) == 1) and (fallout.local_var(5) == 0) then
            fallout.dialogue_system_enter()
        end
        if (fallout.map_var(19) == 1) and (fallout.local_var(6) == 0) then
            fallout.dialogue_system_enter()
        end
    end
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

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(939, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if (fallout.map_var(19) == 1) and (fallout.local_var(6) == 0) then
        fallout.set_local_var(6, 1)
        Mathia09()
    else
        if (fallout.map_var(20) == 1) and (fallout.local_var(5) == 0) then
            Mathia08()
        else
            if fallout.local_var(4) == 0 then
                fallout.set_local_var(4, 1)
                Mathia01()
            else
                Mathia06()
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(939, 100))
end

function Mathia01()
    fallout.gsay_reply(939, 101)
    fallout.giq_option(-3, 939, 102, Mathia05, 50)
    fallout.giq_option(4, 939, 103, Mathia02, 50)
    fallout.giq_option(4, 939, 104, MathiaEnd, 50)
end

function Mathia02()
    fallout.gsay_reply(939, 105)
    fallout.giq_option(4, 939, 106, Mathia03, 50)
    fallout.giq_option(4, 939, 107, Mathia04, 50)
    fallout.giq_option(4, 939, 108, MathiaEnd, 50)
end

function Mathia03()
    fallout.gsay_reply(939, 109)
    fallout.giq_option(4, 939, 110, Mathia04, 50)
    fallout.giq_option(4, 939, 111, MathiaEnd, 50)
end

function Mathia04()
    fallout.gsay_reply(939, 112)
    fallout.giq_option(4, 939, 113, MathiaEnd, 50)
end

function Mathia05()
    fallout.gsay_message(939, 114, 51)
end

function Mathia06()
    fallout.gsay_reply(939, 115)
    fallout.giq_option(-3, 939, 116, Mathia05, 50)
    fallout.giq_option(4, 939, 117, Mathia02, 50)
    fallout.giq_option(4, 939, 118, MathiaEnd, 50)
end

function Mathia07()
    fallout.gsay_reply(939, 119)
    fallout.giq_option(-3, 939, 120, Mathia11, 50)
    fallout.giq_option(-3, 939, 121, combat, 51)
    fallout.giq_option(4, 939, 122, Mathia11, 50)
    fallout.giq_option(4, 939, 123, combat, 51)
end

function Mathia08()
    fallout.gsay_reply(939, 124)
    fallout.giq_option(-3, 939, 125, Mathia05, 50)
    fallout.giq_option(4, 939, 126, Mathia08a, 50)
    fallout.giq_option(4, 939, 127, Mathia08b, 50)
    fallout.giq_option(4, 939, 128, Mathia08c, 50)
    fallout.giq_option(4, 939, 129, Mathia08d, 50)
    fallout.giq_option(4, 939, 130, Mathia08e, 50)
end

function Mathia08a()
    local v0 = 0
    fallout.set_local_var(5, 1)
    v0 = fallout.create_object_sid(143, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(939, 131, 50)
end

function Mathia08b()
    local v0 = 0
    fallout.set_local_var(5, 1)
    v0 = fallout.create_object_sid(13, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(939, 131, 50)
end

function Mathia08c()
    local v0 = 0
    fallout.set_local_var(5, 1)
    v0 = fallout.create_object_sid(16, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(939, 131, 50)
end

function Mathia08d()
    local v0 = 0
    fallout.set_local_var(5, 1)
    v0 = fallout.create_object_sid(235, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(939, 131, 50)
end

function Mathia08e()
    local v0 = 0
    fallout.set_local_var(5, 1)
    v0 = fallout.create_object_sid(116, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(939, 131, 50)
end

function Mathia09()
    fallout.gsay_reply(939, 132)
    fallout.giq_option(4, 939, 133, Mathia10, 50)
    fallout.giq_option(4, 939, 134, MathiaEnd, 50)
    fallout.giq_option(-3, 939, 116, Mathia05, 50)
end

function Mathia10()
    fallout.gsay_reply(939, 135)
    fallout.giq_option(4, 939, 134, MathiaEnd, 50)
end

function Mathia11()
    fallout.set_global_var(108, 5)
    fallout.world_map()
end

function MathiaEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
