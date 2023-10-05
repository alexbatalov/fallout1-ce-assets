local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local Jain00
local Jain01
local Jain02
local Jain03
local Jain04
local Jain05
local Jain06
local Jain07
local Jain08
local Jain09
local Jain10
local Jain11
local Jain12
local Jain13
local Jain14
local Jain15
local Jain16
local Jain17
local Jain18
local Jain19
local Jain20
local Jain21
local Jain22
local Jain23
local Jain24
local Jain25
local Jain26
local Jain27
local Jain28
local Jain29
local Jain30
local Jain31
local Jain32
local Jain33
local Jain34
local Jain35
local Jain36
local Jain37
local Jain38
local Jain39
local JainEnd
local JainEndCombat

local hostile = 0
local Only_Once = 1

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

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 72)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 77)
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
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if (fallout.map_var(6) == 1) and (fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) == 1) then
        combat()
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    get_reaction()
    if fallout.map_var(0) == 1 then
        fallout.start_gdialog(46, fallout.self_obj(), 4, 18, 3)
        fallout.gsay_start()
        Jain29()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        if fallout.global_var(18) == 1 then
            fallout.start_gdialog(46, fallout.self_obj(), 4, 18, 3)
            fallout.gsay_start()
            Jain30()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            if fallout.local_var(4) == 0 then
                fallout.set_local_var(4, 1)
                fallout.start_gdialog(46, fallout.self_obj(), 4, 18, 3)
                fallout.gsay_start()
                Jain00()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                if fallout.local_var(1) >= 2 then
                    fallout.start_gdialog(46, fallout.self_obj(), 4, 18, 3)
                    fallout.gsay_start()
                    Jain27()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    fallout.start_gdialog(46, fallout.self_obj(), 4, 18, 3)
                    fallout.gsay_start()
                    Jain29()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            end
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
    fallout.set_global_var(112, 2)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(46, 100))
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_map_var(6, 1)
    end
end

function Jain00()
    fallout.gsay_reply(46, 101)
    fallout.giq_option(4, 46, 102, Jain04, 50)
    fallout.giq_option(4, 46, 103, Jain07, 50)
    fallout.giq_option(4, 46, 104, Jain10, 50)
    fallout.giq_option(-3, 46, 105, Jain02, 50)
end

function Jain01()
    fallout.gsay_reply(46, 106)
    fallout.giq_option(-3, 46, 107, Jain03, 50)
    fallout.giq_option(-3, 46, 108, Jain02, 50)
end

function Jain02()
    fallout.gsay_message(46, 109, 51)
    JainEndCombat()
end

function Jain03()
    fallout.set_map_var(0, 1)
    fallout.gsay_message(46, 110, 50)
end

function Jain04()
    fallout.gsay_reply(46, 111)
    fallout.giq_option(4, 46, 112, Jain05, 50)
    fallout.giq_option(4, 46, 113, Jain03, 50)
end

function Jain05()
    fallout.set_map_var(0, 1)
    fallout.gsay_message(46, 114, 51)
end

function Jain06()
end

function Jain07()
    fallout.gsay_reply(46, 115)
    fallout.giq_option(4, 46, 116, Jain10, 50)
    fallout.giq_option(4, 46, 117, Jain09, 50)
    fallout.giq_option(4, 46, 118, Jain08, 51)
    fallout.giq_option(4, 46, 119, JainEnd, 50)
end

function Jain08()
    fallout.gsay_message(46, 120, 51)
    JainEndCombat()
end

function Jain09()
    BigDownReact()
    fallout.gsay_message(46, 121, 51)
    JainEndCombat()
end

function Jain10()
    fallout.gsay_reply(46, 122)
    fallout.giq_option(4, 46, 123, Jain11, 49)
    fallout.giq_option(4, 46, 124, Jain26, 51)
    fallout.giq_option(4, 46, 125, Jain20, 50)
end

function Jain11()
    UpReact()
    fallout.gsay_reply(46, 126)
    fallout.giq_option(4, 46, 127, Jain17, 51)
    fallout.giq_option(4, 46, 128, Jain13, 50)
    fallout.giq_option(4, 46, 129, Jain12, 50)
end

function Jain12()
    fallout.set_map_var(0, 1)
    fallout.gsay_reply(46, 130)
    fallout.giq_option(4, 46, 131, JainEnd, 50)
    fallout.giq_option(4, 46, 132, JainEndCombat, 51)
end

