local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local GenMercA00
local GenMercA01
local GenMercA02
local GenMercA03
local GenMercA04
local GenMercAEnd

local hostile = 0
local initialized = false
local scared = 0
local name_index = 0
local job_index = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
        name_index = 105 + fallout.global_var(335)
        job_index = 109 + fallout.global_var(335)
        hostile = fallout.global_var(334)
        fallout.set_global_var(335, fallout.global_var(335) + 1)
        initialized = true
    end
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 4 then
                pickup_p_proc()
            else
                if fallout.script_action() == 11 then
                    talk_p_proc()
                end
            end
        end
    end
end

function critter_p_proc()
    if scared and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8) then
        behaviour.flee_dude(1)
    else
        if hostile then
            hostile = 0
            scared = 1
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(334, 1)
        reputation.inc_good_critter()
    end
end

function pickup_p_proc()
    if scared == 0 then
        hostile = 1
        fallout.set_global_var(334, 1)
    end
end

function talk_p_proc()
    if reputation.has_rep_berserker() then
        fallout.set_global_var(156, 1)
        fallout.set_global_var(157, 0)
    end
    if scared then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        fallout.start_gdialog(752, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        GenMercA00()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function GenMercA00()
    fallout.gsay_reply(752, 100)
    fallout.giq_option(4, 752, 101, GenMercA01, 50)
    fallout.giq_option(4, 752, 102, GenMercA02, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 752, 103, GenMercA03, 51)
    end
    fallout.giq_option(-3, 752, 104, GenMercAEnd, 50)
    fallout.giq_option(4, 634, 103, GenMercAEnd, 50)
end

function GenMercA01()
    fallout.gsay_reply(752, name_index)
    fallout.giq_option(4, 752, 102, GenMercA02, 50)
    fallout.giq_option(4, 634, 100, GenMercAEnd, 50)
end

function GenMercA02()
    fallout.gsay_reply(752, job_index)
    fallout.giq_option(4, 752, 114, GenMercA04, 50)
    fallout.giq_option(4, 634, 100, GenMercAEnd, 50)
end

function GenMercA03()
    scared = 1
    fallout.gsay_message(752, 113, 51)
end

function GenMercA04()
    if reputation.has_rep_berserker() or (fallout.global_var(158) > 2) or (fallout.global_var(155) < -20) then
        fallout.gsay_message(752, 117, 51)
    else
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
            fallout.gsay_message(752, 116, 50)
        else
            fallout.gsay_message(752, 116, 50)
        end
    end
end

function GenMercAEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
