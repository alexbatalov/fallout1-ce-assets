local fallout = require("fallout")

local start
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local peter0
local peter1
local peter2
local peter3
local peter4
local peter4a
local peter5
local peter6
local peter7
local peter8
local peter9
local peter10
local peterend

local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 46)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 33)
        initialized = 1
        if fallout.global_var(129) == 2 then
            if fallout.random(0, 1) then
                fallout.kill_critter(fallout.self_obj(), 59)
            else
                fallout.kill_critter(fallout.self_obj(), 57)
            end
        end
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        end
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 11 then
            talk_p_proc()
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    if fallout.local_var(0) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(267, 100))
    end
end

function talk_p_proc()
    fallout.set_local_var(0, 1)
    fallout.script_overrides()
    if fallout.global_var(133) == 1 then
        peter9()
    else
        if fallout.global_var(133) == 2 then
            peter10()
        else
            if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800) then
                fallout.start_gdialog(267, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                peter0()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                peter8()
            end
        end
    end
end

function peter0()
    fallout.gsay_reply(267, 101)
    fallout.giq_option(-3, 267, 102, peter1, 50)
    fallout.giq_option(4, 267, 103, peterend, 50)
    fallout.giq_option(4, 267, 104, peter2, 50)
    fallout.giq_option(4, 267, 105, peter7, 50)
end

function peter1()
    fallout.gsay_message(267, 106, 50)
end

function peter2()
    fallout.gsay_reply(267, 107)
    fallout.giq_option(4, 267, 108, peter3, 50)
    fallout.giq_option(4, 267, 109, peter4, 50)
    fallout.giq_option(4, 267, 110, peter6, 50)
end

function peter3()
    fallout.gsay_message(267, 111, 50)
end

function peter4()
    fallout.gsay_reply(267, 112)
    fallout.giq_option(4, 267, 113, peter4a, 50)
    fallout.giq_option(4, 267, 114, peter5, 50)
end

function peter4a()
    fallout.set_global_var(133, 1)
end

function peter5()
    fallout.gsay_message(267, 115, 50)
end

function peter6()
    fallout.gsay_reply(267, 116)
    fallout.giq_option(4, 267, 117, peter4a, 50)
    fallout.giq_option(4, 267, 118, peter5, 50)
end

function peter7()
    fallout.gsay_message(267, 119, 50)
end

function peter8()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(267, 120), 0)
end

function peter9()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(267, 121), 0)
end

function peter10()
    local v0 = 0
    fallout.float_msg(fallout.self_obj(), fallout.message_str(267, 122), 0)
    if fallout.local_var(1) == 0 then
        fallout.set_local_var(1, 1)
        v0 = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
        v0 = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
        v0 = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    end
end

function peterend()
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
