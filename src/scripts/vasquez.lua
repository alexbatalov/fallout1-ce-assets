local fallout = require("fallout")

local start
local do_dialogue
local end_employment
local hiring
local follow_player
local vasquez01
local vasquez00
local vasquezend
local vasquez10
local vasquez02
local vasquez03
local vasquez04
local vasquez05
local vasquez06
local vasquez07
local vasquez08
local vasquez09

local known = 0
local warned = 0
local following = 0
local hire_date = 0

function start()
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 18 then
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
        else
            if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                fallout.script_overrides()
                if known then
                    fallout.display_msg(fallout.message_str(436, 100))
                else
                    fallout.display_msg(fallout.message_str(436, 101))
                end
            else
                if fallout.script_action() == 12 then
                    if following then
                        if ((fallout.game_time() // (10 * 60 * 60 * 24)) - hire_date) > 7 then
                            end_employment()
                        else
                            follow_player()
                        end
                    else
                        if fallout.script_action() == 14 then
                            if fallout.source_obj() == fallout.dude_obj() then
                                if not(warned) then
                                    vasquez10()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(436, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if following then
        vasquez06()
    else
        if known then
            vasquez07()
        else
            vasquez00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function end_employment()
    following = 0
end

function hiring()
    vasquez05()
end

function follow_player()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 3 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num(fallout.dude_obj()), 0)
    else
        if fallout.anim_busy(fallout.self_obj()) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num(fallout.self_obj()), 0)
        end
    end
end

function vasquez01()
    fallout.gsay_message(436, 105, 50)
end

function vasquez00()
    fallout.gsay_reply(436, 102)
    fallout.giq_option(4, 436, 103, vasquez02, 50)
    fallout.giq_option(-3, 436, 104, vasquez01, 50)
end

function vasquezend()
end

function vasquez10()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(436, 126), 0)
    warned = 1
end

function vasquez02()
    known = 1
    fallout.gsay_reply(436, 106)
    fallout.giq_option(4, 436, 107, vasquez03, 50)
    fallout.giq_option(4, 436, 108, vasquezend, 50)
end

function vasquez03()
    fallout.gsay_reply(436, 109)
    fallout.giq_option(4, 436, 110, hiring, 50)
    fallout.giq_option(4, 436, 111, vasquezend, 50)
end

function vasquez04()
    fallout.gsay_message(436, 112, 50)
end

function vasquez05()
    fallout.gsay_message(436, 113, 50)
    following = 1
    hire_date = fallout.game_time() // (10 * 60 * 60 * 24)
end

function vasquez06()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 5)
    if v0 == 1 then
        v1 = fallout.message_str(436, 114)
    else
        if v0 == 2 then
            v1 = fallout.message_str(436, 115)
        else
            if v0 == 3 then
                v1 = fallout.message_str(436, 116)
            else
                if v0 == 4 then
                    v1 = fallout.message_str(436, 117)
                else
                    if v0 == 5 then
                        v1 = fallout.message_str(436, 118)
                    end
                end
            end
        end
    end
    fallout.float_msg(fallout.self_obj(), v1, 0)
end

function vasquez07()
    fallout.gsay_reply(436, 119)
    fallout.giq_option(4, 436, 120, vasquez09, 50)
    fallout.giq_option(4, 436, 121, vasquezend, 50)
    fallout.giq_option(-3, 436, 122, vasquez08, 50)
end

function vasquez08()
    fallout.gsay_message(436, 123, 50)
end

function vasquez09()
    fallout.gsay_reply(436, 124)
    fallout.giq_option(4, 436, 125, hiring, 50)
end

local exports = {}
exports.start = start
return exports
