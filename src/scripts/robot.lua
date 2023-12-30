local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local look_at_p_proc
local destroy_p_proc
local robot00
local robot01
local robot02
local robotend
local robotcbt

local hostile = false
local initialized = false
local disguised = false
local again = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 55)
        fallout.critter_add_trait(self_obj, 1, 5, 71)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.set_local_var(3, 1)
    reaction.get_reaction()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.metarule(16, 0) > 1 then
            disguised = false
        else
            disguised = true
        end
    end
    if disguised then
        if fallout.local_var(1) > 1 then
            robot00()
        else
            robot02()
        end
    else
        robot01()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        disguised = false
        if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
            if fallout.metarule(16, 0) > 1 then
                disguised = false
            else
                disguised = true
            end
        end
        if not disguised and not again then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
                again = true
                fallout.dialogue_system_enter()
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
end

function robot00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 100), 2)
end

function robot01()
    local rndx = fallout.random(1, 4)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 101), 2)
    elseif rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 102), 2)
    elseif rndx == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 103), 2)
    elseif rndx == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 104), 2)
    end
    robotcbt()
end

function robot02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(530, 105), 2)
    robotcbt()
end

function robotend()
end

function robotcbt()
    hostile = true
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
