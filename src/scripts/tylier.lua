local fallout = require("fallout")

local start
local do_dialogue
local tylier01
local tylier02
local tylier03
local tylier04
local tylier05
local tylier06
local tylier07
local tylier08
local tylier09
local tylierend

function start()
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.float_msg(fallout.self_obj(), fallout.message_str(309, 100), 0)
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(309, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.global_var(140) ~= 0 then
        tylier01()
    else
        tylier09()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function tylier01()
    fallout.gsay_reply(309, 101)
    fallout.giq_option(-3, 309, 102, tylier02, 50)
    fallout.giq_option(-3, 309, 103, tylier02, 50)
    fallout.giq_option(4, 309, 104, tylier02, 50)
    fallout.giq_option(5, 309, fallout.message_str(309, 105) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(309, 106), tylier02, 50)
    fallout.giq_option(5, 309, 107, tylier03, 50)
end

function tylier02()
    fallout.gsay_message(309, 108, 50)
end

function tylier03()
    fallout.gsay_reply(309, 109)
    fallout.giq_option(5, 309, 110, tylier04, 50)
    fallout.giq_option(5, 309, 111, tylier04, 50)
    fallout.giq_option(5, 309, 112, tylierend, 50)
end

function tylier04()
    fallout.gsay_reply(309, 113)
    fallout.giq_option(5, 309, 114, tylier05, 50)
    fallout.giq_option(5, 309, 115, tylierend, 50)
    fallout.giq_option(6, 309, 116, tylier06, 50)
end

function tylier05()
    fallout.gsay_message(309, 117, 50)
end

function tylier06()
    fallout.gsay_reply(309, 118)
    if fallout.global_var(141) ~= 0 then
        fallout.giq_option(5, 309, 119, tylier07, 50)
    end
    fallout.giq_option(5, 309, 120, tylier06, 50)
    fallout.giq_option(5, 309, 121, tylier06, 50)
    fallout.giq_option(5, 309, 122, tylier06, 50)
    fallout.giq_option(0, 309, 123, tylierend, 50)
end

function tylier07()
    fallout.gsay_message(309, 124, 50)
    fallout.set_global_var(140, 1)
end

function tylier08()
    fallout.gsay_reply(309, 125)
    fallout.giq_option(5, 309, 126, tylier06, 50)
    fallout.giq_option(0, 309, 127, tylierend, 50)
end

function tylier09()
    fallout.gsay_message(309, 128, 50)
end

function tylierend()
end

local exports = {}
exports.start = start
return exports
