local fallout = require("fallout")
local misc = require("lib.misc")

local start
local do_dialogue
local surfend
local surfcombat
local weapon_check
local surf00
local surf01
local surf02
local surf03
local surf03a
local surf03b
local surf04
local surf05
local surf05a
local surf05b
local surf05c
local surf06
local surf07
local surf07a /* Prodedure defined, but not implemented */
local surf07b /* Prodedure defined, but not implemented */
local surf07c /* Prodedure defined, but not implemented */
local surf08 /* Prodedure defined, but not implemented */
local surf09 /* Prodedure defined, but not implemented */
local surf09a /* Prodedure defined, but not implemented */
local surf10 /* Prodedure defined, but not implemented */
local surf10a /* Prodedure defined, but not implemented */
local surf11 /* Prodedure defined, but not implemented */
local surf11a /* Prodedure defined, but not implemented */
local surf11b /* Prodedure defined, but not implemented */
local surf12 /* Prodedure defined, but not implemented */
local surf13 /* Prodedure defined, but not implemented */
local surf13a /* Prodedure defined, but not implemented */
local surf13b /* Prodedure defined, but not implemented */
local surf14 /* Prodedure defined, but not implemented */
local surf15 /* Prodedure defined, but not implemented */
local surf16 /* Prodedure defined, but not implemented */
local surf16a /* Prodedure defined, but not implemented */
local surf16b /* Prodedure defined, but not implemented */
local surf17 /* Prodedure defined, but not implemented */
local surf18 /* Prodedure defined, but not implemented */
local surf18a /* Prodedure defined, but not implemented */
local surf19 /* Prodedure defined, but not implemented */
local surf19a /* Prodedure defined, but not implemented */
local surf20 /* Prodedure defined, but not implemented */
local surf21 /* Prodedure defined, but not implemented */
local surf21a /* Prodedure defined, but not implemented */
local surf22 /* Prodedure defined, but not implemented */
local surf22a /* Prodedure defined, but not implemented */
local surf23 /* Prodedure defined, but not implemented */
local surf23a /* Prodedure defined, but not implemented */
local surf23b /* Prodedure defined, but not implemented */
local surf24 /* Prodedure defined, but not implemented */
local surf24a /* Prodedure defined, but not implemented */
local surf24b /* Prodedure defined, but not implemented */
local surf25 /* Prodedure defined, but not implemented */
local surf26 /* Prodedure defined, but not implemented */
local surf26a /* Prodedure defined, but not implemented */
local surf27 /* Prodedure defined, but not implemented */
local surf27a /* Prodedure defined, but not implemented */
local surf28 /* Prodedure defined, but not implemented */
local surf29 /* Prodedure defined, but not implemented */
local surf29a /* Prodedure defined, but not implemented */
local surf30 /* Prodedure defined, but not implemented */
local surf31 /* Prodedure defined, but not implemented */
local surf32 /* Prodedure defined, but not implemented */
local surf32a /* Prodedure defined, but not implemented */
local surf33 /* Prodedure defined, but not implemented */
local surf33a /* Prodedure defined, but not implemented */
local surf34 /* Prodedure defined, but not implemented */
local surf35 /* Prodedure defined, but not implemented */
local surf36 /* Prodedure defined, but not implemented */
local surf36a /* Prodedure defined, but not implemented */
local surf37 /* Prodedure defined, but not implemented */
local surf38 /* Prodedure defined, but not implemented */
local surf38a /* Prodedure defined, but not implemented */

local hostile = 0
local armed = 0
local GENDER = 0
local POWERBLOWN = 0
local LASHERKNOWN = 0
local TARGET = 0

local get_reaction /* Prodedure defined, but not implemented */
local ReactToLevel /* Prodedure defined, but not implemented */
local LevelToReact /* Prodedure defined, but not implemented */
local UpReact /* Prodedure defined, but not implemented */
local DownReact /* Prodedure defined, but not implemented */
local BottomReact /* Prodedure defined, but not implemented */
local TopReact /* Prodedure defined, but not implemented */
local BigUpReact /* Prodedure defined, but not implemented */
local BigDownReact /* Prodedure defined, but not implemented */
local UpReactLevel /* Prodedure defined, but not implemented */
local DownReactLevel /* Prodedure defined, but not implemented */
local Goodbyes /* Prodedure defined, but not implemented */

local exit_line = 0

function start()
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(0, 100))
        else
            if fallout.script_action() == 12 then
                if hostile then
                    hostile = 0
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
            end
        end
    end
end

