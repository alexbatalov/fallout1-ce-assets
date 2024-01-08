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

local hostile = false
local initialized = false
local go_away = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.set_external_var("Richie_Ptr", self_obj)
        fallout.critter_add_trait(self_obj, 1, 6, 73)
        fallout.critter_add_trait(self_obj, 1, 5, 1)
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
    if fallout.map_var(23) == 1 or fallout.map_var(15) > 0 or fallout.map_var(18) == 2 then
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
    if go_away then
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
    go_away = true
end

function Richie04()
    fallout.gsay_message(599, 112, 51)
end

function Richie05()
    fallout.gsay_message(599, 113, 49)
    go_away = true
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

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