function Jain13()
    fallout.gsay_reply(46, 133)
    fallout.giq_option(4, 46, 134, Jain14, 50)
    fallout.giq_option(4, 46, 135, Jain15, 51)
end

function Jain14()
    fallout.gsay_reply(46, 136)
    fallout.giq_option(4, 46, 137, Jain20, 49)
    fallout.giq_option(4, 46, 138, Jain09, 51)
    fallout.giq_option(4, 46, 139, Jain15, 51)
end

function Jain15()
    DownReact()
    fallout.gsay_message(46, 140, 50)
end

function Jain16()
end

function Jain17()
    fallout.gsay_reply(46, 141)
    fallout.giq_option(4, 46, 142, Jain18, 51)
    fallout.giq_option(4, 46, 143, Jain19, 50)
end

function Jain18()
    DownReact()
    fallout.gsay_message(46, 144, 51)
end

function Jain19()
    fallout.gsay_reply(46, 145)
    fallout.giq_option(4, 46, 146, Jain13, 50)
    fallout.giq_option(4, 46, 147, JainEnd, 50)
end

function Jain20()
    UpReact()
    fallout.gsay_reply(46, 148)
    fallout.giq_option(4, 46, 149, Jain21, 50)
    fallout.giq_option(4, 46, 150, Jain22, 50)
end

function Jain21()
    fallout.gsay_reply(46, 151)
    fallout.giq_option(4, 46, 152, Jain38, 50)
    fallout.giq_option(4, 46, 153, JainEndCombat, 51)
    fallout.giq_option(4, 46, 154, Jain37, 50)
    fallout.giq_option(4, 46, 155, JainEnd, 50)
end

function Jain22()
    fallout.gsay_reply(46, 156)
    fallout.giq_option(4, 46, 157, Jain37, 50)
    fallout.giq_option(4, 46, 158, Jain15, 51)
    fallout.giq_option(4, 46, 159, JainEnd, 50)
end

function Jain23()
end

function Jain24()
end

function Jain25()
end

function Jain26()
    BigDownReact()
    fallout.gsay_reply(46, 161)
    fallout.giq_option(4, 46, 161, Jain19, 50)
    fallout.giq_option(4, 46, 162, JainEndCombat, 50)
end

function Jain27()
    fallout.gsay_reply(46, 163)
    fallout.giq_option(4, 46, 164, Jain36, 50)
    fallout.giq_option(4, 46, 165, Jain28, 51)
    fallout.giq_option(4, 46, 166, JainEnd, 50)
    fallout.giq_option(-3, 46, 167, Jain39, 50)
    fallout.giq_option(-3, 46, 168, Jain34, 50)
end

function Jain28()
    BigDownReact()
    fallout.set_map_var(0, 1)
    fallout.gsay_message(46, 169, 50)
end

function Jain29()
    fallout.gsay_message(46, 170, 50)
end

function Jain30()
    fallout.gsay_reply(46, 171)
    fallout.giq_option(4, 46, 172, Jain31, 50)
    fallout.giq_option(4, 46, 173, Jain32, 50)
    fallout.giq_option(-3, 46, 174, Jain39, 50)
    fallout.giq_option(-3, 46, 175, JainEnd, 50)
end

function Jain31()
    fallout.gsay_message(46, 176, 51)
    JainEndCombat()
end

function Jain32()
    fallout.gsay_reply(46, 177)
    fallout.giq_option(4, 46, 178, Jain33, 50)
    fallout.giq_option(4, 46, 179, JainEnd, 50)
end

function Jain33()
    fallout.gsay_message(46, 180, 50)
end

function Jain34()
    fallout.set_map_var(0, 1)
    fallout.gsay_message(46, 181, 51)
end

function Jain35()
    fallout.set_map_var(0, 1)
    fallout.gsay_message(46, 182, 51)
end

function Jain36()
    fallout.gsay_reply(46, 183)
    fallout.giq_option(4, 46, 184, Jain14, 50)
    fallout.giq_option(4, 46, 185, JainEnd, 50)
end

function Jain37()
    UpReact()
    fallout.gsay_message(46, 186, 49)
end

function Jain38()
    fallout.gsay_message(46, 187, 50)
end

function Jain39()
    fallout.gsay_message(46, 188, 50)
end

function JainEnd()
end

function JainEndCombat()
    BottomReact()
    fallout.set_map_var(0, 1)
    combat()
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
    exit_line = fallout.message_str(634, fallout.random(100, 105))
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
