local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local Brat02
local Brat03
local Brat04
local Brat05
local Brat06
local Brat07
local Combat
local BratEnd

local Hostile = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        initialized = true
    end
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(395, 100))
    else
        if fallout.script_action() == 4 then
            Hostile = 1
        else
            if fallout.script_action() == 12 then
                if Hostile then
                    Hostile = 0
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
            else
                if fallout.script_action() == 18 then
                    reputation.inc_evil_critter()
                else
                    if fallout.script_action() == 11 then
                        fallout.script_overrides()
                        if fallout.global_var(195) == 1 then
                            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) or (fallout.global_var(158) > 2) then
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(395, 102), 0)
                            else
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(395, 101), 0)
                            end
                        else
                            fallout.start_gdialog(395, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            Brat02()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        end
                    end
                end
            end
        end
    end
end

function Brat02()
    fallout.gsay_reply(395, 103)
    fallout.giq_option(7, 395, 104, Brat03, 50)
    fallout.giq_option(4, 395, 105, Brat04, 50)
    fallout.giq_option(4, 395, 106, Brat05, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 395, 107, Brat06, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 395, 108, Brat07, 50)
    end
    fallout.giq_option(-3, 395, 109, Brat07, 50)
end

function Brat03()
    fallout.gsay_reply(395, 110)
    fallout.gsay_option(395, 115, BratEnd, 50)
end

function Brat04()
    fallout.gsay_reply(395, 111)
    fallout.gsay_option(395, 115, BratEnd, 50)
end

function Brat05()
    fallout.gsay_reply(395, 112)
    fallout.gsay_option(395, 115, BratEnd, 50)
end

function Brat06()
    fallout.gsay_reply(395, 113)
    fallout.gsay_option(395, 115, BratEnd, 50)
end

function Brat07()
    fallout.gsay_reply(395, 114)
    fallout.gsay_option(395, 115, BratEnd, 50)
end

function Combat()
    Hostile = 1
end

function BratEnd()
end

local exports = {}
exports.start = start
return exports
