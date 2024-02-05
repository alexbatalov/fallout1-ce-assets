local fallout = require("fallout")
local misc = require("lib.misc")
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
local Dugan01
local Dugan02
local Dugan03
local Dugan04
local Dugan05
local Dugan06
local Dugan07
local Dugan08
local Dugan09
local DuganEnd

local initialized = false
local PsstTime = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 47)
        fallout.critter_add_trait(self_obj, 1, 5, 27)
        initialized = true
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(917, 101))
    else
        fallout.display_msg(fallout.message_str(917, 100))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(917, 101))
    else
        fallout.display_msg(fallout.message_str(917, 100))
    end
end

function talk_p_proc()
    if fallout.global_var(253) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if fallout.local_var(4) == 1 and fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(917, 120), 0)
        else
            reaction.get_reaction()
            fallout.start_gdialog(917, fallout.self_obj(), -1, -1, -1)
            fallout.gsay_start()
            Dugan01()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if time.game_time_in_seconds() - PsstTime >= 30 and fallout.tile_distance_objs(self_obj, dude_obj) <= 10 then
        fallout.float_msg(self_obj, fallout.message_str(917, fallout.random(121, 125)), 0)
        PsstTime = time.game_time_in_seconds()
    end
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        if fallout.global_var(253) == 1 then
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
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

function Dugan01()
    fallout.gsay_reply(917, 102)
    fallout.giq_option(4, 917, 103, Dugan02, 50)
    fallout.giq_option(4, 917, 104, Dugan03, 50)
    fallout.giq_option(4, 917, 105, Dugan05, 50)
    if fallout.global_var(613) < 1 then
        fallout.giq_option(4, 917, 106, Dugan08, 50)
    end
    fallout.giq_option(4, 917, 107, DuganEnd, 50)
    fallout.giq_option(-3, 917, 108, Dugan09, 50)
end

function Dugan02()
    fallout.gsay_message(917, 109, 50)
end

function Dugan03()
    fallout.gsay_reply(917, 110)
    Dugan04()
end

function Dugan04()
    fallout.gsay_option(917, 111, Dugan05, 50)
    fallout.gsay_option(917, 112, Dugan06, 50)
    fallout.gsay_option(917, 113, Dugan07, 50)
    fallout.gsay_option(917, 114, Dugan01, 50)
    fallout.gsay_option(917, 115, DuganEnd, 50)
end

function Dugan05()
    fallout.gsay_reply(917, 116)
    Dugan04()
end

function Dugan06()
    fallout.gsay_reply(917, 117)
    Dugan04()
end

function Dugan07()
    fallout.gsay_reply(917, 118)
    Dugan04()
end

function Dugan08()
    fallout.gsay_message(917, 119, 50)
    Dugan01()
end

function Dugan09()
    fallout.gsay_message(917, 120, 50)
end

function DuganEnd()
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
