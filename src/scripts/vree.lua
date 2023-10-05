local fallout = require("fallout")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0
local g3 = 0
local g4 = 0
local g5 = 0
local g6 = 0
local g7 = 0
local g8 = 0
local g9 = 0
local g10 = 0
local g11 = 1
local g12 = 0

local start
local do_dialogue
local vree_end
local vreecbt
local vree00
local vree01
local vree02
local vree03
local vree03a
local vree17
local vree17a
local vree17z
local vree18
local vree19
local vree21
local vree22
local vree23
local vree24
local vree25
local vree26
local vree27
local vree28
local vree29
local vree30
local vree31
local vree32
local vree33
local vree34
local vree35
local vree36
local vree36_1
local vree37
local vree38
local vree39
local vree40
local vree41
local vree42
local vree43
local vree44
local vree45
local vree46
local vree47
local vree48
local vree200
local vree201
local vree202
local vree203
local vree204
local vree205
local vree300
local vree301
local vree302
local vree303
local vree304
local vree305
local vree306
local branch01
local branch02
local branch03
local branch04
local vree00a
local vree01a
local vree01b
local vree45a
local vree46a
local look_at_p_proc
local talk_p_proc
local time_p_proc
local pickup_p_proc
local critter_p_proc
local destroy_p_proc

-- ?import? variable term4_ptr
-- ?import? variable term5_ptr
-- ?import? variable term6_ptr
-- ?import? variable term7_ptr
-- ?import? variable term8_ptr
-- ?import? variable rndx
-- ?import? variable rndy
-- ?import? variable rndz
-- ?import? variable item
-- ?import? variable MALE
-- ?import? variable HOSTILE
-- ?import? variable DESTROYED
-- ?import? variable CAPTURED
-- ?import? variable ATKBROTHERS
-- ?import? variable KNOWKEDPLAN
-- ?import? variable INITIAT
-- ?import? variable Only_Once

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
    if g11 then
        g11 = 0
        fallout.set_external_var("Vree_ptr", fallout.self_obj())
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 80)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(40), 1)
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
                if fallout.script_action() == 22 then
                    time_p_proc()
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
end

function do_dialogue()
    fallout.start_gdialog(57, fallout.self_obj(), 4, 4, 5)
    get_reaction()
    fallout.gsay_start()
    g4 = fallout.get_critter_stat(fallout.dude_obj(), 34) == 0
    if fallout.local_var(4) > 0 then
        if g8 then
            vree32()
        end
        if g9 then
            vree34()
        end
        if g10 == 1 then
            vree43()
        end
        if g10 == 2 then
            vree45()
        end
        if g10 < 1 then
            if fallout.local_var(1) > 1 then
                vree17()
            else
                vree46()
            end
        end
    else
        fallout.set_local_var(4, 1)
        if fallout.local_var(1) >= 2 then
            vree02()
        else
            vree00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function vree_end()
end

function vreecbt()
end

function vree00()
    fallout.gsay_reply(58, 101)
    fallout.giq_option(4, 58, 102, vree00a, 49)
    fallout.giq_option(4, 58, 103, vree_end, 50)
    fallout.giq_option(4, 58, 104, vree01, 50)
    fallout.giq_option(-3, 58, 105, vree31, 50)
end

function vree01()
    fallout.gsay_reply(58, 106)
    fallout.giq_option(4, 58, 107, vree_end, 50)
    fallout.giq_option(4, 58, 108, vree01a, 51)
    fallout.giq_option(4, 58, 109, vree01b, 51)
end

function vree02()
    fallout.gsay_reply(58, 110)
    fallout.giq_option(4, 58, 111, vree03, 50)
    fallout.giq_option(5, 58, 112, vree17, 50)
    fallout.giq_option(-3, 58, 113, vree31, 50)
end

function vree03()
    fallout.gsay_reply(58, 114)
    fallout.giq_option(4, 58, 115, vree03a, 50)
end

function vree03a()
    fallout.gsay_message(58, 116, 50)
    vree17()
end

function vree17()
    fallout.gsay_reply(58, 117)
    vree17z()
end

