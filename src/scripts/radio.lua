local fallout = require("fallout")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0

local start
local talk_p_proc
local use_p_proc
local Radio01
local Radio02
local Radio02a
local Radio03
local Radio03a
local Radio04
local Radio05
local Radio06
local Radio07
local Radio08
local Radio10
local Radio11
local Radio12
local Radio13
local Radio14
local Radio21
local Radio22
local Radio23
local Radio23a
local Radio24
local Radio25
local Radio31
local Radio36
local Radio36a
local Radio37
local RadioEnd
local RadioAlert
local RadioEnt
local RadioStrg1
local RadioStrg2
local RadioVats1

-- ?import? variable hascode
-- ?import? variable got_exp
-- ?import? variable field_change

function start()
    if fallout.script_action() == 11 then
        talk_p_proc()
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        end
    end
end

function talk_p_proc()
    if fallout.cur_map_index() == 30 then
        RadioEnt()
    else
        if fallout.cur_map_index() == 31 then
            if fallout.elevation(fallout.dude_obj()) == 0 then
                RadioStrg1()
            else
                RadioStrg2()
            end
        else
            if fallout.cur_map_index() == 32 then
                if fallout.elevation(fallout.dude_obj()) == 0 then
                    RadioVats1()
                else
                    Radio08()
                end
            else
                Radio08()
            end
        end
    end
    if g1 then
        g1 = 0
        fallout.display_msg(fallout.message_str(361, 139))
        fallout.give_exp_points(1500)
    end
end

function use_p_proc()
    if fallout.cur_map_index() == 30 then
        fallout.dialogue_system_enter()
    else
        if fallout.cur_map_index() == 31 then
            if fallout.elevation(fallout.dude_obj()) == 0 then
                RadioStrg1()
            else
                RadioStrg2()
            end
        else
            if fallout.cur_map_index() == 32 then
                if fallout.elevation(fallout.dude_obj()) == 0 then
                    RadioVats1()
                else
                    Radio08()
                end
            else
                Radio08()
            end
        end
    end
end

function Radio01()
    fallout.set_map_var(0, 1)
    g1 = 1
    fallout.gsay_message(361, 106, 0)
end

function Radio02()
    fallout.gsay_reply(361, 107)
    fallout.giq_option(4, 361, 108, RadioAlert, 0)
    fallout.giq_option(5, 361, 109, Radio04, 0)
    fallout.giq_option(4, 361, 110, Radio02a, 0)
end

function Radio02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Radio06()
    else
        Radio04()
    end
end

function Radio03()
    fallout.gsay_reply(361, 111)
    fallout.giq_option(6, 361, 112, Radio04, 0)
    fallout.giq_option(6, 361, 113, Radio05, 0)
    fallout.giq_option(6, 361, 114, Radio03a, 0)
end

function Radio03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Radio05()
    else
        Radio04()
    end
end

function Radio04()
    fallout.set_global_var(146, 1)
    fallout.gsay_message(361, 115, 0)
end

function Radio05()
    fallout.set_map_var(0, 1)
    g1 = 1
    fallout.gsay_message(361, 116, 0)
end

function Radio06()
    fallout.set_map_var(0, 1)
    g1 = 1
    fallout.gsay_message(361, 117, 0)
end

function Radio07()
    fallout.set_map_var(0, 1)
    g1 = 1
    fallout.gsay_message(361, 118, 0)
end

function Radio08()
    fallout.display_msg(fallout.message_str(361, 119))
end

function Radio10()
    fallout.display_msg(fallout.message_str(361, 120))
end

function Radio11()
    local v0 = 0
    v0 = fallout.message_str(361, 121)
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 0)) then
        v0 = v0 .. fallout.message_str(361, 122)
    end
    fallout.display_msg(v0)
end

function Radio12()
    if fallout.global_var(262) == 0 then
        fallout.set_global_var(262, 1)
    else
        fallout.set_global_var(262, 0)
    end
    fallout.display_msg(fallout.message_str(361, 123))
