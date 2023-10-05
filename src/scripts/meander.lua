local fallout = require("fallout")

local start
local do_dialogue
local timeforwhat
local genericend
local genericcbt
local generic00
local generic01
local generic02
local generic03

local prev_tile = 0
local new_tile = 0
local loopcount = 0
local noevent = 0
local rndx = 0
local rndy = 0
local rndz = 0
local dist = 0
local curtime = 0
local prevtime = 0
local hostile = 0
local SET = 0
local MUTANTS = 0
local MAXLEASH = 9
local DAY = 0
local initialized = 0

function start()
    if not(initialized) then
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, 1)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 32)
        initialized = 1
    end
    curtime = DAY
    if prevtime ~= curtime then
        noevent = curtime
        prevtime = curtime
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(0), 0)
    end
    if fallout.script_action() == 22 then
        timeforwhat()
    else
        if fallout.script_action() == 11 then
            do_dialogue()
        else
            if fallout.script_action() == 4 then
                hostile = 1
            else
                if fallout.script_action() == 12 then
                    if hostile then
                        hostile = 0
                        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    else
                        loopcount = loopcount + 1
                        if loopcount > 40 then
                            loopcount = 0
                            if noevent == 0 then
                                noevent = 1
                                rndx = 5 + fallout.random(1, 10)
                                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(rndx), 0)
                            end
                        end
                    end
                else
                    if fallout.script_action() == 18 then
                        if fallout.source_obj() == fallout.dude_obj() then
                            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                                fallout.set_global_var(156, 1)
                                fallout.set_global_var(157, 0)
                            end
                            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                                fallout.set_global_var(157, 1)
                                fallout.set_global_var(156, 0)
                            end
                            fallout.set_global_var(160, fallout.global_var(160) + 1)
                            if (fallout.global_var(160) % 6) == 0 then
                                fallout.set_global_var(155, fallout.global_var(155) + 1)
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(84, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if hostile then
        generic01()
    else
        generic00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function timeforwhat()
    noevent = curtime
    rndy = fallout.random(1, 6)
    if rndy > 1 then
        dist = 2
    end
    if rndy > 5 then
        dist = 3
    end
    rndz = fallout.random(0, 5)
    prev_tile = fallout.tile_num(fallout.self_obj())
    new_tile = fallout.tile_num_in_direction(prev_tile, rndz, dist)
    if fallout.tile_distance(fallout.local_var(0), new_tile) < MAXLEASH then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
end

function genericend()
end

function genericcbt()
end

function generic00()
    rndx = fallout.random(1, 7)
    if rndx == 1 then
        fallout.gsay_message(84, 100, 50)
    end
    if rndx == 2 then
        fallout.gsay_message(84, 101, 50)
    end
    if rndx == 3 then
        fallout.gsay_message(84, 102, 50)
    end
    if rndx == 4 then
        fallout.gsay_message(84, 103, 50)
    end
    if rndx == 5 then
        fallout.gsay_message(84, 104, 50)
    end
    if rndx == 6 then
        generic02()
    end
    if rndx == 7 then
        generic03()
    end
end

function generic01()
    rndx = fallout.random(1, 4)
    if rndx == 1 then
        fallout.gsay_message(84, 105, 50)
    end
    if rndx == 2 then
        fallout.gsay_message(84, 106, 50)
    end
    if rndx == 3 then
        fallout.gsay_message(84, 107, 50)
    end
    if rndx == 4 then
        fallout.gsay_message(84, 108, 50)
    end
end

function generic02()
    if SET == 0 then
        rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.gsay_message(84, 109, 50)
        end
        if rndx == 2 then
            fallout.gsay_message(84, 110, 50)
        end
    else
        fallout.gsay_message(84, 111, 50)
    end
end

function generic03()
    if MUTANTS == 0 then
        rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.gsay_message(84, 112, 50)
        end
        if rndx == 2 then
            fallout.gsay_message(84, 113, 50)
        end
    else
        fallout.gsay_message(84, 114, 50)
    end
end

local exports = {}
exports.start = start
return exports
