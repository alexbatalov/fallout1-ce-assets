local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local supercbt
local superx
local super00

local hostile = false
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
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
    elseif script_action == 21 then
        look_at_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.start_gdialog(100, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(0) ~= 0 then
        super00()
    else
        fallout.set_local_var(0, 1)
        super00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.global_var(13) == 0 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        else
            if time.is_night() and (fallout.tile_num(fallout.self_obj()) ~= 24929) then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), 24929, 0)
            end
            if time.is_day() and (fallout.tile_num(fallout.self_obj()) ~= 25915) then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), 25915, 0)
            end
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(35, fallout.global_var(35) + 1)
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.display_msg(fallout.message_str(100, 100))
end

function supercbt()
    hostile = true
end

function superx()
    supercbt()
end

function super00()
    fallout.gsay_reply(100, 101)
    fallout.giq_option(3, 100, 102, superx, 50)
    fallout.giq_option(3, 100, 103, supercbt, 50)
    fallout.giq_option(-3, 100, 104, supercbt, 50)
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
