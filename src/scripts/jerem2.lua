local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local jeremend
local jeremcbt
local jeremret

local hostile = false
local initialized = false
local Weapons = 0
local disguised = false
local moving = true
local home_tile = 0

function start()
    if fallout.local_var(0) == 0 then
        fallout.set_local_var(0, 1)
        fallout.set_local_var(1, 0)
        fallout.set_local_var(2, 4)
        fallout.set_local_var(3, 16912)
    end
    if not initialized then
        home_tile = 16912
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 69)
        if fallout.global_var(233) == 1 then
            fallout.set_obj_visibility(self_obj, true)
            moving = false
        elseif fallout.global_var(232) == 0 then
            fallout.set_obj_visibility(self_obj, true)
            moving = false
            fallout.add_timer_event(self_obj, fallout.game_ticks(300), 1)
        end
        initialized = true
    end
    if fallout.global_var(233) ~= 1 then
        local script_action = fallout.script_action()
        if script_action == 11 then
            talk_p_proc()
        elseif script_action == 22 then
            timed_event_p_proc()
        elseif script_action == 4 then
            pickup_p_proc()
        elseif script_action == 12 then
            critter_p_proc()
        elseif script_action == 21 then
            look_at_p_proc()
        elseif script_action == 18 then
            destroy_p_proc()
        end
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        if misc.party_member_count() > 1 then
            disguised = false
        else
            disguised = true
        end
    end
    if fallout.global_var(231) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(672, 187), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(672, 120), 2)
    end
    jeremcbt()
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if moving then
        if fallout.tile_num(self_obj) == fallout.local_var(3) then
            if fallout.local_var(1) ~= 0 then
                fallout.set_local_var(2, fallout.local_var(2) + 1)
            else
                fallout.set_local_var(2, fallout.local_var(2) - 1)
            end
            if fallout.local_var(2) > 4 then
                moving = false
                fallout.set_local_var(1, 0)
                fallout.set_local_var(2, 4)
                fallout.set_obj_visibility(self_obj, true)
                fallout.set_global_var(232, 0)
                fallout.add_timer_event(self_obj, fallout.game_ticks(300), 1)
            else
                if fallout.local_var(2) < 0 then
                    moving = false
                    fallout.set_local_var(1, 1)
                    fallout.set_local_var(2, 0)
                    fallout.add_timer_event(self_obj, fallout.game_ticks(300), 2)
                end
            end
            if fallout.local_var(2) == 0 then
                fallout.set_local_var(3, 23689)
            elseif fallout.local_var(2) == 1 then
                fallout.set_local_var(3, 22900)
            elseif fallout.local_var(2) == 2 then
                fallout.set_local_var(3, 22312)
            elseif fallout.local_var(2) == 3 then
                fallout.set_local_var(3, 19512)
            elseif fallout.local_var(2) == 4 then
                fallout.set_local_var(3, 16912)
            end
        else
            fallout.animate_move_obj_to_tile(self_obj, fallout.local_var(3), 0)
        end
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            disguised = false
            if misc.is_wearing_coc_robe(dude_obj) then
                if misc.party_member_count() > 1 then
                    disguised = false
                else
                    disguised = true
                end
            end
            if not disguised then
                fallout.dialogue_system_enter()
            end
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(233, 1)
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(672, 100))
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        moving = true
        fallout.set_global_var(232, 1)
        fallout.move_to(fallout.self_obj(), home_tile, 0)
        fallout.set_local_var(1, 0)
        fallout.set_local_var(2, 4)
        fallout.set_local_var(3, 16912)
        fallout.set_obj_visibility(fallout.self_obj(), false)
    elseif event == 2 then
        moving = true
    end
end

function jeremend()
end

function jeremcbt()
    hostile = true
end

function jeremret()
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
