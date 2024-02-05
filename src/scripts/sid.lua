local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local Sid00

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.set_external_var("Sid_Ptr", self_obj)
        misc.set_team(self_obj, 37)
        fallout.critter_add_trait(self_obj, 1, 5, 4)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    Sid00()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(602, 100))
end

function Sid00()
    local self_obj = fallout.self_obj()
    local rnd = fallout.random(1, 7)
    if rnd == 1 then
        local game_time_hour = fallout.game_time_hour()
        if game_time_hour >= 800 and game_time_hour < 1200 then
            fallout.float_msg(self_obj, fallout.message_str(602, 101), 8)
        elseif game_time_hour >= 1200 and game_time_hour < 1600 then
            if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                fallout.float_msg(self_obj, fallout.message_str(602, 102), 8)
            else
                fallout.float_msg(self_obj, fallout.message_str(602, 103), 8)
            end
        else
            fallout.float_msg(self_obj, fallout.message_str(602, 104), 8)
        end
    elseif rnd == 2 then
        fallout.float_msg(self_obj, fallout.message_str(602, 105), 8)
    elseif rnd == 3 then
        fallout.float_msg(self_obj, fallout.message_str(602, 106), 8)
        fallout.float_msg(fallout.external_var("Beth_Ptr"), fallout.message_str(617, 374), 2)
    elseif rnd == 4 then
        fallout.float_msg(self_obj, fallout.message_str(602, 107), 8)
        fallout.float_msg(fallout.external_var("Beth_Ptr"), fallout.message_str(617, 375), 2)
    elseif rnd == 5 then
        fallout.float_msg(self_obj, fallout.message_str(602, 108), 8)
        fallout.float_msg(fallout.external_var("Beth_Ptr"), fallout.message_str(617, 376), 2)
    elseif rnd == 6 then
        fallout.float_msg(self_obj, fallout.message_str(602, 109), 8)
        fallout.float_msg(fallout.external_var("Beth_Ptr"), fallout.message_str(617, 377), 2)
    else
        fallout.float_msg(self_obj, fallout.message_str(602, 110), 8)
        fallout.float_msg(fallout.external_var("Beth_Ptr"), fallout.message_str(617, 378), 2)
        fallout.float_msg(self_obj, fallout.message_str(602, 111), 8)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
