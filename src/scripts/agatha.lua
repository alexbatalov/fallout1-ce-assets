local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local timed_event_p_proc
local Agatha00
local Agatha01
local Agatha02
local Agatha03
local Agatha04
local Agatha05
local Agatha06
local Agatha07
local Agatha08
local Agatha09
local Agatha10
local Agatha11
local Agatha12
local Agatha13
local Agatha14
local Agatha15
local Agatha16
local Agatha17
local Agatha18
local Agatha19
local Agatha20
local AgathaEnd

local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
end

function description_p_proc()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0))) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(663, 102))
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) then
        fallout.display_msg(fallout.message_str(663, 101))
    else
        fallout.display_msg(fallout.message_str(663, 100))
    end
end

function talk_p_proc()
    fallout.start_gdialog(663, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) then
        if fallout.local_var(5) then
            Agatha14()
        else
            if fallout.local_var(1) > 1 then
                Agatha16()
            else
                AgathaEnd()
            end
        end
    else
        Agatha08()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function timed_event_p_proc()
end

function Agatha00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(663, 103), 0)
end

function Agatha01()
    fallout.gsay_reply(663, 104)
    fallout.giq_option(-3, 663, 105, Agatha02, 49)
    fallout.giq_option(4, 663, 106, AgathaEnd, 50)
    fallout.giq_option(5, 663, 107, Agatha03, 50)
    fallout.giq_option(4, 663, 108, Agatha04, 50)
end

function Agatha02()
    fallout.gsay_message(663, 109, 49)
end

function Agatha03()
    fallout.gsay_reply(663, 110)
    fallout.giq_option(5, 663, 111, AgathaEnd, 49)
    fallout.giq_option(6, 663, 112, Agatha04, 50)
    fallout.giq_option(5, 663, 113, AgathaEnd, 50)
end

function Agatha04()
    fallout.gsay_reply(663, 114)
    fallout.giq_option(5, 663, 115, AgathaEnd, 49)
end

function Agatha05()
    fallout.gsay_message(663, 116, 50)
end

function Agatha06()
    reaction.UpReact()
    fallout.gsay_message(663, 117, 49)
end

function Agatha07()
    fallout.gsay_message(663, 118, 50)
end

function Agatha08()
    fallout.gsay_reply(663, 119)
    fallout.giq_option(-3, 663, 120, Agatha09, 50)
    fallout.giq_option(4, 663, 121, Agatha10, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        fallout.giq_option(5, 663, 122, Agatha13, 50)
    else
        fallout.giq_option(7, 663, 123, Agatha13, 50)
    end
    fallout.giq_option(4, 663, 124, Agatha09, 51)
end

function Agatha09()
    fallout.gsay_message(663, 125, 50)
end

function Agatha10()
    fallout.gsay_reply(663, 126)
    fallout.giq_option(4, 663, 127, Agatha11, 50)
    fallout.giq_option(4, 663, 128, AgathaEnd, 50)
    fallout.giq_option(6, 663, 129, Agatha12, 49)
end

function Agatha11()
    fallout.gsay_message(663, 130, 50)
end

function Agatha12()
    reaction.UpReact()
    fallout.gsay_message(663, 131, 50)
end

function Agatha13()
    fallout.gsay_message(663, 132, 50)
end

function Agatha14()
    fallout.gsay_reply(663, 133)
    fallout.giq_option(-3, 663, 134, AgathaEnd, 50)
    fallout.giq_option(4, 663, 135, AgathaEnd, 50)
    fallout.giq_option(6, 663, 136, Agatha15, 50)
end

function Agatha15()
    fallout.gsay_message(663, 137, 50)
end

function Agatha16()
    fallout.gsay_reply(663, 138)
    fallout.giq_option(-3, 663, 139, Agatha17, 50)
    fallout.giq_option(4, 663, 140, Agatha20, 50)
    fallout.giq_option(6, 663, 141, Agatha18, 50)
    fallout.giq_option(4, 663, 142, AgathaEnd, 50)
end

function Agatha17()
    fallout.gsay_message(663, 143, 50)
end

function Agatha18()
    fallout.gsay_reply(663, 144)
    fallout.giq_option(5, 663, 145, Agatha20, 50)
    fallout.giq_option(5, 663, 146, Agatha19, 51)
end

function Agatha19()
    reaction.DownReactLevel()
    reaction.DownReactLevel()
    fallout.gsay_message(663, 147, 51)
end

function Agatha20()
end

function AgathaEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
