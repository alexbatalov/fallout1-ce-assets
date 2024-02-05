local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local combat_p_proc
local damage_p_proc
local Justin00
local Justin01
local Justin01a
local Justin01b
local Justin02
local Justin03
local Justin04
local Justin05a
local Justin05b
local Justin06
local Justin07
local Justin08
local Justin09
local Justin10
local Justin11
local Justin12
local Justin13
local Justin14
local Justin15
local Justin15a
local Justin15b
local Justin15c
local Justin15d
local Justin16
local Justin17
local Justin18
local Justin19
local Justin20
local Justin26
local Justin27
local Justin28
local Justin29
local Justin30
local Justin31
local Justin32
local Justin33
local Justin34
local Justin35
local JustinEnd
local JustinCombat
local JustinTravel
local GoToDecker

local hostile = false
local initialized = false
local travel = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.set_external_var("Justin_Ptr", self_obj)
        if fallout.global_var(221) == 1 then
            fallout.set_obj_visibility(self_obj, false)
        end
        misc.set_team(self_obj, 40)
        fallout.critter_add_trait(self_obj, 1, 5, 86)
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
    elseif script_action == 13 then
        combat_p_proc()
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
    if travel then
        travel = false
        GoToDecker()
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.map_var(53) == 1 then
        fallout.set_map_var(53, 0)
        fallout.start_gdialog(696, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Justin35()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(7) == 1 then
        fallout.start_gdialog(696, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Justin29()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.global_var(203) == 1 then
        fallout.start_gdialog(696, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Justin27()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(6) == 1 then
        fallout.start_gdialog(696, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Justin26()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(6) == 2 then
        fallout.start_gdialog(696, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Justin28()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(696, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Justin00()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.global_var(158) > 2 then
        Justin03()
    elseif fallout.local_var(1) == 3 or fallout.local_var(1) == 0 then
        fallout.start_gdialog(696, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Justin31()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(1) == 2 then
        fallout.start_gdialog(696, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Justin32()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(1) == 1 then
        fallout.start_gdialog(696, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Justin33()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    fallout.set_global_var(221, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(696, 100))
end

function combat_p_proc()
    if fallout.map_var(54) == 1 then
        fallout.script_overrides()
    end
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil and fallout.map_var(52) == 0 then
        fallout.set_global_var(248, 1)
    end
end

function Justin00()
    if fallout.global_var(158) > 2 then
        fallout.gsay_message(696, 101, 50)
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.gsay_reply(696, 102)
        else
            fallout.gsay_reply(696, 103)
        end
        Justin30()
    end
end

function Justin01()
    fallout.gsay_reply(696, 104)
    if (fallout.global_var(203) == 0) and ((fallout.map_var(46) > 0) and (fallout.map_var(46) ~= 6)) then
        fallout.giq_option(4, 696, 105, Justin01a, 50)
    end
    if (fallout.global_var(203) == 0) and ((fallout.map_var(47) > 0) and (fallout.map_var(47) ~= 7)) then
        fallout.giq_option(4, 696, 106, Justin01b, 50)
    end
    fallout.giq_option(4, 696, 107, JustinEnd, 50)
    fallout.giq_option(4, 696, 108, Justin04, 50)
end

function Justin01a()
    if fallout.global_var(111) ~= 2 then
        Justin05a()
    else
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
            Justin06()
        else
            Justin07()
        end
    end
end

function Justin01b()
    if fallout.global_var(112) ~= 2 then
        Justin05a()
    else
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
            Justin06()
        else
            Justin08()
        end
    end
end

function Justin02()
    if fallout.local_var(5) == 0 then
        reaction.UpReact()
        fallout.set_local_var(5, 1)
        fallout.gsay_message(696, 109, 49)
    else
        fallout.gsay_message(696, 110, 49)
    end
end

function Justin03()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(696, 111), 2)
end

function Justin04()
    fallout.gsay_message(696, 112, 50)
end

function Justin05a()
    fallout.gsay_reply(696, 170)
    fallout.giq_option(4, 696, 171, Justin05b, 50)
end

function Justin05b()
    fallout.gsay_reply(696, 113)
    Justin09()
end

function Justin06()
    fallout.gsay_reply(696, 114)
    Justin09()
end

function Justin07()
    fallout.gsay_reply(696, 115)
    Justin15()
end

function Justin08()
    fallout.gsay_reply(696, 116)
    Justin15()
end

function Justin09()
    fallout.giq_option(4, 696, 117, Justin11, 50)
    fallout.giq_option(4, 696, 118, Justin10, 50)
    fallout.giq_option(4, 696, 119, Justin12, 50)
end

function Justin10()
    fallout.gsay_reply(696, 120)
    fallout.giq_option(4, 696, 121, Justin11, 50)
    fallout.giq_option(4, 696, 122, Justin12, 50)
end

function Justin11()
    local v0 = 0
    fallout.set_local_var(6, 1)
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), 300)
    fallout.gsay_message(696, 123, 50)
    fallout.gsay_reply(696, 174)
    fallout.giq_option(4, 696, 124, Justin20, 50)
    fallout.giq_option(4, 696, 125, JustinEnd, 50)
end

function Justin12()
    fallout.set_local_var(6, 2)
    fallout.gsay_reply(696, 126)
    fallout.giq_option(4, 696, 127, Justin13, 50)
    fallout.giq_option(4, 696, 128, Justin14, 50)
    fallout.giq_option(4, 696, 129, JustinEnd, 50)
end

function Justin13()
    local v0 = 0
    fallout.set_local_var(6, 1)
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), 300)
    fallout.gsay_message(696, 130, 49)
    fallout.gsay_message(696, 175, 50)
end

function Justin14()
    fallout.gsay_message(696, 131, 50)
end

function Justin15()
    fallout.giq_option(4, 696, 132, JustinCombat, 50)
    fallout.giq_option(4, 696, 133, Justin15a, 50)
    fallout.giq_option(4, 696, 134, Justin15b, 50)
    fallout.giq_option(4, 696, 135, Justin15c, 50)
    fallout.giq_option(4, 696, 136, Justin15d, 50)
end

function Justin15a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 30)) then
        Justin16()
    else
        Justin17()
    end
end

function Justin15b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Justin16()
    else
        Justin17()
    end
end

function Justin15c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 15)) then
        Justin16()
    else
        Justin17()
    end
