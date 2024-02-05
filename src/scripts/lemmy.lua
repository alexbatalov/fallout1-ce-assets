local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local timed_event_p_proc
local SendLemmyAtDay
local Lemmy01
local Lemmy02
local Lemmy03
local Lemmy04
local Lemmy05
local Lemmy06
local Lemmy08
local Lemmy09
local Lemmy10
local Lemmy10a
local Lemmy10b
local Lemmy10c
local Lemmy11
local Lemmy12
local Lemmy13
local Lemmy14
local Lemmy15
local Lemmy16
local Lemmy17
local Lemmy18
local Lemmy19
local Lemmy20
local Lemmy20a
local Lemmy20b
local Lemmy20c
local Lemmy20d
local Lemmy20e
local Lemmy20f
local Lemmy21
local Lemmy22
local Lemmy23
local Lemmy24
local Lemmy24a
local Lemmy24b
local Lemmy24c
local Lemmy24d
local Lemmy24e
local Lemmy24f
local Lemmy25
local Lemmy26
local Lemmy27
local LemmyEnd
local LemmyCombat

local hostile = false
local initialized = false
local lastPsst = 0
local LastMove = 0
local SetDayNight = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, 1)
            fallout.item_caps_adjust(self_obj, 500)
        end
        misc.set_team(self_obj, 41)
        misc.set_ai(self_obj, 51)
        LastMove = 21325
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
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function combat()
    hostile = true
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if not SetDayNight then
        fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(5, 20)), 1)
        SetDayNight = true
    end
    if fallout.local_var(6) == 0 then
        if time.game_time_in_seconds() - lastPsst >= 10 and fallout.tile_distance_objs(self_obj, dude_obj) <= 6 then
            lastPsst = time.game_time_in_seconds()
            fallout.float_msg(self_obj, fallout.message_str(846, 101), 2)
        end
    end
    local self_tile_num = fallout.tile_num(self_obj)
    if self_tile_num == 21917 or self_tile_num == 20116 or self_tile_num == 25318 then
        if fallout.anim_busy(self_obj) == 0 then
            if fallout.has_trait(1, self_obj, 10) ~= 3 then
                fallout.anim(self_obj, 1000, 3)
            end
        end
    elseif self_tile_num == 26327 then
        if fallout.anim_busy(self_obj) == 0 then
            if fallout.has_trait(1, self_obj, 10) ~= 2 then
                fallout.anim(self_obj, 1000, 2)
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.set_local_var(6, 1)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(846, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Lemmy01()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(5) == 1 then
        fallout.start_gdialog(846, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Lemmy26()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        fallout.start_gdialog(846, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Lemmy27()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(846, 100))
end

function timed_event_p_proc()
    SendLemmyAtDay()
end

local WORK_TILES <const> = {
    25931,
    25551,
    21325,
    21917,
    18925,
    23322,
    26327,
    20116,
    25318,
}

function SendLemmyAtDay()
    local destination = 0
    local delay = fallout.random(25, 45)
    while destination == 0 do
        destination = WORK_TILES[fallout.random(1, #WORK_TILES)]
        if destination == LastMove then
            destination = 0
        end
    end
    LastMove = destination

    local self_obj = fallout.self_obj()
    fallout.reg_anim_func(2, self_obj)
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(self_obj, destination, -1)
    fallout.reg_anim_func(3, 0)
    fallout.rm_timer_event(self_obj)
    fallout.add_timer_event(self_obj, fallout.game_ticks(delay), 1)
end

function Lemmy01()
    fallout.gsay_reply(846, 102)
    fallout.giq_option(4, 846, 103, Lemmy03, 50)
    fallout.giq_option(4, 846, 104, Lemmy04, 50)
    fallout.giq_option(4, 846, 105, Lemmy05, 50)
    fallout.giq_option(-3, 846, 106, Lemmy02, 50)
end

function Lemmy02()
    fallout.gsay_reply(846, 107)
    fallout.giq_option(-3, 846, 108, LemmyEnd, 50)
end

function Lemmy03()
    fallout.set_local_var(5, 1)
    fallout.gsay_message(846, 109, 50)
end

function Lemmy04()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(846, 110)
    else
        fallout.gsay_reply(846, 178)
    end
    fallout.giq_option(4, 846, 111, Lemmy06, 50)
    fallout.giq_option(4, 846, 112, LemmyCombat, 51)
    fallout.giq_option(5, 846, 113, Lemmy03, 50)
end

function Lemmy05()
    fallout.gsay_reply(846, 114)
    fallout.giq_option(4, 846, 116, Lemmy23, 50)
    fallout.giq_option(4, 846, 117, Lemmy09, 50)
    fallout.giq_option(4, 846, 118, Lemmy03, 50)
end

function Lemmy06()
    fallout.gsay_reply(846, 119)
    fallout.giq_option(4, 846, 120, Lemmy05, 50)
    fallout.giq_option(4, 846, 121, Lemmy09, 50)
    fallout.giq_option(4, 846, 123, Lemmy08, 50)
end

function Lemmy08()
    fallout.gsay_message(846, 128, 50)
end

function Lemmy09()
    fallout.gsay_reply(846, 129)
    Lemmy18()
end

function Lemmy10()
    fallout.gsay_reply(846, 130)
    fallout.giq_option(4, 846, 131, Lemmy10a, 50)
    fallout.giq_option(4, 846, 132, Lemmy10b, 50)
    fallout.giq_option(4, 846, 133, Lemmy10c, 50)
    fallout.giq_option(4, 846, 134, Lemmy08, 50)
end

function Lemmy10a()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 500 then
        fallout.item_caps_adjust(dude_obj, -500)
        Lemmy13()
    else
        Lemmy11()
    end
end

function Lemmy10b()
    local dude_obj = fallout.dude_obj()
    if fallout.is_success(fallout.do_check(dude_obj, 3, -3)) or fallout.is_success(fallout.roll_vs_skill(dude_obj, 15, -30)) then
        if fallout.item_caps_total(dude_obj) >= 400 then
            fallout.item_caps_adjust(dude_obj, -400)
            Lemmy14()
        else
            Lemmy11()
        end
    else
        Lemmy11()
    end
end

function Lemmy10c()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 0, -3)) then
        Lemmy15()
    else
        Lemmy12()
    end
end

function Lemmy11()
    fallout.gsay_message(846, 135, 50)
end

function Lemmy12()
    fallout.set_local_var(5, 1)
    fallout.gsay_message(846, 136, 51)
end

function Lemmy13()
    fallout.gsay_message(846, 137, 50)
    Lemmy16()
end

function Lemmy14()
    fallout.gsay_message(846, 138, 50)
    Lemmy16()
end

function Lemmy15()
    fallout.gsay_message(846, 139, 50)
    Lemmy16()
end

function Lemmy16()
    fallout.gsay_reply(846, 140)
    fallout.giq_option(4, 846, 141, Lemmy17, 50)
    fallout.giq_option(4, 846, 142, Lemmy08, 50)
end

function Lemmy17()
    fallout.gsay_message(846, 143, 50)
    Lemmy18()
end

function Lemmy18()
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 846, 144, Lemmy10, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 846, 145, Lemmy19, 50)
    end
    if fallout.map_var(41) == 1 then
        fallout.giq_option(4, 846, 146, Lemmy20, 50)
    end
    fallout.giq_option(4, 846, 147, Lemmy23, 50)
    fallout.giq_option(4, 846, 148, Lemmy08, 50)
    fallout.giq_option(-3, 846, 106, Lemmy02, 50)
end

function Lemmy19()
    fallout.gsay_reply(846, 149)
    fallout.giq_option(4, 846, 150, Lemmy17, 50)
    fallout.giq_option(4, 846, 151, Lemmy08, 50)
end

function Lemmy20()
    fallout.gsay_reply(846, 152)
    fallout.giq_option(4, 846, 153, Lemmy20a, 50)
    fallout.giq_option(4, 846, 154, Lemmy20b, 50)
    fallout.giq_option(4, 846, 155, Lemmy20c, 50)
    fallout.giq_option(4, 846, 156, Lemmy08, 50)
end

function Lemmy20a()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 300 then
        fallout.item_caps_adjust(dude_obj, -300)
        Lemmy20d()
    else
        Lemmy11()
    end
end

function Lemmy20b()
    local dude_obj = fallout.dude_obj()
    if fallout.is_success(fallout.do_check(dude_obj, 3, -3)) or fallout.is_success(fallout.roll_vs_skill(dude_obj, 15, -30)) then
        if fallout.item_caps_total(dude_obj) >= 240 then
            fallout.item_caps_adjust(dude_obj, -240)
            Lemmy20e()
        else
            Lemmy11()
        end
    else
        Lemmy11()
    end
end

function Lemmy20c()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 0, -3)) then
        Lemmy20f()
    else
        Lemmy12()
    end
