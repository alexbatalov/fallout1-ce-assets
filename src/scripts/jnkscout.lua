local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local Scout01
local Scout02
local Scout03
local Scout04
local Scout05
local ScoutEnd

local hostile = false

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        -- FIXME: `hostile` is usually reset here.
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
    end
end

function look_at_p_proc()
    fallout.display_msg(fallout.message_str(437, 100))
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.start_gdialog(437, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Scout01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Scout01()
    fallout.gsay_reply(437, 101)
    Scout02()
end

function Scout02()
    fallout.giq_option(4, 437, 102, Scout03, 50)
    fallout.giq_option(4, 437, 103, Scout04, 50)
    fallout.giq_option(4, 437, 104, Scout05, 50)
    fallout.giq_option(4, 437, 105, ScoutEnd, 50)
    fallout.giq_option(-3, 437, 106, ScoutEnd, 50)
end

function Scout03()
    fallout.gsay_reply(437, 107)
    Scout02()
end

function Scout04()
    fallout.gsay_reply(437, 108)
    Scout02()
end

function Scout05()
    fallout.gsay_reply(437, 109)
    Scout02()
end

function ScoutEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
