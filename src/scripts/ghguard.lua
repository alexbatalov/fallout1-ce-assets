local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local ghoulend
local ghoulcbt
local ghoul00
local ghoul01
local ghoul01a
local ghoul02
local ghoul03
local ghoul03a
local ghoul04
local ghoul05
local ghoul06
local critter_p_proc
local timetomove

local hostile = false
local initialized = false
local maxleash = 9
local noevent = false
local loopcount = 0
local new_tile = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, fallout.tile_num(self_obj))
            fallout.set_local_var(5, 0)
        end
        misc.set_team(self_obj, 30)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 or script_action == 3 then
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
    fallout.start_gdialog(72, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) ~= 0 then
        ghoul06()
    else
        if fallout.local_var(1) >= 2 then
            fallout.set_local_var(4, 1)
            ghoul01()
        else
            fallout.set_local_var(4, 1)
            ghoul00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(72, 100))
end

function ghoulend()
end

function ghoulcbt()
    hostile = true
end

function ghoul00()
    fallout.gsay_message(72, 101, 50)
    ghoulcbt()
end

function ghoul01()
    fallout.gsay_reply(72, 102)
    fallout.giq_option(6, 72, 103, ghoul01a, 50)
    fallout.giq_option(3, 72, 104, ghoulend, 50)
    fallout.giq_option(-3, 72, 105, ghoul00, 50)
end

function ghoul01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        ghoul02()
    else
        ghoul03()
    end
end

function ghoul02()
    fallout.gsay_reply(72, 106)
    fallout.giq_option(3, 72, 107, ghoulcbt, 50)
    fallout.giq_option(5, 72, 108, ghoulend, 50)
end

function ghoul03()
    fallout.gsay_reply(72, 109)
    fallout.giq_option(3, 72, 110, ghoul03a, 50)
    fallout.giq_option(3, 72, 111, ghoul04, 50)
end

function ghoul03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        ghoul05()
    else
        ghoul04()
    end
end

function ghoul04()
    fallout.gsay_message(72, 112, 50)
    ghoulend()
end

function ghoul05()
    fallout.gsay_reply(72, 113)
    fallout.giq_option(4, 72, 114, ghoulend, 50)
end

function ghoul06()
    fallout.gsay_message(72, 115, 50)
    ghoulend()
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(5) ~= 0 then
            loopcount = loopcount + 1
            if loopcount > 40 then
                loopcount = 0
                if not noevent then
                    noevent = true
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(5, 13)), 0)
                end
            end
        end
    end
end

function timetomove()
    noevent = false
    fallout.set_local_var(6, fallout.tile_num(fallout.self_obj()))
    new_tile = fallout.tile_num_in_direction(fallout.local_var(6), fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(7), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
