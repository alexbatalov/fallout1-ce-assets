local fallout = require("fallout")

local start
local talk_p_proc
local Zax01
local Zax02
local Zax03
local Zax04
local Zax05
local Zax06
local Zax07
local Zax08
local Zax09
local Zax10
local Zax11
local Zax12
local Zax13
local Zax14
local Zax15
local Zax16
local Zax17
local Zax18
local Zax19
local Zax20
local Zax21
local Zax22
local Zax23
local Zax24
local Zax25
local ZaxClearance
local Term01
local Term02
local Term03
local Term03a
local Term04
local Term05
local Term06
local Term06a
local Term07
local Term08
local Term09
local Term09a
local Term10
local Term11
local Term11a
local Term12
local Term13
local Term14
local Term14a
local Term15
local TermEnd
local TermStart
local Mainframe00
local Mainframe01
local Mainframe02
local Mainframe03
local Mainframe04
local Mainframe04a
local Mainframe05
local Mainframe05a
local Mainframe05b
local Mainframe05c
local Mainframe06
local Mainframe06a
local Mainframe07
local Mainframe07a
local Mainframe08
local Mainframe08a
local Mainframe09
local Mainframe10

local exit_line = 0

function start()
    if fallout.script_action() == 11 then
        talk_p_proc()
    else
        if fallout.script_action() == 6 then
            fallout.dialogue_system_enter()
        else
            if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                fallout.script_overrides()
                if fallout.local_var(4) == 1 then
                    fallout.display_msg(fallout.message_str(312, 100))
                else
                    fallout.display_msg(fallout.message_str(312, 101))
                end
            end
        end
    end
end

function talk_p_proc()
    fallout.script_overrides()
    fallout.start_gdialog(312, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Zax01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Zax01()
    fallout.gsay_reply(312, 102)
    if fallout.local_var(4) == 0 then
        fallout.giq_option(5, 312, 103, Zax02, 50)
    end
    fallout.giq_option(5, 312, 105, Zax04, 50)
    if fallout.local_var(6) == 0 then
        fallout.giq_option(5, 312, 106, Zax12, 50)
    end
    fallout.giq_option(5, 828, 200, Mainframe00, 50)
    fallout.giq_option(5, 312, 108, Zax13, 50)
    fallout.giq_option(-4, 312, 109, Zax05, 50)
end

function Zax02()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(312, 110)
    fallout.giq_option(5, 312, 111, Zax06, 50)
    fallout.giq_option(5, 312, 112, Zax04, 50)
    fallout.giq_option(5, 312, 113, Zax07, 50)
    fallout.giq_option(7, 312, 114, Zax08, 50)
    fallout.giq_option(0, 312, 115, Zax13, 50)
end

function Zax03()
    fallout.gsay_message(312, 116, 50)
    fallout.set_local_var(5, 1)
    Zax01()
end

function Zax04()
    ZaxClearance()
    fallout.gsay_reply(828, fallout.message_str(828, 211) .. fallout.message_str(828, 241) .. fallout.message_str(828, 242) .. fallout.message_str(828, 243))
    fallout.giq_option(7, 312, 119, Zax21, 50)
    fallout.giq_option(7, 312, 120, Zax15, 50)
    fallout.giq_option(5, 312, 121, Zax13, 50)
end

function Zax05()
    fallout.gsay_message(312, 122, 50)
end

function Zax06()
    ZaxClearance()
    fallout.gsay_reply(312, 123)
    fallout.giq_option(5, 312, 124, Zax14, 50)
    fallout.giq_option(7, 312, 125, Zax15, 50)
    fallout.giq_option(5, 312, 126, Zax07, 50)
end

function Zax07()
    fallout.gsay_reply(312, 127)
    fallout.giq_option(7, 312, 128, Zax08, 50)
end

function Zax08()
    fallout.gsay_message(312, 129, 50)
    fallout.gsay_reply(312, 130)
    fallout.giq_option(5, 312, 131, Zax01, 50)
    fallout.giq_option(7, 312, 132, Zax09, 50)
    fallout.giq_option(9, 312, 133, Zax11, 50)
end

function Zax09()
    fallout.gsay_message(312, 134, 50)
    fallout.gsay_reply(312, 135)
    fallout.giq_option(7, 312, 136, Zax10, 50)
    fallout.giq_option(7, 312, 137, Zax01, 50)
    fallout.giq_option(9, 312, 138, Zax11, 50)
end

function Zax10()
    fallout.gsay_message(312, 139, 50)
    fallout.gsay_reply(312, 140)
    fallout.giq_option(7, 312, 141, Zax01, 50)
    fallout.giq_option(9, 312, 142, Zax11, 50)
end

function Zax11()
    fallout.gsay_message(312, 143, 50)
    fallout.gsay_message(312, 144, 50)
    fallout.gsay_reply(312, 145)
    fallout.giq_option(5, 312, 146, Zax01, 50)
    fallout.giq_option(5, 312, 147, Zax13, 50)
end

function Zax12()
    local v0 = 0
    fallout.gsay_message(312, 148, 50)
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks(7200))
    v0 = fallout.do_check(fallout.dude_obj(), 4, 0)
    fallout.gfade_in(600)
    if fallout.is_success(v0) then
        if fallout.is_critical(v0) then
            fallout.gsay_reply(312, 149)
            fallout.set_local_var(6, 1)
            fallout.give_exp_points(700)
        else
            fallout.gsay_reply(312, 150)
        end
    else
        fallout.gsay_reply(312, 150)
    end
    fallout.giq_option(5, 312, 151, Zax12, 50)
    fallout.giq_option(5, 312, 152, Zax01, 50)
