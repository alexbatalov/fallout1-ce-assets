local fallout = require("fallout")
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

local hostile = 0
local Only_Once = 1
local lastPsst = 0
local Destination = 0
local LastMove = 0
local SetDayNight = 0

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
    local v0 = 0
    if Only_Once then
        Only_Once = 0
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, 1)
            v0 = fallout.item_caps_adjust(fallout.self_obj(), 500)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 41)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 51)
        LastMove = 21325
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
                    else
                        if fallout.script_action() == 22 then
                            timed_event_p_proc()
                        end
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
    local v0 = 0
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if SetDayNight == 0 then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(5, 20)), 1)
        SetDayNight = 1
    end
    if fallout.local_var(6) == 0 then
        if ((time.game_time_in_seconds() - lastPsst) >= 10) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 6) then
            lastPsst = time.game_time_in_seconds()
            fallout.float_msg(fallout.self_obj(), fallout.message_str(846, 101), 2)
        end
    end
    v0 = fallout.tile_num(fallout.self_obj())
    if (v0 == 21917) or (v0 == 20116) or (v0 == 25318) then
        if fallout.anim_busy(fallout.self_obj()) == 0 then
            if fallout.has_trait(1, fallout.self_obj(), 10) ~= 3 then
                fallout.anim(fallout.self_obj(), 1000, 3)
            end
        end
    else
        if v0 == 26327 then
            if fallout.anim_busy(fallout.self_obj()) == 0 then
                if fallout.has_trait(1, fallout.self_obj(), 10) ~= 2 then
                    fallout.anim(fallout.self_obj(), 1000, 2)
                end
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    get_reaction()
    fallout.set_local_var(6, 1)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(846, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Lemmy01()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        if fallout.local_var(5) == 1 then
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
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
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

function SendLemmyAtDay()
    local v0 = 0
    Destination = 0
    v0 = fallout.random(25, 45)
    while Destination == 0 do
        Destination = fallout.random(1, 9)
        if Destination == 1 then
            Destination = 25931
        else
            if Destination == 2 then
                Destination = 25551
            else
                if Destination == 3 then
                    Destination = 21325
                else
                    if Destination == 4 then
                        Destination = 21917
                    else
                        if Destination == 5 then
                            Destination = 18925
                        else
                            if Destination == 6 then
                                Destination = 23322
                            else
                                if Destination == 7 then
                                    Destination = 26327
                                else
                                    if Destination == 8 then
                                        Destination = 20116
                                    else
                                        if Destination == 9 then
                                            Destination = 25318
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if Destination == LastMove then
            Destination = 0
        end
    end
    LastMove = Destination
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), Destination, -1)
    fallout.reg_anim_func(3, 0)
    fallout.rm_timer_event(fallout.self_obj())
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(v0), 1)
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
    local v0 = 0
    if fallout.item_caps_total(fallout.dude_obj()) >= 500 then
        v0 = fallout.item_caps_adjust(fallout.dude_obj(), -500)
        Lemmy13()
    else
        Lemmy11()
    end
end

function Lemmy10b()
    local v0 = 0
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -3)) or fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, -30)) then
        if fallout.item_caps_total(fallout.dude_obj()) >= 400 then
            v0 = fallout.item_caps_adjust(fallout.dude_obj(), -400)
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
    local v0 = 0
    if fallout.item_caps_total(fallout.dude_obj()) >= 300 then
        v0 = fallout.item_caps_adjust(fallout.dude_obj(), -300)
        Lemmy20d()
    else
        Lemmy11()
    end
end

function Lemmy20b()
    local v0 = 0
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -3)) or fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, -30)) then
        if fallout.item_caps_total(fallout.dude_obj()) >= 240 then
            v0 = fallout.item_caps_adjust(fallout.dude_obj(), -240)
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
    local v0 = 0
    if fallout.item_caps_total(fallout.dude_obj()) >= 1000 then
        v0 = fallout.item_caps_adjust(fallout.dude_obj(), -1000)
        Lemmy24d()
    else
        Lemmy11()
    end
end

function Lemmy24b()
    local v0 = 0
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -3)) or fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, -30)) then
        if fallout.item_caps_total(fallout.dude_obj()) >= 800 then
            v0 = fallout.item_caps_adjust(fallout.dude_obj(), -800)
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
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
