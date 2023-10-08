local fallout = require("fallout")
local reputation = require("lib.reputation")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0
local g3 = 0
local g4 = 0

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

-- ?import? variable removal_ptr
-- ?import? variable Hostile
-- ?import? variable said_stuff
-- ?import? variable explode
-- ?import? variable initialized

local get_reaction
local ReactToLevel
local LevelToReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

-- ?import? variable exit_line

function start()
    if not(g3) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        g3 = 1
    end
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 21 then
            look_at_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
                end
            end
        end
    end
end

function critter_p_proc()
    if g0 then
        g0 = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if g2 then
            fallout.critter_dmg(fallout.self_obj(), fallout.random(200, 250), 6)
        else
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                    if not(g1) then
                        g1 = 1
                        if fallout.external_var("Team9_Count") > 0 then
                            ChocTech00()
                        else
                            ChocTech01()
                        end
                    end
                end
            else
                g1 = 0
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
    else
        if fallout.global_var(54) == 1 then
            ChocTech09()
        else
            if fallout.external_var("Team9_Count") > 0 then
                fallout.start_gdialog(358, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                ChocTech02()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                ChocTech01()
            end
        end
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
    g2 = 1
end

function ChocTech10()
    fallout.gsay_reply(358, 126)
    fallout.giq_option(-3, 358, 127, ChocTech11, 0)
    fallout.giq_option(4, 358, 128, ChocTech11, 0)
    fallout.giq_option(4, 358, 129, combat, -10)
end

function ChocTech11()
    fallout.gsay_message(358, 130, 0)
    g2 = 1
end

function combat()
    g0 = 1
end

function ChocTechend()
end

function get_reaction()
    if fallout.local_var(2) == 0 then
        fallout.set_local_var(0, 50)
        fallout.set_local_var(1, 2)
        fallout.set_local_var(2, 1)
        fallout.set_local_var(0, fallout.local_var(0) + (5 * fallout.get_critter_stat(fallout.dude_obj(), 3)) - 25)
        fallout.set_local_var(0, fallout.local_var(0) + (10 * fallout.has_trait(0, fallout.dude_obj(), 10)))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            end
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            end
        end
        if fallout.global_var(158) > 2 then
            fallout.set_local_var(0, fallout.local_var(0) - 30)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) - 20)
        end
        ReactToLevel()
    end
end

function ReactToLevel()
    if fallout.local_var(0) <= 25 then
        fallout.set_local_var(1, 1)
    else
        if fallout.local_var(0) <= 75 then
            fallout.set_local_var(1, 2)
        else
            fallout.set_local_var(1, 3)
        end
    end
end

function LevelToReact()
    if fallout.local_var(1) == 1 then
        fallout.set_local_var(0, fallout.random(1, 25))
    else
        if fallout.local_var(1) == 2 then
            fallout.set_local_var(0, fallout.random(26, 75))
        else
            fallout.set_local_var(0, fallout.random(76, 100))
        end
    end
end

function UpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 10)
    ReactToLevel()
end

function DownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 10)
    ReactToLevel()
end

function BottomReact()
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function TopReact()
    fallout.set_local_var(0, 100)
    fallout.set_local_var(1, 3)
end

function BigUpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 25)
    ReactToLevel()
end

function BigDownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 25)
    ReactToLevel()
end

function UpReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(1, 3)
    end
    LevelToReact()
end

function DownReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) - 1)
    if fallout.local_var(1) < 1 then
        fallout.set_local_var(1, 1)
    end
    LevelToReact()
end

function Goodbyes()
    g4 = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
