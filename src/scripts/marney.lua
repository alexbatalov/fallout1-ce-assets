local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local Marney00
local Marney01
local Marney02
local Marney03
local Marney04
local Marney05
local Marney06
local Marney07
local MarneyEnd

local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 46)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 34)
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
                    if fallout.script_action() == 11 then
                        talk_p_proc()
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.global_var(129) == 2 then
        fallout.kill_critter(fallout.self_obj(), 59)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        if time.is_night() then
            fallout.display_msg(fallout.message_str(270, 100))
        else
            fallout.display_msg(fallout.message_str(270, 101))
        end
    else
        if time.is_night() then
            fallout.display_msg(fallout.message_str(270, 102))
        else
            fallout.display_msg(fallout.message_str(270, 103))
        end
    end
end

function talk_p_proc()
    fallout.start_gdialog(270, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.set_local_var(0, 1)
    Marney00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Marney00()
    local v0 = 0
    v0 = fallout.get_critter_stat(fallout.dude_obj(), 7) - fallout.get_critter_stat(fallout.dude_obj(), 35)
    fallout.gsay_reply(270, 104)
    fallout.giq_option(-3, 270, 105, Marney01, 50)
    fallout.giq_option(4, 270, 125, MarneyEnd, 50)
    if v0 > 0 then
        fallout.giq_option(4, 270, 106, Marney01, 50)
    end
    if not(fallout.local_var(2)) then
        fallout.giq_option(5, 270, 107, Marney06, 50)
    end
end

function Marney01()
    fallout.gsay_reply(270, 108)
    fallout.giq_option(-3, 270, 109, Marney02, 50)
    fallout.giq_option(-3, 270, 110, Marney05, 50)
    fallout.giq_option(4, 270, 111, Marney02, 50)
    fallout.giq_option(4, 270, 112, Marney05, 50)
end

function Marney02()
    local v0 = 0
    fallout.gfade_out(600)
    fallout.gfade_in(600)
    v0 = fallout.get_critter_stat(fallout.dude_obj(), 7) - fallout.get_critter_stat(fallout.dude_obj(), 35)
    fallout.game_time_advance(fallout.game_ticks(60 * 20 * v0))
    fallout.critter_heal(fallout.dude_obj(), v0)
    fallout.gsay_message(270, 113, 50)
    if not(fallout.local_var(1)) then
        fallout.giq_option(4, 270, 114, Marney03, 50)
    end
    fallout.giq_option(4, 270, 115, MarneyEnd, 50)
end

function Marney03()
    fallout.gsay_reply(270, 116)
    fallout.giq_option(4, 270, 117, Marney04, 50)
    fallout.giq_option(4, 270, 118, Marney05, 50)
end

function Marney04()
    fallout.gfade_out(600)
    fallout.gfade_in(600)
    fallout.game_time_advance(fallout.game_ticks(18000))
    fallout.critter_mod_skill(fallout.dude_obj(), 6, 15)
    fallout.set_local_var(1, 1)
    fallout.gsay_message(270, 119, 50)
end

function Marney05()
    fallout.gsay_message(270, 120, 50)
end

function Marney06()
    fallout.gsay_reply(270, 121)
    fallout.giq_option(5, 270, 122, Marney07, 50)
    fallout.giq_option(5, 270, 123, Marney05, 50)
end

function Marney07()
    fallout.gfade_out(600)
    fallout.gfade_in(600)
    fallout.game_time_advance(fallout.game_ticks(25200))
    fallout.critter_mod_skill(fallout.dude_obj(), 7, 15)
    fallout.set_local_var(2, 1)
    fallout.gsay_message(270, 124, 50)
end

function MarneyEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
