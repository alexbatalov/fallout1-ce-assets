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
local explode
local escape
local dialog_end

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

function combat()
    hostile = true
end

function critter_p_proc()
    if fallout.tile_num(fallout.self_obj()) < 25000 then
        explode()
    else
        if fallout.map_var(2) == 1 or fallout.map_var(7) == 1 then
            escape()
        else
            if hostile then
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
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
    if fallout.obj_pid(fallout.self_obj()) == 16777258 then
        fallout.display_msg(fallout.message_str(682, fallout.random(102, 104)))
    else
        local temp = fallout.random(102, 104)
        if temp == 104 then
            temp = 105
        end
        fallout.display_msg(fallout.message_str(682, temp))
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
end

function explode()
    fallout.critter_dmg(fallout.self_obj(), 128, 6)
end

function escape()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 22912, 1)
end

function dialog_end()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
