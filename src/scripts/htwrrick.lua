local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local Rick01
local Rick02
local Rick03
local Rick04
local Rick05
local Rick06
local Rick07
local Rick08
local Rick09
local Rick10
local RickEnd
local RickCombat

local hostile = false
local initialized = false
local nightWarned = false
local visible = true

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.global_var(111) == 5 then
            fallout.set_obj_visibility(self_obj, true)
            visible = false
        end
        misc.set_team(self_obj, 42)
        misc.set_ai(self_obj, 16)
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
    elseif script_action == 14 then
        damage_p_proc()
    end
end

function combat()
    hostile = true
end

function critter_p_proc()
    if not visible then
        fallout.script_overrides()
    else
        local self_obj = fallout.self_obj()
        local dude_obj = fallout.dude_obj()
        if hostile then
            hostile = false
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.map_var(5) == 1 then
            if fallout.obj_can_hear_obj(self_obj, dude_obj) or fallout.obj_can_see_obj(self_obj, dude_obj) then
                combat()
            end
        else
            if time.is_night() then
                if fallout.tile_distance_objs(self_obj, dude_obj) <= 7 and not nightWarned then
                    nightWarned = true
                    fallout.dialogue_system_enter()
                end
                if fallout.tile_num(self_obj) ~= 19713 then
                    fallout.animate_move_obj_to_tile(self_obj, 19713, 0)
                end
            else
                if fallout.tile_num(self_obj) ~= 17892 then
                    fallout.animate_move_obj_to_tile(self_obj, 17892, 0)
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
    reaction.get_reaction()
    if time.is_night() then
        fallout.start_gdialog(871, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rick09()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        fallout.start_gdialog(871, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Rick01()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(871, 100))
end

function damage_p_proc()
    fallout.set_map_var(5, 1)
end

function Rick01()
    fallout.gsay_reply(871, 101)
    fallout.giq_option(4, 871, 103, Rick03, 50)
    fallout.giq_option(4, 871, 104, Rick04, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 871, 105, Rick08, 51)
    end
    fallout.giq_option(-3, 871, 102, Rick02, 50)
end

function Rick02()
    fallout.gsay_reply(871, 106)
    fallout.giq_option(-3, 871, 107, Rick10, 50)
    fallout.giq_option(-3, 871, 108, RickEnd, 50)
end

function Rick03()
    fallout.gsay_reply(871, 109)
    fallout.giq_option(4, 871, 110, Rick05, 50)
    fallout.giq_option(4, 871, 111, Rick06, 50)
    fallout.giq_option(4, 871, 112, RickEnd, 50)
end

function Rick04()
    fallout.gsay_reply(871, 113)
    fallout.giq_option(4, 871, 114, RickCombat, 51)
    fallout.giq_option(4, 871, 115, Rick08, 50)
end

function Rick05()
    fallout.gsay_reply(871, 116)
    fallout.giq_option(4, 871, 117, Rick06, 50)
    fallout.giq_option(4, 871, 118, Rick07, 50)
    fallout.giq_option(4, 871, 119, RickEnd, 50)
end

function Rick06()
    fallout.gsay_reply(871, 120)
    fallout.giq_option(4, 871, 121, RickCombat, 51)
    fallout.giq_option(4, 871, 122, Rick05, 50)
    fallout.giq_option(4, 871, 123, RickEnd, 50)
end

function Rick07()
    fallout.gsay_message(871, 124, 51)
end

function Rick08()
    fallout.gsay_reply(871, 125)
    fallout.giq_option(4, 871, 126, RickEnd, 50)
    fallout.giq_option(4, 871, 127, RickCombat, 51)
end

function Rick09()
    fallout.gsay_reply(871, 128)
    fallout.giq_option(4, 871, 131, RickCombat, 51)
    fallout.giq_option(4, 871, 132, RickEnd, 50)
    fallout.giq_option(-3, 871, 129, RickEnd, 50)
    fallout.giq_option(-3, 871, 130, RickCombat, 51)
end

function Rick10()
    fallout.gsay_message(871, 133, 51)
end

function RickEnd()
end

function RickCombat()
    combat()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.damage_p_proc = damage_p_proc
return exports