end

function Zax13()
    fallout.gsay_message(312, 153, 50)
end

function Zax14()
    fallout.gsay_reply(312, 154)
    fallout.giq_option(5, 312, 155, Zax13, 50)
    fallout.giq_option(5, 312, 156, Zax01, 50)
end

function Zax15()
    fallout.gsay_message(312, 157, 50)
    fallout.gsay_reply(312, 158)
    fallout.giq_option(5, 312, 159, Zax16, 50)
    fallout.giq_option(7, 312, 160, Zax17, 50)
    fallout.giq_option(9, 312, 161, Zax18, 50)
end

function Zax16()
    fallout.gsay_reply(312, 162)
    fallout.giq_option(5, 312, 163, Zax01, 50)
    fallout.giq_option(7, 312, 164, Zax17, 50)
    fallout.giq_option(9, 312, 165, Zax18, 50)
end

function Zax17()
    fallout.gsay_reply(312, 166)
    fallout.giq_option(5, 312, 167, Zax01, 50)
    fallout.giq_option(9, 312, 168, Zax18, 50)
end

function Zax18()
    fallout.gsay_message(312, 169, 50)
    fallout.gsay_message(312, 170, 50)
    fallout.gsay_message(312, 171, 50)
    fallout.gsay_message(312, 172, 50)
    fallout.gsay_reply(312, 173)
    fallout.giq_option(9, 312, 174, Zax19, 50)
    fallout.giq_option(10, 312, 175, Zax20, 50)
    fallout.giq_option(5, 312, 176, Zax01, 50)
    fallout.giq_option(5, 312, 177, Zax13, 50)
end

function Zax19()
    fallout.gsay_message(312, 178, 50)
    fallout.gsay_message(312, 179, 50)
    fallout.gsay_reply(312, 180)
    fallout.giq_option(10, 312, 181, Zax20, 50)
    fallout.giq_option(5, 312, 182, Zax01, 50)
    fallout.giq_option(5, 312, 183, Zax13, 50)
end

function Zax20()
    fallout.gsay_reply(312, 184)
    fallout.giq_option(9, 312, 185, Zax19, 50)
    fallout.giq_option(5, 312, 186, Zax01, 50)
    fallout.giq_option(5, 312, 187, Zax13, 50)
end

function Zax21()
    fallout.gsay_reply(312, 188)
    fallout.giq_option(5, 312, 189, Zax22, 50)
    fallout.giq_option(5, 312, 190, Zax23, 50)
    fallout.giq_option(5, 312, 191, Zax24, 50)
    fallout.giq_option(5, 312, 192, Zax01, 50)