function do_dialogue()
    weapon_check()
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.sayStart()
    if fallout.global_var(195) == 1 then
        surf00()
    else
        if fallout.global_var(158) > 2 then
            surf00()
        else
            if (fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1) then
                surf00()
            else
                if fallout.local_var(6) == 1 then
                    surf02()
                else
                    if (fallout.get_critter_stat(fallout.dude_obj(), 3) > 6) and (GENDER == 1) then
                        surf01()
                    else
                        if fallout.local_var(5) == 1 then
                            surf03()
                        else
                            if armed == 1 then
                                surf04()
                            else
                                if misc.is_wearing_coc_robe(fallout.dude_obj()) then
                                    surf05()
                                else
                                    if POWERBLOWN == 1 then
                                        surf06()
                                    else
                                        surf07()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.sayEnd()
    fallout.end_dialogue()
end

function surfend()
end

function surfcombat()
    fallout.set_global_var(195, 1)
    hostile = 1
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        armed = 1
    else
        armed = 0
    end
end

function surf00()
    fallout.sayReply(0, fallout.message_str(0, 101))
    fallout.sayOption("[done]", surfend)
end

function surf01()
    fallout.sayReply(0, fallout.message_str(0, 102))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 7 then
        fallout.sayOption(fallout.message_str(0, 103), surf08)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 104), surf09)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 105), surf10)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 106), surf11)
    end
    if (fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1) then
        if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
            fallout.sayOption(fallout.message_str(0, 107), surf10)
        end
    end
    if -fallout.get_critter_stat(fallout.dude_obj(), 4) >= -3 then
        fallout.sayOption(fallout.message_str(0, 108), surf12)
    end
end

function surf02()
    fallout.set_local_var(5, 1)
    fallout.sayReply(0, fallout.message_str(0, 109))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 7 then
        fallout.sayOption(fallout.message_str(0, 110), surf25)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 111), surf26)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 112), surf27)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 113), surf28)
    end
    if (fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1) then
        if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
            fallout.sayOption(fallout.message_str(0, 114), surf15)
        end
    end
end

function surf03()
    fallout.sayReply(0, fallout.message_str(0, 115))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 7 then
        fallout.sayOption(fallout.message_str(0, 116), surf29)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 117), surf03a)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 118), surf03b)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 119), surf33)
    end
    if (fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1) then
        if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
            fallout.sayOption(fallout.message_str(0, 120), surf34)
        end
    end
end

function surf03a()
end

function surf03b()
end

function surf04()
    fallout.sayReply(0, fallout.message_str(0, 121))
end

function surf05()
    if GENDER == 0 then
        fallout.sayReply(0, fallout.message_str(0, 122))
    else
        fallout.sayReply(0, fallout.message_str(0, 123))
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 7 then
        fallout.sayOption(fallout.message_str(0, 124), surf05a)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 125), surf36)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 126), surf05b)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 127), surf05c)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 128), surf33)
    end
    if (fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1) then
        if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
            fallout.sayOption(fallout.message_str(0, 129), surf34)
        end
    end
end

function surf05a()
end

function surf05b()
end

function surf05c()
end

function surf06()
    fallout.sayReply(0, fallout.message_str(0, 130))
    fallout.sayOption("[done]", surfend)
end

function surf07()
    if GENDER == 0 then
        fallout.sayReply(0, fallout.message_str(0, 131))
    else
        fallout.sayReply(0, fallout.message_str(0, 132))
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 7 then
        fallout.sayOption(fallout.message_str(0, 133), surf07a)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 134), surf37)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 135), surf07b)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 136), surf07c)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 137), surf33)
    end
    if (fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1) then
        if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
            fallout.sayOption(fallout.message_str(0, 138), surf38)
        end
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 139), surf13)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 140), surf14)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(0, 141), surf10)
    end
    if (fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1) then
        if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
            fallout.sayOption(fallout.message_str(0, 142), surf15)
        end
    end
end

--
-- Found Procedure without body.
--
-- Name: surf07a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf07b
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf07c
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf08
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf09
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf09a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf10
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf10a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf11
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf11a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf11b
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf12
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf13
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf13a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf13b
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf14
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf15
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf16
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf16a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf16b
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf17
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf18
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf18a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf19
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf19a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf20
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf21
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf21a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf22
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf22a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf23
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf23a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf23b
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf24
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf24a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf24b
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf25
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf26
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf26a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf27
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf27a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf28
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf29
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf29a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf30
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf31
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf32
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf32a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf33
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf33a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf34
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf35
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf36
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf36a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf37
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf38
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: surf38a
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: get_reaction
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: ReactToLevel
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: LevelToReact
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: UpReact
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: DownReact
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: BottomReact
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: TopReact
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: BigUpReact
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: BigDownReact
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: UpReactLevel
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: DownReactLevel
--
-- Not implemented
--

--
-- Found Procedure without body.
--
-- Name: Goodbyes
--
-- Not implemented
--

local exports = {}
exports.start = start
return exports
