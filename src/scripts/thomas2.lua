local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Do_Dialogue
local thomasend
local thomas00
local thomas01
local thomas02
local thomas03
local thomas04
local thomas05
local thomas06
local thomas07
local thomas08
local thomas09
local thomas10
local thomas11
local thomas12
local thomas13
local thomas14
local thomas15
local thomas16
local thomas17
local thomas18
local thomas19
local thomas20
local thomas21
local thomas22

local hostile = false
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 64)
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
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
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
    fallout.start_gdialog(685, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Do_Dialogue()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(685, 100))
end

function Do_Dialogue()
    if fallout.local_var(4) ~= 1 then
        fallout.set_local_var(4, 1)
        if fallout.local_var(1) == 1 then
            thomas01()
        else
            thomas00()
        end
    elseif fallout.local_var(1) == 1 then
        if fallout.local_var(6) ~= 0 then
            thomas09()
        else
            thomas08()
        end
    else
        if fallout.local_var(6) ~= 0 then
            thomas20()
        else
            thomas19()
        end
    end
end

function thomasend()
end

function thomas00()
    fallout.gsay_reply(685, 101)
    fallout.giq_option(4, 685, 102, thomas05, 50)
    fallout.giq_option(4, 685, 103, thomas06, 50)
    fallout.giq_option(4, 685, 104, thomas04, 50)
    fallout.giq_option(4, 685, 105, thomasend, 50)
    fallout.giq_option(-3, 685, 106, thomas02, 50)
end

function thomas01()
    fallout.gsay_reply(685, 108)
    fallout.giq_option(4, 685, 102, thomas05, 50)
    fallout.giq_option(4, 685, 103, thomas06, 50)
    fallout.giq_option(4, 685, 104, thomas04, 50)
    fallout.giq_option(4, 685, 105, thomasend, 50)
    fallout.giq_option(-3, 685, 106, thomas02, 50)
end

function thomas02()
    fallout.gsay_message(685, 109, 51)
end

function thomas03()
    fallout.gsay_message(685, 110, 51)
end

function thomas04()
    fallout.gsay_message(685,
        fallout.message_str(685, 111) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(685, 112), 51)
end

function thomas05()
    fallout.gsay_message(685, 113, 50)
end

function thomas06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(685, 114)
    else
        fallout.gsay_reply(685, 115)
    end
    thomas10()
end

function thomas07()
    fallout.gsay_reply(685, 125)
    thomas10()
end

function thomas08()
    if fallout.local_var(5) ~= 0 then
        fallout.set_local_var(5, 1)
        fallout.gsay_reply(685, 126)
    else
        fallout.gsay_reply(685, 127)
    end
    thomas10()
end

function thomas09()
    fallout.gsay_reply(685, 125)
    fallout.giq_option(4, 685, 102, thomas05, 50)
    fallout.giq_option(4, 685, 103, thomas06, 50)
    fallout.giq_option(4, 685, 104, thomas04, 50)
    fallout.giq_option(4, 685, 105, thomas21, 50)
    fallout.giq_option(-3, 685, 107, thomas02, 50)
end

function thomas10()
    fallout.giq_option(4, 685, 118, thomas11, 50)
    fallout.giq_option(4, 685, 119, thomas12, 50)
    fallout.giq_option(4, 685, 120, thomas13, 50)
    fallout.giq_option(4, 685, 121, thomas14, 50)
    fallout.giq_option(4, 685, 122, thomas15, 50)
    fallout.giq_option(4, 685, 123, thomas16, 50)
    fallout.giq_option(4, 685, 124, thomas17, 50)
    fallout.giq_option(-3, 685, 106, thomas02, 50)
end

function thomas11()
    fallout.gfade_out(600)
    fallout.gfade_in(600)
    fallout.display_msg(fallout.message_str(685, 130))
    fallout.set_local_var(6, 1)
end

function thomas12()
    fallout.gfade_out(600)
    fallout.gfade_in(600)
    fallout.display_msg(fallout.message_str(685, 132))
    fallout.set_local_var(6, 1)
end

function thomas13()
    fallout.gfade_out(600)
    fallout.gfade_in(600)
    fallout.display_msg(fallout.message_str(685, 134))
    fallout.set_local_var(6, 1)
end

function thomas14()
    fallout.gfade_out(600)
    fallout.gfade_in(600)
    fallout.display_msg(fallout.message_str(685, 135))
    fallout.set_local_var(6, 1)
end

function thomas15()
    fallout.gfade_out(600)
    fallout.gfade_in(600)
    fallout.display_msg(fallout.message_str(685, 136))
    fallout.set_local_var(6, 1)
end

function thomas16()
    fallout.gfade_out(600)
    fallout.gfade_in(600)
    fallout.display_msg(fallout.message_str(685, 137))
    fallout.set_local_var(6, 1)
end

function thomas17()
    fallout.gsay_message(685, 138, 50)
end

function thomas18()
    fallout.gsay_message(685, 139, 51)
end

function thomas19()
    if fallout.local_var(5) ~= 0 then
        fallout.set_local_var(5, 1)
        fallout.gsay_reply(685, 140)
    else
        fallout.gsay_reply(685, 127)
    end
    thomas10()
end

function thomas20()
    fallout.gsay_reply(685, 140)
    fallout.giq_option(4, 685, 102, thomas03, 50)
    fallout.giq_option(4, 685, 103, thomas07, 50)
    fallout.giq_option(4, 685, 104, thomas04, 50)
    fallout.giq_option(4, 685, 105, thomas22, 50)
    fallout.giq_option(-3, 685, 107, thomas02, 50)
end

function thomas21()
    fallout.gsay_message(685, 142, 50)
end

function thomas22()
    fallout.gsay_message(685, 143, 51)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
