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
local Cleo00
local Cleo01
local Cleo02
local Cleo03
local Cleo04
local Cleo05
local Cleo06
local Cleo07
local Cleo08
local Cleo09
local Cleo10
local Cleo11
local Cleo12
local Cleo13
local Cleo14
local Cleo15
local Cleo16
local Cleo17
local Cleo18
local Cleo19
local Cleo20
local Cleo21
local Cleo22
local CleoEnd

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 39)
        fallout.critter_add_trait(self_obj, 1, 5, 52)
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
    if fallout.map_var(1) == 1 then
        Cleo01()
    else
        if fallout.global_var(107) ~= 2 then
            fallout.start_gdialog(560, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Cleo02()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.start_gdialog(560, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Cleo03()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(560, 100))
end

function Cleo00()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(560, 101), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(560, 102), 2)
    end
    combat()
end

function Cleo01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(560, 103), 2)
end

function Cleo02()
    fallout.gsay_reply(560, 104)
    if fallout.map_var(2) == 1 then
        fallout.giq_option(4, 560, 106, Cleo05, 50)
    end
    if fallout.global_var(207) == 1 then
        fallout.giq_option(4, 560, 105, Cleo04, 50)
    end
    fallout.giq_option(4, 560, 107, Cleo06, 50)
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 560, 108, Cleo07, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 560, 109, Cleo08, 50)
    end
    fallout.giq_option(4, 560, 110, Cleo09, 50)
    fallout.giq_option(-3, 560, 111, Cleo10, 50)
end

function Cleo03()
    fallout.gsay_reply(560, 112)
    if fallout.global_var(207) == 1 then
        fallout.giq_option(4, 560, 113, Cleo11, 50)
    end
    if fallout.map_var(2) == 1 then
        fallout.giq_option(4, 560, 114, Cleo05, 50)
    end
    fallout.giq_option(4, 560, 115, Cleo12, 50)
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 560, 116, Cleo13, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 560, 117, Cleo14, 50)
    end
    fallout.giq_option(4, 560, 119, Cleo09, 50)
    fallout.giq_option(-3, 560, 120, Cleo10, 50)
end

function Cleo04()
    fallout.gsay_reply(560, 121)
    if fallout.map_var(2) == 1 then
        fallout.giq_option(4, 560, 122, Cleo05, 50)
    end
    fallout.giq_option(4, 560, 123, Cleo06, 50)
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 560, 124, Cleo07, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 560, 125, Cleo08, 50)
    end
    fallout.giq_option(4, 560, 126, Cleo09, 50)
    fallout.giq_option(-3, 560, 127, Cleo10, 50)
end

function Cleo05()
    fallout.gsay_reply(560, 128)
    if fallout.global_var(207) == 1 then
        fallout.giq_option(4, 560, 129, Cleo04, 50)
    end
    fallout.giq_option(4, 560, 131, Cleo06, 50)
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 560, 132, Cleo07, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 560, 133, Cleo08, 50)
    end
    fallout.giq_option(4, 560, 134, Cleo09, 50)
    fallout.giq_option(-3, 560, 135, Cleo10, 50)
end

function Cleo06()
    fallout.gsay_reply(560, 136)
    if fallout.global_var(207) == 1 then
        fallout.giq_option(4, 560, 137, Cleo04, 50)
    end
    if fallout.map_var(2) == 1 then
        fallout.giq_option(4, 560, 138, Cleo05, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 560, 139, Cleo07, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 560, 140, Cleo08, 50)
    end
    fallout.giq_option(4, 560, 141, Cleo09, 50)
    fallout.giq_option(-3, 560, 142, Cleo10, 50)
end

function Cleo07()
    fallout.gsay_reply(560, 143)
    if fallout.global_var(207) == 1 then
        fallout.giq_option(4, 560, 144, Cleo04, 50)
    end
    if fallout.map_var(2) == 1 then
        fallout.giq_option(4, 560, 145, Cleo05, 50)
    end
    fallout.giq_option(4, 560, 146, Cleo06, 50)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 560, 147, Cleo08, 50)
    end
    fallout.giq_option(4, 560, 148, Cleo09, 50)
    fallout.giq_option(-3, 560, 149, Cleo10, 50)
end

function Cleo08()
    fallout.gsay_reply(560, 150)
    if fallout.global_var(207) == 1 then
        fallout.giq_option(4, 560, 151, Cleo04, 50)
    end
    if fallout.map_var(2) == 1 then
        fallout.giq_option(4, 560, 152, Cleo05, 50)
    end
    fallout.giq_option(4, 560, 153, Cleo06, 50)
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 560, 154, Cleo07, 50)
    end
    fallout.giq_option(4, 560, 155, Cleo09, 50)
    fallout.giq_option(-3, 560, 156, Cleo10, 50)
end

function Cleo09()
    fallout.gsay_message(560, 157, 50)
end

function Cleo10()
    fallout.gsay_message(560, 158, 50)
end

function Cleo11()
    fallout.gsay_reply(560, 159)
    if fallout.map_var(2) == 1 then
        fallout.giq_option(4, 560, 160, Cleo05, 50)
    end
    fallout.giq_option(4, 560, 161, Cleo12, 50)
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 560, 162, Cleo13, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.gsay_message(560, 4, 50)
    end
    fallout.giq_option(4, 560, 165, Cleo09, 50)
    fallout.giq_option(-3, 560, 166, Cleo10, 50)
end

function Cleo12()
    fallout.gsay_reply(560, 167)
    if fallout.global_var(207) == 1 then
        fallout.giq_option(4, 560, 168, Cleo11, 50)
    end
    if fallout.map_var(2) == 1 then
        fallout.giq_option(4, 560, 169, Cleo05, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 560, 170, Cleo13, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 560, 171, Cleo14, 50)
    end
    fallout.giq_option(4, 560, 173, Cleo09, 50)
    fallout.giq_option(-3, 560, 174, Cleo10, 50)
end

function Cleo13()
    fallout.gsay_message(560, 175, 50)
end

function Cleo14()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(560, 176)
    fallout.giq_option(4, 560, 177, Cleo15, 50)
    fallout.giq_option(4, 560, 178, Cleo16, 50)
    fallout.giq_option(4, 560, 179, Cleo17, 50)
    fallout.giq_option(4, 560, 180, Cleo18, 50)
end

function Cleo15()
    fallout.gsay_message(560, 181, 50)
end

function Cleo16()
    fallout.gsay_message(560, 182, 50)
end

function Cleo17()
    fallout.gsay_reply(560, 183)
    fallout.giq_option(4, 560, 184, Cleo20, 50)
    fallout.giq_option(4, 560, 185, Cleo20, 50)
    fallout.giq_option(4, 560, 186, Cleo21, 50)
    fallout.giq_option(4, 560, 187, Cleo22, 50)
end

function Cleo18()
    fallout.gsay_message(560, 188, 50)
end

function Cleo19()
    fallout.gsay_message(560, 189, 50)
end

function Cleo20()
    fallout.gsay_message(560, 190, 50)
end

function Cleo21()
    fallout.gsay_message(560, 191, 50)
end

function Cleo22()
    fallout.gsay_message(560, 192, 50)
end

function CleoEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