end

function Lemmy20d()
    fallout.gsay_message(846, 137, 50)
    Lemmy21()
end

function Lemmy20e()
    fallout.gsay_message(846, 138, 50)
    Lemmy21()
end

function Lemmy20f()
    fallout.gsay_message(846, 139, 50)
    Lemmy21()
end

function Lemmy21()
    fallout.gsay_reply(846, 157)
    fallout.giq_option(4, 846, 158, Lemmy22, 50)
    fallout.giq_option(4, 846, 159, Lemmy17, 50)
    fallout.giq_option(4, 846, 160, Lemmy08, 50)
end

function Lemmy22()
    fallout.gsay_reply(846, 161)
    fallout.giq_option(4, 846, 162, Lemmy17, 50)
    fallout.giq_option(4, 846, 163, LemmyCombat, 51)
    fallout.giq_option(4, 846, 164, Lemmy08, 50)
end

function Lemmy23()
    fallout.gsay_reply(846, 165)
    fallout.giq_option(4, 846, 166, Lemmy24, 50)
    fallout.giq_option(4, 846, 167, Lemmy08, 50)
end

function Lemmy24()
    fallout.gsay_reply(846, 168)
    fallout.giq_option(4, 846, 169, Lemmy24a, 50)
    fallout.giq_option(4, 846, 170, Lemmy24b, 50)
    fallout.giq_option(4, 846, 171, Lemmy24c, 50)
    fallout.giq_option(4, 846, 172, Lemmy08, 50)
