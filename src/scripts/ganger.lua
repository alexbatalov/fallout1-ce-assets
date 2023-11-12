local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local ghoulend
local ghoulcbt
local ghoul00
local ghoul01
local ghoul02
local ghoul03
local ghoul04
local ghoul04a
local ghoul05
local ghoul06
local ghoul07
local ghoul08
local ghoul09
local ghoul10
local ghoul11
local ghoul12
local ghoul13

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 30)
        fallout.critter_add_trait(self_obj, 1, 5, 42)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.start_gdialog(64, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(0) ~= 0 then
        ghoul08()
    else
        fallout.set_local_var(0, 1)
        ghoul00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(64, 100))
end

function ghoulend()
end

function ghoulcbt()
    hostile = true
end

function ghoul00()
    fallout.gsay_reply(64, 101)
    fallout.giq_option(6, 64, 102, ghoul01, 50)
    fallout.giq_option(4, 64, 103, ghoul08, 50)
    fallout.giq_option(4, 64, 104, ghoul11, 50)
    fallout.giq_option(-3, 64, 105, ghoul12, 50)
end

function ghoul01()
    fallout.gsay_reply(64, 106)
    fallout.giq_option(6, 64, 107, ghoulend, 50)
    fallout.giq_option(6, 64, 108, ghoul02, 50)
    fallout.giq_option(6, 64, 109, ghoulcbt, 51)
end

function ghoul02()
    fallout.gsay_reply(64, 110)
    fallout.giq_option(5, 64, 111, ghoul04, 50)
    fallout.giq_option(4, 64, 112, ghoul05, 50)
end

function ghoul03()
    fallout.gsay_reply(64, 113)
    fallout.giq_option(8, 64, 114, ghoul05, 50)
end

function ghoul04()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        ghoul03()
    else
        ghoul04a()
    end
end

function ghoul04a()
    fallout.gsay_message(64, 115, 50)
    ghoulend()
end

function ghoul05()
    fallout.gsay_reply(64, 116)
    fallout.giq_option(5, 64, 117, ghoul06, 50)
    fallout.giq_option(5, 64, 118, ghoulend, 50)
end

function ghoul06()
    fallout.gsay_reply(64, 119)
    fallout.giq_option(5, 64, 120, ghoul07, 50)
    fallout.giq_option(5, 64, 121, ghoulend, 50)
end

function ghoul07()
    fallout.gsay_message(64, 122, 50)
    ghoulend()
end

function ghoul08()
    fallout.gsay_reply(64, 123)
    fallout.giq_option(4, 64, 124, ghoul09, 50)
    fallout.giq_option(4, 64, 125, ghoulend, 50)
    fallout.giq_option(-3, 64, 105, ghoul12, 50)
end

function ghoul09()
    fallout.gsay_reply(64, 126)
    fallout.giq_option(4, 64, 127, ghoul10, 50)
    fallout.giq_option(4, 64, 128, ghoulend, 50)
end

function ghoul10()
    fallout.gsay_reply(64, 129)
    ghoulcbt()
end

function ghoul11()
    fallout.gsay_message(64, 130, 50)
    ghoulend()
end

function ghoul12()
    fallout.gsay_message(64, 131, 50)
    ghoulcbt()
end

function ghoul13()
    fallout.gsay_message(64, 132, 50)
    ghoulend()
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
