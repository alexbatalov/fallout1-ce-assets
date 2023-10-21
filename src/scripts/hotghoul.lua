local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local do_dialogue
local genericcbt
local generic00
local generic02
local generic03
local Critter_Action

local Hostile = 0
local init = 0
local rndx = 0

function start()
    if not(init) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 41)
        init = 1
    else
        if fallout.script_action() == 11 then
            if fallout.global_var(249) ~= 0 then
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            else
                do_dialogue()
            end
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
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

function do_dialogue()
    generic00()
end

function genericcbt()
end

function generic00()
    rndx = fallout.random(1, 7)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 100), 7)
    end
    if rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 101), 7)
    end
    if rndx == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 102), 7)
    end
    if rndx == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 103), 7)
    end
    if rndx == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 104), 7)
    end
    if rndx == 6 then
        generic02()
    end
    if rndx == 7 then
        generic03()
    end
end

function generic02()
    if fallout.global_var(553) ~= 0 then
        rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 109), 7)
        end
        if rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 110), 7)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 111), 7)
    end
end

function generic03()
    if fallout.global_var(29) == 2 then
        rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 112), 7)
        end
        if rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 113), 7)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 114), 7)
    end
end

function Critter_Action()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(249) ~= 0 then
            fallout.set_local_var(0, 1)
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.map_var(5) ~= 0 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 103), 7)
                fallout.set_local_var(0, 1)
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            else
                if fallout.local_var(0) > 0 then
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
