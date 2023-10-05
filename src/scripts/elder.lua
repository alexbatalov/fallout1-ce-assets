local fallout = require("fallout")

local start
local do_dialogue
local elder01
local elder02
local elder03
local elder04
local elder05
local elder06
local elder07

local whim = 0
local reaction = 0
local in_combat = 0
local rndx = 0
local rndy = 0
local new_obj = 0
local new_obj_picked = 0

function start()
    local v0 = 0
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(2, 100))
        else
            if fallout.script_action() == 18 then
                fallout.set_global_var(6, 1)
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(2, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if (fallout.global_var(6) ~= 0) or (fallout.global_var(4) ~= 0) then
        fallout.set_global_var(0, 1)
        fallout.set_global_var(1, 1)
    end
    if fallout.global_var(0) then
        elder07()
    else
        if fallout.global_var(1) then
            elder06()
        else
            fallout.gsay_reply(2, 101)
            fallout.gsay_option(2, 102, elder01, 50)
            fallout.gsay_option(2, 103, elder02, 50)
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function elder01()
    fallout.dialogue_reaction(-1)
    fallout.gsay_reply(2, 104)
    fallout.gsay_option(2, 105, elder03, 50)
end

function elder02()
    fallout.dialogue_reaction(1)
    fallout.gsay_reply(2, 106)
    fallout.gsay_option(2, 107, elder03, 50)
end

function elder03()
    fallout.gsay_reply(2, 108)
    fallout.gsay_option(2, 109, elder05, 50)
    fallout.gsay_option(2, 110, elder04, 50)
end

function elder04()
    fallout.set_global_var(0, 1)
    fallout.set_global_var(1, 1)
    fallout.dialogue_reaction(1)
    fallout.gsay_reply(2, 111)
end

function elder05()
    local v0 = 0
    fallout.set_global_var(1, 1)
    fallout.dialogue_reaction(-1)
    fallout.gsay_reply(2, 112)
    v0 = fallout.create_object_sid(1, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(10, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(34, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(34, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
end

function elder06()
    fallout.gsay_message(2, 113, 50)
end

function elder07()
    fallout.dialogue_reaction(1)
    fallout.gsay_message(2, 114, 50)
end

local exports = {}
exports.start = start
return exports
