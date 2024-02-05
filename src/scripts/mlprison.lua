local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local goto01
local goto02
local goto03
local goto04
local goto05
local goto06
local goto07
local goto08
local goto09
local goto10
local goto11
local explode
local escape
local dialog_end

local hostile = false
local initialized = false
local said = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 2)
        fallout.critter_add_trait(self_obj, 1, 5, 6)
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

function critter_p_proc()
    if fallout.tile_num(fallout.self_obj()) < 25000 then
        explode()
    elseif fallout.map_var(2) == 1 or fallout.map_var(7) == 1 then
        escape()
    elseif hostile then
        -- FIXME: `hostile` is usually reset here.
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
    fallout.start_gdialog(682, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        if fallout.local_var(5) == 1 then
            goto05()
        else
            goto01()
        end
        fallout.set_local_var(5, 1)
    else
        if fallout.local_var(4) == 1 then
            goto09()
        else
            goto07()
        end
        fallout.set_local_var(4, 1)
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
end

function goto01()
    fallout.gsay_reply(682, 108)
    fallout.giq_option(-3, 682, 109, goto02, 51)
    fallout.giq_option(4, 682, 110, goto03, 51)
    fallout.giq_option(4, 682, 111, goto04, 51)
end

function goto02()
    fallout.gsay_message(682, 112, 51)
    dialog_end()
end

function goto03()
    fallout.gsay_message(682, 113, 51)
    dialog_end()
end

function goto04()
    fallout.gsay_message(682, 128, 51)
    dialog_end()
end

function goto05()
    fallout.gsay_reply(682, 114)
    fallout.giq_option(-3, 682, 115, goto02, 51)
    fallout.giq_option(4, 682, 116, goto06, 51)
    fallout.giq_option(4, 682, 117, dialog_end, 51)
end

function goto06()
    fallout.gsay_message(682, 118, 51)
    dialog_end()
end

function goto07()
    fallout.gsay_reply(682, 119)
    fallout.giq_option(-3, 682, 115, goto02, 51)
    fallout.giq_option(4, 682, 120, goto08, 51)
end

function goto08()
    fallout.gsay_message(682, 122, 51)
    dialog_end()
end

function goto09()
    fallout.gsay_reply(682, 123)
    fallout.giq_option(-3, 682, 115, goto02, 51)
    fallout.giq_option(4, 682, 124, goto11, 51)
    fallout.giq_option(4, 682, 125, dialog_end, 51)
end

function goto10()
    fallout.gsay_message(682, 126, 51)
    dialog_end()
end

function goto11()
    fallout.gsay_message(682, 127, 51)
    dialog_end()
end

function explode()
    fallout.critter_dmg(fallout.self_obj(), 128, 6)
end

function escape()
    if not said then
        said = true
        fallout.float_msg(fallout.self_obj(), fallout.message_str(682, 107), 2)
    end
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