end

function Lemmy24a()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 1000 then
        fallout.item_caps_adjust(dude_obj, -1000)
        Lemmy24d()
    else
        Lemmy11()
    end
end

function Lemmy24b()
    local dude_obj = fallout.dude_obj()
    if fallout.is_success(fallout.do_check(dude_obj, 3, -3)) or fallout.is_success(fallout.roll_vs_skill(dude_obj, 15, -30)) then
        if fallout.item_caps_total(dude_obj) >= 800 then
            fallout.item_caps_adjust(dude_obj, -800)
            Lemmy24e()
        else
            Lemmy11()
        end
    else
        Lemmy11()
    end
end

function Lemmy24c()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 0, -3)) then
        Lemmy24f()
    else
        Lemmy12()
    end
end

function Lemmy24d()
    fallout.gsay_message(846, 137, 50)
    Lemmy25()
end

function Lemmy24e()
    fallout.gsay_message(846, 138, 50)
    Lemmy25()
end

function Lemmy24f()
    fallout.gsay_message(846, 139, 50)
    Lemmy25()
end

function Lemmy25()
    fallout.set_global_var(236, 1)
    fallout.gsay_reply(846, 173)
    fallout.giq_option(4, 846, 174, Lemmy17, 50)
    fallout.giq_option(4, 846, 175, Lemmy08, 50)
end

function Lemmy26()
    fallout.gsay_message(846, 176, 50)
end

function Lemmy27()
    fallout.gsay_reply(846, 177)
    Lemmy18()
end

function LemmyEnd()
end

function LemmyCombat()
    fallout.set_local_var(5, 1)
    combat()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