end

function Zax22()
    fallout.gsay_reply(312, 193)
    fallout.giq_option(5, 312, 194, Zax23, 50)
    fallout.giq_option(5, 312, 195, Zax24, 50)
    fallout.giq_option(5, 312, 196, Zax01, 50)
    fallout.giq_option(5, 312, 197, Zax13, 50)
end

function Zax23()
    fallout.gsay_reply(312, 198)
    fallout.giq_option(5, 312, 199, Zax22, 50)
    fallout.giq_option(5, 312, 200, Zax24, 50)
    fallout.giq_option(5, 312, 201, Zax01, 50)
    fallout.giq_option(5, 312, 202, Zax13, 50)
end

function Zax24()
    fallout.gsay_reply(312, 203)
    fallout.giq_option(5, 312, 204, Zax22, 50)
    fallout.giq_option(5, 312, 205, Zax23, 50)
    fallout.giq_option(5, 312, 206, Zax01, 50)
    fallout.giq_option(5, 312, 207, Zax13, 50)
end

function Zax25()
    fallout.gsay_message(312, 208, 50)
    if fallout.global_var(142) == 1 then
        fallout.gsay_message(312, 209, 50)
        fallout.set_global_var(142, 2)
    end
end

function ZaxClearance()
    if fallout.global_var(140) ~= 0 then
        fallout.gsay_message(312, 210, 50)
        fallout.gsay_message(312, 211, 50)
        fallout.set_global_var(140, 0)
    end
end

function Term01()
    fallout.gsay_reply(828, 100)
    fallout.giq_option(4, 828, 101, Term02, 50)
    fallout.giq_option(-3, 828, 102, Term10, 50)
    fallout.giq_option(0, 828, 103, Mainframe02, 50)
end

function Term02()
    fallout.gsay_reply(828, 104)
    fallout.giq_option(4, 828, 105, Term03, 50)
    fallout.giq_option(4, 828, 106, Term06, 50)
    fallout.giq_option(4, 828, 107, Term01, 50)
end

function Term03()
    fallout.gsay_reply(828, 108)
    fallout.giq_option(4, 828, 109, Term03a, 50)
    fallout.giq_option(4, 828, 110, Term02, 50)
end

function Term03a()
    if fallout.global_var(139) ~= 2 then
        Term04()
    else
        fallout.set_global_var(224, 2)
    end
end

function Term04()
    fallout.gsay_reply(828, 111)
    fallout.giq_option(8, 828, 112, Term05, 50)
    fallout.giq_option(4, 828, 113, Term02, 50)
end

function Term05()
    fallout.gsay_reply(828, 114)
    fallout.giq_option(4, 828, 115, Term02, 50)
end

function Term06()
    fallout.gsay_reply(828, 116)
    fallout.giq_option(4, 828, 117, Term06a, 50)
    fallout.giq_option(4, 828, 118, Term02, 50)
end

function Term06a()
    fallout.set_global_var(224, 0)
end

function Term07()
    fallout.gsay_reply(828, 119)
    fallout.giq_option(4, 828, 120, Term08, 50)
    fallout.giq_option(0, 828, 121, Mainframe02, 50)
end

function Term08()
    fallout.gsay_reply(828, 122)
    fallout.giq_option(4, 828, 123, Term09a, 50)
    fallout.giq_option(4, 828, 124, Term07, 50)
end

function Term09()
    fallout.gsay_reply(828, 125)
    fallout.giq_option(-3, 828, 126, Term09a, 50)
    fallout.giq_option(4, 828, 127, Term09a, 50)
    fallout.giq_option(0, 828, 128, Mainframe02, 50)
end

function Term09a()
    fallout.set_global_var(224, 1)
end

function Term10()
    fallout.gsay_reply(828, 129)
    fallout.giq_option(-3, 828, 130, Term11, 50)
    fallout.giq_option(-3, 828, 131, Term13, 50)
    fallout.giq_option(-3, 828, 132, Term01, 50)
end

