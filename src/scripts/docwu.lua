local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local timed_event_p_proc
local DocWu00
local DocWu01
local DocWu02
local DocWu03
local DocWu04
local DocWu05
local DocWu06
local DocWu06a
local DocWu07
local DocWu08
local DocWu09
local DocWu10
local DocWu10a
local DocWu10b
local DocWu10c
local DocWu11
local DocWu12
local DocWu13
local DocWu14
local DocWu15
local DocWu16
local DocWu17
local DocWu17a
local DocWu17b
local DocWu18
local DocWu19
local DocWu19a
local DocWu19b
local DocWu20
local DocWu20a
local DocWu20b
local DocWu21
local DocWu21a
local DocWu22
local DocWu23
local DocWu24
local DocWu24a
local DocWu24b
local DocWuOpts1
local DocWuOpts2
local DocWuOpts3
local DocWuOpts4
local DocWuOpts5
local DocWuOpts5a
local DocWuEnd

local healing = 0
local initialized = false
local hostile = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 20)
        fallout.critter_add_trait(self_obj, 1, 5, 69)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(400, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    healing = 0
    if fallout.local_var(5) == 1 then
        DocWu00()
    else
        if fallout.local_var(6) == 1 then
            DocWu01()
        else
            if fallout.local_var(7) == 1 then
                DocWu02()
            else
                DocWu03()
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if healing then
        fallout.use_obj(fallout.dude_obj())
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 1)
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if event == 1 then
        if healing == 1 or healing == 3 then
            fallout.float_msg(dude_obj, fallout.message_str(400, 138), 2)
        elseif healing == 2 then
            fallout.float_msg(dude_obj, fallout.message_str(400, 152), 2)
        elseif healing == 4 then
            fallout.float_msg(dude_obj, fallout.message_str(400, 175), 2)
        elseif healing == 5 then
            fallout.float_msg(self_obj, fallout.message_str(400, 150), 8)
        elseif healing == 6 then
            fallout.float_msg(self_obj, fallout.message_str(400, 178), 8)
        end
        fallout.add_timer_event(self_obj, fallout.game_ticks(3), 2)
    elseif event == 2 then
        if healing < 4 then
            fallout.float_msg(self_obj, fallout.message_str(400, 139), 8)
        elseif healing == 4 then
            fallout.float_msg(self_obj, fallout.message_str(400, 176), 8)
        end
        fallout.add_timer_event(self_obj, fallout.game_ticks(3), 3)
    elseif event == 3 then
        if healing == 1 then
            if fallout.get_critter_stat(dude_obj, 34) == 0 then
                fallout.float_msg(self_obj, fallout.message_str(400, 140), 8)
            else
                fallout.float_msg(self_obj, fallout.message_str(400, 141), 8)
            end
        elseif healing == 2 then
            fallout.float_msg(self_obj, fallout.message_str(400, 153), 8)
        elseif healing == 3 then
            if fallout.get_critter_stat(dude_obj, 34) == 0 then
                fallout.float_msg(self_obj, fallout.message_str(400, 167), 8)
            else
                fallout.float_msg(self_obj, fallout.message_str(400, 168), 8)
            end
        end
    end
end

