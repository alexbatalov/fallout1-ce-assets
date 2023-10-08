local fallout = require("fallout")
local reputation = require("lib.reputation")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 1
local g2 = 0
local g3 = 0

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Richie00
local Richie01
local Richie01a
local Richie01b
local Richie02
local Richie03
local Richie04
local Richie05
local Richie06
local Richie07
local Richie08
local Richie09
local Richie10
local Richie11
local Richie12
local Richie13
local RichieLeave
local RichieEnd

-- ?import? variable hostile
-- ?import? variable Only_Once
-- ?import? variable Go_Away
-- ?import? variable Vault_Ptr

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
    if g1 then
        g1 = 0
        fallout.set_external_var("Richie_Ptr", fallout.self_obj())
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 73)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 1)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    end
                end
            end
        end
    end
end

function combat()
    g0 = 1
end

function critter_p_proc()
    if g0 then
        g0 = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        g0 = 1
    end
end

function talk_p_proc()
    get_reaction()
    if (fallout.map_var(23) == 1) or (fallout.map_var(15) > 0) or (fallout.map_var(18) == 2) then
        Richie00()
    else
        if fallout.map_var(20) == 0 then
            fallout.set_map_var(20, 1)
            fallout.start_gdialog(599, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Richie01()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            Richie02()
        end
    end
    if g2 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), 27450, 0)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(599, 100))
end

function Richie00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(599, 101), 2)
    combat()
end

function Richie01()
    fallout.gsay_reply(599, 102)
    fallout.giq_option(7, 599, 103, Richie01a, 50)
    fallout.giq_option(7, 599, 104, Richie01b, 50)
    fallout.giq_option(4, 599, 105, Richie06, 51)
    fallout.giq_option(4, 599, 106, Richie07, 51)
    fallout.giq_option(4, 599, 107, Richie08, 50)
    fallout.giq_option(4, 599, 108, Richie09, 51)
    fallout.giq_option(-3, 599, 109, Richie09, 50)
end

function Richie01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Richie03()
    else
        Richie04()
    end
end

function Richie01b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Richie05()
    else
        Richie04()
    end
end

function Richie02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(599, 110), 2)
end

function Richie03()
    fallout.gsay_message(599, 111, 49)
    g2 = 1
end

function Richie04()
    fallout.gsay_message(599, 112, 51)
end

function Richie05()
    fallout.gsay_message(599, 113, 49)
    g2 = 1
end

function Richie06()
    fallout.gsay_message(599, 114, 51)
end

function Richie07()
    fallout.gsay_message(599, 115, 51)
    combat()
end

function Richie08()
    fallout.gsay_message(599, 116, 50)
end

function Richie09()
    fallout.gsay_reply(599, 117)
    fallout.giq_option(-3, 599, 118, Richie10, 51)
    fallout.giq_option(-3, 599, 119, Richie11, 49)
    fallout.giq_option(-3, 599, 120, Richie12, 50)
end

function Richie10()
    fallout.gsay_message(599, 121, 50)
end

function Richie11()
    fallout.gsay_message(599, 123, 49)
end

function Richie12()
    fallout.gsay_reply(599, 123)
    fallout.giq_option(-3, 599, 124, Richie10, 51)
    fallout.giq_option(-3, 599, 125, Richie11, 49)
    fallout.giq_option(-3, 599, 126, Richie13, 50)
end

function Richie13()
    fallout.gsay_message(599, 127, 50)
end

function RichieLeave()
end

function RichieEnd()
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
    g3 = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
