local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local zamin
local goto00

local hostile = 0
local initialized = false
local DISGUISED = 0
local ARMED = 0
local rndx = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    zamin()
    if (DISGUISED == 1) and (ARMED == 0) then
        goto00()
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
end

function zamin()
    DISGUISED = 0
    ARMED = 0
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        ARMED = 1
    end
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.metarule(16, 0) > 1 then
            DISGUISED = 0
        else
            DISGUISED = 1
        end
    end
end

function goto00()
    rndx = fallout.random(1, 3)
    if rndx == 3 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(711, 106), 2)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(711, 107), 2)
        end
    else
        if rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(711, 105), 2)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(711, 108), 2)
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
