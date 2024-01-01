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
local Jasmine00
local Jasmine01
local Jasmine02
local Jasmine03
local Jasmine04
local Jasmine05
local Jasmine06
local Jasmine07
local Jasmine08
local Jasmine09
local Jasmine10
local Jasmine11
local Jasmine12
local Jasmine13
local Jasmine14
local Jasmine15
local Jasmine16
local Jasmine17
local JasmineEnd

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 39)
        fallout.critter_add_trait(self_obj, 1, 5, 52)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function combat()
    hostile = true
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.map_var(1) == 1 then
        Jasmine01()
    elseif fallout.global_var(107) == 0 then
        Jasmine02()
    elseif fallout.global_var(107) == 1 and fallout.local_var(6) == 0 then
        fallout.start_gdialog(592, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Jasmine03()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.global_var(107) == 1 then
        Jasmine05()
    elseif fallout.map_var(3) == 1 and fallout.local_var(5) == 0 then
        fallout.start_gdialog(592, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Jasmine06()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        Jasmine07()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(592, 100))
end

function Jasmine00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 102), 2)
    combat()
end

function Jasmine01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 103), 2)
end

function Jasmine02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 104), 2)
end

function Jasmine03()
    local item_obj
    item_obj = fallout.create_object_sid(84, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    item_obj = fallout.create_object_sid(79, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), item_obj, 2)
    item_obj = fallout.create_object_sid(106, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(592, 105)
    fallout.giq_option(4, 592, 106, Jasmine08, 50)
    fallout.giq_option(4, 592, 107, Jasmine09, 50)
    fallout.giq_option(4, 592, 109, Jasmine11, 50)
    fallout.giq_option(4, 592, 110, Jasmine12, 50)
    fallout.giq_option(4, 592, 111, Jasmine13, 50)
    fallout.giq_option(-3, 592, 112, Jasmine14, 50)
end

function Jasmine04()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 113), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 114), 2)
    end
end

function Jasmine05()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 117), 2)
end

function Jasmine06()
    fallout.set_local_var(5, 1)
    fallout.item_caps_adjust(fallout.dude_obj(), 3000)
    local item_obj = fallout.create_object_sid(77, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(592, 118, 50)
    else
        fallout.gsay_message(592, 119, 50)
    end
    fallout.gsay_message(592, 121, 50)
    fallout.gsay_message(592, 135, 50)
end

function Jasmine07()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 122), 2)
end

function Jasmine08()
    fallout.gsay_message(592, 123, 50)
end

function Jasmine09()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(592, 124, 50)
    else
        fallout.gsay_message(592, 134, 50)
    end
end

function Jasmine10()
    fallout.gsay_message(592, 125, 50)
end

function Jasmine11()
    fallout.gsay_message(592, 126, 50)
end

function Jasmine12()
    fallout.gsay_message(592, 127, 50)
end

function Jasmine13()
    fallout.gsay_message(592, 128, 50)
end

function Jasmine14()
    fallout.gsay_message(592, 129, 50)
end

function Jasmine15()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 130), 2)
end

function Jasmine16()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 131), 2)
end

function Jasmine17()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(592, 132), 2)
end

function JasmineEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
