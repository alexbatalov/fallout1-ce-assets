local fallout = require("fallout")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local Amber0
local Amber1
local Amber2
local Amber3
local Amber3a
local Amber4
local Amber5
local Amber6
local Amber7
local Amber8
local Amber9
local Amber10
local Amber11
local Amber12
local Amber13
local Amber14
local Amber15
local Amber16
local Amber17
local Amber18
local AmberEnd

local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 46)
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
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(272, 100))
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.global_var(132) == 1 then
        Amber18()
    else
        if time.is_day() then
            Amber0()
        else
            fallout.set_local_var(0, fallout.local_var(0) + 1)
            fallout.start_gdialog(272, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Amber1()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function Amber0()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(272, 101), 0)
end

function Amber1()
    fallout.gsay_reply(272, 102)
    fallout.giq_option(4, 272, 103, Amber2, 50)
    fallout.giq_option(4, 272, 104, Amber3, 50)
    fallout.giq_option(7, 272, 105, Amber17, 50)
end

function Amber2()
    fallout.gsay_message(272, 106, 50)
end

function Amber3()
    fallout.gsay_reply(272, 107)
    if not(fallout.local_var(1)) then
        fallout.giq_option(4, 272, 108, Amber4, 50)
    end
    fallout.giq_option(4, 272, 109, AmberEnd, 50)
    if fallout.local_var(2) == 0 then
        fallout.giq_option(4, 272, 110, Amber3a, 50)
    end
    fallout.giq_option(5, 272, 111, Amber16, 50)
end

function Amber3a()
    if fallout.local_var(0) < 6 then
        Amber9()
    else
        if fallout.local_var(0) == 6 then
            Amber10()
        else
            Amber15()
        end
    end
end

function Amber4()
    fallout.gsay_reply(272, 112)
    fallout.giq_option(4, 272, 113, Amber5, 50)
    fallout.giq_option(4, 272, 114, Amber8, 50)
    fallout.giq_option(5, 272, 115, AmberEnd, 50)
end

function Amber5()
    fallout.gsay_reply(272, 116)
    fallout.giq_option(4, 272, 117, Amber6, 50)
    fallout.giq_option(4, 272, 118, Amber7, 50)
end

function Amber6()
    local v0 = 0
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    fallout.gsay_message(272, 119, 50)
    fallout.gfade_out(800)
    fallout.gfade_in(800)
    v0 = 3600 * 9
    fallout.game_time_advance(fallout.game_ticks(v0))
    fallout.critter_mod_skill(fallout.dude_obj(), 17, 15)
    fallout.gsay_message(272, 120, 50)
end

function Amber7()
    fallout.gsay_message(272, 121, 50)
end

function Amber8()
    local v0 = 0
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    fallout.gsay_message(272, 122, 50)
    fallout.gfade_out(800)
    fallout.gfade_in(800)
    v0 = 3600 * 7
    fallout.game_time_advance(fallout.game_ticks(v0))
    fallout.critter_mod_skill(fallout.dude_obj(), 17, 15)
    fallout.gsay_message(272, 123, 50)
end

function Amber9()
    fallout.gsay_message(272, 124, 50)
end

function Amber10()
    fallout.set_local_var(2, fallout.local_var(2) + 1)
    fallout.gsay_reply(272, 125)
    fallout.giq_option(4, 272, 126, Amber11, 50)
    fallout.giq_option(4, 272, 127, Amber12, 50)
    fallout.giq_option(4, 272, 128, Amber13, 50)
    fallout.giq_option(4, 272, 129, Amber14, 50)
end

function Amber11()
    local v0 = 0
    fallout.gsay_message(272, 130, 50)
    v0 = 3600 * 10
    fallout.gfade_out(800)
    fallout.gfade_in(800)
    fallout.game_time_advance(fallout.game_ticks(v0))
    fallout.critter_mod_skill(fallout.dude_obj(), 8, 12)
    fallout.critter_mod_skill(fallout.dude_obj(), 9, 10)
    fallout.critter_mod_skill(fallout.dude_obj(), 10, 8)
    fallout.critter_mod_skill(fallout.dude_obj(), 11, 8)
    fallout.gsay_message(272, 131, 50)
end

function Amber12()
    local v0 = 0
    fallout.gsay_message(272, 132, 50)
    v0 = 3600 * 10
    fallout.gfade_out(800)
    fallout.gfade_in(800)
    fallout.game_time_advance(fallout.game_ticks(v0))
    fallout.critter_mod_skill(fallout.dude_obj(), 3, 10)
    fallout.critter_mod_skill(fallout.dude_obj(), 0, 8)
    fallout.critter_mod_skill(fallout.dude_obj(), 5, 8)
    fallout.critter_mod_skill(fallout.dude_obj(), 4, 6)
    fallout.gsay_message(272, 133, 50)
end

function Amber13()
    local v0 = 0
    fallout.gsay_message(272, 134, 50)
    v0 = 3600 * 10
    fallout.gfade_out(800)
    fallout.gfade_in(800)
    fallout.game_time_advance(fallout.game_ticks(v0))
    fallout.critter_mod_skill(fallout.dude_obj(), 17, 10)
    fallout.critter_mod_skill(fallout.dude_obj(), 8, 8)
    fallout.critter_mod_skill(fallout.dude_obj(), 5, 8)
    fallout.critter_mod_skill(fallout.dude_obj(), 11, 6)
    fallout.gsay_message(272, 135, 50)
end

function Amber14()
    local v0 = 0
    fallout.gsay_message(272, 136, 50)
    v0 = 3600 * 10
    fallout.gfade_out(800)
    fallout.gfade_in(800)
    fallout.game_time_advance(fallout.game_ticks(v0))
    fallout.critter_mod_skill(fallout.dude_obj(), 15, 10)
    fallout.critter_mod_skill(fallout.dude_obj(), 14, 8)
    fallout.critter_mod_skill(fallout.dude_obj(), 16, 8)
    fallout.critter_mod_skill(fallout.dude_obj(), 4, 6)
    fallout.gsay_message(272, 137, 50)
end

function Amber15()
    fallout.gsay_message(272, 138, 50)
end

function Amber16()
    fallout.gsay_message(272, 139, 50)
end

function Amber17()
    fallout.gsay_reply(272, 140)
    if fallout.local_var(2) == 0 then
        fallout.giq_option(7, 272, 141, Amber10, 50)
    end
    fallout.giq_option(7, 272, 142, AmberEnd, 50)
    if not(fallout.local_var(1)) then
        fallout.giq_option(6, 272, 143, Amber4, 50)
    end
end

function Amber18()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(272, 144), 0)
end

function AmberEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
