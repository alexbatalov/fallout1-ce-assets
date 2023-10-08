local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local do_dialogue
local PalGuard01
local PalGuard02

local line = 0
local Only_Once = 0

local exit_line = 0

function start()
    if Only_Once == 0 then
        Only_Once = 1
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 18 then
            reputation.inc_good_critter()
        else
            if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(317, 100))
            else
                if fallout.script_action() == 22 then
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
            end
        end
    end
end

function do_dialogue()
    reaction.get_reaction()
    if fallout.local_var(1) < 2 then
        PalGuard01()
    else
        PalGuard02()
    end
end

function PalGuard01()
    if not(line) then
        line = fallout.random(1, 9)
    else
        line = line + 1
    end
    if line > 9 then
        line = 1
    end
    if line == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 101), 2)
    else
        if line == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 102), 2)
        else
            if line == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 103), 2)
            else
                if line == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 104), 2)
                else
                    if line == 5 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 105), 2)
                    else
                        if line == 6 then
                            if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 106), 2)
                            else
                                line = line + 1
                            end
                        else
                            if line == 7 then
                                if fallout.global_var(108) == 2 then
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 107), 2)
                                else
                                    line = line + 1
                                end
                            else
                                if line == 8 then
                                    if fallout.global_var(108) < 2 then
                                        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 108), 2)
                                    else
                                        line = line + 1
                                    end
                                else
                                    if line == 9 then
                                        if fallout.global_var(108) < 2 then
                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 109), 2)
                                        else
                                            line = 1
                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 110), 2)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function PalGuard02()
    if not(line) then
        line = fallout.random(1, 10)
    else
        line = line + 1
    end
    if line > 10 then
        line = 1
    end
    if line == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 111), 2)
    else
        if line == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 112), 2)
        else
            if line == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 113), 2)
            else
                if line == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 114), 2)
                else
                    if line == 5 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 115), 2)
                    else
                        if line == 7 then
                            if fallout.global_var(108) == 2 then
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 116), 2)
                            else
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 117), 2)
                            end
                        else
                            if line == 7 then
                                if fallout.global_var(108) == 2 then
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 118), 2)
                                else
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(317, 119), 2)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
