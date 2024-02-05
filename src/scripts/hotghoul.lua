local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local genericcbt
local generic00
local generic02
local generic03
local critter_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 30)
        misc.set_ai(self_obj, 41)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
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
    if fallout.global_var(249) ~= 0 then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        generic00()
    end
end

function genericcbt()
end

function generic00()
    local rndx = fallout.random(1, 7)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 100), 7)
    elseif rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 101), 7)
    elseif rndx == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 102), 7)
    elseif rndx == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 103), 7)
    elseif rndx == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 104), 7)
    elseif rndx == 6 then
        generic02()
    elseif rndx == 7 then
        generic03()
    end
end

function generic02()
    if fallout.global_var(553) ~= 0 then
        local rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 109), 7)
        elseif rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 110), 7)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 111), 7)
    end
end

function generic03()
    if fallout.global_var(29) == 2 then
        local rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 112), 7)
        elseif rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 113), 7)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 114), 7)
    end
end

function critter_p_proc()
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

function destroy_p_proc()
    reputation.inc_evil_critter()
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
