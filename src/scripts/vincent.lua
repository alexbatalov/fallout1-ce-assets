local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local check_status
local vincday
local vincnight
local vincent00
local vincent01
local vincent01n
local vincent02
local vincent02n
local vincent03
local vincent04
local vincent05

local hostile = 0
local initialized = false
local DISGUISED = 0
local ARMED = 0
local again = 0
local home_tile = 0
local sleep_tile = 0

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 47)
        home_tile = fallout.tile_num(fallout.self_obj())
        sleep_tile = 22284
    end
    if fallout.script_action() == 14 then
        if fallout.global_var(245) == 0 then
            fallout.set_global_var(245, 1)
        end
    else
        if fallout.script_action() == 21 then
            look_at_p_proc()
        else
            if fallout.script_action() == 4 then
                pickup_p_proc()
            else
                if fallout.script_action() == 11 then
                    check_status()
                    talk_p_proc()
                else
                    if fallout.script_action() == 22 then
                        vincent03()
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
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            check_status()
            if (ARMED == 1) or (DISGUISED == 0) then
                vincent02()
            else
                if fallout.local_var(5) == 0 then
                    talk_p_proc()
                end
            end
        else
            if time.is_day() then
                if fallout.local_var(6) ~= 0 then
                    fallout.set_local_var(6, 0)
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                else
                    if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                    end
                end
            else
                if fallout.local_var(6) ~= 0 then
                    if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), sleep_tile, 0)
                    end
                else
                    fallout.set_local_var(6, 1)
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), sleep_tile, 0)
                end
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    check_status()
    fallout.set_local_var(5, 1)
    if (ARMED == 1) or (DISGUISED == 0) then
        vincent02()
    else
        if fallout.tile_num(fallout.self_obj()) == sleep_tile then
            vincday()
        else
            vincnight()
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if time.is_day() then
        fallout.display_msg(fallout.message_str(679, 400))
    else
        fallout.display_msg(fallout.message_str(679, 200))
    end
end

function check_status()
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

function vincday()
    again = fallout.local_var(4)
    if again == 0 then
        vincent00()
    else
        if again == 1 then
            vincent01()
        else
            if again > 1 then
                vincent03()
            end
        end
    end
    if again < 2 then
        again = again + 1
    end
    fallout.set_local_var(4, again)
end

function vincnight()
    again = fallout.local_var(4)
    if again == 0 then
        vincent01n()
    else
        if again > 0 then
            vincent02n()
        end
    end
    if again < 2 then
        again = again + 1
    end
    fallout.set_local_var(4, again)
end

function vincent00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(679, 402), 2)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 1)
end

function vincent01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(679, 403), 2)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 1)
end

function vincent01n()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(679, 203), 2)
end

function vincent02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(679, 202), 2)
    combat()
end

function vincent02n()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(679, 204), 2)
end

function vincent03()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(679, 404), 2)
        combat()
    end
end

function vincent04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(679, 203), 2)
end

function vincent05()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(679, 204), 2)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