function DocWu00()
    fallout.set_local_var(4, 1)
    fallout.set_local_var(5, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(400, fallout.message_str(400, 102))
    else
        fallout.gsay_reply(400, fallout.message_str(400, 103))
    end
    fallout.giq_option(7, 400, 106, DocWu04, 50)
    DocWuOpts1()
    fallout.giq_option(4, 400, 109, DocWu07, 50)
    DocWuOpts2()
    fallout.giq_option(4, 400, 111, DocWu09, 50)
    DocWuOpts3()
end

function DocWu01()
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(400, 113)
    fallout.giq_option(7, 400, 114, DocWu11, 50)
    DocWuOpts1()
    fallout.giq_option(4, 400, 115, DocWu12, 50)
    DocWuOpts2()
    fallout.giq_option(4, 400, 116, DocWu09, 50)
    DocWuOpts3()
end

function DocWu02()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(400, 117)
    fallout.giq_option(7, 400, 118, DocWu13, 50)
    DocWuOpts1()
    fallout.giq_option(4, 400, 119, DocWu12, 50)
    DocWuOpts2()
    fallout.giq_option(4, 400, 120, DocWu14, 50)
    DocWuOpts3()
end

function DocWu03()
    fallout.set_local_var(5, 0)
    fallout.set_local_var(6, 0)
    fallout.set_local_var(7, 0)
    fallout.gsay_reply(400, 121)
    fallout.giq_option(7, 400, 122, DocWu15, 50)
    DocWuOpts1()
    fallout.giq_option(4, 400, 123, DocWu12, 50)
    DocWuOpts2()
    fallout.giq_option(4, 400, 124, DocWu14, 50)
    DocWuOpts3()
end

function DocWu04()
    fallout.gsay_reply(400, 125)
    fallout.giq_option(7, 400, 126, DocWu16, 50)
    DocWuOpts4()
end

function DocWu05()
    fallout.gsay_reply(400, 130)
    fallout.giq_option(0, 400, 101, DocWuEnd, 50)
end

function DocWu06()
    fallout.gsay_reply(400, 131)
    fallout.giq_option(0, 400, 100, DocWu06a, 50)
end

function DocWu06a()
    healing = 1
end

function DocWu07()
    fallout.gsay_reply(400, 142)
    DocWuOpts4()
end

function DocWu08()
    fallout.gsay_reply(400, 143)
    fallout.giq_option(0, 400, 101, DocWuEnd, 50)
end

function DocWu09()
    fallout.gsay_reply(400, 144)
    fallout.giq_option(4, 400, 145, DocWu06, 50)
    fallout.giq_option(4, 400, 146, DocWu23, 50)
    fallout.giq_option(4, 400, 147, DocWu24, 50)
end

function DocWu10()
    fallout.gsay_reply(400, 148)
    fallout.giq_option(0, 400, 100, DocWu10a, 50)
end

function DocWu10a()
    fallout.gsay_reply(400, 151)
    fallout.giq_option(0, 400, 100, DocWu10c, 50)
end

function DocWu10b()
    healing = 5
end

function DocWu10c()
    healing = 2
end

function DocWu11()
    fallout.gsay_reply(400, 154)
    DocWuOpts4()
end

function DocWu12()
    fallout.gsay_reply(400, 155)
    DocWuOpts4()
end

function DocWu13()
    fallout.gsay_reply(400, 156)
    DocWuOpts4()
end

function DocWu14()
    fallout.gsay_reply(400, 157)
    fallout.giq_option(4, 400, 158, DocWu06, 50)
    fallout.giq_option(4, 400, 159, DocWu23, 50)
    fallout.giq_option(4, 400, 160, DocWu24, 50)
end

function DocWu15()
    fallout.gsay_reply(400, 161)
    fallout.giq_option(4, 400, 162, DocWu06, 50)
    fallout.giq_option(4, 400, 163, DocWu23, 50)
    fallout.giq_option(4, 400, 160, DocWu24, 50)
end

function DocWu16()
    fallout.gsay_reply(400, 164)
    fallout.giq_option(4, 400, 162, DocWu06, 50)
    fallout.giq_option(4, 400, 163, DocWu23, 50)
    fallout.giq_option(4, 400, 160, DocWu24, 50)
end

function DocWu17()
    fallout.gsay_reply(400, 165)
    fallout.giq_option(0, 400, 100, DocWu17a, 50)
end

function DocWu17a()
    fallout.gsay_reply(400, 166)
    fallout.giq_option(0, 400, 100, DocWu17b, 50)
end

function DocWu17b()
    healing = 3
end

function DocWu18()
    fallout.gsay_reply(400, 169)
    fallout.giq_option(0, 400, 101, DocWuEnd, 50)
end

function DocWu19()
    local dude_obj = fallout.dude_obj()
    local max_hit_points = fallout.get_critter_stat(dude_obj, 7)
    local curr_hit_points = fallout.get_critter_stat(dude_obj, 35)
    if curr_hit_points == max_hit_points then
        fallout.gsay_reply(400, 170)
        fallout.giq_option(0, 400, 101, DocWuEnd, 50)
    elseif curr_hit_points > max_hit_points // 2 then
        DocWu19a()
    else
        DocWu19b()
    end
end

function DocWu19a()
    fallout.gsay_reply(400, 171)
    fallout.giq_option(4, 400, 127, DocWu06, 50)
    fallout.giq_option(4, 400, 173, DocWu23, 50)
end

function DocWu19b()
    fallout.gsay_reply(400, 171)
    fallout.giq_option(4, 400, 127, DocWu06, 50)
    fallout.giq_option(4, 400, 173, DocWu18, 50)
end

function DocWu20()
    fallout.gsay_reply(400, 174)
    fallout.giq_option(0, 400, 100, DocWu20a, 50)
end

function DocWu20a()
    fallout.gsay_reply(400, 137)
    fallout.giq_option(0, 400, 100, DocWu20b, 50)
end

function DocWu20b()
    healing = 4
end

function DocWu21()
    fallout.gsay_reply(400, 177)
    fallout.giq_option(0, 400, 100, DocWu21a, 50)
end

function DocWu21a()
    healing = 6
end

function DocWu22()
    fallout.gsay_reply(400, 179)
    fallout.giq_option(0, 400, 101, DocWuEnd, 50)
end

function DocWu23()
    fallout.gsay_reply(400, 180)
    fallout.giq_option(0, 400, 101, DocWuEnd, 50)
end

function DocWu24()
    local dude_obj = fallout.dude_obj()
    local max_hit_points = fallout.get_critter_stat(dude_obj, 7)
    local curr_hit_points = fallout.get_critter_stat(dude_obj, 35)
    if curr_hit_points == max_hit_points then
        fallout.gsay_reply(400, 170)
        fallout.giq_option(0, 400, 101, DocWuEnd, 50)
    elseif curr_hit_points > (max_hit_points // 2) then
        DocWu24a()
    else
        DocWu24b()
    end
end

function DocWu24a()
    fallout.gsay_reply(400, 181)
    fallout.giq_option(4, 400, 127, DocWu17, 50)
    fallout.giq_option(4, 400, 173, DocWu23, 50)
end

function DocWu24b()
    fallout.gsay_reply(400, 182)
    fallout.giq_option(4, 400, 183, DocWu06, 50)
    fallout.giq_option(4, 400, 173, DocWu23, 50)
end

function DocWuOpts1()
    fallout.giq_option(4, 400, 107, DocWu05, 50)
    fallout.giq_option(4, 400, 108, DocWu06, 50)
end

function DocWuOpts2()
    fallout.giq_option(4, 400, 110, DocWu08, 50)
end

function DocWuOpts3()
    fallout.giq_option(-3, 400, 112, DocWu10, 50)
    fallout.giq_option(-3, 400, 184, DocWuEnd, 50)
end

function DocWuOpts4()
    fallout.giq_option(4, 400, 127, DocWu17, 50)
    fallout.giq_option(4, 400, 128, DocWu18, 50)
    fallout.giq_option(4, 400, 129, DocWu19, 50)
end

function DocWuOpts5()
    fallout.gsay_reply(400, 132)
    fallout.giq_option(7, 400, 133, DocWuOpts5a, 50)
    fallout.giq_option(4, 400, 134, DocWu21, 50)
    fallout.giq_option(4, 400, 135, DocWu22, 50)
    fallout.giq_option(4, 400, 136, DocWuOpts5a, 50)
end

function DocWuOpts5a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        DocWu20()
    else
        DocWu21()
    end
end

function DocWuEnd()
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
