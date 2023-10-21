local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local do_dialogue
local ghoulend
local ghoulcbt
local ghoul00a
local ghoul00b
local ghoul01
local ghoul02
local ghoul03
local ghoul03a
local ghoul05
local Critter_Action
local timetomove

local Hostile = 0
local init = 0
local maxleash = 9
local noevent = 0
local loopcount = 0
local new_tile = 0

local exit_line = 0

function start()
    if not(init) then
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, fallout.tile_num(fallout.self_obj()))
            fallout.set_local_var(5, 0)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 40)
        init = 1
    else
        if fallout.script_action() == 11 then
            if fallout.global_var(249) ~= 0 then
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            else
                do_dialogue()
            end
        else
            if fallout.script_action() == 21 then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(70, 100))
            else
                if fallout.script_action() == 4 then
                    Hostile = 1
                else
                    if fallout.script_action() == 12 then
                        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and fallout.global_var(249) then
                            Hostile = 1
                        end
                        Critter_Action()
                    else
                        if fallout.script_action() == 18 then
                            reputation.inc_evil_critter()
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(70, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) ~= 0 then
        ghoul02()
    end
    if time.is_night() then
        if fallout.local_var(1) >= 3 then
            ghoul00b()
        else
            fallout.set_local_var(4, 1)
            ghoul03()
        end
    else
        if fallout.local_var(1) >= 3 then
            ghoul01()
        else
            fallout.set_local_var(4, 1)
            ghoul03()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function ghoulend()
end

function ghoulcbt()
    Hostile = 1
end

function ghoul00a()
    fallout.gsay_reply(70, 111)
    fallout.giq_option(4, 70, 102, ghoulend, 50)
    fallout.giq_option(-3, 70, 103, ghoulend, 50)
end

function ghoul00b()
    fallout.gsay_message(70, 104, 50)
    ghoulend()
end

function ghoul01()
    fallout.gsay_reply(70, 105)
    fallout.giq_option(4, 70, 106, ghoulend, 50)
    fallout.giq_option(-3, 70, 107, ghoulend, 50)
end

function ghoul02()
    fallout.gsay_reply(70, 108)
    fallout.giq_option(4, 70, 109, ghoulend, 50)
    fallout.giq_option(-3, 70, 110, ghoulend, 50)
end

function ghoul03()
    fallout.gsay_reply(70, 101)
    fallout.giq_option(5, 70, 112, ghoul03a, 50)
    fallout.giq_option(4, 70, 113, ghoulend, 50)
    fallout.giq_option(-3, 70, 114, ghoulend, 50)
end

function ghoul03a()
    ghoul02()
end

function ghoul05()
    fallout.gsay_message(70, 116, 50)
end

function Critter_Action()
    if Hostile > 0 then
        Hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(5) ~= 0 then
            loopcount = loopcount + 1
            if loopcount > 40 then
                loopcount = 0
                if noevent == 0 then
                    noevent = 1
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(5, 13)), 0)
                end
            end
        end
    end
end

function timetomove()
    noevent = 0
    fallout.set_local_var(6, fallout.tile_num(fallout.self_obj()))
    new_tile = fallout.tile_num_in_direction(fallout.local_var(6), fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(7), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
end

local exports = {}
exports.start = start
return exports
