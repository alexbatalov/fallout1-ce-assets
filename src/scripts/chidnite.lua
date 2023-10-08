local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local Nightkin01
local Nightkin01a
local Nightkin02
local Nightkin03
local Nightkin04
local Nightkin05
local Nightkin05a
local Nightkin06
local Nightkin07
local Nightkinend
local Combat

local Hostile = 0
local Only_Once = 1

function start()
    if Only_Once then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 66)
        Only_Once = 0
    end
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(394, 100))
    else
        if fallout.script_action() == 18 then
            reputation.inc_evil_critter()
        else
            if fallout.script_action() == 14 then
                fallout.set_global_var(245, 1)
            else
                if fallout.script_action() == 12 then
                    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                        if not(fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 142)) then
                            if not(fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 141)) then
                                if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) ~= 113 then
                                    Hostile = 1
                                end
                            end
                        end
                    end
                    if (fallout.metarule(16, 0) > 1) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                        Hostile = 1
                    end
                    if Hostile then
                        Hostile = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    end
                else
                    if fallout.script_action() == 4 then
                        Hostile = 1
                    else
                        if fallout.script_action() == 11 then
                            fallout.script_overrides()
                            if fallout.global_var(195) == 1 then
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(394, 101), 0)
                                Hostile = 1
                            else
                                fallout.start_gdialog(394, fallout.self_obj(), 4, -1, -1)
                                fallout.gsay_start()
                                Nightkin01()
                                fallout.gsay_end()
                                fallout.end_dialogue()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Nightkin01()
    fallout.gsay_reply(394, 102)
    fallout.giq_option(7, 394, 103, Nightkin01a, 50)
    fallout.giq_option(4, 394, 104, Nightkin04, 50)
    fallout.giq_option(4, 394, 105, Nightkin05, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 394, 106, Nightkin05, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 394, 107, Nightkin04, 50)
    end
    fallout.giq_option(-3, 394, 108, Nightkinend, 50)
end

function Nightkin01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Nightkin02()
    else
        Nightkin03()
    end
end

function Nightkin02()
    fallout.gsay_reply(394, 109)
    fallout.gsay_option(394, 125, Nightkinend, 50)
end

function Nightkin03()
    fallout.gsay_reply(394, 110)
    Combat()
end

function Nightkin04()
    fallout.gsay_reply(394, 111)
    Combat()
end

function Nightkin05()
    fallout.gsay_reply(394, 112)
    fallout.giq_option(7, 394, 113, Nightkin05a, 50)
    fallout.giq_option(4, 394, 114, Nightkin04, 50)
    fallout.giq_option(4, 394, 115, Nightkin07, 50)
    fallout.giq_option(4, 394, 116, Nightkin07, 50)
    fallout.giq_option(4, 394, 117, Nightkinend, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 394, 118, Nightkin04, 50)
    end
end

function Nightkin05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Nightkin06()
    else
        Nightkin03()
    end
end

function Nightkin06()
    fallout.gsay_reply(394, 119)
    fallout.gsay_option(394, 125, Nightkinend, 50)
end

function Nightkin07()
    fallout.gsay_reply(394, 120)
    fallout.giq_option(4, 394, 121, Nightkin04, 50)
    fallout.giq_option(4, 394, 122, Nightkin04, 50)
    fallout.giq_option(4, 394, 123, Nightkinend, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 394, 124, Combat, 50)
    end
end

function Nightkinend()
end

function Combat()
    fallout.set_global_var(195, 1)
    Hostile = 1
end

local exports = {}
exports.start = start
return exports
