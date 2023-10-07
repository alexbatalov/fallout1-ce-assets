local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local IrwinTalks
local IrwinAccept
local IrwinEnd
local Irwin00
local Irwin01
local Irwin02
local Irwin03
local Irwin04
local Irwin05
local Irwin06
local Irwin07

local hostile = 0
local Only_Once = 1

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
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 41)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 51)
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
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.global_var(307) == 501 then
        if fallout.tile_num(fallout.self_obj()) ~= 27969 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 27969, 0)
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    local v0 = 0
    get_reaction()
    IrwinTalks()
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

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(935, 100))
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function IrwinTalks()
    if fallout.global_var(307) == 0 then
        fallout.start_gdialog(935, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Irwin00()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        if (fallout.global_var(307) == 1) or (fallout.global_var(307) == 2) then
            fallout.start_gdialog(935, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Irwin05()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(935, 117), 8)
        end
    end
end

function IrwinAccept()
    fallout.gsay_message(935, 109, 50)
    fallout.set_global_var(307, 1)
    fallout.game_time_advance(10 * 60 * 60 * 1)
    fallout.load_map("hubmis1.map", 1)
end

function IrwinEnd()
end

function Irwin00()
    fallout.gsay_reply(935, 101)
    fallout.giq_option(4, 935, 102, Irwin01, 50)
    fallout.giq_option(4, 935, 103, Irwin03, 50)
    fallout.giq_option(4, 935, 104, IrwinEnd, 50)
    fallout.giq_option(-3, 935, 118, Irwin07, 50)
end

function Irwin01()
    if fallout.get_pc_stat(1) < 5 then
        fallout.gsay_message(935, 105, 50)
    else
        Irwin02()
    end
end

function Irwin02()
    fallout.gsay_reply(935, 106)
    fallout.giq_option(4, 935, 107, IrwinAccept, 50)
    fallout.giq_option(4, 935, 108, Irwin04, 50)
end

function Irwin03()
    fallout.gsay_message(935, 110, 50)
end

function Irwin04()
    fallout.gsay_message(935, 111, 50)
end

function Irwin05()
    fallout.gsay_reply(935, 112)
    fallout.giq_option(4, 935, 113, Irwin06, 50)
    fallout.giq_option(4, 935, 114, IrwinEnd, 50)
    fallout.giq_option(-3, 935, 120, Irwin06, 50)
    fallout.giq_option(-3, 935, 121, IrwinEnd, 50)
end

function Irwin06()
    local v0 = 0
    if fallout.global_var(307) == 2 then
        fallout.gsay_message(935, 115, 50)
        v0 = fallout.create_object_sid(241, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
        fallout.give_exp_points(500)
        fallout.set_global_var(155, fallout.global_var(155) + 2)
        fallout.set_global_var(307, 501)
    else
        fallout.gsay_message(935, 116, 50)
    end
end

function Irwin07()
    fallout.gsay_message(935, 119, 50)
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
exports.look_at_p_proc = look_at_p_proc
exports.damage_p_proc = damage_p_proc
return exports
