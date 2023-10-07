local fallout = require("fallout")

local start
local do_dialogue

local Hostile = 0
local init_teams = 0
local rndx = 0

function start()
    local v0 = 0
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 31)
        init_teams = 1
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(68, 100))
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 13 then
                    if fallout.fixed_param() == 2 then
                        rndx = fallout.random(1, 6) - 5
                        if rndx < 0 then
                            rndx = 0
                        end
                        if rndx > 0 then
                            fallout.radiation_inc(fallout.target_obj(), rndx)
                        end
                    end
                else
                    if fallout.script_action() == 12 then
                        if Hostile then
                            Hostile = 0
                            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                        end
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
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    rndx = fallout.random(1, 3)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(68, 101), 9)
    end
    if rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(68, 102), 9)
    end
    if rndx == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(68, 103), 9)
    end
end

local exports = {}
exports.start = start
return exports