end

function Radio13()
    fallout.display_msg(fallout.message_str(361, 124))
end

function Radio14()
    local v0 = 0
    local v1 = 0
    if fallout.get_critter_stat(fallout.dude_obj(), 4) > fallout.get_critter_stat(fallout.dude_obj(), 1) then
        v0 = 4
    else
        v0 = 1
    end
    v1 = fallout.message_str(361, 125)
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), v0, 0)) then
        v1 = v1 .. fallout.message_str(361, 126)
    end
    fallout.display_msg(v1)
end

function Radio21()
    if fallout.global_var(262) == 0 then
        fallout.set_global_var(262, 1)
    else
        fallout.set_global_var(262, 0)
    end
end

function Radio22()
    fallout.display_msg(fallout.message_str(361, 127))
end

function Radio23()
    fallout.gsay_reply(361, 128)
    fallout.giq_option(-3, 361, 129, Radio24, 0)
    fallout.giq_option(4, 361, 130, Radio23a, 0)
end

function Radio23a()
    if fallout.local_var(1) or not(fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 10))) then
        Radio24()
    else
        Radio25()
    end
end

function Radio24()
    fallout.set_global_var(146, 1)
    fallout.gsay_message(361, 131, 0)
end

function Radio25()
    fallout.set_local_var(1, 1)
    fallout.gsay_message(361, 132, 0)
end

function Radio31()
    if fallout.global_var(262) == 0 then
        fallout.set_global_var(262, 1)
    else
        fallout.set_global_var(262, 0)
    end
    fallout.display_msg(fallout.message_str(361, 123))
end

function Radio36()
    fallout.gsay_reply(361, 133)
    fallout.giq_option(-3, 361, 134, Radio37, 0)
    fallout.giq_option(4, 361, 135, Radio37, 0)
    if fallout.map_var(6) ~= 0 then
        fallout.giq_option(4, 361, 136, Radio36a, 0)
    end
    fallout.giq_option(4, 361, 137, RadioEnd, 0)
end

function Radio36a()
    fallout.set_map_var(7, 0)
end

function Radio37()
    fallout.gsay_message(361, 138, 0)
    fallout.set_local_var(0, 1)
end

function RadioEnd()
end

function RadioAlert()
    fallout.set_global_var(146, 1)
end

function RadioEnt()
    if fallout.map_var(2) ~= 0 then
        Radio08()
    else
        fallout.set_map_var(2, 1)
        fallout.start_gdialog(361, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        fallout.gsay_reply(361, 101)
        fallout.giq_option(-3, 361, 102, Radio01, 0)
        fallout.giq_option(4, 361, 103, Radio02, 0)
        fallout.giq_option(5, 361, 104, Radio03, 0)
        fallout.giq_option(6, 361, 105, Radio07, 0)
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function RadioStrg1()
    if fallout.global_var(608) ~= 0 then
        Radio14()
    else
        if fallout.global_var(610) ~= 0 then
            Radio12()
        else
            if fallout.global_var(146) ~= 0 then
                if fallout.map_var(12) == 3 then
                    Radio13()
                else
                    Radio11()
                end
            end
        end
    end
end

function RadioStrg2()
    if fallout.global_var(608) ~= 0 then
        Radio14()
    else
        if fallout.global_var(610) ~= 0 then
            Radio21()
        else
            if fallout.global_var(146) ~= 0 then
                Radio22()
            else
                Radio23()
            end
        end
    end
end

function RadioVats1()
    if fallout.global_var(608) ~= 0 then
        Radio12()
    else
        if fallout.map_var(6) and fallout.map_var(7) and not(fallout.local_var(0)) then
            Radio36()
        else
            if fallout.global_var(610) ~= 0 then
                Radio31()
            else
                if fallout.global_var(146) ~= 0 then
                    Radio22()
                else
                    Radio23()
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.use_p_proc = use_p_proc
return exports
