local fallout = require("fallout")

local start
local do_dialogue
local ration01
local ration02
local ration03
local ration03a
local ration03b
local ration03c
local ration04
local ration05
local ration06
local ration07
local rationend

local crying = 0
local hostile = 0
local myname = 0
local PICK = 0

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

local reaction = 50
local reaction_level = 2
local got_reaction = 0
local badguy = 0
local exit_line = 0

function start()
    if (fallout.script_action() == 11) and (crying == 0) then
        do_dialogue()
    else
        if fallout.script_action() == 4 then
            hostile = 1
        else
            if fallout.script_action() == 12 then
                if hostile then
                    hostile = 0
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
            else
                if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                    fallout.script_overrides()
                    if crying == 1 then
                        PICK = myname
                        if PICK == 1 then
                            fallout.display_msg("You see Cindy crying.")
                        else
                            if PICK > 2 then
                                fallout.display_msg("You see Lisa crying.")
                            else
                                if PICK > 3 then
                                    fallout.display_msg("You see Sandy crying.")
                                else
                                    if PICK > 4 then
                                        fallout.display_msg("You see Mary crying.")
                                    else
                                        if PICK > 5 then
                                            fallout.display_msg("You see Stacy crying.")
                                        else
                                            if PICK > 6 then
                                                fallout.display_msg("You see Susan crying.")
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        PICK = myname
                        if PICK == 1 then
                            fallout.display_msg("You see Cindy.")
                        else
                            if PICK > 2 then
                                fallout.display_msg("You see Lisa.")
                            else
                                if PICK > 3 then
                                    fallout.display_msg("You see Sandy.")
                                else
                                    if PICK > 4 then
                                        fallout.display_msg("You see Mary.")
                                    else
                                        if PICK > 5 then
                                            fallout.display_msg("You see Stacy.")
                                        else
                                            if PICK > 6 then
                                                fallout.display_msg("You see Susan.")
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if fallout.script_action() == 18 then
                        if fallout.source_obj() == fallout.dude_obj() then
                            fallout.set_global_var(159, fallout.global_var(159) + 1)
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(168, fallout.self_obj(), 4, -1, -1)
    fallout.sayStart()
    ration01()
    fallout.sayEnd()
    fallout.end_dialogue()
end

function ration01()
    fallout.sayReply(0, "Hello, " .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. ". Have you found the water chip yet?")
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption("No, not yet.", ration03)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption("I will. How are you doing?", ration04)
    end
    if -fallout.get_critter_stat(fallout.dude_obj(), 4) >= -3 then
        fallout.sayOption("Urug!", ration02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 0 then
        fallout.sayOption("", rationend)
    end
end

function ration02()
    crying = 1
    fallout.sayReply(0, "Oh . . . you don't understand me. I guess we really don't have much hope after all. Excuse me while I cry.")
    if -fallout.get_critter_stat(fallout.dude_obj(), 4) >= -3 then
        fallout.sayOption("Ugg!", rationend)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 0 then
        fallout.sayOption("", rationend)
    end
end

function ration03()
    PICK = fallout.random(1, 3)
    if PICK == 1 then
        ration03a()
    else
        if PICK > 2 then
            ration03b()
        else
            if PICK > 3 then
                ration03c()
            end
        end
    end
end

function ration03a()
    fallout.sayReply(0, "Please find it before my baby dies of thirst.")
    fallout.sayOption("[Done]", rationend)
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 0 then
        fallout.sayOption("", rationend)
    end
end

function ration03b()
    fallout.sayReply(0, "You've got to find it! Don't let us die like this!")
    fallout.sayOption("[Done]", rationend)
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 0 then
        fallout.sayOption("", rationend)
    end
end

function ration03c()
    fallout.sayReply(0, "Keep trying. I believe in you. I know you will do everything you can to save us.")
    fallout.sayOption("[Done]", rationend)
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 0 then
        fallout.sayOption("", rationend)
    end
end

function ration04()
    fallout.sayReply(0, "I am afraid of what is happening. Someone has been stealing water and now everyone is on edge.")
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption("Who would do such a thing?", ration05)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption("What happened?", ration06)
    end
end

function ration05()
    fallout.sayReply(0, "Some people have been accused and fights have broken out over it but nobody really knows.")
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption("Ok. Thanks.", rationend)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 0 then
        fallout.sayOption("", rationend)
    end
end

function ration06()
    fallout.sayReply(0, "Some people reported that their water had been stolen. They weren't given more water but some friends shared with them. After this everybody got very paranoid and started guarding their water. A few days later someone knocked the guard out in the ration supply area and stole water.")
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption("That is terrible! What can I do?", ration07)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 0 then
        fallout.sayOption("", rationend)
    end
end

function ration07()
    fallout.sayReply(0, "Maybe you can stop whoever is doing this.")
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption("I'll take a look around.", rationend)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 0 then
        fallout.sayOption("", rationend)
    end
end

function rationend()
end

function get_reaction()
    if not(got_reaction) then
        got_reaction = 1
        reaction = reaction + ((fallout.get_critter_stat(fallout.dude_obj(), 3) - 5) * 5)
        reaction = reaction + (10 * fallout.has_trait(0, fallout.dude_obj(), 10))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                reaction = reaction + fallout.global_var(155)
            else
                reaction = reaction - fallout.global_var(155)
            end
        else
            if badguy then
                reaction = reaction - fallout.global_var(155)
            else
                reaction = reaction + fallout.global_var(155)
            end
        end
        if fallout.global_var(158) > 2 then
            reaction = reaction - 30
        end
        if (fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1) then
            reaction = reaction + 20
        end
        if (fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1) then
            reaction = reaction - 20
        end
        ReactToLevel()
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
