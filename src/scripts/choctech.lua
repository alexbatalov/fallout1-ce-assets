local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local look_at_p_proc
local talk_p_proc
local destroy_p_proc
local ChocTech00
local ChocTech01
local ChocTech02
local ChocTech02a
local ChocTech03
local ChocTech04
local ChocTech05
local ChocTech06
local ChocTech06a
local ChocTech07
local ChocTech08
local ChocTech09
local ChocTech10
local ChocTech11
local combat
local ChocTechend

local hostile = false
local said_stuff = false
local explode = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 69)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if explode then
            fallout.critter_dmg(fallout.self_obj(), fallout.random(200, 250), 6)
        else
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if misc.is_armed(fallout.dude_obj()) then
                    if not said_stuff then
                        said_stuff = true
                        if fallout.external_var("Team9_Count") > 0 then
                            ChocTech00()
                        else
                            ChocTech01()
                        end
                    end
                end
            else
                said_stuff = false
            end
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(358, 100))
end

function talk_p_proc()
    if fallout.global_var(53) == 1 then
        fallout.start_gdialog(358, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        ChocTech10()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.global_var(54) == 1 then
        ChocTech09()
    elseif fallout.external_var("Team9_Count") > 0 then
        fallout.start_gdialog(358, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        ChocTech02()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        ChocTech01()
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_global_var(146, 1)
end

function ChocTech00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(358, fallout.random(101, 104)), 0)
end

function ChocTech01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(358, fallout.random(105, 107)), 0)
end

function ChocTech02()
    fallout.gsay_reply(358, 108)
    fallout.giq_option(-3, 358, 109, ChocTech03, 0)
    fallout.giq_option(4, 358, 110, ChocTech04, 0)
    fallout.giq_option(4, 358, 111, combat, -10)
    fallout.giq_option(6, 358, 112, ChocTech02a, 0)
end

function ChocTech02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        ChocTech06()
    else
        ChocTech05()
    end
end

function ChocTech03()
    fallout.gsay_message(358, 113, 0)
end

function ChocTech04()
    fallout.gsay_message(358, 114, 0)
end

function ChocTech05()
    fallout.gsay_message(358, 115, 0)
    combat()
end

function ChocTech06()
    fallout.gsay_reply(358, 116)
    fallout.giq_option(5, 358, 117, combat, -10)
    fallout.giq_option(6, 358, 118, ChocTech06a, 0)
end

function ChocTech06a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        ChocTech07()
    else
        ChocTech05()
    end
end

function ChocTech07()
    fallout.gsay_reply(358, 119)
    fallout.giq_option(6, 358, 120, ChocTechend, 0)
    fallout.giq_option(6, 358, 121, ChocTech08, 0)
    fallout.giq_option(6, 358, 122, ChocTech05, 0)
end

function ChocTech08()
    fallout.gsay_reply(358, 123)
    fallout.giq_option(6, 358, 124, ChocTech05, 0)
end

function ChocTech09()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(358, 125), 0)
    explode = true
end

function ChocTech10()
    fallout.gsay_reply(358, 126)
    fallout.giq_option(-3, 358, 127, ChocTech11, 0)
    fallout.giq_option(4, 358, 128, ChocTech11, 0)
    fallout.giq_option(4, 358, 129, combat, -10)
end

function ChocTech11()
    fallout.gsay_message(358, 130, 0)
    explode = true
end

function combat()
    hostile = true
end

function ChocTechend()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
