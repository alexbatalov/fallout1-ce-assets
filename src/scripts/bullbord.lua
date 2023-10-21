local fallout = require("fallout")

local start
local use_p_proc
local look_at_p_proc
local talk_p_proc
local bull01
local bull02
local bull03
local bull04

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function use_p_proc()
    fallout.dialogue_system_enter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(839, 100))
end

function talk_p_proc()
    fallout.set_map_var(43, 1)
    fallout.start_gdialog(839, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    bull01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function bull01()
    fallout.gsay_reply(839, 101)
    fallout.giq_option(0, 839, 105, bull02, 50)
end

function bull02()
    fallout.gsay_reply(839, 102)
    fallout.giq_option(0, 839, 105, bull03, 50)
end

function bull03()
    fallout.gsay_reply(839, 103)
    fallout.giq_option(0, 839, 105, bull04, 50)
end

function bull04()
    fallout.gsay_message(839, 104, 50)
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