function Term11()
    fallout.gsay_reply(828, 133)
    fallout.giq_option(-3, 828, 134, Term11a, 50)
    fallout.giq_option(-3, 828, 135, Term10, 50)
end

function Term11a()
    if fallout.global_var(139) ~= 2 then
        Term12()
    else
        fallout.set_global_var(224, 2)
    end
end

function Term12()
    fallout.gsay_reply(828, 136)
    fallout.giq_option(-3, 828, 137, Term10, 50)
end

function Term13()
    fallout.gsay_reply(828, 138)
    fallout.giq_option(-3, 828, 148, Term06a, 50)
    fallout.giq_option(-3, 828, 137, Term10, 50)
end

function Term14()
    fallout.gsay_reply(828, 139)
    fallout.giq_option(4, 828, 140, Term14a, 50)
    fallout.giq_option(-3, 828, 141, Term15, 50)
    fallout.giq_option(-3, 828, 142, Term15, 50)
    fallout.giq_option(-3, 828, 143, Term14a, 50)
    fallout.giq_option(-3, 828, 144, Term15, 50)
    fallout.giq_option(0, 828, 145, Mainframe02, 50)
end

function Term14a()
    fallout.set_global_var(224, 1)
    if fallout.global_var(139) == 2 then
        Term01()
    end
end

function Term15()
    fallout.gsay_reply(828, 146)
    fallout.giq_option(0, 828, 147, Mainframe02, 50)
end

function TermEnd()
end

function TermStart()
    if fallout.global_var(224) == 0 then
        Term14()
    else
        if fallout.global_var(224) == 1 then
            Term01()
        else
            Term09()
        end
    end
end

function Mainframe00()
    if fallout.has_skill(fallout.dude_obj(), 12) >= 25 then
        fallout.set_local_var(8, 0)
    end
    if fallout.local_var(8) == 0 then
        if fallout.local_var(7) == 1 then
            Mainframe01()
        else
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, -10)) then
                fallout.set_local_var(7, 1)
                Mainframe01()
            else
                if fallout.has_skill(fallout.dude_obj(), 12) < 25 then
                    fallout.set_local_var(8, 1)
                end
                fallout.gsay_message(828, 201, 50)
            end
        end
    else
        fallout.gsay_message(828, 201, 50)
        fallout.display_msg(fallout.message_str(312, 300))
    end
end

function Mainframe01()
    fallout.gsay_reply(828, 202)
    fallout.giq_option(4, 828, 203, Mainframe02, 50)
    fallout.giq_option(4, 828, 204, Zax01, 50)
end

function Mainframe02()
    fallout.gsay_reply(828, 206)
    fallout.giq_option(4, 828, 207, Mainframe03, 50)
    fallout.giq_option(4, 828, 208, Mainframe04, 50)
    fallout.giq_option(4, 828, 209, Mainframe05, 50)
    fallout.giq_option(4, 828, 210, TermStart, 50)
    fallout.giq_option(4, 828, 204, Zax01, 50)
end

function Mainframe03()
    fallout.gsay_reply(828, fallout.message_str(828, 211) .. fallout.message_str(828, 241) .. fallout.message_str(828, 242) .. fallout.message_str(828, 243))
    fallout.giq_option(4, 828, 203, Mainframe02, 50)
    fallout.giq_option(4, 828, 205, TermEnd, 50)
end

function Mainframe04()
    if (fallout.global_var(140) == 0) and (fallout.global_var(224) == 2) then
        fallout.gsay_reply(828, 212)
    else
        fallout.gsay_reply(828, 213)
    end
    if fallout.global_var(224) == 2 then
        if fallout.global_var(140) == 0 then
            fallout.giq_option(4, 828, 214, Mainframe04a, 50)
        else
            fallout.giq_option(4, 828, 215, Mainframe04a, 50)
        end
    end
    fallout.giq_option(4, 828, 203, Mainframe02, 50)
    fallout.giq_option(4, 828, 205, TermEnd, 50)
end

