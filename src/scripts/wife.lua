local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local Wife01
local Wife02
local Wife03
local Wife00n
local WifeEnd
local critter_p_proc
local talk_p_proc
local pickup_p_proc
local destroy_p_proc
local damage_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 2)
        misc.set_ai(self_obj, 6)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    end
end

function Wife01()
    fallout.gsay_reply(119, 100)
    fallout.giq_option(4, 119, 101, Wife02, 50)
    fallout.giq_option(4, 119, 107, WifeEnd, 50)
    fallout.giq_option(-3, 119, 102, Wife03, 50)
end

function Wife02()
    fallout.gsay_message(119, 103, 50)
end

function Wife03()
    fallout.gsay_message(119, 104, 50)
end

function Wife00n()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(119, 105), 8)
end

function WifeEnd()
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if fallout.map_var(2) == 1 then
        fallout.set_local_var(0, fallout.local_var(0) + 1)
        fallout.set_map_var(2, 0)
        if fallout.local_var(0) < 3 then
            fallout.float_msg(self_obj, fallout.message_str(129, 308), 2)
        else
            hostile = true
        end
    end
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        if fallout.global_var(246) == 1 then
            hostile = true
        end
    end
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
end

function talk_p_proc()
    if time.is_night() then
        Wife00n()
    else
        fallout.start_gdialog(119, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Wife01()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function pickup_p_proc()
    hostile = true
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
    reputation.inc_good_critter()
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.talk_p_proc = talk_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
return exports
