local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local BYGreg03
local BYGreg04
local BYGreg05
local BYGreg06
local BYGreg07
local BYGregEnd

local Initialize = 1
local PsstTime = 0
local DisplayMessage = 100

local exit_line = 0

function start()
    if Initialize then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 47)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 27)
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(925, 101))
    else
        fallout.display_msg(fallout.message_str(925, 100))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(925, 101))
    else
        fallout.display_msg(fallout.message_str(925, 100))
    end
end

function talk_p_proc()
    if fallout.global_var(253) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if (fallout.local_var(5) == 1) and (fallout.get_critter_stat(fallout.dude_obj(), 4) < 4) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(925, fallout.random(115, 119)), 0)
        else
            reaction.get_reaction()
            fallout.start_gdialog(925, fallout.self_obj(), -1, -1, -1)
            fallout.gsay_start()
            if fallout.local_var(4) == 0 then
                DisplayMessage = 102
            else
                DisplayMessage = 103
            end
            BYGreg03()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function critter_p_proc()
    if ((time.game_time_in_seconds() - PsstTime) >= 30) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 4) and (fallout.local_var(5) == 1) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(925, fallout.random(115, 119)), 0)
        PsstTime = time.game_time_in_seconds()
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(253) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
        reputation.inc_good_critter()
    end
end

function pickup_p_proc()
    fallout.set_global_var(253, 1)
end

function BYGreg03()
    fallout.gsay_reply(925, DisplayMessage)
    if fallout.local_var(4) == 0 then
        fallout.gsay_option(925, 105, BYGreg04, 50)
    end
    fallout.gsay_option(925, 106, BYGreg05, 50)
    fallout.gsay_option(925, 107, BYGreg07, 50)
    fallout.gsay_option(925, 108, BYGregEnd, 50)
end

function BYGreg04()
    DisplayMessage = 109
    fallout.set_local_var(4, 1)
    BYGreg03()
end

function BYGreg05()
    fallout.gsay_reply(925, 110)
    fallout.gsay_option(925, 111, BYGreg06, 50)
    fallout.gsay_option(925, 112, BYGregEnd, 50)
end

function BYGreg06()
    fallout.gsay_reply(925, 113)
    fallout.set_local_var(5, 1)
end

function BYGreg07()
    fallout.gsay_reply(925, 114)
    fallout.set_local_var(5, 1)
end

function BYGregEnd()
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
