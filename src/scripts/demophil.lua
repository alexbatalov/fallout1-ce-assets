local fallout = require("fallout")
local misc = require("lib.misc")
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
local do_dialogue
local run_away
local weapon_check
local go_forward
local Phil00
local Phil01
local Phil02
local Phil03
local Phil04
local Phil05
local Phil06
local Phil07
local Phil08
local Phil09
local PhilEnd

-- ?import? variable known
-- ?import? variable hostile
-- ?import? variable armed
-- ?import? variable initialized
-- ?import? variable smartass2

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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 5)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
        g3 = 1
    else
        if fallout.script_action() == 11 then
            do_dialogue()
        else
            if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                fallout.script_overrides()
                if g0 then
                    fallout.display_msg(fallout.message_str(376, 100))
                else
                    fallout.display_msg(fallout.message_str(376, 101))
                end
            else
                if fallout.script_action() == 12 then
                    if fallout.external_var("growling") ~= 0 then
                        run_away()
                    end
                    if fallout.external_var("smartass") ~= 0 then
                        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 2)
                        fallout.set_external_var("smartass", 0)
                    end
                    if fallout.external_var("dog_is_angry") == 0 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 15686, 0)
                    end
                else
                    if fallout.script_action() == 4 then
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    else
                        if fallout.script_action() == 22 then
                            if fallout.fixed_param() == 2 then
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(376, 102), 0)
                            else
                                if fallout.external_var("dog_is_angry") ~= 0 then
                                    go_forward()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    weapon_check()
    if fallout.global_var(5) ~= 0 then
        Phil01()
    else
        if not(fallout.external_var("dog_is_angry")) then
            Phil09()
        else
            if g2 then
                Phil00()
            else
                if not(g0) then
                    fallout.start_gdialog(376, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Phil02()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    Phil08()
                end
            end
        end
    end
end

function run_away()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 16892, 1)
    fallout.set_external_var("growling", 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(10, 30)), 1)
end

function weapon_check()
    if misc.is_armed(fallout.dude_obj()) then
        g2 = 1
    else
        g2 = 0
    end
end

function go_forward()
    fallout.set_external_var("Phil_approaches", 1)
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 16886, 0)
end

function Phil00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(376, 103), 0)
end

function Phil01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(376, 104), 0)
end

function Phil02()
    local v0 = 0
    g0 = 1
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        v0 = fallout.message_str(376, 105)
    else
        v0 = fallout.message_str(376, 106)
    end
    fallout.gsay_reply(376, v0 .. fallout.message_str(376, 107))
    fallout.giq_option(4, 376, 108, Phil04, 50)
    fallout.giq_option(4, 376, 109, PhilEnd, 50)
    fallout.giq_option(6, 376, 110, Phil05, 50)
    fallout.giq_option(-3, 376, 111, Phil03, 50)
end

function Phil03()
    fallout.gsay_message(376, 112, 50)
end

function Phil04()
    fallout.gsay_reply(376, 113)
    fallout.giq_option(4, 376, 114, PhilEnd, 50)
    fallout.giq_option(4, 376, 115, Phil05, 50)
end

function Phil05()
    fallout.gsay_reply(376, 116)
    fallout.giq_option(4, 376, 117, PhilEnd, 50)
    fallout.giq_option(5, 376, 118, Phil06, 50)
    fallout.giq_option(6, 376, 119, Phil07, 50)
end

function Phil06()
    fallout.gsay_message(376, 120, 50)
    fallout.gsay_reply(376, 121)
    Goodbyes()
    fallout.giq_option(7, 376, 122, Phil07, 50)
    fallout.giq_option(4, 634, g4, PhilEnd, 50)
end

function Phil07()
    fallout.gsay_message(376, 123, 50)
    fallout.gsay_reply(376, 124)
    fallout.giq_option(4, 376, 125, PhilEnd, 50)
end

function Phil08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(376, 126), 0)
end

function Phil09()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(376, 127), 0)
end

function PhilEnd()
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
        if reputation.has_rep_champion() then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if reputation.has_rep_berserker() then
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
return exports
