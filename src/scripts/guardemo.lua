local fallout = require("fallout")

local start
local do_dialogue
local guard02a
local guard02b
local guard00
local guard00i
local guard00ii
local guard01
local guard01i
local guard02
local guard02i
local guard03
local guard04
local guard05
local guardend
local weapon_check

local Caught = 0
local armed = 0
local Scared = 0
local Occurance = 0
local Checked = 0
local hostile = 0
local rndx = 0

local ReactToLevel
local LevelToReact
local ModReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

local reaction = 50
local reaction_level = 2
local Talk = 0
local exit_line = 0

function start()
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 12 then
            weapon_check()
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if (fallout.global_var(142) == 0) and armed and not(Scared) and not(Checked) then
                    Checked = 1
                    fallout.dialogue_system_enter()
                end
            end
            if hostile then
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
        else
            if fallout.script_action() == 22 then
                if fallout.fixed_param() == 1 then
                    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                        weapon_check()
                        if armed then
                            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                        end
                    else
                        if fallout.script_action() == 18 then
                            fallout.give_exp_points(150)
                            fallout.display_msg(fallout.message_str(221, 123))
                        else
                            if (fallout.script_action() == 21) or 3 then
                                fallout.script_overrides()
                                fallout.display_msg(fallout.message_str(221, 100))
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    if (fallout.global_var(142) == 0) and armed and not(Scared) then
        fallout.set_global_var(142, 1)
        fallout.start_gdialog(221, fallout.self_obj(), 4, -1, -1)
        fallout.sayStart()
        guard00()
        fallout.sayEnd()
        fallout.end_dialogue()
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
    else
        guard02a()
    end
end

function guard02a()
    rndx = fallout.random(1, 3)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(221, 101), 0)
    else
        if rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(221, 102), 0)
        else
            if rndx == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(221, 103), 0)
            end
        end
    end
end

function guard02b()
    fallout.sayReply(0, fallout.message_str(221, 114))
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 4 then
        fallout.sayOption(fallout.message_str(221, 115), guardend)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 4 then
        fallout.sayOption(fallout.message_str(221, 116), guard02i)
    end
end

function guard00()
    fallout.sayReply(0, fallout.message_str(221, 104))
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 4 then
        fallout.sayOption(fallout.message_str(221, 105), guard01)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 4 then
        fallout.sayOption(fallout.message_str(221, 106), guard00i)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 5 then
        fallout.sayOption(fallout.message_str(221, 107), guard00ii)
    end
    if -fallout.get_critter_stat(fallout.dude_obj(), 2) >= -3 then
        fallout.sayOption(fallout.message_str(221, 108), guard05)
    end
end

function guard00i()
    DownReact()
    guard02()
end

function guard00ii()
    UpReact()
    guard04()
end

function guard01()
    fallout.sayReply(0, fallout.message_str(221, 109))
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 4 then
        fallout.sayOption(fallout.message_str(221, 110), guard02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 4 then
        fallout.sayOption(fallout.message_str(221, 111), guard01i)
    end
end

function guard01i()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        guard03()
    else
        guard02()
    end
end

function guard02()
    fallout.sayReply(0, fallout.message_str(221, 112))
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 0 then
        fallout.sayOption(fallout.message_str(221, 113), guard02b)
    end
end

function guard02i()
    hostile = 1
end

function guard03()
    fallout.sayReply(0, fallout.message_str(221, 117))
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 0 then
        fallout.sayOption(fallout.message_str(221, 118), guardend)
    end
    Scared = 1
end

function guard04()
    fallout.sayReply(0, fallout.message_str(221, 119))
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 0 then
        fallout.sayOption(fallout.message_str(221, 120), guardend)
    end
end

function guard05()
    fallout.sayReply(0, fallout.message_str(221, 121))
    if fallout.get_critter_stat(fallout.dude_obj(), 2) >= 0 then
        fallout.sayOption(fallout.message_str(221, 122), guardend)
    end
end

function guardend()
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        armed = 1
    else
        armed = 0
    end
end

function ReactToLevel()
    if reaction < 24 then
        reaction_level = 1
    else
        if reaction < 74 then
            reaction_level = 2
        else
            reaction_level = 3
        end
    end
end

function LevelToReact()
    if reaction_level == 1 then
        reaction = fallout.random(1, 24)
    else
        if reaction_level == 2 then
            reaction = fallout.random(25, 74)
        else
            reaction = fallout.random(75, 100)
        end
    end
end

function ModReact()
    Talk = fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)
    if fallout.action_being_used() == 14 then
        if fallout.is_success(Talk) then
            reaction_level = reaction_level + 1
        end
    end
    LevelToReact()
end

function UpReact()
    reaction = reaction + 10
    ReactToLevel()
end

function DownReact()
    reaction = reaction - 10
    ReactToLevel()
end

function BottomReact()
    reaction_level = 1
    reaction = 1
end

function TopReact()
    reaction = 100
    reaction_level = 3
end

function BigUpReact()
    reaction = reaction + 25
    ReactToLevel()
end

function BigDownReact()
    reaction = reaction - 25
    ReactToLevel()
end

function UpReactLevel()
    reaction_level = reaction_level + 1
    if reaction_level > 3 then
        reaction_level = 3
    end
    LevelToReact()
end

function DownReactLevel()
    reaction_level = reaction_level - 1
    if reaction_level < 1 then
        reaction_level = 1
    end
    LevelToReact()
end

function Goodbyes()
    local v0 = 0
    v0 = fallout.random(1, 6)
    if v0 == 1 then
        exit_line = "Thanks, bye."
    end
    if v0 == 2 then
        exit_line = "Okay, thanks."
    end
    if v0 == 3 then
        exit_line = "Hmm. Bye."
    end
    if v0 == 4 then
        exit_line = "See ya."
    end
    if v0 == 5 then
        exit_line = "Thanks."
    end
    if v0 == 6 then
        exit_line = "Okay, bye."
    end
end

local exports = {}
exports.start = start
return exports