function vree17a()
    fallout.gsay_reply(58, 118)
    vree17z()
end

function vree17z()
    if fallout.global_var(30) ~= 1 then
        fallout.giq_option(4, 58, 119, vree48, 50)
    end
    fallout.giq_option(4, 58, 120, branch01, 50)
    fallout.giq_option(5, 58, 121, branch02, 50)
    if fallout.local_var(5) ~= 1 then
        fallout.giq_option(6, 58, 122, branch03, 50)
    end
    if fallout.local_var(6) == 0 then
        fallout.giq_option(7, 58, 123, branch04, 50)
    end
end

function vree18()
    fallout.set_map_var(0, 1)
    fallout.gsay_reply(58, 124)
    fallout.giq_option(4, 58, 125, vree_end, 50)
    fallout.giq_option(4, 58, 126, vree17a, 50)
end

function vree19()
    fallout.gsay_reply(58, 127)
    vree_end()
end

function vree21()
    fallout.gsay_reply(58, 128)
    if fallout.local_var(7) ~= 1 then
        fallout.giq_option(5, 58, 129, vree22, 50)
    end
    fallout.giq_option(4, 58, 130, vree_end, 50)
    fallout.giq_option(4, 58, 131, vree17a, 50)
end

function vree22()
    fallout.set_local_var(7, 1)
    fallout.gsay_message(58, 132, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(4), 2)
end

function vree23()
end

function vree24()
    fallout.gsay_message(58, 134, 50)
    vree_end()
end

function vree25()
    g3 = fallout.create_object_sid(109, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), g3)
    fallout.gsay_reply(58, 135)
    fallout.giq_option(4, 58, 136, vree_end, 50)
    fallout.giq_option(4, 58, 137, vree17a, 50)
end

function vree26()
    fallout.gsay_message(58, 138, 50)
    vree_end()
end

function vree27()
    fallout.gsay_reply(58, 139)
    fallout.giq_option(6, 58, 140, vree28, 50)
    fallout.giq_option(5, 58, 141, vree_end, 50)
    fallout.giq_option(4, 58, 142, vree17a, 50)
end

function vree28()
    fallout.gsay_reply(58, 143)
    fallout.giq_option(6, 58, 144, vree_end, 50)
    fallout.giq_option(6, 58, 145, vree29, 50)
    fallout.giq_option(4, 58, 146, vree17a, 50)
end

