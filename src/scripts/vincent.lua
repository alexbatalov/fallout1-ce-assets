local fallout = require("fallout")
local misc = require("lib.misc")
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

local hostile = false
local initialized = false
local disguised = false
local armed = false
local home_tile = 0
local sleep_tile = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 47)
        home_tile = fallout.tile_num(self_obj)
        sleep_tile = 22284
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 14 then
        if fallout.global_var(245) == 0 then
            fallout.set_global_var(245, 1)
        end
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        check_status()
        talk_p_proc()
    elseif script_action == 22 then
        vincent03()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function combat()
    hostile = true
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            check_status()
            if armed or not disguised then
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
                    fallout.animate_move_obj_to_tile(self_obj, home_tile, 0)
                else
                    if fallout.tile_num(self_obj) ~= home_tile then
                        fallout.animate_move_obj_to_tile(self_obj, home_tile, 0)
                    end
                end
            else
                if fallout.local_var(6) ~= 0 then
                    if fallout.tile_num(self_obj) ~= sleep_tile then
                        fallout.animate_move_obj_to_tile(self_obj, sleep_tile, 0)
                    end
                else
                    fallout.set_local_var(6, 1)
                    fallout.animate_move_obj_to_tile(self_obj, sleep_tile, 0)
                end
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    check_status()
    fallout.set_local_var(5, 1)
    if armed or not disguised then
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
    disguised = false
    armed = false
    if misc.is_armed(fallout.dude_obj()) then
        armed = true
    end
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        if misc.party_member_count() > 1 then
            disguised = false
        else
            disguised = true
        end
    end
end

function vincday()
    local again = fallout.local_var(4)
    if again == 0 then
        vincent00()
    elseif again == 1 then
        vincent01()
    elseif again > 1 then
        vincent03()
    end
    if again < 2 then
        again = again + 1
    end
    fallout.set_local_var(4, again)
end

function vincnight()
    local again = fallout.local_var(4)
    if again == 0 then
        vincent01n()
    elseif again > 0 then
        vincent02n()
    end
    if again < 2 then
        again = again + 1
    end
    fallout.set_local_var(4, again)
end

function vincent00()
    local self_obj = fallout.self_obj()
    fallout.float_msg(self_obj, fallout.message_str(679, 402), 2)
    fallout.add_timer_event(self_obj, fallout.game_ticks(30), 1)
end

function vincent01()
    local self_obj = fallout.self_obj()
    fallout.float_msg(self_obj, fallout.message_str(679, 403), 2)
    fallout.add_timer_event(self_obj, fallout.game_ticks(15), 1)
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
    local self_obj = fallout.self_obj()
    if fallout.obj_can_see_obj(self_obj, fallout.dude_obj()) then
        fallout.float_msg(self_obj, fallout.message_str(679, 404), 2)
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
