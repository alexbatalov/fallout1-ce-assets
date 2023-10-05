local fallout = require("fallout")

local start
local description_p_proc
local talk_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local Control00
local Control01
local Control02
local Control03
local Control04
local Control05
local Control06
local Control07
local Control08
local Control08a
local Control08b
local Control08c
local Control09
local Control09a
local Control09b
local Control10
local Control10a
local Control10b
local Control10c
local Control10d
local Control10e
local Control11
local Control12
local Control13
local Control14
local Control15
local Control16
local Control16a
local Control17
local Control18
local Control19
local Control20
local Control21
local Control22
local Control23
local Control24
local Control25
local Controlend

local rndx = 0
local chance = 0

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    else
        if fallout.script_action() == 11 then
            talk_p_proc()
        else
            if fallout.script_action() == 6 then
                use_p_proc()
            else
                if fallout.script_action() == 7 then
                    use_obj_on_p_proc()
                else
                    if fallout.script_action() == 8 then
                        use_skill_on_p_proc()
                    end
                end
            end
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(368, 100))
end

function talk_p_proc()
    fallout.start_gdialog(368, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(0) == 1 then
        fallout.gsay_message(368, 101, 50)
    else
        if fallout.local_var(1) == 1 then
            Control14()
        else
            Control00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(368, 196))
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 100 then
        fallout.display_msg(fallout.message_str(368, 195))
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 13 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(368, 197))
    else
        if fallout.action_being_used() == 12 then
            fallout.script_overrides()
            fallout.dialogue_system_enter()
        end
    end
end

function Control00()
    fallout.set_local_var(1, 1)
    fallout.gsay_reply(368, 102)
    fallout.giq_option(-3, 368, 103, Control01, 50)
    fallout.giq_option(4, 368, 104, Control03, 50)
    fallout.giq_option(6, 368, 105, Control03, 50)
    fallout.giq_option(8, 368, 106, Control06, 50)
end

function Control01()
    fallout.gsay_reply(368, 107)
    fallout.giq_option(-3, 368, 108, Control01, 50)
    fallout.giq_option(-3, 368, 109, Control01, 50)
    fallout.giq_option(-3, 368, 110, Control02, 50)
    fallout.giq_option(-3, 368, 111, Control01, 50)
end

function Control02()
    fallout.gsay_message(368, 112, 50)
end

function Control03()
    fallout.gsay_reply(368, 113)
    fallout.giq_option(6, 368, 114, Controlend, 50)
    fallout.giq_option(6, 368, 115, Control04, 50)
    fallout.giq_option(6, 368, 116, Control06, 50)
end

function Control04()
    fallout.gsay_reply(368, 117)
    fallout.giq_option(6, 368, 118, Control05, 50)
    fallout.giq_option(6, 368, 119, Control06, 50)
end

function Control05()
    fallout.gsay_reply(368, 120)
    fallout.giq_option(6, 368, 121, Control06, 50)
end

function Control06()
    fallout.gsay_reply(368, 122)
    fallout.giq_option(6, 368, 123, Control07, 50)
    fallout.giq_option(6, 368, 124, Control07, 50)
    fallout.giq_option(6, 368, 125, Control07, 50)
    fallout.giq_option(6, 368, 126, Control07, 50)
    fallout.giq_option(6, 368, 127, Controlend, 50)
end

function Control07()
    fallout.gsay_reply(368, 128)
    fallout.giq_option(6, 368, 129, Control08, 50)
    fallout.giq_option(6, 368, 130, Control09, 50)
    fallout.giq_option(6, 368, 131, Control10, 50)
    fallout.giq_option(6, 368, 132, Control11, 50)
    fallout.giq_option(6, 368, 133, Controlend, 50)
end

function Control08()
    fallout.gsay_reply(368, 134)
    fallout.giq_option(6, 368, 135, Control08a, 50)
    fallout.giq_option(6, 368, 136, Control08b, 50)
    fallout.giq_option(6, 368, 137, Control08c, 50)
end

function Control08a()
    fallout.set_global_var(274, 0)
    Control12()
end

function Control08b()
    fallout.set_global_var(274, 1)
    Control12()
end

function Control08c()
    fallout.set_global_var(274, 2)
    Control12()
end

function Control09()
    fallout.gsay_reply(368, 138)
    fallout.giq_option(6, 368, 139, Control09a, 50)
    fallout.giq_option(6, 368, 140, Control09b, 50)
end

function Control09a()
    fallout.set_global_var(275, 0)
    Control12()
end