function vree29()
    local v0 = 0
    v0 = fallout.create_object_sid(194, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.set_local_var(6, 1)
    fallout.set_global_var(310, 1)
    fallout.gsay_reply(58, 147)
    fallout.giq_option(4, 58, 148, vree_end, 50)
    fallout.giq_option(4, 58, 149, vree17a, 50)
end

function vree30()
    fallout.gsay_message(58, 150, 50)
    vree_end()
end

function vree31()
    fallout.gsay_message(58, 151, 50)
    vree_end()
end

function vree32()
    fallout.gsay_reply(58, 152)
    fallout.giq_option(4, 58, 153, vreecbt, 51)
    fallout.giq_option(5, 58, 154, vree33, 50)
end

function vree33()
    fallout.gsay_reply(58, 155)
    fallout.giq_option(4, 58, 156, vreecbt, 51)
end

function vree34()
    fallout.gsay_reply(58, 157)
    fallout.giq_option(4, 58, 158, vree36, 50)
    fallout.giq_option(5, 58, 159, vree39, 50)
    fallout.giq_option(-3, 58, 160, vree35, 50)
end

function vree35()
    fallout.gsay_message(58, 161, 50)
    vree_end()
end

function vree36()
    fallout.gsay_reply(58, 162)
    fallout.giq_option(5, 58, 163, vree36_1, 50)
    fallout.giq_option(4, 58, 164, vree_end, 50)
end

function vree36_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        vree37()
    else
        vree38()
    end
end

function vree37()
    fallout.gsay_message(58, 165, 50)
    vree_end()
end

function vree38()
    fallout.gsay_message(58, 166, 50)
    vree_end()
end

function vree39()
    fallout.gsay_reply(58, 167)
    fallout.giq_option(6, 58, 168, vree40, 50)
    fallout.giq_option(6, 58, 169, vree42, 50)
end

function vree40()
    fallout.gsay_reply(58, 170)
    fallout.giq_option(6, 58, 171, vree41, 50)
    fallout.giq_option(6, 58, 172, vree_end, 50)
end

function vree41()
    fallout.gsay_message(58, 173, 50)
    vree_end()
end

function vree42()
    fallout.gsay_message(58, 174, 50)
    vree_end()
end

function vree43()
    fallout.gsay_reply(58, 175)
    fallout.giq_option(4, 58, 176, vree44, 50)
    fallout.giq_option(-3, 58, 177, vree35, 50)
end

function vree44()
    fallout.gsay_message(58, 178, 50)
    vree_end()
end

function vree45()
    fallout.gsay_message(58, 179, 50)
    vree45a()
end

function vree46()
    fallout.gsay_reply(58, 180)
    fallout.giq_option(4, 58, 181, vree47, 50)
    fallout.giq_option(4, 58, 182, vree46a, 50)
end

function vree47()
    fallout.gsay_message(58, 183, 50)
    if fallout.local_var(1) > 2 then
        vree17()
    else
        fallout.gsay_message(58, 184, 50)
        vree_end()
    end
end

function vree48()
    fallout.gsay_reply(58, 185)
    fallout.giq_option(4, 58, 186, vree_end, 50)
    fallout.giq_option(4, 58, 187, vree17, 50)
end

function vree200()
    fallout.gsay_message(58, 188, 50)
end

function vree201()
    fallout.gsay_message(58, 189, 50)
end

function vree202()
    fallout.gsay_message(58, 190, 50)
end

function vree203()
    fallout.gsay_message(58, 191, 50)
end

function vree204()
    fallout.gsay_message(58, 192, 50)
end

function vree205()
    fallout.gsay_message(58, 193, 50)
end

function vree300()
    fallout.gsay_message(58, 194, 50)
end

function vree301()
    fallout.gsay_message(58, 195, 50)
end

function vree302()
    fallout.gsay_message(58, 196, 50)
end

function vree303()
    fallout.gsay_message(58, 197, 50)
end

function vree304()
    fallout.gsay_message(58, 198, 50)
end

function vree305()
    fallout.gsay_message(58, 199, 50)
end

function vree306()
    fallout.gsay_message(58, 200, 50)
end

function branch01()
    if fallout.local_var(1) >= 2 then
        vree18()
    else
        vree19()
    end
end

function branch02()
    if fallout.local_var(1) > 1 then
        vree21()
    else
        vree24()
    end
end

function branch03()
    fallout.set_local_var(5, 1)
    if fallout.local_var(1) > 1 then
        vree25()
    else
        vree26()
    end
end

function branch04()
    if fallout.local_var(1) > 1 then
        vree27()
    else
        vree30()
    end
end

function vree00a()
    UpReact()
    vree_end()
end

function vree01a()
    DownReact()
    vree_end()
end

function vree01b()
    BigDownReact()
    vree_end()
end

function vree45a()
    local v0 = 0
    v0 = fallout.create_object_sid(48, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(48, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(38, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(39, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    BigUpReact()
    vree_end()
end

function vree46a()
    DownReact()
    vree_end()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(58, 100))
end

function talk_p_proc()
    do_dialogue()
end

function time_p_proc()
    if fallout.fixed_param() == 1 then
        g0 = fallout.random(2, 3)
        if g0 == 2 then
            fallout.use_obj(fallout.external_var("term2_ptr"))
        else
            if g0 == 3 then
                fallout.use_obj(fallout.external_var("term3_ptr"))
            end
        end
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(40), 1)
    else
        if fallout.fixed_param() == 2 then
            fallout.use_obj(fallout.external_var("term1_ptr"))
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        g5 = 1
    end
end

function critter_p_proc()
    if fallout.global_var(250) then
        g5 = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        g5 = 0
    end
    if g5 then
        fallout.set_global_var(250, 1)
        g5 = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
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
    g12 = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
exports.time_p_proc = time_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