end

function Justin15d()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -50)) then
        Justin18()
    else
        Justin19()
    end
end

function Justin16()
    fallout.gsay_reply(696, 137)
    Justin09()
end

function Justin17()
    fallout.set_local_var(7, 1)
    fallout.gsay_message(696, 138, 51)
end

function Justin18()
    fallout.gsay_reply(696, 139)
    Justin09()
end

function Justin19()
    fallout.set_local_var(7, 1)
    fallout.gsay_message(696, 140, 51)
end

function Justin20()
    fallout.gsay_message(696, 141, 50)
    JustinTravel()
end

function Justin26()
    fallout.gsay_reply(696, 151)
    fallout.giq_option(4, 696, 152, JustinTravel, 50)
    fallout.giq_option(4, 696, 153, JustinEnd, 50)
    fallout.giq_option(-3, 696, 154, Justin34, 50)
end

function Justin27()
    fallout.gsay_message(696, 155, 49)
end

function Justin28()
    fallout.gsay_reply(696, 156)
    fallout.giq_option(4, 696, 157, Justin11, 50)
    fallout.giq_option(4, 696, 158, JustinEnd, 50)
    fallout.giq_option(-3, 696, 159, Justin34, 50)
end

function Justin29()
    fallout.gsay_message(696, 160, 50)
end

function Justin30()
    fallout.giq_option(4, 696, 161, Justin01, 50)
    fallout.giq_option(4, 696, 162, Justin02, 50)
    fallout.giq_option(4, 696, 163, JustinEnd, 50)
    fallout.giq_option(-3, 696, 164, Justin34, 50)
end

function Justin31()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(696, 165)
    else
        fallout.gsay_reply(696, 166)
    end
    Justin30()
end

function Justin32()
    fallout.gsay_reply(696, 167)
    Justin30()
end

function Justin33()
    fallout.gsay_reply(696, 168)
    Justin30()
end

function Justin34()
    fallout.gsay_message(696, 169, 50)
end

function Justin35()
    local v0 = 0
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), 1000)
    fallout.set_global_var(155, fallout.global_var(155) + 4)
    fallout.give_exp_points(1400)
    fallout.display_msg(fallout.message_str(766, 103) .. 1400 .. fallout.message_str(766, 104))
    fallout.gsay_message(696, 172, 49)
    fallout.gsay_message(696, 173, 49)
end

function JustinEnd()
end

function JustinCombat()
    combat()
end

function JustinTravel()
    travel = true
end

function GoToDecker()
    local fry_obj = fallout.external_var("Fry_Stub_Ptr")
    local decker_obj = fallout.external_var("Decker_Ptr")
    local decker_tile_num = fallout.tile_num(decker_obj)
    local kane_obj = fallout.external_var("Kane_Ptr")
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    fallout.set_map_var(52, 1)
    fallout.gfade_out(1000)
    fallout.set_obj_visibility(fry_obj, false)
    fallout.move_to(self_obj, 23926, 1)
    fallout.anim(self_obj, 1000, fallout.rotation_to_tile(fallout.tile_num(self_obj), decker_tile_num))
    misc.set_team(self_obj, 0)
    fallout.move_to(kane_obj, 22526, 1)
    fallout.anim(kane_obj, 1000, fallout.rotation_to_tile(fallout.tile_num(kane_obj), decker_tile_num))
    fallout.move_to(dude_obj, 23924, 1)
    fallout.anim(dude_obj, 1000, fallout.rotation_to_tile(fallout.tile_num(dude_obj), decker_tile_num))
    fallout.gfade_in(1000)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.combat_p_proc = combat_p_proc
exports.damage_p_proc = damage_p_proc
return exports
