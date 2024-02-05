local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local zamin
local goto00
local goto01
local goto02
local goto03

local lesson = 0
local hostile = false
local initialized = false
local disguised = false
local armed = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 48)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
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
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    local self_tile_num = fallout.tile_num(self_obj)
    if self_tile_num == 12098 then
        fallout.move_to(self_obj, 7000, 0)
    else
        if fallout.tile_distance(self_tile_num, fallout.tile_num(dude_obj)) < 12 then
            if fallout.local_var(2) ~= 1 then
                fallout.set_local_var(2, 1)
                lesson = 0
                fallout.add_timer_event(self_obj, fallout.game_ticks(1), 0)
            end
        end
    end
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        zamin()
        if armed or not disguised then
            combat()
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    zamin()
    if armed or not disguised then
        combat()
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
end

function timed_event_p_proc()
    if not hostile then
        lesson = lesson + 1
        fallout.set_local_var(1, lesson)
        goto00()
    end
end

function zamin()
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

function goto00()
    if lesson == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(694, 101), 2)
    elseif lesson == 2 then
        fallout.float_msg(fallout.external_var("patient"), fallout.message_str(694, 102), 8)
    elseif lesson == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(694, 103), 2)
    elseif lesson == 4 then
        goto01()
    elseif lesson == 5 then
        goto02()
    elseif lesson == 6 then
        fallout.float_msg(fallout.external_var("patient"), fallout.message_str(694, 108), 8)
    elseif lesson == 7 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(694, 109), 2)
    elseif lesson == 8 then
        fallout.float_msg(fallout.external_var("patient"), fallout.message_str(694, 110), 8)
    elseif lesson == 9 then
        goto03()
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 1)
end

function goto01()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.external_var("patient"), fallout.message_str(694, 104), 8)
    else
        fallout.float_msg(fallout.external_var("patient"), fallout.message_str(694, 105), 8)
    end
end

function goto02()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(694, 106), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(694, 107), 2)
    end
end

function goto03()
    fallout.set_external_var("lets_go", 1)
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 12098, 0)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
