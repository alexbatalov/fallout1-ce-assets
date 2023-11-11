local fallout = require("fallout")

local start
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local elder01
local elder02
local elder03
local elder04
local elder05
local elder06
local elder07

local PIDS <const> = {
    1,
    10,
    34,
    34,
}

function start()
    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function talk_p_proc()
    fallout.start_gdialog(2, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.global_var(6) ~= 0 or fallout.global_var(4) ~= 0 then
        fallout.set_global_var(0, 1)
        fallout.set_global_var(1, 1)
    end
    if fallout.global_var(0) ~= 0 then
        elder07()
    elseif fallout.global_var(1) ~= 0 then
        elder06()
    else
        fallout.gsay_reply(2, 101)
        fallout.gsay_option(2, 102, elder01, 50)
        fallout.gsay_option(2, 103, elder02, 50)
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    fallout.set_global_var(6, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(2, 100))
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
    fallout.set_global_var(1, 1)
    fallout.dialogue_reaction(-1)
    fallout.gsay_reply(2, 112)

    local dude_obj = fallout.dude_obj()
    for index = 1, #PIDS do
        local item_obj = fallout.create_object_sid(PIDS[index], 0, 0, -1)
        fallout.add_obj_to_inven(dude_obj, item_obj)
    end
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
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