function Mainframe04a()
    fallout.game_time_advance(fallout.game_ticks(600))
    if fallout.has_skill(fallout.dude_obj(), 12) >= 40 then
        fallout.set_local_var(9, 0)
    end
    if fallout.global_var(163) == 1 then
        if fallout.global_var(140) == 0 then
            fallout.set_global_var(140, 1)
        else
            fallout.set_global_var(140, 0)
        end
        fallout.give_exp_points(100)
        Mainframe09()
    end
    if fallout.local_var(9) == 0 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, -25)) then
            if fallout.global_var(140) == 0 then
                fallout.set_global_var(140, 1)
            else
                fallout.set_global_var(140, 0)
            end
            fallout.give_exp_points(100)
            Mainframe09()
        else
            if fallout.has_skill(fallout.dude_obj(), 12) < 40 then
                fallout.set_local_var(9, 1)
            end
            Mainframe10()
        end
    else
        if fallout.local_var(9) == 1 then
            fallout.display_msg(fallout.message_str(312, 300))
            Mainframe10()
        else
            Mainframe10()
        end
    end
end

function Mainframe05()
    fallout.gsay_reply(828, 216)
    fallout.giq_option(4, 828, 217, Mainframe05a, 50)
    fallout.giq_option(4, 828, 218, Mainframe05b, 50)
    fallout.giq_option(4, 828, 219, Mainframe05c, 50)
    fallout.giq_option(4, 828, 203, Mainframe02, 50)
    fallout.giq_option(4, 828, 205, TermEnd, 50)
end

function Mainframe05a()
    Mainframe06()
end

function Mainframe05b()
    Mainframe07()
end

function Mainframe05c()
    Mainframe08()
end

function Mainframe06()
    fallout.gsay_message(828, 220, 50)
    fallout.gsay_message(828, 221, 50)
    fallout.gsay_message(828, 222, 50)
    fallout.gsay_message(828, 223, 50)
    fallout.gsay_message(828, 224, 50)
    fallout.gsay_message(828, 225, 50)
    fallout.gsay_message(828, 226, 50)
    fallout.gsay_message(828, 227, 50)
    fallout.gsay_reply(828, 228)
    fallout.giq_option(4, 828, 229, Mainframe06a, 50)
    fallout.giq_option(4, 828, 230, Mainframe05, 50)
    fallout.giq_option(4, 828, 205, TermEnd, 50)
end

function Mainframe06a()
    fallout.set_global_var(260, 1)
    Mainframe05()
end

function Mainframe07()
    fallout.gsay_reply(828, fallout.message_str(828, 231) .. fallout.message_str(828, 250) .. fallout.message_str(828, 251) .. fallout.message_str(828, 252))
    fallout.giq_option(4, 828, 229, Mainframe07a, 50)
    fallout.giq_option(4, 828, 230, Mainframe05, 50)
    fallout.giq_option(4, 828, 205, TermEnd, 50)
end

function Mainframe07a()
    fallout.set_global_var(259, 1)
    Mainframe05()
end

function Mainframe08()
    fallout.gsay_message(828, fallout.message_str(828, 232) .. fallout.message_str(828, 233), 50)
    fallout.gsay_message(828, fallout.message_str(828, 234) .. fallout.message_str(828, 235), 50)
    fallout.gsay_reply(828, fallout.message_str(828, 236) .. fallout.message_str(828, 237) .. fallout.message_str(828, 238))
    fallout.giq_option(4, 828, 229, Mainframe08a, 50)
    fallout.giq_option(4, 828, 230, Mainframe05, 50)
    fallout.giq_option(4, 828, 205, TermEnd, 50)
end

function Mainframe08a()
    fallout.set_global_var(258, 1)
    Mainframe05()
end

function Mainframe09()
    fallout.gsay_reply(828, 239)
    fallout.giq_option(4, 828, 203, Mainframe02, 50)
    fallout.giq_option(4, 828, 205, TermEnd, 50)
end

function Mainframe10()
    fallout.game_time_advance(fallout.game_ticks(18000))
    fallout.gsay_reply(828, 240)
    fallout.giq_option(4, 828, 203, Mainframe02, 50)
    fallout.giq_option(4, 828, 205, TermEnd, 50)
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
return exports
