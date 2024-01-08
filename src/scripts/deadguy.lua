local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Deadguy00
local Deadguy01
local Deadguy02
local Deadguy03
local Deadguy04
local Deadguy05
local Deadguy06
local Deadguy07
local Deadguy08
local DeadguyEnd

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 41)
        fallout.critter_add_trait(self_obj, 1, 5, 51)
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
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(4) == 1 then
        Deadguy02()
    else
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(564, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Deadguy00()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(564, 100))
end

function Deadguy00()
    fallout.gsay_reply(564, 101)
    fallout.giq_option(4, 564, 102, Deadguy01, 51)
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 564, 103, Deadguy03, 50)
    end
    fallout.giq_option(4, 564, 104, Deadguy07, 50)
    fallout.giq_option(-3, 564, 105, Deadguy06, 50)
end

function Deadguy01()
    fallout.gsay_message(564, 106, 50)
end

function Deadguy02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(564, 107), 2)
end

function Deadguy03()
    fallout.set_local_var(5, 1)
    fallout.item_caps_adjust(fallout.dude_obj(), 20)
    fallout.gsay_reply(564, 108)
    fallout.giq_option(4, 564, 109, DeadguyEnd, 50)
    fallout.giq_option(4, 564, 110, Deadguy04, 50)
end

function Deadguy04()
    fallout.gsay_reply(564, 111)
    fallout.giq_option(4, 564, 112, Deadguy05, 50)
    fallout.giq_option(4, 564, 113, DeadguyEnd, 50)
end

function Deadguy05()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(564, 114, 50)
    else
        fallout.gsay_message(564, 115, 50)
    end
end

function Deadguy06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(564, 118, 50)
    else
        fallout.gsay_message(564, 119, 50)
    end
end

function Deadguy07()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(564, 122)
    else
        fallout.gsay_reply(564, 123)
    end
    fallout.giq_option(4, 564, 126, Deadguy08, 50)
    fallout.giq_option(4, 564, 127, combat, 50)
end

function Deadguy08()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(564, 128, 50)
    else
        fallout.gsay_message(564, 129, 50)
    end
end

function DeadguyEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