function Control09b()
    fallout.set_global_var(275, 1)
    Control12()
end

function Control10()
    fallout.gsay_reply(368, 141)
    fallout.giq_option(6, 368, 142, Control10a, 50)
    fallout.giq_option(6, 368, 143, Control10b, 50)
    fallout.giq_option(6, 368, 144, Control10c, 50)
    fallout.giq_option(6, 368, 145, Control10d, 50)
    fallout.giq_option(6, 368, 146, Control10e, 50)
end

function Control10a()
    fallout.set_global_var(273, 1)
    Control12()
end

function Control10b()
    fallout.set_global_var(273, 4)
    Control12()
end

function Control10c()
    fallout.set_global_var(273, 3)
    Control12()
end

function Control10d()
    fallout.set_global_var(273, 2)
    Control12()
end

function Control10e()
    fallout.set_global_var(273, 0)
    Control12()
end

function Control11()
    chance = 4 * 10
    if chance < 5 then
        chance = 5
    end
    if chance > 95 then
        chance = 95
    end
    rndx = fallout.random(1, 100)
    if rndx < chance then
        fallout.gsay_message(368, 147, 50)
    else
        fallout.gsay_message(368, 148, 50)
    end
end

function Control12()
    fallout.gsay_reply(368, 149)
    fallout.giq_option(6, 368, 150, Control08, 50)
    fallout.giq_option(6, 368, 151, Control09, 50)
    fallout.giq_option(6, 368, 152, Control10, 50)
    fallout.giq_option(6, 368, 153, Control11, 50)
    fallout.giq_option(6, 368, 154, Controlend, 50)
end

function Control13()
    fallout.gsay_reply(368, 155)
    fallout.giq_option(6, 368, 156, Control08, 50)
    fallout.giq_option(6, 368, 157, Control09, 50)
    fallout.giq_option(6, 368, 158, Control10, 50)
    fallout.giq_option(6, 368, 159, Control11, 50)
    fallout.giq_option(6, 368, 160, Controlend, 50)
end

function Control14()
    fallout.gsay_reply(368, 161)
    fallout.giq_option(-3, 368, 103, Control01, 50)
    fallout.giq_option(4, 368, 162, Control03, 50)
    fallout.giq_option(6, 368, 163, Control13, 50)
    fallout.giq_option(6, 368, 164, Control15, 50)
    fallout.giq_option(6, 368, 165, Control16, 50)
    fallout.giq_option(6, 368, 166, Control23, 50)
    fallout.giq_option(6, 368, 167, Controlend, 50)
end

function Control15()
    fallout.gsay_reply(368, 168)
    fallout.giq_option(6, 368, 169, Control13, 50)
    fallout.giq_option(6, 368, 170, Control16, 50)
    fallout.giq_option(6, 368, 171, Control23, 50)
    fallout.giq_option(6, 368, 172, Controlend, 50)
end

function Control16()
    fallout.gsay_reply(368, 173)
    fallout.giq_option(6, 368, 174, Control13, 50)
    fallout.giq_option(6, 368, 175, Control16a, 50)
end

function Control16a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, 0)) then
        Control17()
    else
        Control22()
    end
end

function Control17()
    fallout.gsay_reply(368, 176)
    fallout.giq_option(6, 368, 177, Control18, 50)
    fallout.giq_option(6, 368, 178, Control19, 50)
end

function Control18()
    fallout.gsay_reply(368, 179)
    fallout.giq_option(6, 368, 180, Control13, 50)
    fallout.giq_option(6, 368, 181, Controlend, 50)
end

function Control19()
    fallout.gsay_reply(368, 182)
    fallout.giq_option(6, 368, 183, Control13, 50)
    fallout.giq_option(6, 368, 184, Controlend, 50)
    fallout.giq_option(6, 368, 185, Control20, 50)
end

function Control20()
    fallout.gsay_reply(368, 186)
    fallout.giq_option(6, 368, 187, Control21, 50)
end

function Control21()
    fallout.set_local_var(0, 1)
    fallout.gsay_message(368, 188, 50)
end

function Control22()
    fallout.gsay_message(368, 189, 50)
end

function Control23()
    fallout.gsay_reply(368, 190)
    fallout.giq_option(6, 368, 191, Control24, 50)
    fallout.giq_option(6, 368, 192, Control25, 50)
end

function Control24()
    fallout.set_local_var(0, 1)
    fallout.gsay_message(368, 193, 50)
end

function Control25()
    fallout.gsay_message(368, 194, 50)
end

function Controlend()
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
