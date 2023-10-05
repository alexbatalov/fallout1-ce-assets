local fallout = require("fallout")

local start
local use_p_proc
local talk_p_proc
local use_skill_on_p_proc
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

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    else
        if fallout.script_action() == 11 then
            talk_p_proc()
        else
            if fallout.script_action() == 8 then
                use_skill_on_p_proc()
            end
        end
    end
end

function use_p_proc()
    fallout.script_overrides()
    fallout.dialogue_system_enter()
end

function talk_p_proc()
    fallout.start_gdialog(828, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.global_var(224) == 0 then
        Term14()
    else
        if fallout.global_var(224) == 1 then
            Term01()
        else
            Term09()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 12 then
        fallout.script_overrides()
        fallout.dialogue_system_enter()
    end
end

function Term01()
    fallout.gsay_reply(828, 100)
    fallout.giq_option(4, 828, 101, Term02, 50)
    fallout.giq_option(-3, 828, 102, Term10, 50)
    fallout.giq_option(0, 828, 103, TermEnd, 50)
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
    fallout.giq_option(0, 828, 121, TermEnd, 50)
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
    fallout.giq_option(0, 828, 128, TermEnd, 50)
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
    fallout.giq_option(0, 828, 145, TermEnd, 50)
end

function Term14a()
    fallout.set_global_var(224, 1)
    if fallout.global_var(139) == 2 then
        Term01()
    end
end

function Term15()
    fallout.gsay_reply(828, 146)
    fallout.giq_option(0, 828, 147, TermEnd, 50)
end

function TermEnd()
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.talk_p_proc = talk_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
