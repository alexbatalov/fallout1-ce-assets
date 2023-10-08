local fallout = require("fallout")
local reaction = require("lib.reaction")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local Sid00

local hostile = 0
local Only_Once = 1

local exit_line = 0

function start()
    if Only_Once then
        fallout.set_external_var("Sid_Ptr", fallout.self_obj())
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 37)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 4)
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
    reaction.get_reaction()
    Sid00()
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

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(602, 100))
end

function Sid00()
    local v0 = 0
    v0 = fallout.random(1, 7)
    if v0 == 1 then
        if (fallout.game_time_hour() >= 800) and (fallout.game_time_hour() < 1200) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 101), 8)
        else
            if (fallout.game_time_hour() >= 1200) and (fallout.game_time_hour() < 1600) then
                if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 102), 8)
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 103), 8)
                end
            else
                fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 104), 8)
            end
        end
    else
        if v0 == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 105), 8)
        else
            if v0 == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 106), 8)
                fallout.float_msg(fallout.external_var("Beth_Ptr"), fallout.message_str(617, 374), 2)
            else
                if v0 == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 107), 8)
                    fallout.float_msg(fallout.external_var("Beth_Ptr"), fallout.message_str(617, 375), 2)
                else
                    if v0 == 5 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 108), 8)
                        fallout.float_msg(fallout.external_var("Beth_Ptr"), fallout.message_str(617, 376), 2)
                    else
                        if v0 == 6 then
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 109), 8)
                            fallout.float_msg(fallout.external_var("Beth_Ptr"), fallout.message_str(617, 377), 2)
                        else
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 110), 8)
                            fallout.float_msg(fallout.external_var("Beth_Ptr"), fallout.message_str(617, 378), 2)
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(602, 111), 8)
                        end
                    end
                end
            end
        end
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
